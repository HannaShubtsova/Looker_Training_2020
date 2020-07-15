connection: "snowlooker"
label: "Model2"
#access_grant: can_view_financial_data {# @ user_attribute: department
#  allowed_values: [ "finance", "executive" ]
#}
include: "/views/*.view.lkml"                # include all views in the views/ folder in this project
# include: "/**/view.lkml"                   # include all views in this project
# include: "my_dashboard.dashboard.lookml"   # include a LookML dashboard called my_dashboard

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
    fields: [distribution_center_location.name, distribution_center_location.location]
  }

 join: users_location {
    view_label:"Shipped to info"
    type: left_outer
    sql_on: ${order_items_turnover.user_id} = ${users_location.id};;
    fields: [users_location.state,users_location.city,users_location.zip,users_location.location]
    relationship: many_to_one
 }
}





explore: fact_orders {}
