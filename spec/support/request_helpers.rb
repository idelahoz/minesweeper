require 'hashie/mash'

module RequestsHelpers
  def json
    Hashie::Mash.new JSON.parse(response.body)
  end
end