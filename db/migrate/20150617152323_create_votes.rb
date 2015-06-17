class CreateVotes < ActiveRecord::Migration
  def change
    create_table :votes do |t|
      t.integer :value
      t.integer :voter_id
      t.integer :voteable_id
      t.string  :voteable_type

      t.timestamps
    end
  end
end
