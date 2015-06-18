class CreateAnswers < ActiveRecord::Migration
  def change
    create_table :answers do |t|
      t.string :title
      t.text  :content
      t.integer :question_id
      t.integer :answerer_id

      t.timestamps
    end
  end
end
