class PublicationStatus < ApplicationRecord
  validates :name, presence: true, uniqueness: true
end
