class QuestionSerializer
  include JSONAPI::Serializer
  attributes :name, :description, :score, :uid

  attribute :trivium_id do |question|
    question.trivium.uid
  end
end