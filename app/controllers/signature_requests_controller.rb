class SignatureRequestsController < ApplicationController
  skip_before_action :verify_authenticity_token, only: [:callbacks]

  def index
    @signature_requests = SignatureRequest.all
  end

  def new
    @signature_request = SignatureRequest.new
  end

  def create
    @signature_request = SignatureRequest.new(signature_request_params)

    if @signature_request.save && send_signature_request && text_signer
      redirect_to signature_requests_path
    else
      render :new
    end
  end

  def callbacks
    respond_to do |format|
      format.json { render json: 'Hello API Event Received', status: 200 }
    end
  end

  private

  def signature_request_params
    params.require(:signature_request).permit(:email, :name, :phone_number)
  end

  def send_signature_request
    HelloSign.send_signature_request test_mode: 1,
      title: 'Example Request',
      subject: 'Please Sign',
      message: 'This is an example signature request. Not legally binding.',
      signers: [{
        email_address: @signature_request.email,
        name: @signature_request.name
      }],
      files: ["#{Rails.root}/public/hellosign_test_template.pdf"]
  end

  def text_signer
    twilio = Twilio::REST::Client.new ENV['TWILIO_ACCOUNT_SID'], ENV['TWILIO_AUTH_TOKEN']
    twilio.account.messages.create({
      from: '+17024873281',
      to: @signature_request.phone_number.gsub(/\D/, ''),
      body: "You have a new signature request send to this email: #{@signature_request.email}"
    })
  end
end
