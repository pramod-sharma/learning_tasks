class Photo < ActiveRecord::Base
  include ActiveRecord::CachedAssociation

  belongs_to :user
  cache_belongs_to :user, inverse_of: :photos

  has_many :likes, as: :likeable
  cache_has_many :cached_likes

  has_many :comments
  cache_has_many :cached_comments
end
