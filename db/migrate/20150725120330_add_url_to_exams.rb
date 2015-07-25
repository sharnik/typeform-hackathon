class AddUrlToExams < ActiveRecord::Migration
  def change
    add_column :exams, :url, :string
  end
end
