class CreatePages < ActiveRecord::Migration[6.0]
  def change
    create_table :pages do |t|
      t.references :tenant, null: false, foreign_key: { primary_key: :tenant_id }
      t.references :publication_status, null: false, foreign_key: true
      t.string :name

      t.timestamps
    end
  end
end
