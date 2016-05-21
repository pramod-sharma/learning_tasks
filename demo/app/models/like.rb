class Like < ActiveRecord::Base
  include ActiveRecord::CachedAssociation

  belongs_to :user
  cache_belongs_to :user, inverse_of: :likes

  belongs_to :likeable, polymorphic: true
  cache_belongs_to :likeable, inverse_of: :likes
end
