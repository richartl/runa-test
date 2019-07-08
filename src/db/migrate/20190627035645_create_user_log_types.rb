class CreateUserLogTypes < ActiveRecord::Migration[5.1]
  def change
    create_table :user_log_types do |t|
      t.string :name, null: false
      t.string :description
      t.timestamps
    end
  end
end
