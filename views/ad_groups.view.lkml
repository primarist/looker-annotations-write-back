view: ad_groups {
  sql_table_name: `dl_ecomm.ad_groups` ;;
  drill_fields: [ad_id]

# DIMENSIONS
  dimension: ad_id {
    primary_key: yes
    type: number
    sql: ${TABLE}.ad_id ;;
  }

  dimension: ad_type {
    type: string
    sql: ${TABLE}.ad_type ;;
  }

  dimension: campaign_id {
    type: number
    # hidden: yes
    sql: ${TABLE}.campaign_id ;;
  }

  dimension_group: created {
    type: time
    timeframes: [raw, date, week, month, quarter, year]
    convert_tz: no
    datatype: date
    sql: ${TABLE}.created_at ;;
  }

  dimension: headline {
    type: string
    sql: ${TABLE}.headline ;;
  }

  dimension: name {
    type: string
    sql: ${TABLE}.name ;;
  }

  dimension: period {
    type: number
    sql: ${TABLE}.period ;;
  }

# MEASURES
  measure: total_period {
    type: sum
    sql: ${period} ;;
  }

  measure: average_period {
    type: average
    sql: ${period} ;;
  }

  measure: count {
    type: count
    drill_fields: [ad_id, name, campaigns.campaign_name, campaigns.id]
  }
}
