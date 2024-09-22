class TriviumSerializer
  include JSONAPI::Serializer
  attributes :name, :description, :uid
end