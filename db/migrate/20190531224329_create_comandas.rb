class CreateComandas < ActiveRecord::Migration[5.2]
  def change
    create_table :comandas do |t|
      t.string :produtos
      t.integer :valortotal
      t.belongs_to :usuario, foreign_key: true

      t.timestamps
    end
  end
end
