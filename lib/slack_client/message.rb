require './lib/weather/forecast'
require './lib/weather/geocode'
require './lib/weather/regex'

module SlackClient
  module Message
    module_function

    def run(client)
      weather_forecast = Weather::Forecast.new
      client.on :message do |data|
        # slackから取得した文字列から必要なテキストを抽出
        text = Weather::Regex.extract_text(data.text)
        unless text.nil?
          location = Weather::Geocode.search(text['place_name'])
          if location.nil?
            client.message(channel: data.channel, text: "Hi <@#{data.user}>！\n\n指定した地域のデータは取得できませんでした…")
          else
            # 天気情報を取得
            weather_forecast.info(location)
            # 該当する日付のメソッドを実行
            disp_text = weather_forecast.send(text['daily_name'])
            # slackへメッセージを送信
            client.message(channel: data.channel, text: "Hi <@#{data.user}>！\n\n#{disp_text}")
          end
        end
      end

      client.start!
    end
  end
end
