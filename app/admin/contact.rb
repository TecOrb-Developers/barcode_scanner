ActiveAdmin.register Contact, as: "UserMessages" do
#actions :all, except: [:edit]
filter :name,:label => "UserName"
permit_params :name,:subject,:description

index do
    selectable_column
    column 'UserName',:name 
    column :subject
    column :description 
    actions
  end
  show do 
    attributes_table do
      row :name 
      row :subject
      row :description
      end
    end
 end
