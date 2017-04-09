module Slugifiable
  module InstanceMethods
    def slug
      self.language.downcase.gsub(/\s/, "-")
    end

  end

    module ClassMethods
      def find_by_slug(slug)
        self.all.find { |s| slug == s.slug }
      end

      def deslug(slug) # removes the dash in the slug
        slug.gsub('-', ' ')
      end
    end

end
