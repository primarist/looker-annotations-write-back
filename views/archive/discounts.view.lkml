view: discounts {
  sql_table_name: `dl_ecomm.discounts` ;;

# DIMENSIONS
  dimension_group: date {
    type: time
    timeframes: [raw, time, date, week, month, quarter, year]
    sql: ${TABLE}.date ;;
  }

  dimension: discount_amount {
    type: number
    sql: ${TABLE}.discount_amount ;;
  }

  dimension: discount_price {
    type: number
    sql: ${TABLE}.discount_price ;;
  }

  dimension: inventory_item_id {
    type: number
    # hidden: yes
    sql: ${TABLE}.inventory_item_id ;;
  }

  dimension: product_id {
    type: number
    # hidden: yes
    sql: ${TABLE}.product_id ;;
  }

  dimension: retail_price {
    type: number
    sql: ${TABLE}.retail_price ;;
  }

# MEASURES
  measure: count {
    type: count
    drill_fields: [inventory_items.id, inventory_items.product_name, products.name, products.id]
  }

  measure: total_discount_amount {
    type: sum
    sql: ${discount_amount} ;;
  }

  measure: average_discount_amount {
    type: average
    sql: ${discount_amount} ;;
  }
}
