class User < ActiveRecord::Base
	include ActiveRecord::CachedAssociation

	has_many :comments
	cache_has_many :cached_comments

	has_many :likes
	cache_has_many :cached_likes

	has_many :photos
	cache_has_many :cached_photos
end
