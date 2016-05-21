class Comment < ActiveRecord::Base
  include ActiveRecord::CachedAssociation

  belongs_to :user
  cache_belongs_to :user, inverse_of: :comments

  has_many :likes, as: :likeable
  cache_has_many :cached_likes
end
