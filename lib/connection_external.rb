class ConnectionExternal
  def initialize(connection_class: Typhoeus, base_url: nil)
    @connection_class = connection_class
    @base_url = base_url || 'https://graph.microsoft.com/v1.0'
  end

  def post(endpoint:, payload: '', headers: nil)
    response = @connection_class.post(build_url(endpoint),
                                      headers: headers || base_headers, body: payload)

    JSON.parse(response.body) if response.body.present?
  end

  def put(endpoint:, payload: '', headers: nil)
    response = @connection_class.put(build_url(endpoint),
                                     headers: headers || base_headers, body: payload)

    JSON.parse(response.body) if response.body.present?
  end

  def get(endpoint:, headers: nil)
    response = @connection_class.get(build_url(endpoint), headers: headers || base_headers)

    JSON.parse(response.body) if response.body.present?
  end

  def delete(endpoint:, payload: '', headers: nil)
    response = @connection_class.delete(build_url(endpoint),
                                        headers: headers || base_headers, body: payload)

    JSON.parse(response.body) if response.body.present?
  end

  private

  def build_url(endpoint)
    "#{@base_url}/#{endpoint}"
  end

  def base_headers
    { 'Content-Type': 'application/json' }
  end
end
