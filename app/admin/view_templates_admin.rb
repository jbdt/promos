Trestle.resource(:view_templates) do
  menu do
    item :view_templates, icon: "fa fa-paint-brush", label: "View Templates", priority: 2
  end

  form dialog: true do |view_template|
    text_field :name
    text_area :description
    
    if view_template.images.attached?
      row do
        view_template.images.each do |image|
          col(sm: 3) do
            image_tag Rails.application.routes.url_helpers.rails_blob_path(image.variant(resize_to_limit: [100, 100]).processed, only_path: true), alt: view_template.name, class: "template-image"
          end
        end
      end
    end
    
    file_field :images, multiple: true
  end

  table do
    column :name
    column :description
    column "Images" do |view_template|
      if view_template.images.attached?
        view_template.images.map do |image|
          image_tag Rails.application.routes.url_helpers.rails_blob_path(image.variant(resize_to_limit: [50, 50]).processed, only_path: true), class: "thumbnail"
        end.join(" ").html_safe
      end
    end

    column "Preview", align: :center do |view_template|
      link_to Rails.application.routes.url_helpers.view_template_preview_path(id: view_template.id), target: "_blank", class: "btn btn-primary" do
        "<i class='fa fa-eye'></i>".html_safe
      end
    end
  end

  search do |query|
    if query
      ViewTemplate.where("name ILIKE ?
        OR description ILIKE ?", "%#{query}%", "%#{query}%")
    else
      ViewTemplate.all
    end
  end
end
