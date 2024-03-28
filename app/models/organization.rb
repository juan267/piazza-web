class Organization < ApplicationRecord
  has_many :memberships, dependent: :destroy
  # The source: :user option tells ActiveRecord to use the user_id foreign key for this relation.
  has_many :members, through: :memberships, source: :user
end
