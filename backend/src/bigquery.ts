import { BigQuery } from '@google-cloud/bigquery'
export class Bigquery {
  protected client: BigQuery
  protected dataset = 'looker_hackathon23_annotations'
  protected table = 'annotations'

  constructor() {
    this.client = new BigQuery({
      projectId: 'looker-hackathon-annotations',
      location: 'europe-west1',
    })
  }

  public async insertRows(rows: any[]) {
    await this.client.dataset(this.dataset).table(this.table).insert(rows)
  }

  public async doQuery<T extends object>(queryString: string, parameters: any = {}): Promise<T[]> {
    // console.log(queryString)
    const [job] = await this.client.createQueryJob({
      query: queryString,
      location: 'europe-west1',
      params: parameters,
      defaultDataset: {
        datasetId: 'looker_hackathon23_annotations',
      },
    })

    const [rows] = await job.getQueryResults()
    return rows as T[]
  }
}
