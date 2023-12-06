import { Body, Controller, Delete, Get, Path, Post, Queries, Res, Route, TsoaResponse } from "tsoa";
import { Annotation, CreateAnnotation } from "./annotation";
import { AnnotationsService } from "./annotations.service";

export interface GetAnnotationsParams {
    /**
     * Return the annotations for a specific dashboard only
     */
    dashboardId?: string

    /**
     * If provided, return only the annotations matching the given filters
     * These filters should be serialized as JSON
     */
    filters?: string
}

@Route("annotations")
export class AnnotationsController extends Controller {
    private service: AnnotationsService = new AnnotationsService();

    /**
     * Fetches a specific annotation by ID
     * @param annotationId ID of the target annotation
     * @returns 
     */
    @Get("{annotationId}")
    public async getAnnotation(
        @Path() annotationId: string,
        @Res() notFoundResponse: TsoaResponse<404, { reason: string }>
    ): Promise<Annotation> {
        const annotation = await this.service.getAnnotation(annotationId);
        if(!annotation) {
            return notFoundResponse(404, { reason: `Annotation ${annotationId} not found` })
        } else {
            return annotation
        }
    }

    /**
     * Creates an annotation
     * @param annotation 
     * @returns 
     */
    @Post()
    public async createAnnotation(
        @Body() annotation: CreateAnnotation
    ): Promise<Annotation> {
        return this.service.createAnnotation(annotation)
    }

    /**
     * Fetches annotations for a specific dashboard
     * @param dashboardId ID of the dashboard
     * @returns 
     */
    @Get()
    public async getAnnotations(
        @Queries() queryParams: GetAnnotationsParams
    ): Promise<Annotation[]> {
        return this.service.getAnnotations(queryParams.dashboardId, queryParams.filters);
    }

    /**
     * Deletes a specific annotation by ID 
     * @param annotationId ID of the target annotation
     * @returns 
     */
    @Delete("{annotationId}")
    public async deleteAnnotation(
        @Path() annotationId: string
    ): Promise<void> {
        return this.service.deleteAnnotation(annotationId);
    }
}
