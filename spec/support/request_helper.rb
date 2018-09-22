module RequestHelper
  # This is tricky: our serializer gem describe in a relationship the type of the object.
  # For instance: ...:relationships=>{:user=>{:data=>{:id=>"6", :type=>:user}}}...
  # Note that :type value return as a symbol too (:user). JSON.parse returns this same 
  # value as a string, and here is the problem: in our tests, we wanna check if the returns
  # are the same, and even if they're, the expectation will fail, because one returns a symbol
  # and other a string. So we get the serialized object from the gem, and parse with JSON.parse
  # to get the same format. 
  def serialize(serializer, object)
    serializer.new(object).serialized_json
  end

  def get_serializable_hash(serializer, object)
    serializer.new(object).serializable_hash
  end

  def response_json
    response.body
  end

  def header_with_authentication(user)
    token = Knock::AuthToken.new(payload: { sub: user.id }).token
    
    return { 'Authorization' => "Bearer #{token}" }
  end

  def header_without_authentication
    return { 'content-type' => 'application/json' }
  end
end
