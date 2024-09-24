class QuestionStartSerializer
  include JSONAPI::Serializer
  
  attributes :name, :description
  
  attribute :options do |question|
    question.question_options.map do |option|
      {
        name: option.name,
        uid: option.uid
      }
    end
  end
end