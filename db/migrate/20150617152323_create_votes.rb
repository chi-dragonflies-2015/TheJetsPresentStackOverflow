class CreateVotes < ActiveRecord::Migration
  def change
    create_table :votes do |t|
      t.integer :value
      t.integer :voter_id
      t.references :voteable, polymorphic: true, index: true

      t.timestamps
    end
  end
end
