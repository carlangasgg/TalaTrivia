class OptionSerializer
  include JSONAPI::Serializer
  attributes :name, :correct_option, :uid

  attribute :question_id do |option|
    option.question.uid
  end
end