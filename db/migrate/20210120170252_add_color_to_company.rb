class AddColorToCompany < ActiveRecord::Migration[6.0]
  def self.up
    add_column :companies, :color, :string
  end
  def self.down
    remove_column :companies, :color
  end
end


