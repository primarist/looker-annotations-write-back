import { Annotation, AnnotationDTO, CreateAnnotation } from "./annotation";
import { v4 as uuidv4 } from 'uuid'
import { Bigquery } from "./bigquery";

export class AnnotationsService {
    private bq = new Bigquery()

    private convertToDTO(annotation: Annotation): AnnotationDTO {
        return {
            annotation_id: annotation.id,
            dashboard_id: annotation.dashboardId,
            url: annotation.url,
            explore: annotation.explore,
            content: annotation.content,
            created_at: annotation.createdAt,
            filters: annotation.filters
        }
    }

    private convertFromDTO(dto: AnnotationDTO): Annotation {
        return {
            id: dto.annotation_id,
            dashboardId: dto.dashboard_id,
            content: dto.content,
            filters: dto.filters,
            url: dto.url,
            explore: dto.explore,
            createdAt: dto.created_at
        }
    }

    public async getAnnotation(annotationId: string): Promise<Annotation | undefined> {
        let q = `SELECT * FROM annotations WHERE annotation_id = @annotationId`

        const result = await this.bq.doQuery<AnnotationDTO>(q, {annotationId})
        if(result.length === 0) {
            return 
        } else {
            return this.convertFromDTO(result[0])
        }
    }

    public async getAnnotations(dashboardId?: string, filters?: string): Promise<Annotation[]> {
        let q = `SELECT * FROM annotations WHERE 1=1`

        if(dashboardId) {
            q += ` AND dashboard_id = @dashboardId`
        }

        if(filters) {
            q += ` AND filters = @filters`
        }

        const annotations = await this.bq.doQuery<AnnotationDTO>(q, {dashboardId, filters})
        return annotations.map(this.convertFromDTO)
    }

    public async deleteAnnotation(annotationId: string) {
        await this.bq.doQuery<any>(`DELETE FROM annotations WHERE annotation_id = @annotationId`, {annotationId})
        return;
    }

    public async createAnnotation(newAnnotation: CreateAnnotation): Promise<Annotation> {
        const annotation = {
            ...newAnnotation,
            id: uuidv4(),
            createdAt: new Date()
        }
        const dto = this.convertToDTO(annotation)
        await this.bq.doQuery<any>(`INSERT INTO annotations (annotation_id, dashboard_id, url, explore, content, filters, created_at) VALUES (@annotation_id, @dashboard_id, @url, @explore, @content, @filters, @created_at)`, dto)
        // await this.bq.insertRows([dto])

        return annotation
    }
}
