class CreateUserScores < ActiveRecord::Migration[6.1]
  def change
    create_table :user_scores do |t|
      t.references :user, null: false, foreign_key: true
      t.integer :max_score, default: 0

      t.timestamps
    end
  end
end
