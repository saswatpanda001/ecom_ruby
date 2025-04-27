class AddFieldsToPages < ActiveRecord::Migration[8.0]
  def change
    add_column :pages, :about_us, :text
    add_column :pages, :our_story, :text
    add_column :pages, :mission, :text
    add_column :pages, :values, :text
    add_column :pages, :phone, :string
    add_column :pages, :email, :string
    add_column :pages, :instagram, :string
    add_column :pages, :address, :string
  end
end
