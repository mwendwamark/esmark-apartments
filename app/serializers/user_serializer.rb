class UserSerializer < ActiveModel::Serializer
  attributes :id, :email, :name, :house_number, :password_digest
end
