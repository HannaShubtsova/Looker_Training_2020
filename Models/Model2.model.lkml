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



explore: products {
  label: "Products returned vs shipped"

  fields: [category,brand,name]


}
