class CreateSignatureRequests < ActiveRecord::Migration
  def change
    create_table :signature_requests do |t|
      t.string :email
      t.string :name
      t.string :phone_number
      t.string :pin
      t.boolean :signed, default: false

      t.timestamps null: false
    end
  end
end
