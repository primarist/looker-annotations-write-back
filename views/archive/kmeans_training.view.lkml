view: kmeans_training {
  sql_table_name: `dl_ecomm.kmeans_training` ;;

# DIMENSIONS
  dimension: accessories_avg_qty {
    type: number
    sql: ${TABLE}.accessories_avg_qty ;;
  }

  dimension: active_avg_qty {
    type: number
    sql: ${TABLE}.active_avg_qty ;;
  }

  dimension: add_to_cart {
    type: number
    sql: ${TABLE}.add_to_cart ;;
  }

  dimension: avg_quantity_per_order {
    type: number
    sql: ${TABLE}.avg_quantity_per_order ;;
  }

  dimension: avg_unit_price {
    type: number
    sql: ${TABLE}.avg_unit_price ;;
  }

  dimension: blazers_and_jackets_avg_qty {
    type: number
    sql: ${TABLE}.blazers_and_jackets_avg_qty ;;
  }

  dimension: cancel_order {
    type: number
    sql: ${TABLE}.cancel_order ;;
  }

  dimension: clothing_sets_avg_qty {
    type: number
    sql: ${TABLE}.clothing_sets_avg_qty ;;
  }

  dimension: dresses_avg_qty {
    type: number
    sql: ${TABLE}.dresses_avg_qty ;;
  }

  dimension: email {
    type: number
    sql: ${TABLE}.email ;;
  }

  dimension: event_usage {
    type: number
    sql: ${TABLE}.event_usage ;;
  }

  dimension: fashion_hoodie_avg_qty {
    type: number
    sql: ${TABLE}.fashion_hoodie_avg_qty ;;
  }

  dimension: home_visits {
    type: number
    sql: ${TABLE}.home_visits ;;
  }

  dimension: jeans_avg_qty {
    type: number
    sql: ${TABLE}.jeans_avg_qty ;;
  }

  dimension: jumpsuits_and_rompers_avg_qty {
    type: number
    sql: ${TABLE}.jumpsuits_and_rompers_avg_qty ;;
  }

  dimension: leggings_avg_qty {
    type: number
    sql: ${TABLE}.leggings_avg_qty ;;
  }

  dimension: maternity_avg_qty {
    type: number
    sql: ${TABLE}.maternity_avg_qty ;;
  }

  dimension: outerwear_and_coats_avg_qty {
    type: number
    sql: ${TABLE}.outerwear_and_coats_avg_qty ;;
  }

  dimension: pants_and_capris_avg_qty {
    type: number
    sql: ${TABLE}.pants_and_capris_avg_qty ;;
  }

  dimension: pants_avg_qty {
    type: number
    sql: ${TABLE}.pants_avg_qty ;;
  }

  dimension: purchases {
    type: number
    sql: ${TABLE}.purchases ;;
  }

  dimension: shorts_avg_qty {
    type: number
    sql: ${TABLE}.shorts_avg_qty ;;
  }

  dimension: skirts_avg_qty {
    type: number
    sql: ${TABLE}.skirts_avg_qty ;;
  }

  dimension: sleep_and_lounge_avg_qty {
    type: number
    sql: ${TABLE}.sleep_and_lounge_avg_qty ;;
  }

  dimension: sock_avg_qty {
    type: number
    sql: ${TABLE}.sock_avg_qty ;;
  }

  dimension: sweaters_avg_qty {
    type: number
    sql: ${TABLE}.sweaters_avg_qty ;;
  }

  dimension: swim_avg_qty {
    type: number
    sql: ${TABLE}.swim_avg_qty ;;
  }

  dimension: tops_and_tees_avg_qty {
    type: number
    sql: ${TABLE}.tops_and_tees_avg_qty ;;
  }

  dimension: underwear_avg_qty {
    type: number
    sql: ${TABLE}.underwear_avg_qty ;;
  }

# MEASURES
  measure: count {
    type: count
  }

  measure: total_avg_unit_price {
    type: sum
    sql: ${avg_unit_price} ;;
  }

  measure: average_avg_unit_price {
    type: average
    sql: ${avg_unit_price} ;;
  }
}
