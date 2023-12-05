view: transaction_detail {
  sql_table_name: `dl_ecomm.transaction_detail` ;;
  drill_fields: [order_id]

# DIMENSIONS
  dimension: order_id {
    primary_key: yes
    type: number
    sql: ${TABLE}.order_id ;;
  }

  dimension_group: created_at {
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

  dimension: items {
    hidden: yes
    sql: ${TABLE}.items ;;
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

  dimension: user__age {
    type: number
    sql: ${TABLE}.user.age ;;
    group_label: "User"
    group_item_label: "Age"
  }


  dimension: user__city {
    type: string
    sql: ${TABLE}.user.city ;;
    group_label: "User"
    group_item_label: "City"
  }

  dimension: user__country {
    type: string
    sql: ${TABLE}.user.country ;;
    group_label: "User"
    group_item_label: "Country"
  }

  dimension: user__email {
    type: string
    sql: ${TABLE}.user.email ;;
    group_label: "User"
    group_item_label: "Email"
  }

  dimension: user__gender {
    type: string
    sql: ${TABLE}.user.gender ;;
    group_label: "User"
    group_item_label: "Gender"
  }

  dimension: user__location {
    type: string
    sql: ${TABLE}.user.location ;;
    group_label: "User"
    group_item_label: "Location"
  }

  dimension: user__name {
    type: string
    sql: ${TABLE}.user.name ;;
    group_label: "User"
    group_item_label: "Name"
  }

  dimension: user__state {
    type: string
    sql: ${TABLE}.user.state ;;
    group_label: "User"
    group_item_label: "State"
  }

  dimension: user__traffic_source {
    type: string
    sql: ${TABLE}.user.traffic_source ;;
    group_label: "User"
    group_item_label: "Traffic Source"
  }

  dimension_group: user__user_created {
    type: time
    timeframes: [raw, time, date, week, month, quarter, year]
    sql: ${TABLE}.user.user_created_at ;;
  }

  dimension: user__user_id {
    type: number
    sql: ${TABLE}.user.user_id ;;
    group_label: "User"
    group_item_label: "User ID"
  }

  dimension: user__zip {
    type: string
    sql: ${TABLE}.user.zip ;;
    group_label: "User"
    group_item_label: "Zip"
  }

# MEASURES
  measure: count {
    type: count
    drill_fields: [order_id, user__name]
  }

  measure: total_user__age {
    type: sum
    sql: ${user__age} ;;
  }

  measure: average_user__age {
    type: average
    sql: ${user__age} ;;
  }

}
