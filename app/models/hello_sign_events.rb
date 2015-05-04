class HelloSignEvents

  attr_reader :json

  def initialize(json = nil)
    @json = JSON.parse(json)
  end

  def process
    if event_type == 'signature_request_signed'
      signature_request = SignatureRequest.find(server_signature_request_id)
      TwilioMessages.send phone_number: signature_request.phone_number,
        body: "Your document was received."
    end
  end

  private

  def event_type
    json['event']['event_type']
  end

  def server_signature_request_id
    json['signature_request']['metadata']['server_signature_request_id']
  end
end
