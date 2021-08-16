class AddContentToTasks < ActiveRecord::Migration[6.0]
  def change
    add_column :tasks, :content, :string
  end
end
