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

# EXPLORES
explore: ecommerce_orders {
  view_name: order_items
  group_label: "DashNotes: Persistent Dashboard Annotations"
  label: "eCommerce Orders Explore"
  persist_with: ecommerce_default_datagroup
  fields: [
    order_items*,
    order_items*,
    inventory_items*,
    products*,
    distribution_centers*,
    users*
  ]

  join: inventory_items {
    sql_on: ${order_items.inventory_item_id} = ${inventory_items.id} ;;
    relationship: one_to_one
    type: inner
  }

  join: products {
    sql_on: ${inventory_items.product_id} = ${products.id} ;;
    relationship: many_to_one
    type: inner
  }

  join: distribution_centers {
    sql_on: cast(${products.distribution_center_id} as string) = cast(${distribution_centers.id} as string) ;;
    relationship: many_to_one
    type: inner
  }

  join: users {
    sql_on: ${order_items.user_id} = ${users.id} ;;
    relationship: many_to_one
    type: inner
  }
}

explore: annotations {
  # extends: [ecommerce_orders]
  group_label: "DashNotes: Persistent Dashboard Annotations"
  label: "Annotations Explore"
  persist_with: ecommerce_default_datagroup

  # join: annotations {
  #   sql_on: ${order_items.notes_join_key} = ${annotations.notes_join_key} ;;
  #   relationship: one_to_one
  #   type: inner
  # }
}
