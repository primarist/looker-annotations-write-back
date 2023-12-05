view: inventory_items {
  sql_table_name: `dl_ecomm.inventory_items` ;;

# DIMENSIONS
  dimension: id {
    primary_key: yes
    type: number
    sql: ${TABLE}.id ;;
  }

  dimension: cost {
    type: number
    sql: ${TABLE}.cost ;;
  }

  dimension_group: created {
    type: time
    timeframes: [raw, date, week, month, quarter, year]
    convert_tz: no
    datatype: date
    sql: ${TABLE}.created_at ;;
  }

  dimension: product_brand {
    type: string
    sql: ${TABLE}.product_brand ;;
  }

  dimension: product_category {
    type: string
    sql: ${TABLE}.product_category ;;
  }

  dimension: product_department {
    type: string
    sql: ${TABLE}.product_department ;;
  }

  dimension: product_distribution_center_id {
    type: number
    sql: ${TABLE}.product_distribution_center_id ;;
  }

  dimension: product_id {
    type: number
    # hidden: yes
    sql: ${TABLE}.product_id ;;
  }

  dimension: product_name {
    type: string
    sql: ${TABLE}.product_name ;;
  }

  dimension: product_retail_price {
    type: number
    sql: ${TABLE}.product_retail_price ;;
  }

  dimension: product_sku {
    type: string
    sql: ${TABLE}.product_sku ;;
  }

  dimension_group: sold {
    type: time
    timeframes: [raw, time, date, week, month, quarter, year]
    sql: ${TABLE}.sold_at ;;
  }

# MEASURES
  measure: count {
    type: count
  }

  measure: total_cost {
    type: sum
    sql: ${cost} ;;
  }

  measure: average_cost {
    type: average
    sql: ${cost} ;;
  }

# SETS
  # set: dim_include_set {
  #   fields: [
  #     id,
  #     cost,
  #     created_date,
  #     created_week,
  #     created_month,
  #     created_year,

  #   ]
  # }
}
