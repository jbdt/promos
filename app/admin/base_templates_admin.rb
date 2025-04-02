Trestle.resource(:base_templates) do
  menu do
    item :base_templates, icon: "fa fa-image", label: "Base Templates", priority: 3
  end

  form dialog: true do |base_template|
    text_field :name
    text_area :description
    
    if base_template.images.attached?
      row do
        base_template.images.each do |image|
          col(sm: 3) do
            image_tag Rails.application.routes.url_helpers.rails_blob_path(image.variant(resize_to_limit: [100, 100]).processed, only_path: true), alt: base_template.name, class: "template-image"
          end
        end
      end
    end

    file_field :images, multiple: true
  end

  table do
    column :name
    column :description
    column "Images" do |base_template|
      if base_template.images.attached?
        base_template.images.map do |image|
          image_tag Rails.application.routes.url_helpers.rails_blob_path(image.variant(resize_to_limit: [50, 50]).processed, only_path: true), class: "thumbnail"
        end.join(" ").html_safe
      end
    end

    column "Preview", align: :center do |base_template|
      link_to Rails.application.routes.url_helpers.base_template_preview_path(id: base_template.id), target: "_blank", class: "btn btn-primary" do
        "<i class='fa fa-eye'></i>".html_safe
      end
    end
  end

  search do |query|
    if query
      BaseTemplate.where("name ILIKE ?
        OR description ILIKE ?", "%#{query}%", "%#{query}%")
    else
      BaseTemplate.all
    end
  end
end
