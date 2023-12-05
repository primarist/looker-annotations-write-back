view: distribution_centers {
  sql_table_name: `dl_ecomm.distribution_centers` ;;
  drill_fields: [id]

# DIMENSIONS
  dimension: id {
    primary_key: yes
    type: number
    sql: ${TABLE}.id ;;
  }

  dimension: latitude {
    type: number
    sql: ${TABLE}.latitude ;;
  }

  dimension: longitude {
    type: number
    sql: ${TABLE}.longitude ;;
  }

  dimension: name {
    type: string
    sql: ${TABLE}.name ;;
  }

# MEASURES
  measure: count {
    type: count
    drill_fields: [id, name, products.count]
  }

  measure: total_latitude {
    type: sum
    sql: ${latitude} ;;
  }

  measure: average_latitude {
    type: average
    sql: ${latitude} ;;
  }
}
