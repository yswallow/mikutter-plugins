# -*- coding: utf-8 -*-

module FuckinMaker
  def column(target = '')
    hbox = Gtk::HBox.new( true, 0 )
    hbox.pack_start(Gtk::Label.new(target), false, false, 0 )
    entry = Gtk::Entry.new
    entry.text = target
    hbox.pack_start(entry, false, false, 0) 
    return [hbox, entry]
  end
  
  def create_plugin(plugin_sym, menu_title, base_str, *strs)
    Plugin.create(plugin_sym) do
      command(plugin_sym,
          name: menu_title,
          condition: lambda{ |opt| opt.messages.all?(&:repliable?) },
          visible: true,
          role: :timeline) do |opt|
        dialog = Gtk::Dialog.new( menu_title,
                               $main_application_window,
                               Gtk::Dialog::DESTROY_WITH_PARENT,
                               [ Gtk::Stock::OK, Gtk::Dialog::RESPONSE_OK ],
                               [ Gtk::Stock::CANCEL, Gtk::Dialog::RESPONSE_CANCEL ])
      
        hboxes = []
        entries = []
        strs.each do |s|
          hbox, entry = FuckinMaker.column(s)
          dialog.vbox.add(hbox)
          entries << entry
        end
        
        dialog.show_all
        
        result = dialog.run
        if result == Gtk::Dialog::RESPONSE_OK # OKボタンが押されたとき
          #puts :hoge
          entries.zip(strs) do |entry, str|
            to = entry.text
            base_str = base_str.gsub(str, to) unless to.empty?
          end
        end
        dialog.destroy
        
        opt.messages.each do |message|
          opt.widget.create_postbox(to: message,
                                footer: base_str % {sn: message.user.idname, name: message.user[:name]})
        end

      end
    end
  end
  module_function :create_plugin, :column
end

puts "FuckinMakerLoaded"
FuckinMaker.create_plugin(:suumo_fuckin, '改変スーモ', 'あ❗️%{name}(@%{sn})❗️🌚ダン💥ダン💥ダン💥シャーン🎶スモ🌝スモ🌚スモ🌝スモ🌚スモ 🌝スモ🌚ス〜〜〜モ⤴🌝スモ🌚スモ🌝スモ🌚スモ🌝スモ🌚スモ🌝ス〜〜〜モ⤵🌞', 'ス', 'モ')
FuckinMaker.create_plugin(:famima, 'ファミマ', '@%{sn} ♪ファミファミファミーマ♫ファミファミマー♪', 'ファ', 'ミ', 'マ')
FuckinMaker.create_plugin(:usmin, 'ウサミン', 'ﾐﾝﾐﾝﾐﾝ🎶ﾐﾝﾐﾝﾐﾝ🎶%{name}(@%{sn})! ﾐﾝﾐﾝﾐﾝ🎶ﾐﾝﾐﾝﾐﾝ🎶%{name}(@%{sn})! ﾐﾝﾐﾝﾐﾝ🎶ﾐﾝﾐﾝﾐﾝ🎶%{name}(@%{sn})! ｳｻｳｻｳｻ %{name}(@%{sn})!!')

