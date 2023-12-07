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
                filters: currentFilters ?? "{}",
                url: generateURL() ?? "empty",
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
                    url: generateURL() ?? "empty",
                    explore: "dummy_explore",
                }),
            }
        );

        return updatedAnnotation;
    }
}

const generateURL = () => {
    let url = new URL(document.referrer.split("?")[0]);
    let params = new URLSearchParams(url.search);

    for (const [filterName, value] of Object.entries(currentFilters ?? {})) {
        params.set(filterName, encodeURIComponent(value));
    }

    console.log(url);
    console.log(params);

    return params;
};

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

let currentFilters = "{}";
let currentDoneFunction = () => {};
const debouncedRenderNotes = debounce(() => {
    renderNotes(currentFilters).then(
        () => {
            console.log("done rerendering");
            currentDoneFunction();
        },
        () => {
            console.log("done rerendering");
            currentDoneFunction();
        }
    );
}, 1000);

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
                    document.querySelector("#submitInput")?.value ??
                        "Empty note"
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
        // queryResponse.applied_filters = {
        //     "products.cost": {
        //         field: {
        //             align: "right",
        //             can_filter: true,
        //             category: "dimension",
        //             default_filter_value: null,
        //             description: "",
        //             enumerations: null,
        //             field_group_label: null,
        //             fill_style: null,
        //             fiscal_month_offset: 0,
        //             has_allowed_values: false,
        //             hidden: false,
        //             is_filter: false,
        //             is_numeric: true,
        //             label: "Products Cost",
        //             label_from_parameter: null,
        //             label_short: "Cost",
        //             map_layer: null,
        //             name: "products.cost",
        //             strict_value_format: false,
        //             requires_refresh_on_sort: false,
        //             sortable: true,
        //             suggestions: null,
        //             tags: [],
        //             type: "number",
        //             user_attribute_filter_types: [
        //                 "number",
        //                 "advanced_filter_number",
        //             ],
        //             value_format: null,
        //             view: "products",
        //             view_label: "Products",
        //             dynamic: false,
        //             week_start_day: "monday",
        //             original_view: "products",
        //             dimension_group: null,
        //             error: null,
        //             field_group_variant: "Cost",
        //             measure: false,
        //             parameter: false,
        //             primary_key: false,
        //             project_name: "annotations_write_back",
        //             scope: "products",
        //             suggest_dimension: "products.cost",
        //             suggest_explore: "ecommerce_orders",
        //             suggestable: false,
        //             is_fiscal: false,
        //             is_timeframe: false,
        //             can_time_filter: false,
        //             time_interval: null,
        //             lookml_link:
        //                 "/projects/annotations_write_back/files/views%2Fproducts.view.lkml?line=22",
        //             permanent: null,
        //             source_file: "views/products.view.lkml",
        //             source_file_path:
        //                 "annotations_write_back/views/products.view.lkml",
        //             sql: "${TABLE}.cost ",
        //             sql_case: null,
        //             filters: null,
        //             times_used: 0,
        //         },
        //         value: "[0,100]",
        //     },
        // };

        const parsedFilters = {};
        for (const [filterName, value] of Object.entries(
            queryResponse?.applied_filters ?? {}
        )) {
            parsedFilters[filterName] =
                typeof value.value === "string"
                    ? value.value
                    : JSON.stringify(value.value);
        }

        console.log(queryResponse);
        console.log(parsedFilters);
        console.log(JSON.stringify(parsedFilters));
        console.log(document.referrer);

        currentFilters = JSON.stringify(parsedFilters);
        currentDoneFunction = doneRendering;
        debouncedRenderNotes();
    },
};

looker.plugins.visualizations.add(visObject);
