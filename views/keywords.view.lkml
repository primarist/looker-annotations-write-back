# The name of this view in Looker is "Keywords"
view: keywords {
  # The sql_table_name parameter indicates the underlying database table
  # to be used for all fields in this view.
  sql_table_name: `dl_ecomm.keywords` ;;
  drill_fields: [keyword_id]

  # This primary key is the unique key for this table in the underlying database.
  # You need to define a primary key in a view in order to join to other views.

  dimension: keyword_id {
    primary_key: yes
    type: number
    sql: ${TABLE}.keyword_id ;;
  }
    # Here's what a typical dimension looks like in LookML.
    # A dimension is a groupable field that can be used to filter query results.
    # This dimension will be called "Ad ID" in Explore.

  dimension: ad_id {
    type: number
    sql: ${TABLE}.ad_id ;;
  }

  dimension: bidding_strategy_type {
    type: string
    sql: ${TABLE}.bidding_strategy_type ;;
  }

  dimension: cpc_bid_amount {
    type: number
    sql: ${TABLE}.cpc_bid_amount ;;
  }

  # A measure is a field that uses a SQL aggregate function. Here are defined sum and average
  # measures for this dimension, but you can also add measures of many different aggregates.
  # Click on the type parameter to see all the options in the Quick Help panel on the right.

  measure: total_cpc_bid_amount {
    type: sum
    sql: ${cpc_bid_amount} ;;  }
  measure: average_cpc_bid_amount {
    type: average
    sql: ${cpc_bid_amount} ;;  }
  # Dates and timestamps can be represented in Looker using a dimension group of type: time.
  # Looker converts dates and timestamps to the specified timeframes within the dimension group.

  dimension_group: created {
    type: time
    timeframes: [raw, date, week, month, quarter, year]
    convert_tz: no
    datatype: date
    sql: ${TABLE}.created_at ;;
  }

  dimension: criterion_name {
    type: string
    sql: ${TABLE}.criterion_name ;;
  }

  dimension: keyword_match_type {
    type: string
    sql: ${TABLE}.keyword_match_type ;;
  }

  dimension: period_id {
    type: number
    sql: ${TABLE}.period_id ;;
  }

  dimension: quality_score {
    type: number
    sql: ${TABLE}.quality_score ;;
  }

  dimension: system_serving_status {
    type: string
    sql: ${TABLE}.system_serving_status ;;
  }
  measure: count {
    type: count
    drill_fields: [keyword_id, criterion_name, ad_events.count]
  }
}
