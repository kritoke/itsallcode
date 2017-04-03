module Slugifiable
  module InstanceMethods
    def slug
      self.username.downcase.gsub(/\s/, "-")
    end
  end

    module ClassMethods
      def find_by_slug(slug)
        self.all.find { |s| slug == s.slug }
      end
    end

end
