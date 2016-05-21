module ActiveRecord
  module CachedAssociation

    extend ActiveSupport::Concern

    module ClassMethods
      def cache_has_many(association)

        self.class_eval(<<-CODE, __FILE__, __LINE__ + 1)

          def #{ association }
            original_association_name = __method__.to_s.split('_')[1..-1].join('_')
            fetch_and_cache_associations(original_association_name)
          end
        CODE
      end

      def cache_belongs_to(association, options = {})
        self.class_eval(<<-CODE, __FILE__, __LINE__ + 1)
          after_save -> { expire_associated_caches(association, options) }
          after_destroy -> { expire_associated_caches(association, options) }
        CODE
      end
    end

    def fetch_and_cache_associations(original_association_name)
      Rails.cache.fetch("#{ self.class.name.downcase.tableize.singularize }_#{ original_association_name }_#{ id }") { self.reload.send(original_association_name).to_a }
    end

    def expire_associated_caches(association, options)
      associated_object = send(association)
      belongs_to_association = associated_object.class.name.downcase
      cache_key = "#{ belongs_to_association }_#{ options[:inverse_of].to_s }_#{ associated_object.id }"
      Rails.cache.delete(cache_key)
    end
  end
end