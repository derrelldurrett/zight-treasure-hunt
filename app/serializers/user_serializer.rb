class UserSerializer
  include JSONAPI::Serializer
  attributes :id, :email, :guess
end
