class AddProductToUser < ActiveRecord::Migration[6.1]
  def change
    add_column :users, :product, :string
  end
end
