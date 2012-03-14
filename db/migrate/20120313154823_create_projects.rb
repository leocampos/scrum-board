class CreateProjects < ActiveRecord::Migration
  def change
    create_table :projects do |t|
      t.string :name
      t.string :repository
      t.integer :team_id
      t.string :qa_approved_url
      t.string :production_version_url
      t.boolean :pilot

      t.timestamps
    end
  end
end
