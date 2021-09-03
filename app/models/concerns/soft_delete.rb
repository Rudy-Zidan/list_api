# frozen_string_literal: true

module Concerns
  module SoftDelete
    extend ActiveSupport::Concern

    included do
      scope :only_deleted, -> { unscope(where: :deleted_at).where.not(deleted_at: nil) }
      scope :with_deleted, -> { unscope(where: :deleted_at) }

      def soft_delete!
        update(deleted_at: Time.current) unless deleted?
      end

      def restore!
        update(deleted_at: nil) if deleted?
      end

      def deleted?
        deleted_at.present?
      end

      def update_deleted_at
        update(deleted_at: Time.current)
      end
    end
  end
end
