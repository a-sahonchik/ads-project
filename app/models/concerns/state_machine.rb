# frozen_string_literal: true

module StateMachine
  extend ActiveSupport::Concern

  included do
    state_machine initial: :draft do
      state :draft
      state :opened
      state :rejected
      state :approved
      state :published
      state :archived

      event :start do
        transition draft: :opened
      end

      event :reject do
        transition opened: :rejected
      end

      event :approve do
        transition opened: :approved
      end

      event :publish do
        transition approved: :published
      end

      event :archive do
        transition published: :archived
      end

      event :change do
        transition %i[rejected archived] => :draft
      end
    end

    def can_be_started?(current_user)
      current_user.user? && current_user.id == user_id && can_start?
    end

    def can_be_edited?(current_user)
      current_user.user? && current_user.id == user_id && state == 'draft'
    end

    def can_be_deleted?(current_user)
      (current_user.user? && current_user.id == user_id) || current_user.admin?
    end

    def can_be_approved_or_rejected?(current_user)
      current_user.admin? && state == 'opened'
    end

    def can_be_drafted?(current_user)
      current_user.user? && current_user.id == user_id && %w[rejected archived].any?(state)
    end
  end
end
