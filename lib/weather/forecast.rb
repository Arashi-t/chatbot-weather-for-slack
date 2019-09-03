require 'forecast_io'
require './lib/weather/calculation'
require './lib/weather/format_text'

module Weather
  class Forecast
    def initialize
      # DarkSkyで作成したアカウントにあるAPI TOKENをセット
      ForecastIO.api_key = ENV['DARKSKY_API_TOKEN']
      # 天気情報を日本語、取得する気温を摂氏で取得するように設定
      ForecastIO.default_params = { lang: 'ja', units: 'si' }
      # 取得した天気情報の箱を初期化
      @forecast_info = []
    end

    # DarkSkyAPIで取得できる天気情報を取得
    def info(location)
      # 前回のリクエストから1h経過していなければリクエストはしない
      return unless needs_request?(location)

      # 緯度経度を検索
      @forecast_info = ForecastIO.forecast(location['lat'], location['lon'])
    end

    # 今日の天気を取得
    def currently
      Weather::FormatText.daily(@forecast_info['daily']['data'][0])
    end

    # 明日の天気を取得
    def tomorrow
      Weather::FormatText.daily(@forecast_info['daily']['data'][1])
    end

    # 1週間の天気を取得
    def weekly
      Weather::FormatText.weekly(@forecast_info['daily']['data'])
    end

    private

    # リクエストが必要かどうか判定
    def needs_request?(location)
      return true if @forecast_info.empty?

      # 緯度経度が一致しているか
      match_location = @forecast_info['latitude'] == location['lat'] && @forecast_info['longitude'] == location['lon']

      return true unless match_location

      duration_time = 3600
      # 現在時刻より前回取得した天気情報の時刻を計算
      diff_request_time = Weather::Calculation.diff_request_time(@forecast_info['currently']['time'])
      # 1時間以上経過しているか
      diff_request_time >= duration_time
    end
  end
end
