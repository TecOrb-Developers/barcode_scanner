ActiveAdmin.register Chef do

permit_params :name,:email,:phone,:image,:restaurant_owner_id

index do
    selectable_column
      column 'ChefName',:name 
       column :email
       column :phone
      
    actions
  end
end
