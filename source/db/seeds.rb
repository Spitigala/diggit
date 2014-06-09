# Users
require 'faker'

usernames = ["Pei", "Tuan", "Connor", "Sahan"]
uploaders = []
commenters = []
song_urls = ["https://soundcloud.com/mmmusic/toad-the-wet-sprocket-01-california-wasted-1404236",
             "https://soundcloud.com/defectedrecords/wallflower-say-you-wont-ever-deetron-edit",
             "https://soundcloud.com/fivosvalachis/the-path-the-heart-decides-nocturne-03-jun",
             "https://soundcloud.com/darealquilly/0-100-quilly-and-kur-freestlye"]


usernames.each do |username|
  uploaders << User.create(username: username, password: "yolo", password_confirmation: "yolo")
end

10.times do
  commenters << User.create(username: Faker::Name.first_name, password: "yolo", password_confirmation: "yolo")
end


# Create Users


uploaders.each do |uploader|
  song_urls.each do |url|
    song = Song.create(title: Faker::Lorem.word, artist: Faker::Name.first_name, url: url, user_id: uploader.id)
    commenters.each do |commenter|
      comment = Comment.create(content: Faker::Lorem.sentence, song: song, user_id: commenter.id)
      Vote.create(user_id: commenter.id, voteable: song, value: [1,-1].sample)
      Vote.create(user_id: uploader.id, voteable: comment, value: [1,-1].sample)
    end
  end
end




