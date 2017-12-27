class CreateProducts < ActiveRecord::Migration[5.1]
  def change
    create_table :products do |t|
      t.string :title
      t.text :description
      t.string :image_url
	  t.decimal :price, precision: 8, scale: 2  # Eight digits of significance and two digits after the decimal point
      
      t.timestamps
    end
  end
end
