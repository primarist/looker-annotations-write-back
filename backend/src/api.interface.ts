export interface Note {
    id: string
    dashboardId: string
    content: string 
    filters: any
    url: string
    explore: string
}

export interface NewNote extends Omit<Note, "id"> {}
export interface UpdateNote extends Note {}
export interface DeleteNote {
    id: string
}
