class Tenant < ApplicationRecord
  self.primary_key = :tenant_id

  validates :tenant_id, presence: true, uniqueness: true
  validates :name, presence: true
end
