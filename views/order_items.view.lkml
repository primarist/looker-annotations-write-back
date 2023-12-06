view: order_items {
  sql_table_name: `dl_ecomm.order_items` ;;

# DIMENSIONS
  dimension: id {
    primary_key: yes
    type: number
    sql: ${TABLE}.id ;;
  }

  dimension_group: created {
    type: time
    timeframes: [raw, time, date, week, month, quarter, year]
    sql: ${TABLE}.created_at ;;
  }

  dimension_group: delivered {
    type: time
    timeframes: [raw, date, week, month, quarter, year]
    convert_tz: no
    datatype: date
    sql: ${TABLE}.delivered_at ;;
  }

  dimension: inventory_item_id {
    type: number
    # hidden: yes
    sql: ${TABLE}.inventory_item_id ;;
  }

  dimension: order_id {
    type: number
    sql: ${TABLE}.order_id ;;
  }

  dimension_group: returned {
    type: time
    timeframes: [raw, time, date, week, month, quarter, year]
    sql: ${TABLE}.returned_at ;;
  }

  dimension: sale_price {
    type: number
    sql: ${TABLE}.sale_price ;;
  }

  dimension_group: shipped {
    type: time
    timeframes: [raw, date, week, month, quarter, year]
    convert_tz: no
    datatype: date
    sql: ${TABLE}.shipped_at ;;
  }

  dimension: status {
    type: string
    sql: ${TABLE}.status ;;
  }

  dimension: user_id {
    type: number
    # hidden: yes
    sql: ${TABLE}.user_id ;;
  }

# MEASURES
  measure: count {
    type: count
  }

  measure: total_sale_price {
    type: sum
    value_format_name: usd
    sql: ${sale_price} ;;
    link: {
      label: "Load Dashboard 1"
      url: "@{dashboard_link_1}"
    }
    link: {
      label: "Load Dashboard 2"
      url: "@{dashboard_link_1}"
    }
  }

  measure: average_sale_price {
    type: average
    value_format_name: usd
    sql: ${sale_price} ;;
    link: {
      label: "Load Dashboard 1"
      url: "@{dashboard_link_1}"
    }
    link: {
      label: "Load Dashboard 2"
      url: "@{dashboard_link_1}"
    }
  }

  # Link generator measure for the link generating script
  measure: link_generator {
    # hidden: yes
    type: number
    sql: 1 ;;
    html: {{link}} ;;
    drill_fields: [link_generator]
  }

# SETS
  # set: dim_include_set {
  #   fields: [
  #     id,
  #     created_date,
  #     created_week,
  #     created_month,
  #     created_year,
  #     delivered_date,
  #     delivered_week,
  #     delivered_month,
  #     delivered_year,
  #     inventory_item_id,
  #     order_id,
  #     returned_date,
  #     returned_week,
  #     returned_month,
  #     returned_year,
  #     sale_price,
  #     shipped_date,
  #     shipped_week,
  #     shipped_month,
  #     shipped_year,
  #     status,
  #     user_id
  #   ]
  # }

  # set: measure_include_set {
  #   fields: [
  #     count,
  #     total_sale_price,
  #     average_sale_price
  #   ]
  # }
}
