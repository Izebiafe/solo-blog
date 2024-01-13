# frozen_string_literal: true

class AddUserRefToComments < ActiveRecord::Migration[7.1]
  def change
    add_reference :comments, :user, index: true, foreign_key: true
    add_reference :comments, :post, index: true, foreign_key: true
  end
end
