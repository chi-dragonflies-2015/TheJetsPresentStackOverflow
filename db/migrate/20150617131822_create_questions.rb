class CreateQuestions < ActiveRecord::Migration
  def change
    create_table :questions do |t|
      t.string :title
      t.text  :content
      t.integer :asker_id
      t.integer :best_answer_id

      t.timestamps
    end
  end
end
