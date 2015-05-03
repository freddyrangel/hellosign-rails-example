class SignatureRequestsController < ApplicationController

  def index
    @signature_requests = SignatureRequest.all
  end

  def new
    @signature_request = SignatureRequest.new
  end

  def create
    @signature_request = SignatureRequest.new(signature_request_params)

    if @signature_request.save
      redirect_to signature_requests_path
    else
      render :new
    end
  end

  private

  def signature_request_params
    params.require(:signature_request).permit(:email, :name, :phone_number)
  end
end
