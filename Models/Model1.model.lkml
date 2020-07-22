connection: "snowlooker"
label: " Hanna_Shubtsova_Training_Model1"
#access_grant: can_view_financial_data {# @ user_attribute: department
#  allowed_values: [ "finance", "executive" ]
#}
include: "/views/*.view.lkml"                # include all views in the views/ folder in this project
# include: "/**/view.lkml"                   # include all views in this project
# include: "my_dashboard.dashboard.lookml"   # include a LookML dashboard called my_dashboard
include: "/**/*.dashboard"
# # Select the views that should be a part of this model,
# # and define the joins that connect them together.

 explore: inventory_items {
  label: "Products and distribution centers"
  join: products {
    type: inner
    sql_on: ${inventory_items.product_id} = ${products.id} ;;
    relationship: many_to_one
  }

  join: distribution_centers {
    type: inner
    sql_on: ${products.distribution_center_id} = ${distribution_centers.id} ;;
    relationship: many_to_one
  }
  }

explore:  order_items{
  label: "Orders data"

  join: users {
    type: left_outer
    sql_on: ${order_items.user_id} = ${users.id} ;;
    relationship: many_to_one

  }

  join: inventory_items {
    type: left_outer
    sql_on: ${order_items.inventory_item_id} = ${inventory_items.id} ;;
    relationship: many_to_one
  }

  join: products {
    type: left_outer
    sql_on: ${inventory_items.product_id} = ${products.id} ;;
    relationship: many_to_one
  }


}
