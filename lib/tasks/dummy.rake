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
          description: random_paragraph_with_linebreak(rand1(10)),
          gender: User.genders.values.sample,
          birth_date: Faker::Date.birthday
        )
        user.skip_confirmation!
        user.save!

        puts "  created #{i} users" if (i % 100).zero?
      end
      puts "finish to create #{count} users"
    end

    desc 'Generate random tags'
    task :tag, [:count] => :environment do |_t, args|
      args.with_defaults count: 30
      count = args[:count]
      puts "start to create #{count} tags"
      1.upto(count) do |i|
        Tag.create!(value: Faker::Zelda.unique.character)
        puts "  created #{i} tags" if (i % 100).zero?
      end
      puts "finish to create #{count} tags"
    end

    desc 'Generate random posts'
    task :post, [:count] => :environment do |_t, args|
      args.with_defaults count: 100
      count = args[:count]
      puts "start to create #{count} posts"
      1.upto(count) do |i|
        tags = Array.new(rand(4)).map { random_tag }.uniq { |t| t.id }
        Post.create!(
          title: [Faker::Book.title, Faker::Food.ingredient].join(' '),
          body: random_paragraph_with_linebreak(rand1(5) * 10),
          user: random_user,
          tags: tags
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
          body: random_paragraph_with_linebreak(rand1(10)),
          post: random_post,
          user: random_user
        ).save!
        puts "  created #{i} comments" if (i % 100).zero?
      end
      puts "finish to create #{count} comments"
    end

    desc 'Generate random information'
    task :information, [:count] => :environment do |_t, args|
      args.with_defaults count: 30
      count = args[:count]
      puts "start to create #{count} information"
      1.upto(count) do |i|
        Information.new(
          title: Faker::StarWars.unique.quote,
          body: random_paragraph_with_linebreak(rand1(10))
        ).save!
        puts "  created #{i} information" if (i % 100).zero?
      end
      puts "finish to create #{count} information"
    end

    private

    def rand1(n)
      rand(n) + 1
    end

    def random_user
      random_find User
    end

    def random_tag
      random_find Tag
    end

    def random_paragraph_with_linebreak(n)
      Faker::Lorem.paragraphs(n).join("\n\n")
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
    Rake::Task['dummy:generate:tag'].invoke
    Faker::UniqueGenerator.clear
    Rake::Task['dummy:generate:post'].invoke
    Faker::UniqueGenerator.clear
    Rake::Task['dummy:generate:comment'].invoke
  end
end
