class TwilioMessages
  def self.send(opts = {})
    phone_number = opts[:phone_number]
    body = opts[:body]
    twilio = Twilio::REST::Client.new ENV['TWILIO_ACCOUNT_SID'], ENV['TWILIO_AUTH_TOKEN']
    twilio.account.messages.create({
      from: '+17024873281',
      to: phone_number.gsub(/\D/, ''),
      body: body
    })
  end
end
