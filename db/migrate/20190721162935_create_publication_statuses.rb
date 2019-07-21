class CreatePublicationStatuses < ActiveRecord::Migration[6.0]
  def change
    create_table :publication_statuses do |t|
      t.string :name

      t.timestamps
    end
  end
end
