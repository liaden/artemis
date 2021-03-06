# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

ActiveRecord::Base.transaction do
  Tenant.create_or_find_by(tenant_id: 1, name: 'dev-tenant')
  Tenant.create_or_find_by(tenant_id: 2, name: 'other-dev-tenant')

  PublicationStatus.create_or_find_by(name: 'draft')
  PublicationStatus.create_or_find_by(name: 'published')
  PublicationStatus.create_or_find_by(name: 'withdrawn')
end
