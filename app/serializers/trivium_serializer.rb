class TriviumSerializer
  include JSONAPI::Serializer
  attributes :name, :description, :uid

  attribute :url_trivia do |trivium|
    "/trivias/#{trivium.uid}/start"
  end
end