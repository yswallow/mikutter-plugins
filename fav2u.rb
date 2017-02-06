Plugin.create :fav2u do
  settings '自動ふぁぼ' do
    multi 'ターゲットscreen_name', :fav2u_users
  end
  
  puts RUBY_VERSION
  p UserConfig[:fav2u_users]
  count = 0
  target_users = UserConfig[:fav2u_users]
  onappear do |ms|
    ms.each do |m|
      if target_users.include?(m.user.to_s) && !m.retweet?
        m.message.favorite(true)
        count += 1
        puts 'ふぁぼった ' + count.to_s
      end
      #puts "to_s: #{user.to_s}, idname: #{user.idname}, id: #{user.id}"
    end
  end
end
