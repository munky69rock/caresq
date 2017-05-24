# frozen_string_literal: true
# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
StaticPage.create [
  {
    path: 'about',
    title: '運営会社',
    body: 'coming soon...'
  },
  {
    path: 'privacy',
    title: 'プライバシー',
    body: 'coming soon...',
  },
  {
    path: 'terms',
    title: '規約',
    body: 'coming soon...',
  },
  {
    path: 'faq',
    title: 'FAQ',
    body: 'coming soon...',
  }
]
