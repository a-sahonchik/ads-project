class Advertisement < ApplicationRecord
  belongs_to :category

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

end
