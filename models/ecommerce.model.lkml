# # Define the database connection to be used for this model.
connection: "lookerdata"

# # include all the views
# include: "/views/**/*.view.lkml"

# # Datagroups define a caching policy for an Explore. To learn more,
# # use the Quick Help panel on the right to see documentation.

# datagroup: ecommerce_default_datagroup {
#   # sql_trigger: SELECT MAX(id) FROM etl_log;;
#   max_cache_age: "1 hour"
# }

# persist_with: ecommerce_default_datagroup

# # Explores allow you to join together different views (database tables) based on the
# # relationships between fields. By joining a view into an Explore, you make those
# # fields available to users for data analysis.
# # Explores should be purpose-built for specific use cases.

# # To see the Explore you’re building, navigate to the Explore menu and select an Explore under "Ecommerce"

# explore: transaction_detail {
#     join: transaction_detail__items {
#       view_label: "Transaction Detail: Items"
#       sql: LEFT JOIN UNNEST(${transaction_detail.items}) as transaction_detail__items ;;
#       relationship: one_to_many
#     }
# }
