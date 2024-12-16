class CreateServiceRequests < ActiveRecord::Migration[7.1]
  def change
    create_table :service_requests do |t|
      t.string :citizen_name
      t.string :address
      t.string :category
      t.text :description
      t.string :status, default: 'pending'
      t.references :user, null: false, foreign_key: true

      t.timestamps
    end
  end
end
