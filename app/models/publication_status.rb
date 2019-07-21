class PublicationStatus < ApplicationRecord
  lookup_by :name, cache: true, raise: true

  validates :name, presence: true, uniqueness: true
end
