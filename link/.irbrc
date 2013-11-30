require 'rubygems'
require 'interactive_editor'
require 'ap'

IRB::Irb.class_eval do
  def output_value
    ap @context.last_value
  end
end

require 'irb/ext/save-history'
#History configuration
IRB.conf[:SAVE_HISTORY] = 1000
IRB.conf[:HISTORY_FILE] = "#{ENV['HOME']}/.irb-save-history"

