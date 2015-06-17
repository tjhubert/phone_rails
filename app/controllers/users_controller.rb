class UsersController < ApplicationController
	def index
		@user = current_user
	end

	def send_code_again
    # @user = User.find(params[:id])
    puts 'SENDING CODE'
		current_user.generate_new_code_and_send_sms
		redirect_to edit_user_registration_path
	end

	def verify_phone_number
    # @user = User.find(params[:id])
    puts 'PARAMS:'
		print params
		code_entered = params['code_entered']
		puts 'CODE ENTERED:'
		print code_entered
		current_user.verify_phone_verification_code_with_code_entered(code_entered)
		redirect_to edit_user_registration_path
	end

end
