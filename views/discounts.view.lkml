# The name of this view in Looker is "Discounts"
view: discounts {
  # The sql_table_name parameter indicates the underlying database table
  # to be used for all fields in this view.
  sql_table_name: `dl_ecomm.discounts` ;;

  # No primary key is defined for this view. In order to join this view in an Explore,
  # define primary_key: yes on a dimension that has no repeated values.

  # Dates and timestamps can be represented in Looker using a dimension group of type: time.
  # Looker converts dates and timestamps to the specified timeframes within the dimension group.

  dimension_group: date {
    type: time
    timeframes: [raw, time, date, week, month, quarter, year]
    sql: ${TABLE}.date ;;
  }
    # Here's what a typical dimension looks like in LookML.
    # A dimension is a groupable field that can be used to filter query results.
    # This dimension will be called "Discount Amount" in Explore.

  dimension: discount_amount {
    type: number
    sql: ${TABLE}.discount_amount ;;
  }

  # A measure is a field that uses a SQL aggregate function. Here are defined sum and average
  # measures for this dimension, but you can also add measures of many different aggregates.
  # Click on the type parameter to see all the options in the Quick Help panel on the right.

  measure: total_discount_amount {
    type: sum
    sql: ${discount_amount} ;;  }
  measure: average_discount_amount {
    type: average
    sql: ${discount_amount} ;;  }

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
  measure: count {
    type: count
    drill_fields: [inventory_items.id, inventory_items.product_name, products.name, products.id]
  }
}
