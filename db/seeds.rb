# Linkashare Seed File
#############################
#   Delete Old Records      #
#############################

puts "Deleting old records..."

User.destroy_all
Link.destroy_all
Approval.destroy_all

#############################
#   Create Users section    #
#############################

generic_password = ENV.fetch('generic_password', 'some-password')
usernames = ['gomiko', 'erick', 'terry', 'sandara', 'kasumi']

def information_text(username)
  "Hi my name is #{username} and I like exploring the internet." +
  " I stumbled upon this site and would like to share my links."
end

users = []
puts "Creating users..."
usernames.each do |username|
  puts "#{username}"
  users << User.create(username: username, email: "#{username}@email.com",
           password: generic_password, information: information_text(username))
end

#############################
#   Create Links section    #
#############################

link_urls = ['www.google.com',
             'www.9gag.com', 
             'www.knowyourmeme.com',
             'www.yahoo.com',
             'en-gb.facebook.com',
             'www.amazon.com',
             'wwww.reddit.com',
             'www.sitepoint.com',
             'www.tutsplus.com',
             'www.pluralsight.com',
             'pinterest.com',
             'www.udemy.com',
             'tutorialzine.com',
             'www.github.com',
             'rubyonrails.org',
             'cloudinary.com',
             'softwareengineering.stackexchange.com',
             'goodreads.com',
             'twitter.com',
             'wikipedia.com',
             'kobo.com'
            ]
        
user_index = 0
links = []
puts "Creating links..."
link_urls.each do |link_url|
  puts "for #{link_url}"
  link = Link.new
  link_data = link.get_link_data(link_url)
  unless link_data
    next
  end
  link.fetch_website_image(link_data)
  link.title = link_data.title
  link.description = link_data.description
  link.user = users[user_index]
  link.save
  links << link
  
  user_index = (user_index >= users.size - 1) ? 0 : user_index + 1
end

#############################
#  Create Approvers section #
#############################

puts "Creating approvers..."
links.each do |link|
  print "for #{link.url}"
  approver_count = Random.rand(0..(users.size))
  i = 0
  while i < approver_count
    link.approvers << users[i]
    i += 1
  end
  puts " (#{approver_count})"
end

#############################
#  Create Comments section  #
#############################

comments_list = [ 'Nice site :)',
                  'I agree with your assumption.',
                  'Looks interesting...',
                  'Sure why not...',
                  'What a cool link. Thanks for being submitted.',
                  'Really... eh',
                  'I stumbled upon this site last week.',
                  'Everybody has seen this site already. Thanks anyways.',
                  'I cannot believe it fascinating!',
                  'Good link :)',
                  'OK'
                ]

puts "Creating comments..."
links.each do |link|
  print "for #{link.url}"
  comment_count = Random.rand(0..(users.size))
  i = 0
  while i < comment_count
    comment = Comment.new(content: comments_list.sample,
                          user: users.sample)
    link.comments << comment
    i += 1
  end
  puts " (#{comment_count})"
end


puts "Seeding done :)"