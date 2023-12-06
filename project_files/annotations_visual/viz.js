let currentAnnotationId = 0;

const mockedAnotations = [];

const updateContainerHeight = () => {
  const notes = document.querySelector("#notes");
  notes.style.height = `${
    document.querySelectorAll(".note").length * 50 + 20
  }px`;
};

const addNote = () => {
  const notes = document.querySelector("#notes");
  const noteContainer = document.createElement("div");

  const input = document.querySelector("#submitInput");
  const text = input.value ?? "Empty note";
  input.value = "";

  noteContainer.setAttribute("id", `note-${currentAnnotationId}`);
  noteContainer.setAttribute("class", "note");
  noteContainer.innerHTML = `
    <input id="noteInput" value="${text}"/>
    <button id="editButton">Edit</button>
    <button id="deleteButton" onClick="removeNote(${currentAnnotationId})">Delete</button>
  `;
  notes.appendChild(noteContainer);

  updateContainerHeight();
  currentAnnotationId++;
};
const removeNote = (noteId) => {
  const note = document.querySelector(`#note-${noteId}`);
  note.remove();

  updateContainerHeight();
};

const fetchAnnotations = (activeFilters, dashboardId) => {
  console.log("fetching annotations");

  return mockedAnotations;
};

const visObject = {
  create: function (element, config) {
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
            height: 40px;
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
            <button id="submitButton" onClick="addNote()">Add note</button>
          </div>
        </div>
      `;
  },

  updateAsync: function (
    data,
    element,
    config,
    queryResponse,
    details,
    doneRendering
  ) {
    // TODO: fetch and render annotations
    const annotations = fetchAnnotations(
      queryResponse.activeFilters ?? [],
      document.referrer
    );

    doneRendering();
  },
};

looker.plugins.visualizations.add(visObject);
