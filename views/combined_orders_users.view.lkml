view: combined_orders_users {
  sql_table_name: `dl_ecomm.combined_orders_users` ;;
  drill_fields: [user_id]

# DIMENSIONS
  dimension: user_id {
    primary_key: yes
    type: number
    sql: ${TABLE}.user_id ;;
  }

# MEASURES
  measure: count {
    type: count
    drill_fields: [user_id]
  }
}
