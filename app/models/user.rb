class User < ActiveRecord::Base
	
	include VerifyPhoneNumberHelper
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

	validates :phone_number, uniqueness: true

  before_save :set_phone_attributes, if: :phone_verification_needed?
  after_save :send_sms_for_phone_verification, if: :phone_verification_needed?

	def verify_phone_verification_code_with_code_entered(code_entered)
		verify_phone(code_entered)
	end

  def generate_new_code_and_send_sms
  	self.set_phone_attributes
		if self.save!
    	send_sms_for_phone_verification
    end
  end

  def phone_verification_needed?
    phone_number.present? && !phone_number_verified
  end

  def set_phone_attributes
  	self.phone_number_verified = false
    self.phone_verification_code = generate_phone_verification_code

    # removes all white spaces, hyphens, and parenthesis
    self.phone_number.gsub!(/[\s\-\(\)]+/, '')
  end

  private

  	# increase protection
  	def verify_phone(code_entered)
  		if self.phone_verification_code == code_entered
				mark_phone_as_verified!
			end
		end

	  def mark_phone_as_verified!
	  	update!(phone_number_verified: true,
				  	 phone_verification_code: nil,
				  	 phone_verification_code_sent_at: nil,
				  	 phone_verified_at: DateTime.now)
	  end	

	  

	  def send_sms_for_phone_verification
	    send_verification_code_to(self)
	  end

	  def generate_phone_verification_code
	    # begin
	    verification_code = SecureRandom.hex(3)
	    # end while self.class.exists?(phone_verification_code: verification_code)
	    verification_code
	  end



end



