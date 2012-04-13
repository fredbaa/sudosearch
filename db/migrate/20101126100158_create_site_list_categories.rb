class CreateSiteListCategories < ActiveRecord::Migration
  def self.up
    create_table :site_list_categories do |t|
      t.string :code, :nil => false
      t.string :name, :nil => false
      t.timestamps
    end
  end

  def self.down
    drop_table :site_list_categories
  end
end
