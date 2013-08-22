class AddUserEmailColumnToMovies < ActiveRecord::Migration
  def change
  	add_column :movies, :user_email, :string
  end
end
