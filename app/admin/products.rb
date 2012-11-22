ActiveAdmin.register Product do
  
  
  show do |ad|
      attributes_table do
        row :title
        row :description
        row :photo do
          image_tag(ad.photo.url(:thumb))
        end
        row :price
      end
      active_admin_comments
    end
  
  
  
  form :html => { :multipart=> true } do |f|
      f.inputs "Details" do
        f.input :title
        f.input :description
        f.input :price
        f.input :photo #,:as => :file, :label => "Image",:hint => f.object.photo.nil? ? f.template.content_tag(:span, "No Image Yet") : f.template.image_tag(f.object.photo.url(:thumb))
        #f.input :_destroy, :as=>:boolean, :required => false, :label => 'Remove image'
        #f.input :photo #, :hint => "current image: #{f.template.image_tag(f.object.photo.url(:thumb))}" 
      end
      f.buttons
    end
  
end
