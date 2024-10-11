# Custom RSpec matcher to compare JSON responses.
# Usage:
# expect(actual_response).to match_response(expected_response)
# You can also specify a serializer if needed:
# expect(actual_response).to match_response(expected_response).with_serializer(MySerializer)

RSpec::Matchers.define :match_response do |expected|
  match do |actual|
    @actual = JSON.parse(actual)
    @expected = serialize(expected)
    @actual == @expected
  end

  chain :with_serializer do |serializer|
    @serializer = serializer
  end

  diffable

  private

  def serialize(object)
    if object.is_a?(Array)
      object.map { |item| serialize_item(item) }
    else
      serialize_item(object)
    end
  end

  def serialize_item(item)
    if item.respond_to?(:serializable_hash)
      serializer_class = @serializer || ActiveModel::Serializer.serializer_for(item)
      raise "No serializer found for #{item.class}" unless serializer_class

      serializer_instance = serializer_class.new(item)
      serializer_instance.as_json.deep_stringify_keys
    elsif item.is_a?(Hash)
      item.deep_stringify_keys
    else
      item
    end
  end
end
