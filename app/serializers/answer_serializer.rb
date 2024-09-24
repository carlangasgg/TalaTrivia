class AnswerSerializer
  include JSONAPI::Serializer
  attributes :question_name, :question_description, :option_selected, :question_score
end