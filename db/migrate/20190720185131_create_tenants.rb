class CreateTenants < ActiveRecord::Migration[6.0]
  def change
    create_table :tenants, id: false do |t|
      t.integer :tenant_id, null: false, index: { unique: true }
      t.string :name

      t.timestamps
    end
  end
end
