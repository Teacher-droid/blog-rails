class AddUserToComment < ActiveRecord::Migration[6.1]
  def change
    add_reference :api_comments, :user, index: true
  end
end
