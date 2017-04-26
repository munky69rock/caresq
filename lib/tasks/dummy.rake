# frozen_string_literal: true

namespace :dummy do # rubocop:disable Metrics/BlockLength
  namespace :generate do # rubocop:disable Metrics/BlockLength
    desc 'Generate random users'
    task :user, [:count] => :environment do |_t, args|
      args.with_defaults count: 50
      count = args[:count]
      puts "start to create #{count} users"
      1.upto(count) do |i|
        user = User.new(
          name: Faker::Name.unique.name,
          email: Faker::Internet.unique.email,
          password: Faker::Lorem.characters(10),
          description: Faker::Lorem.paragraphs(rand(10) + 1).join("\n\n"),
          gender: User.genders.values.sample,
          birth_date: Faker::Date.birthday
        )
        user.skip_confirmation!
        user.save!

        puts "  created #{i} users" if (i % 100).zero?
      end
      puts "finish to create #{count} users"
    end

    desc 'Generate random posts'
    task :post, [:count] => :environment do |_t, args|
      args.with_defaults count: 100
      count = args[:count]
      puts "start to create #{count} posts"
      1.upto(count) do |i|
        Post.create!(
          title: [Faker::Book.title, Faker::Food.ingredient].join(' '),
          body: Faker::Lorem.paragraphs((rand(5) + 1) * 10).join("\n\n"),
          user: random_user
        )
        puts "  created #{i} posts" if (i % 100).zero?
      end
      puts "finish to create #{count} posts"
    end

    desc 'Generate random comments'
    task :comment, [:count] => :environment do |_t, args|
      args.with_defaults count: 1_000
      count = args[:count]
      puts "start to create #{count} comments"
      1.upto(count) do |i|
        CommentForm.new(
          body: Faker::Lorem.paragraphs(rand(10) + 1).join("\n\n"),
          post: random_post,
          user: random_user
        ).save!
        puts "  created #{i} comments" if (i % 100).zero?
      end
      puts "finish to create #{count} comments"
    end

    private

    def random_user
      random_find User
    end

    def random_post
      random_find Post
    end

    def random_find(model)
      model.offset(rand(model.count)).first
    end
  end

  desc 'Generate random resources'
  task generate: :environment do
    Rake::Task['dummy:generate:user'].invoke
    Faker::UniqueGenerator.clear
    Rake::Task['dummy:generate:post'].invoke
    Faker::UniqueGenerator.clear
    Rake::Task['dummy:generate:comment'].invoke
  end
end
