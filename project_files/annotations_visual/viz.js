class AnnotationAPI {
  base_url = "https://annotations-api.tfoureur.com";
  async addAnnotation(content) {
    const res = await fetch(this.base_url + "/annotations", {
      method: "POST",
      headers: {
        "Content-Type": "application/json",
      },
      body: JSON.stringify({
        dashboardId: dashboardId ?? "1",
        filters: lastRenderedFilters ?? "{}",
        url: "test_url",
        content,
        explore: "dummy_explore",
      }),
    });

    const newAnnotation = await res.json();

    return newAnnotation;
  }
  async getAnnotations(filters) {
    const res = await fetch(
      `${this.base_url}/annotations?dashboardId=${
        dashboardId ?? "1"
      }&filters=${filters}`
    );
    const annotations = await res.json();

    return annotations;
  }
  async removeAnnotation(annotationId) {
    await fetch(this.base_url + `/annotations/${annotationId}`, {
      method: "DELETE",
    });

    return true;
  }
  async editAnnotation(annotationId, content) {
    const updatedAnnotation = await fetch(
      this.base_url + `/annotations/${annotationId}`,
      {
        method: "PATCH",
        headers: {
          "Content-Type": "application/json",
        },
        body: JSON.stringify({
          dashboardId: dashboardId ?? "1",
          content: content,
          filters: lastRenderedFilters ?? "{}",
          url: "test_url",
          explore: "dummy_explore",
        }),
      }
    );

    return updatedAnnotation;
  }
}

const annotationsApi = new AnnotationAPI();

function extractDashboardId(url) {
  const regex = /dashboards\/(\d+)/;
  const match = url.match(regex);
  return match ? match[1] : null;
}

const url = document.referrer;
const dashboardId = extractDashboardId(url);
let lastRenderedFilters = "{}";

const updateContainerHeight = () => {
  const notes = document.querySelector("#notes");
  notes.style.height = `${document.querySelectorAll(".note").length * 58}px`;
};

const createNote = async (content) => {
  const annotation = await annotationsApi.addAnnotation(content);

  renderNote(annotation);
};

const debounce = (callback, debounceTime) => {
  let timeoutId = null;
  return (...args) => {
    window.clearTimeout(timeoutId);
    timeoutId = window.setTimeout(() => {
      callback.apply(null, args);
    }, debounceTime);
  };
};

const renderNote = async (annotation) => {
  const noteId = annotation.id;
  const content = annotation.content;

  const notes = document.querySelector("#notes");
  const noteContainer = document.createElement("div");

  const input = document.querySelector("#submitInput");
  input.value = "";

  noteContainer.setAttribute("id", `note-${noteId}`);
  noteContainer.setAttribute("class", "note");
  noteContainer.innerHTML = `
    <input id="noteInput" value="${content}"/>
    <button id="deleteButton">Delete</button>
  `;
  notes.appendChild(noteContainer);

  document
    .querySelector(`#note-${noteId} > #deleteButton`)
    .addEventListener("click", () => removeNote(noteId));
  document.querySelector(`#note-${noteId} > #noteInput`).addEventListener(
    "change",
    debounce(
      (e) => annotationsApi.editAnnotation(noteId, e.target?.value ?? ""),
      500
    )
  );

  updateContainerHeight();
};

const removeNote = async (noteId) => {
  await annotationsApi.removeAnnotation(noteId);

  const note = document.querySelector(`#note-${noteId}`);
  note.remove();

  updateContainerHeight();
};

const debouncedRenderNotes = debounce((filters, doneRendering) => {
  renderNotes(filters).then(
    () => {
      console.log("done rerendering");
      doneRendering();
    },
    () => {
      console.log("done rerendering");
      doneRendering();
    }
  );
}, 250);

const renderNotes = async (filters) => {
  console.log("invoked render");
  // reset layout
  const notes = document.querySelector("#notes");
  notes.innerHTML = "";

  // fetch notes
  const annotations = await annotationsApi.getAnnotations(filters);

  // render notes
  for (let i = 0; i < annotations.length; i++) {
    renderNote(annotations[i]);
  }
};

const visObject = {
  create: async (element, config) => {
    element.innerHTML = `
        <style>
          * {
            box-sizing: border-box
          }
          button {
            cursor: pointer;
          }
          #notes {
            height: 40px;
            width: 100%;
          }
          #submitButton {
            flex-shrink: 0;
            width: 100px;
            height: 48px;
            border-radius: 20px;
            border: 0px solid #bdbdbd;
            padding: 3px;
            color: white;
            font-weight: bold;
            background: #4285EF;
            box-shadow: 3px 3px 11px -7px rgba(66, 68, 90, 1);
            margin: 0px;
          }
          #noteInput, #submitInput {
            flex-grow: 1;
            border: 1px solid #bdbdbd;
            padding: 15px;
            box-shadow: 3px 3px 11px -7px rgba(66, 68, 90, 1);
            margin: 0px;
            margin-right: 5px;
            border-radius: 20px;
          }
          #bottomContainer {
            width: 100%;
            display: flex;
            flex-direction: row;
          }
          .note {
            width: 100%;
            min-height: 40px;
            display: flex;
            flex-direction: row;
            margin-bottom: 10px;
            animation-duration: 0.5s;
            animation-name: animation-appear;
          }
          #deleteButton {
            height: 48px;
            border: 0px solid #bdbdbd;
            width: 50px;
            font-size: 10px;
            border-radius: 15px;
            background: #4285EF;
            font-weight: bold;
            px: 5px;
            color: white;
            margin: 0px 2px;
          }
          #divider {
            width: 85%;
            border-top: 3px solid #e6e6e6;
            margin: 20px auto 20px auto;
          }

          @keyframes animation-appear {
            0% { opacity: 0; transform: scale(1, 0);}
            100% { opacity: 1; transform: scale(1, 1);}
          }
        </style>
        <div>
          <div id="notes"></div>
          <div id="divider"></div>
          <div id="bottomContainer">
            <input id="submitInput"/>
            <button id="submitButton">Add note</button>
          </div>
        </div>
      `;

    document
      .querySelector("#submitButton")
      .addEventListener("click", () =>
        createNote(
          document.querySelector("#submitInput")?.value ?? "Empty note"
        )
      );
  },

  updateAsync: async function (
    data,
    element,
    config,
    queryResponse,
    details,
    doneRendering
  ) {
    const currentFilters = JSON.stringify(queryResponse?.applied_filters ?? {});
    debouncedRenderNotes(currentFilters, doneRendering);

    lastRenderedFilters = currentFilters;
  },
};

looker.plugins.visualizations.add(visObject);
