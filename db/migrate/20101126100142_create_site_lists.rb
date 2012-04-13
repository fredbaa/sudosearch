class CreateSiteLists < ActiveRecord::Migration
  def self.up
    create_table :site_lists do |t|
      t.string    :code, :nil => false
      t.string    :name, :nil => false
      t.text      :url,  :nil => false
      t.integer   :site_list_category_id, :nil => false
      t.timestamps
    end
  end

  def self.down
    drop_table :site_lists
  end
end
