view: keywords {
  sql_table_name: `dl_ecomm.keywords` ;;
  drill_fields: [keyword_id]

# DIMENSIONS
  dimension: keyword_id {
    primary_key: yes
    type: number
    sql: ${TABLE}.keyword_id ;;
  }

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

# MEASURES
  measure: count {
    type: count
    drill_fields: [keyword_id, criterion_name, ad_events.count]
  }

  measure: total_cpc_bid_amount {
    type: sum
    sql: ${cpc_bid_amount} ;;
  }

  measure: average_cpc_bid_amount {
    type: average
    sql: ${cpc_bid_amount} ;;
  }
}
