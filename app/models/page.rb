class Page < ApplicationRecord
  has_rich_text :content

  belongs_to :tenant
  belongs_to :publication_status

  validates :name,    presence: true, uniqueness: { scope: :tenant_id }
  validates :content, presence: true

  scope :owned_by, ->(tenant) { where(tenant_id: tenant.respond_to?(:tenant_id) ? tenant.tenant_id : tenant) }

  scope :published, -> { where(publication_status_id: PublicationStatus['published'].id) }
  scope :draft, -> { where(publication_status_id: PublicationStatus['draft'].id) }
  scope :withdrawn, -> { where(publication_status_id: PublicationStatus['withdrawn'].id) }

  def published?
    publication_status == PublicationStatus['published']
  end

  def draft?
    publication_status == PublicationStatus['draft']
  end

  def withdrawn?
    publication_status == PublicationStatus['withdrawn']
  end
end
