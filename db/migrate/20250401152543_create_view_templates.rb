class CreateViewTemplates < ActiveRecord::Migration[7.2]
  def change
    create_table :view_templates do |t|
      t.string :name
      t.text :description

      t.timestamps
    end
  end
end
