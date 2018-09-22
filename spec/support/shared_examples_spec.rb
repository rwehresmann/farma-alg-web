# `api_endpoint` must be defined were :deny_without_authorization is called.

shared_examples_for :deny_without_authorization do |method_type, params = {}|
	it 'returns unauthrorized(401) request' do
		case method_type
		when :get
			get api_endpoint,
				params: params,
				headers: header_without_authentication
		when :post
			post api_endpoint,
				params: params,
				headers: header_without_authentication
		when :put
			put api_endpoint,
				params: params,
				headers: header_without_authentication
		when :delete
			delete api_endpoint,
				params: params,
				headers: header_without_authentication
		end

		expect(response.status).to eql(401)
	end
end
