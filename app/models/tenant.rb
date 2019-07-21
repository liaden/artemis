class Tenant < ApplicationRecord
  validates :tenant_id, presence: true, uniqueness: true
  validates :name, presence: true
end
