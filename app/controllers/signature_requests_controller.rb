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
    HelloSignEvents.new(params[:json]).process
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
      metadata: {
        server_signature_request_id: @signature_request.id.to_s
      },
      signers: [{
        email_address: @signature_request.email,
        name: @signature_request.name,
        pin: @signature_request.pin
      }],
      file_urls: [ENV['FILE_URL']]
  end

  def text_signer
    TwilioMessages.send phone_number: @signature_request.phone_number,
      body: "You have a new signature request send to this email: #{@signature_request.email}"
  end
end
