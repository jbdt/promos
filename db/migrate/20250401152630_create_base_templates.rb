class CreateBaseTemplates < ActiveRecord::Migration[6.1]
  def change
    create_table :base_templates do |t|
      t.string :name
      t.text :description

      t.timestamps
    end
  end
end
