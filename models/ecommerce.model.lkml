# MODEL PARAMETERS
connection: "lookerdata"
include: "/views/**/*.view.lkml"
# include: "/dashboards/*.dashboard.lookml"
# include: "/project_files/*"

# DATAGROUPS & ACCESS GRANTS
datagroup: ecommerce_default_datagroup {
  # sql_trigger: SELECT MAX(id) FROM etl_log;;
  max_cache_age: "1 hour"
}

persist_with: ecommerce_default_datagroup

# EXPLORES
# explore: transaction_detail {
#     join: transaction_detail__items {
#       view_label: "Transaction Detail: Items"
#       sql: LEFT JOIN UNNEST(${transaction_detail.items}) as transaction_detail__items ;;
#       relationship: one_to_many
#     }
# }
