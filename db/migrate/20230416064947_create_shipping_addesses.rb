class CreateShippingAddesses < ActiveRecord::Migration[6.1]
  def change
    create_table :shipping_addesses do |t|

      t.timestamps
    end
  end
end
