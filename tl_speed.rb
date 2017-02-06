# -*- coding: utf-8 -*-

Plugin.create(:tl_speed) do
  
  tweets = []
  count = 0

  on_update do |service, messages|
    next unless messages && messages[0]
    time = messages[0][:created]
    tweets += messages.flatten
    
    while( !tweets.empty? && tweets[0][:created] < time - 120 ) 
      tweets.delete_at(0)
    end
    #p tweets
    
    Plugin.call(:gui_window_rewindstatus, Plugin::GUI::Window.instance(:default), "分速#{ tweets.size.to_f / 2 }ツイート", Time.now+60 )
  end
end


