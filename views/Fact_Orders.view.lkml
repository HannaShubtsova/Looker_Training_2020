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


  dimension_group: created {
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

  measure: Sales {
    type: sum
    sql: ${TABLE}."SALE_PRICE" ;;

  }
  measure: Completed {
    label: "Completed"
    type: count
    #sql:  ${TABLE}."ID";;
    filters: {
      field: status
      value: "Complete"
    }
  }
  measure: Cancellations {
    label: "Cancellations"
    type: count
    #sql:  ${TABLE}."ID";;
    filters: {
      field: status
      value: "Cancelled"
      }
  }
  measure: Returns {
      label: "Returns"
      type: count
    #  sql:  ${TABLE}."ID";;
      filters: {
        field: status
        value: "Returned"
      }
  }
  }
