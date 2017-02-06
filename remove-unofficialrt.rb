Plugin.create :remove_legacy do
 command(:legacy_retweet,
          name: _('hoge'),
          condition: Plugin::Command[:HasOneMessage, :CanReplyAll],
          visible: false,
          role: :timeline) {}
end
