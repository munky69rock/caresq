# frozen_string_literal: true

# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

User.new(email: 'admin@caresq.jp',
         name: 'admin',
         password: ENV.fetch('ADMIN_PASSWORD'),
         password_confirmation: ENV.fetch('ADMIN_PASSWORD'),
         notification: false).tap do |admin|
  admin.skip_confirmation!
  admin.save!
  AdminUser.create! user: admin
end

file = File.expand_path(File.join('..', 'seeds', 'dump.json'), __FILE__)
data = JSON.parse(File.read(file))

StaticPage.create! data['static_pages'] if data['static_pages'].present?
Information.create! data['information'] if data['information'].present?
