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


explore:  order_items{
  label: "Returns analysis aggregated"
  #fields: []
  sql_always_where: ${order_items.status} =  Returned ;;
  join: users {
    type: left_outer
    sql_on: ${order_items.user_id} = ${users.id} ;;
    relationship: many_to_one
    fields: [users.country, users.state, users.city, users.age ]
  }

  join: inventory_items {
    type: inner
    sql_on: ${order_items.inventory_item_id} = ${inventory_items.id} ;;
    relationship: many_to_one
  }

  join: products {
    type: left_outer
    sql_on: ${inventory_items.product_id} = ${products.id} ;;
    relationship: many_to_one
  }


}

explore: products {
  label: "Products returned vs shipped"
  view_name: products
  join: inventory_items_returns {
  from: inventory_items
  type:  inner
  sql_on: ${inventory_items_returns.product_id} = ${products.id} ;;
  relationship: one_to_many


  }
  join: inventory_items_sold  {
  from: inventory_items
    type:  inner
    sql_on: ${ inventory_items_sold.product_id} = ${products.id} ;;
    relationship: one_to_many



  }

}
