include: "order_items.view"
include: "inventory_items.view"

view: fact_orders {
  derived_table: {
  sql:
  SELECT
    PUBLIC.ORDER_ITEMS.ID,
    PUBLIC.ORDER_ITEMS.ORDER_ID,
    PUBLIC.ORDER_ITEMS.INVENTORY_ITEM_ID,
    PUBLIC.INVENTORY_ITEMS.PRODUCT_ID,
    PUBLIC.ORDER_ITEMS.USER_ID,
    PUBLIC.ORDER_ITEMS.STATUS,
    PUBLIC.ORDER_ITEMS.CREATED_AT,
    PUBLIC.ORDER_ITEMS.SHIPPED_AT,
    PUBLIC.ORDER_ITEMS.DELIVERED_AT,
    PUBLIC.ORDER_ITEMS.RETURNED_AT,
    PUBLIC.ORDER_ITEMS.SALE_PRICE
  FROM
    PUBLIC.ORDER_ITEMS
    JOIN PUBLIC.INVENTORY_ITEMS
    ON PUBLIC.ORDER_ITEMS. INVENTORY_ITEM_ID = PUBLIC.INVENTORY_ITEMS.ID;;

  }
  dimension: id {
    primary_key: yes
    type: number
    sql: ${TABLE}."ID" ;;
  }


  dimension_group: created_2 {
    type: time
    timeframes: [date,week, month,quarter,year]
    sql: ${TABLE}."CREATED_AT" ;;
  }

  dimension_group: delivered {
    type: time
    timeframes: [date, week, month,quarter,year]
    sql: ${TABLE}."DELIVERED_AT" ;;
  }

  dimension: inventory_item_id {
    type: number
    # hidden: yes
    sql: ${TABLE}."INVENTORY_ITEM_ID" ;;
  }

  dimension: order_id {
    type: number
    sql: ${TABLE}."ORDER_ID" ;;
  }

  dimension_group: returned {
    type: time
    timeframes: [date,week,month,quarter,year]
    sql: ${TABLE}."RETURNED_AT" ;;
  }

  dimension_group: shipped {
    type: time
    timeframes: [date,week,month,quarter,year]
    sql: ${TABLE}."SHIPPED_AT" ;;
  }

  dimension: status {
    type: string
    sql: ${TABLE}."STATUS" ;;
  }

  dimension: user_id {
    type: number
    # hidden: yes
    sql: ${TABLE}."USER_ID" ;;
  }

  dimension: product_id {
    type: number
    # hidden: yes
    sql: ${TABLE}."PRODUCT_ID" ;;
  }

  parameter: max_rank {
    type: number
  }

  dimension: rank_limit {
    type: number
    sql: {% parameter max_rank %} ;;
  }

dimension:   is_ytd {
 type: yesno
 group_label: "Date Restrictions"
 label: "Is YTD?"
 view_label: "Dynamic Grouping & Time Comparisons"
 sql:
    MONTH(${TABLE}."CREATED_AT") < MONTH(CURRENT_TIMESTAMP)
    OR
    (MONTH(${TABLE}."CREATED_AT") = MONTH(CURRENT_TIMESTAMP)
    AND
    DAY(${TABLE}."CREATED_AT") <= DAY(CURRENT_TIMESTAMP))
    ;;
}

  dimension:   is_mtd {
    type: yesno
    group_label: "Date Restrictions"
    label: "Is YTD?"
    view_label: "Dynamic Grouping & Time Comparisons"
    sql:
    MONTH(${TABLE}."CREATED_AT") = MONTH(CURRENT_TIMESTAMP)
    OR
    (MONTH(${TABLE}."CREATED_AT") = MONTH(CURRENT_TIMESTAMP)
    AND
    DAY(${TABLE}."CREATED_AT") <= DAY(CURRENT_TIMESTAMP))
    ;;
  }


  measure: Sales {
    type: sum
    sql: ${TABLE}."SALE_PRICE" ;;

  }
  measure: count {
    group_label: "Base KPIs"
    label: "All orders"
    type: count
    #sql:  ${TABLE}."ID";;
    drill_fields: [products.brand, products.name]
  }


  measure: count_YTD{
    group_label: "Running KPIs"
    label: "YTD all orders"
    type: running_total
    #sql:  Sum(COUNT(${TABLE}."ID")) over (partition by EXTRACT(YEAR FROM fact_orders."CREATED_AT" )::integer order by TO_CHAR(DATE_TRUNC('month', fact_orders."CREATED_AT" ), 'YYYY-MM') );;
    #filters: {
    #  field: is_ytd
    #  value: "yes"
    #}
    drill_fields: [products.brand, products.name]

  }
  measure: count_MTD{
    group_label: "Running KPIs"
    label: "MTD All orders"
    type: count
    #sql:  ${TABLE}."ID";;
    filters: {
      field: is_mtd
      value: "yes"
    }
    drill_fields: [products.brand, products.name]

  }

  measure: Completed {
    group_label: "Base KPIs"
    label: "Completed"
    type: count
    #sql:  ${TABLE}."ID";;
    filters: {
      field: status
      value: "Complete"
    }
    drill_fields: [products.brand, products.name]
  }

  measure: Comleted_YTD{
    group_label: "Running KPIs"
    label: "YTD Completed"
    type: count
    #sql:  ${TABLE}."ID";;
    filters: {
      field: status
      value: "Complete"
      }
      filters: {
      field: is_ytd
      value: "yes"
    }
    drill_fields: [products.brand, products.name]

  }
  measure: Comleted_MTD{
    group_label: "Running KPIs"
    label: "MTD Completed"
    type: count
    #sql:  ${TABLE}."ID";;
    filters: {
      field: status
      value: "Complete"
    }
    filters: {
      field: is_mtd
      value: "yes"
    }
    drill_fields: [products.brand, products.name]

  }

  measure: Cancellations {
    group_label: "Base KPIs"
    label: "Cancellations"
    type: count
    #sql:  ${TABLE}."ID";;
    filters: {
      field: status
      value: "Cancelled"
      }
    drill_fields: [products.brand, products.name]
  }
  measure: Returns {
    group_label: "Base KPIs"
    label: "Returns"
      type: count
    #  sql:  ${TABLE}."ID";;
      filters: {
        field: status
        value: "Returned"
      }
     drill_fields: [products.brand, products.name]
  }

  measure: Returns_YTD{
    group_label: "Running KPIs"
    label: "YTD Returns"
    type: count
    #sql:  ${TABLE}."ID";;
    filters: {
      field: status
      value: "Returned"
    }
    filters: {
      field: is_ytd
      value: "yes"
    }
    drill_fields: [products.brand, products.name]

  }
  measure: Returns_MTD{
    group_label: "Running KPIs"
    label: "MTD Returns"
    type: count
    #sql:  ${TABLE}."ID";;
    filters: {
      field: status
      value: "Returned"
    }
    filters: {
      field: is_mtd
      value: "yes"
    }
    drill_fields: [products.brand, products.name]

  }
  }
