provider "google" {
  project = "looker-hackathon-annotations"
  region  = "europe-west1"
  zone    = "us-central1-c"
}

# Add bigquery dataset 
module "bigquery" {
  source       = "terraform-google-modules/bigquery/google"
  version      = "~> 7.0"
  dataset_id   = "looker_hackathon23_annotations"
  dataset_name = "looker_hackathon23_annotations"
  project_id   = "looker-hackathon-annotations"
  location     = "europe-west1"

  access = [
    {
      role          = "roles/bigquery.dataOwner"
      special_group = "projectOwners"
    }
  ]

  tables = [
    {
      table_id           = "annotations"
      clustering         = null
      expiration_time    = null
      labels             = null
      range_partitioning = null
      time_partitioning  = null
      schema             = <<EOF
[
  {
    "name": "annotation_id",
    "type": "STRING",
    "mode": "REQUIRED",
    "description": "Annotation unique ID"
  },
  {
    "name": "content",
    "type": "STRING",
    "mode": "NULLABLE",
    "description": "Content of the annotation"
  },
  {
    "name": "filters",
    "type": "STRING",
    "mode": "NULLABLE",
    "description": "Filters to get this annotation"
  },
  {
    "name": "url",
    "type": "STRING",
    "mode": "REQUIRED",
    "description": "Context url"
  },
  {
    "name": "explore",
    "type": "STRING",
    "mode": "REQUIRED",
    "description": "Name of the explore this annotation is for"
  },
  {
    "name": "dashboard_id",
    "type": "STRING",
    "mode": "NULLABLE",
    "description": "Dashboard ID"
  },
  {
    "name": "created_at",
    "type": "TIMESTAMP",
    "mode": "REQUIRED",
    "description": "Creation timestamp of the annotation"
  }
]
EOF

  }]
}

