// Annotation
// {
//   "id": "a8d13884-50af-4158-9c5e-cbd6db15d01c",
//   "dashboardId": "1",
//   "content": "Hello",
//   "filters": "Current filters",
//   "url": "test_url",
//   "explore": "dummy_explore",
//   "createdAt": {
//     "value": "2023-12-06T16:04:28.884Z"
//   }
// }

class AnnotationAPI {
  base_url = "https://annotations-api.tfoureur.com";
  async addAnnotation(content) {
    const res = await fetch(this.base_url + "/annotations", {
      method: "POST",
      headers: {
        "Content-Type": "application/json",
      },
      body: JSON.stringify({
        dashboardId: "1",
        content,
        filters: "Current filters",
        url: "test_url",
        explore: "dummy_explore",
      }),
    });

    const newAnnotation = await res.json();
    console.log("Created annotation", newAnnotation);
    return newAnnotation;
  }

  async getAnnotations() {
    const res = await fetch(this.base_url + "/annotations");
    const annotations = await res.json();

    console.log(annotations);
    return annotations;
  }

  async removeAnnotation(annotationId) {
    await fetch(this.base_url + `/annotations/${annotationId}`, {
      method: "DELETE",
    });

    return true;
  }
}

const annotationsApi = new AnnotationAPI();

const updateContainerHeight = () => {
  const notes = document.querySelector("#notes");
  notes.style.height = `${
    document.querySelectorAll(".note").length * 50 + 20
  }px`;
};

const createNote = async (content) => {
  const annotation = await annotationsApi.addAnnotation(content);

  addNote(annotation);
};

const addNote = async (annotation) => {
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
    <button id="editButton">Edit</button>
    <button id="deleteButton">Delete</button>
  `;
  notes.appendChild(noteContainer);

  document
    .querySelector(`#note-${noteId} > #editButton`)
    .addEventListener("click", () => editNote(noteId));
  document
    .querySelector(`#note-${noteId} > #deleteButton`)
    .addEventListener("click", () => removeNote(noteId));

  updateContainerHeight();
};

const removeNote = async (noteId) => {
  await annotationsApi.removeAnnotation(noteId);

  const note = document.querySelector(`#note-${noteId}`);
  note.remove();

  updateContainerHeight();
};

const editNote = (noteId) => {
  console.log(noteId);
  console.log("edit");
};

const fetchAnnotations = (activeFilters, dashboardId) => {
  console.log("fetching annotations");

  return mockedAnotations;
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
            border: 1px solid #bdbdbd;
            margin-bottom: 10px;
            box-shadow: 3px 3px 11px -7px rgba(66, 68, 90, 1);
            border-radius: 10px;
            padding: 10px;
            transition: all 0.1s ease-in-out;
          }
          #submitButton {
            flex-shrink: 0;
            width: 100px;
            height: 40px;
            border-radius: 10px;
            border: 0px solid #bdbdbd;
            padding: 3px;
            color: white;
            font-weight: bold;
            background: #1E90FF;
            box-shadow: 3px 3px 11px -7px rgba(66, 68, 90, 1);
            margin: 0px;
          }
          #noteInput, #submitInput {
            flex-grow: 1;
            height: 40px;
            border-radius: 10px;
            border: 1px solid #bdbdbd;
            padding: 3px;
            box-shadow: 3px 3px 11px -7px rgba(66, 68, 90, 1);
            margin: 0px;
            margin-right: 5px;
            border-radius: 5px;
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
          }
          #editButton, #deleteButton {
            height: 40px;
            border: 0px solid #bdbdbd;
            width: 50px;
            font-size: 10px;
            border-radius: 8px;
            background: #1E90FF;
            font-weight: bold;
            px: 5px;
            color: white;
            margin: 0px 2px;
          }
        </style>
        <div>
          <div id="notes">
          </div>
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

    const annotations = await annotationsApi.getAnnotations();

    for (let i = 0; i < annotations.length; i++) {
      addNote(annotations[i]);
    }
  },

  updateAsync: function (
    data,
    element,
    config,
    queryResponse,
    details,
    doneRendering
  ) {
    doneRendering();
  },
};

looker.plugins.visualizations.add(visObject);
