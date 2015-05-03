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

    if send_signature_request && @signature_request.save
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
end
