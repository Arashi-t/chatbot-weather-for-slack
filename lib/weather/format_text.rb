require './lib/weather/calculation'

module Weather
  module FormatText
    module_function

    # 1日の天気情報を整形
    def daily(data)
      data['viewTime'] = Weather::Calculation.unixtime_to_date(data['time'])
      data['viewPrecipProbability'] = Weather::Calculation.precip_probability(data['precipProbability'])
      default_text(data)
    end

    # 1週間の天気情報を整形
    def weekly(data_list)
      text_list = ''
      data_list.each do |data|
        text_list += daily(data) + "\n\n"
      end
      text_list
    end

    # 出力用の基本テキスト
    def default_text(data)
      "日付：#{data['viewTime']} \n天気：#{data['summary']} \n最高気温：#{data['temperatureHigh']}度 \n最低気温：#{data['temperatureLow']}度 \n降水確率：#{data['viewPrecipProbability']}%"
    end

    private_class_method :default_text
  end
end
