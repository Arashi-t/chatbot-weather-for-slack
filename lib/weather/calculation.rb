module Weather
  module Calculation
    module_function

    # 降水確率を計算
    def precip_probability(precip_probability)
      (precip_probability * 100).round
    end

    # unixtimeを日付へ
    def unixtime_to_date(unixtime)
      Time.at(unixtime).strftime('%Y/%m/%d')
    end

    # 現在時刻から前回取得した天気情報の時刻のdiffを計算
    def diff_request_time(request_time)
      Time.now.to_i - request_time
    end
  end
end
