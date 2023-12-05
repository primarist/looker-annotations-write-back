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
explore: order_items {
    join: inventory_items {
      sql_on: ${order_items.inventory_item_id} = ${inventory_items.id} ;;
      relationship: one_to_one
      type: inner
    }

    join: distribution_centers {
      sql_on: ${inventory_items.product_distribution_center_id} = ${distribution_centers.id} ;;
      relationship: many_to_one
      type: inner
    }

    join: products {
      sql_on: ${inventory_items.product_id} = ${products.id} ;;
      relationship: many_to_one
      type: inner
    }

    join: users {
      sql_on: ${order_items.user_id} = ${users.id} ;;
      relationship: many_to_one
      type: inner
    }
}
