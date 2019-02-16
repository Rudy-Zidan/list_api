module Concerns
  module SoftDelete
    extend ActiveSupport::Concern

    included do
      default_scope -> { where(deleted_at: nil) }

      scope :only_deleted, -> { unscope(where: :deleted_at).where.not(deleted_at: nil) }
      scope :with_deleted, -> { unscope(where: :deleted_at) }

      alias_method :really_destroy!, :destroy

      def destroy
        update(deleted_at: Time.current) unless deleted?
      end

      def restore!
        update(deleted_at: nil) if deleted?
      end

      def deleted?
        deleted_at.present?
      end
    end
  end
end
