Trestle.resource(:daily_views) do
  menu do
    item :daily_views, icon: "fa fa-calendar", label: "Calendar", priority: 1
  end

  scope :upcoming, -> { DailyView.where("day >= ?", Date.today).order(:day) }, default: true
  scope :past, -> { DailyView.where("day < ?", Date.today).order(day: :desc) }
  scope :all_days, -> { DailyView.order(:day) }

  form dialog: true do |daily_view|
    date_field :day
    select :view_template_id, ViewTemplate.all.collect { |vt| [vt.name, vt.id] }, label: "Template"

    if daily_view.view_template && daily_view.view_template.images.attached?
      row do
        daily_view.view_template.images.each do |image|
          col(sm: 3) do
            image_tag Rails.application.routes.url_helpers.rails_blob_path(image.variant(resize_to_limit: [100, 100]).processed, only_path: true), alt: daily_view.view_template.name, class: "template-image"
          end
        end
      end
    end

    select :base_template_id, BaseTemplate.all.collect { |bt| [bt.name, bt.id] }, label: "Base Template"  # Nueva selección para BaseTemplate

    if daily_view.base_template && daily_view.base_template.images.attached?
      row do
        daily_view.base_template.images.each do |image|
          col(sm: 3) do
            image_tag Rails.application.routes.url_helpers.rails_blob_path(image.variant(resize_to_limit: [100, 100]).processed, only_path: true), alt: daily_view.base_template.name, class: "template-image"
          end
        end
      end
    end
  end

  table do
    column :day, sort: :day do |dv|
      dv.day.strftime("%m/%d/%Y")
    end
    column "Day of the Week", sort: :day_of_the_week,  align: :center do |dv|
      content_tag(:span, dv.day.strftime("%A"), class: "badge badge-secondary")
    end

    column "View Template", sort: :view_template do |dv|
      template_name = content_tag(:strong, dv.view_template.name)
      images = dv.view_template.images.map do |image|
        image_tag Rails.application.routes.url_helpers.rails_blob_path(image.variant(resize_to_limit: [50, 50]).processed, only_path: true), class: "thumbnail"
      end.join(" ").html_safe

      "#{template_name}<br>#{images}".html_safe
    end

    column "Base Template", sort: :base_template do |dv|
      base_template_name = content_tag(:strong, dv.base_template.name)
      base_images = dv.base_template.images.map do |image|
        image_tag Rails.application.routes.url_helpers.rails_blob_path(image.variant(resize_to_limit: [50, 50]).processed, only_path: true), class: "thumbnail"
      end.join(" ").html_safe

      "#{base_template_name}<br>#{base_images}".html_safe
    end

    column "Views Count", sort: :views_count, align: :center do |dv|
      content_tag(:span, dv.views_count, class: "badge badge-danger") # Puedes cambiar "badge-info" por otras clases de Bootstrap como "badge-success", "badge-danger", etc.
    end

    column "Preview", align: :center do |dv|
      link_to Rails.application.routes.url_helpers.daily_view_preview_path(dv), target: "_blank", class: "btn btn-primary" do
        "<i class='fa fa-eye'></i>".html_safe
      end
    end
  end

  sort_column(:view_template) do |collection, order|
    sorted = collection.to_a.sort_by { |dv| dv.view_template.name }
    sorted.reverse! if order == :desc
    sorted
  end

  sort_column(:base_template) do |collection, order|
    sorted = collection.to_a.sort_by { |dv| dv.base_template.name }
    sorted.reverse! if order == :desc
    sorted
  end

  sort_column(:day) do |collection, order|
    sorted = collection.to_a.sort_by { |dv| dv.day }
    sorted.reverse! if order == :desc
    sorted
  end

  sort_column(:day) do |collection, order|
    sorted = collection.to_a.sort_by { |dv| dv.views_count }
    sorted.reverse! if order == :desc
    sorted
  end

  sort_column(:day_of_the_week) do |collection, order|
    days_of_week = ["Monday", "Tuesday", "Wednesday", "Thursday", "Friday", "Saturday", "Sunday"]
    sorted = collection.to_a.sort_by { |dv| days_of_week.index(dv.day.strftime("%A")) }
    sorted.reverse! if order == :desc
    sorted
  end
end
