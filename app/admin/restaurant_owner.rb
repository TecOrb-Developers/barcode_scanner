ActiveAdmin.register RestaurantOwner do

permit_params :name,:restaurant_name,:email,:phone,:image,:chef_id

index do
    selectable_column
    id_column
     column :restaurant_name
     column 'OwnerName',:name 
     column 'Chef list' do |restaurant_owner|
       link_to restaurant_owner.chefs.count,admin_chefs_path
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
        image_tag restaurant_owner.image.url,:width => 60, :height => 60
      end
      row "List Of Product" do
       # select("name", "hdfh", Product.where(restaurant_owner_id: params[:id]).collect {|p| [ p.name, p.id ] }, { include_blank: true,:placeholder=>"Select one" })
          select :product_id, collection: options_for_select(Product.where(restaurant_owner_id: params[:id]).collect{|l| [l.name, l.id]}.unshift(''), {:include_blank => "Select one"}) 
      end



  end
  end

end
