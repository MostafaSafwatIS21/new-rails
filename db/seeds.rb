# This file should ensure the existence of records required to run the application in every environment (production,
# development, test). The code here should be idempotent so that it can be executed at any point in every environment.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Example:
#
#   ["Action", "Comedy", "Drama", "Horror"].each do |genre_name|
#     MovieGenre.find_or_create_by!(name: genre_name)
#   end

puts "Seeding data..."

puts "Clearing existing data..."

Post.destroy_all
User.destroy_all
Editor.destroy_all


puts "Seeding users..."

users = User.create!([
  { name: "Alice Johnson",  email: "alice@example.com"   },
  { name: "Bob Smith",      email: "bob@example.com"     },
  { name: "Carol White",    email: "carol@example.com"   },
  { name: "David Brown",    email: "david@example.com"   },
  { name: "Eva Martinez",   email: "eva@example.com"     },
  { name: "Frank Lee",      email: "frank@example.com"   },
  { name: "Grace Kim",      email: "grace@example.com"   },
  { name: "Henry Davis",    email: "henry@example.com"   },
  { name: "Isla Thompson",  email: "isla@example.com"    },
  { name: "Jack Wilson",    email: "jack@example.com"    }
])

puts "Seeding editors..."

editors = Editor.create!([
  { name: "Editor Emma",    email: "emma@editors.com"    },
  { name: "Editor Liam",    email: "liam@editors.com"    },
  { name: "Editor Olivia",  email: "olivia@editors.com"  },
  { name: "Editor Noah",    email: "noah@editors.com"    },
  { name: "Editor Ava",     email: "ava@editors.com"     },
  { name: "Editor Ethan",   email: "ethan@editors.com"   },
  { name: "Editor Sophia",  email: "sophia@editors.com"  },
  { name: "Editor Mason",   email: "mason@editors.com"   },
  { name: "Editor Isabella", email: "isabella@editors.com" },
  { name: "Editor Logan",   email: "logan@editors.com"   }
])

# ── Posts (1:M — each User creates 2 Posts) ───────────────────────────────
puts "Seeding posts..."

post_data = [
  { title: "Introduction to Ruby",         content: "Ruby is a dynamic, open source language." },
  { title: "Getting Started with Rails",   content: "Rails is a web framework built on Ruby." },
  { title: "Understanding MVC",            content: "Model, View, Controller explained simply." },
  { title: "ActiveRecord Basics",          content: "ActiveRecord makes database work easy." },
  { title: "RESTful Routes in Rails",      content: "REST is a convention for structuring URLs." },
  { title: "Scaffold Deep Dive",           content: "Scaffolding speeds up CRUD generation." },
  { title: "Migrations Explained",         content: "Migrations manage your database schema." },
  { title: "Associations: 1:M and M:M",   content: "belongs_to, has_many, and has_many through." },
  { title: "Validations in Rails",         content: "Keep your data clean with validations." },
  { title: "Rails Console Tips",           content: "The console is your best debugging friend." },
  { title: "Deploying Rails Apps",         content: "Deploy with Render, Fly.io, or Heroku." },
  { title: "Testing with RSpec",           content: "Write specs to keep your app reliable." },
  { title: "Background Jobs with Sidekiq", content: "Offload heavy work to background queues." },
  { title: "Action Mailer Guide",          content: "Send emails easily with Action Mailer." },
  { title: "API-only Rails Apps",          content: "Rails can serve JSON APIs efficiently." },
  { title: "Hotwire and Turbo",            content: "Build modern UIs without heavy JavaScript." },
  { title: "Caching Strategies",           content: "Speed up your app with smart caching." },
  { title: "Security Best Practices",      content: "Keep your Rails app safe from attacks." },
  { title: "File Uploads with ActiveStorage", content: "Attach files easily with ActiveStorage." },
  { title: "Rails Engines Overview",       content: "Modularize your app with Rails Engines." }
]
posts= []
users.each_with_index do |user, i|
  2.times do |j|
    data = post_data[(i * 2) + j]
    posts << user.posts.create!(title: data[:title], content: data[:content])
  end
end

# ── Assign Editors to Posts (M:M via PostEditor join model) ───────────────
# Each post gets 2 random editors, no duplicates per post.
puts "Linking editors to posts..."

posts.each do |post|
  editors.sample(2).each do |editor|
    PostEditor.create!(post: post, editor: editor)
  end
end

puts "Done!"
puts "  Users:       #{User.count}"
puts "  Editors:     #{Editor.count}"
puts "  Posts:       #{Post.count}"
puts "  PostEditors: #{PostEditor.count}"
