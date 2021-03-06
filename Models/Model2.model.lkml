connection: "snowlooker"
label: "Model2"
#access_grant: can_view_financial_data {# @ user_attribute: department
#  allowed_values: [ "finance", "executive" ]
#}
include: "/views/*.view.lkml"                # include all views in the views/ folder in this project
# include: "/**/view.lkml"                   # include all views in this project
# include: "my_dashboard.dashboard.lookml"   # include a LookML dashboard called my_dashboard
include: "/**/*.dashboard"
# # Select the views that should be a part of this model,
# # and define the joins that connect them together.



#explore: products {
#  label: "Products returned vs shipped"

#  fields: [category,brand,name]


#}

explore:  order_items_turnover {
  label: "Shipment turnover analysis"
 # fields: [order_id, status,turnover_created_delivered_days,count,sale_price,delivered_year,delivered_month,created_year,created_month]


  join: inventory_items {
      #Left Join only brings in items that have been sold as order_item
      type: left_outer
      relationship: one_to_many
      sql_on: ${inventory_items.id} = ${order_items_turnover.inventory_item_id} ;;
      fields: [inventory_items.product_name,inventory_items.product_brand,inventory_items.product_category]

    }

  join: distribution_center_location {
    view_label: "Shipped from info"
    type: left_outer
    sql_on: ${distribution_center_location.id} = ${inventory_items.product_distribution_center_id} ;;
    relationship: many_to_one
    fields: [distribution_center_location.name, distribution_center_location.location,distribution_center_location.latitude,distribution_center_location.longitude]
  }

 join: users_location {
    view_label:"Shipped to info"
    type: left_outer
    sql_on: ${order_items_turnover.user_id} = ${users_location.id};;
    fields: [users_location.state,users_location.city,users_location.zip,users_location.location, users_location.latitude,users_location.longitude]
    relationship: many_to_one
 }
}

explore: fact_orders {
  label: "Delivered VS Retured"
  view_label: "Delivered VS Retured"

join: products {
  view_label: "Products"
  type: left_outer
  sql_on: ${fact_orders.product_id} = ${products.id};;
  relationship: one_to_many

}

}

test: order_id_is_unique {
  explore_source: fact_orders {
    column: id {}
    column: count {}
    sorts: [count: desc]
    limit: 1
  }
  assert: order_id_is_unique {
    expression: ${fact_orders.count} = 1 ;;
  }
}

test: status_is_not_null {
  explore_source: fact_orders {
    column: status {}
    sorts: [status: desc]
    limit: 1
  }
  assert: status_is_not_null {
    expression: NOT is_null(${orders.status}) ;;
  }
}

test: sales_greater_then_zero{
  explore_source: fact_orders {
    column: Sales {}
    limit: 1
  }
  assert: sales_greater_then_zero {
    expression: ${fact_orders.sales}>0 ;;
  }
}
