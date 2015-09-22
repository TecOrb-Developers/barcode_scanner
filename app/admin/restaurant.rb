include AdminHelper
ActiveAdmin.register Restaurant do
menu priority: 6, label:"Restaurant Owner"
permit_params :name,:restaurant_name,:email,:phone,:image
filter :restaurant_name
filter :name,:label => "Owner Name"
filter :email
filter :phone,:label => "Phone Number"
index do
    selectable_column
    id_column
     column :restaurant_name
     column 'OwnerName',:name 
     column 'Chef list' do |restaurant|
       link_to restaurant.chef.count
      end 
    column :email
    column :phone
    actions
  end
   form do |f|
    f.inputs "Owner Details" do
      f.input :name,:label=>"OwnerName"
      f.input :restaurant_name
      f.input :image, :as => :file,:label => "Image"
      f.input :email
      f.input :phone
      
    end
    f.actions
  end
    
    show do 
      attributes_table do
        row "OwnerName" do |r|
        r.name
        end
        row :restaurant_name
        row :email
        row :phone
        row :image do
        image_tag restaurant.image.url,:width => 60, :height => 60
      end
      row "List Of Product" do
       select options_for_select(product_list),{:id=> 'list_product'}
      end
      row "List Of Ingredient" do |r|
       select options_for_select(""),{:id=> 'list_ingredient'}
      end
     end
    end
  end




