require 'kaminari/models/active_record_relation_methods'

module Kaminari
  module ActiveRecordModelExtension
    extend ActiveSupport::Concern

    included do
      self.send(:include, Kaminari::ConfigurationMethods)

      # Fetch the values at the specified page number
      #   Model.page(5)
      def self.page(num = nil)
        num = num.to_i  # '5' -> 5, and nil -> 0
        num = 0 if num.negative?

        limit(default_per_page)  # Limit by the number of items we want per page
          .offset(default_per_page * num)  # Get the items of the page we want
          .extending do
          include Kaminari::ActiveRecordRelationMethods
          include Kaminari::PageScopeMethods
        end
      end  # self.page
    end  # included
  end
end
