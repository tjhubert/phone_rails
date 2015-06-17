class AddPhoneNumberToUsers < ActiveRecord::Migration
  def change
    add_column 	:users, :name, :string
    add_column 	:users, :phone_number, :string
    add_column 	:users, :phone_number_verified, :boolean
    add_column 	:users, :phone_verification_code, :string
    add_column 	:users, :phone_verification_code_sent_at, :datetime
    add_column 	:users, :phone_verified_at, :datetime

    add_index 	:users, :phone_number, unique: true
  end
end
