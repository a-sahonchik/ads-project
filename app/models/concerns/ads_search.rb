# frozen_string_literal: true

module AdsSearch
  extend ActiveSupport::Concern

  included do
    include Elasticsearch::Model
    include Elasticsearch::Model::Callbacks

    index_name Rails.application.class.parent_name.underscore

    settings index: { number_of_shards: 1 } do
      mapping dynamic: false do
        indexes :ad_title, analyzer: 'russian'
        indexes :ad_text, analyzer: 'russian'
        indexes :state
      end
    end

    def self.search(query)
      __elasticsearch__.search(
        {
          query: {
            bool: {
              must: [
                {
                  multi_match: {
                    query: query,
                    fields: ['ad_title^5', 'ad_text']
                  }
                },
                {
                  match: {
                    state: :published
                  }
                }
              ]
            }
          },

          highlight: {
            pre_tags: ['<mark>'],
            post_tags: ['</mark>'],
            fields: {
              ad_title: {},
              ad_text: {},
            }
          },

          suggest: {
            text: query,
            ad_title: {
              term: {
                size: 1,
                field: :ad_title
              }
            },

            ad_text: {
              term: {
                size: 1,
                field: :ad_text
              }
            }
          }
       }
     )
    end

    def as_indexed_json(options = nil)
      self.as_json( only: [ :ad_title, :ad_text, :state ] )
    end
  end
end
