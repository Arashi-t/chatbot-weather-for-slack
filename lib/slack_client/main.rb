require 'slack-ruby-client'
require './lib/slack_client/message'

module SlackClient
  module Main
    module_function

    def run
      Slack.configure do |conf|
        conf.token = ENV['SLACK_BOT_API_TOKEN']
      end

      client = Slack::RealTime::Client.new

      SlackClient::Message.run(client)
    end
  end
end
