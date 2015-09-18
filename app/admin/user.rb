ActiveAdmin.register User  do

#actions :all, except: [:edit]
menu priority: 5, label:"End User"
permit_params :name,:email,:dob,:image
filter :name,:label => "UserName"
filter :email
filter :dob
index do
    selectable_column
    column 'UserName',:name
    column :email
    column :dob 
    actions
  end
form do |f|
      f.inputs 'Create user' do
      f.input :image, :as => :file,:label => "Image"
      f.input :name, :label=>'UserName'
      f.input :email
      f.input :dob, as: :datepicker
     end
  f.actions
 end


  show do 
    attributes_table do
      row :image do
      image_tag user.image.url,:width => 60, :height => 60
    end
      row 'UserName' do |res|
        res.name
      end
      row :email
      row :dob
    end
      columns do
       column   do
        panel "List Of Member"do 
          table_for user.members do
         column(:name) { |member| member.name.titleize }
       end
     end
   end
 end
        
     columns do
       column max_width: "500px", min_width: "300px" ,span: 2 do
        panel "User History"do 
          table_for user.scan_histories do
          column(:product_name) { |history| history.product_name.titleize }
          column "scan date", :created_at
       end
      end
    end
    
     column max_width: "600px", min_width: "300px"  do
        panel "Preventive List" do
         table_for user.preventives do
          column(:name) { |preventive| preventive.name.titleize }
       end   
     end
    end
   end
  end
 end
