export interface Annotation {
    id: string
    
    /**
     * ID of the dashboard this annotation is attached to
     */
    dashboardId: string

    /**
     * Actual content of the note (HTML ? Markdown ?)
     */
    content: string 

    /**
     * JSON stringified filters
     */
    filters: string 

    /**
     * URL of the dashboard
     */
    url: string

    /**
     * Name of the looker explore
     */
    explore: string

    /**
     * Creation date of this note
     */
    createdAt: Date
}

export interface CreateAnnotation extends Omit<Annotation, "id" | "createdAt"> {}

export interface AnnotationDTO {
    annotation_id: string
    dashboard_id: string
    url: string
    explore: string
    content: string
    filters: string
    created_at: Date
}
