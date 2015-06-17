module VerifyPhoneNumberHelper

  def send_verification_code_to(user)
    number_to_send_to = user.phone_number
    verification_code = user.phone_verification_code

    twilio_sid = Rails.application.secrets.twilio_sid
    twilio_token = Rails.application.secrets.twilio_token
    twilio_phone_number = Rails.application.secrets.twilio_phone_number

    @twilio_client = Twilio::REST::Client.new twilio_sid, twilio_token
 
    @twilio_client.account.sms.messages.create(
      :from => "+1#{twilio_phone_number}",
      :to => number_to_send_to,
      :body => "Hi! This is MathCrunch. Your verification code is #{verification_code}"
    )
  end

end