class CreateUserLogs < ActiveRecord::Migration[5.1]
  def change
    create_table :user_logs do |t|
      t.string :description
      t.references :employee, index: true
      t.references :admin, index: true
      t.references :user_log_type, index: true
      t.timestamps
    end
  end
end
