class Advertisement < ApplicationRecord

  resourcify

  belongs_to :category
  belongs_to :user

  mount_uploaders :pictures, PictureUploader
  serialize :pictures, JSON

  validates :ad_title, presence: true,
                    length: { minimum: 5 , maximum: 50}
  validates :ad_text, presence: true,
                    length: { minimum: 100 , maximum: 1000}
  validates :category_id, presence: true

  filterrific :default_filter_params => { :sorted_by => 'created_at_desc' },
              :available_filters => %w[
                sorted_by
                with_category_id
                with_created_at_gte
              ]

  # default for will_paginate
  self.per_page = 10

  scope :sorted_by, ->(sort_option) {
    # extract the sort direction from the param value.
    direction = (sort_option =~ /desc$/) ? 'desc' : 'asc'
    advertisements = Advertisement.arel_table
    categories = Category.arel_table
    case sort_option.to_s
    when /^created_at_/
      order(advertisements[:created_at].send(direction))
    else
      raise(ArgumentError, "Invalid sort option: #{sort_option.inspect}")
    end
  }

  scope :with_category_id, ->(category_ids) {
    where(:category_id => [*category_ids])
  }

  delegate :ad_title, :to => :advertisement, :prefix => true

  def self.options_for_sorted_by
    [
      ['Сначала новые', 'created_at_desc'],
      ['Сначала старые', 'created_at_asc']
    ]
  end

  state_machine initial: :draft do
    state :draft
    state :opened
    state :rejected
    state :approved
    state :published
    state :archived

    event :start do
      transition :draft => :opened
    end

    event :reject do
      transition :opened => :rejected
    end

    event :approve do
      transition :opened => :approved
    end

    event :publish do
      transition :approved => :published
    end

    event :archive do
      transition :published => :archived
    end

    event :change do
      transition [:rejected, :archived] => :draft
    end
  end

  def can_be_started?(current_user)
    current_user.user? && current_user.id == self.user_id && self.can_start?
  end

  def can_be_edited?(current_user)
    current_user.user? && current_user.id == self.user_id && self.state == 'draft'
  end

  def can_be_deleted?(current_user)
    (current_user.user? && current_user.id == self.user_id) || current_user.admin?
  end

  def can_be_approved_or_rejected?(current_user)
    current_user.admin? && self.state == 'opened'
  end

  def can_be_drafted?(current_user)
    current_user.user? && current_user.id == self.user_id && ['rejected', 'archived'].any?(self.state)
  end
end
