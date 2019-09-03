module Weather
  module Regex
    module_function

    # 対象のテキスト抽出
    def extract_text(text)
      matched_text = match_text(text)
      return if matched_text.empty?

      daily_name = match_daily_name(matched_text[0])
      if daily_name.nil?
        place_name = matched_text[0]
        # 日付が未指定の場合は今日の日付を設定
        daily_name = match_daily_name(matched_text[1]) || 'currently'
      else
        place_name = matched_text[1]
      end

      { 'daily_name' => daily_name, 'place_name' => place_name }
    end

    # マッチするテキストを取得
    def match_text(text)
      matched_text = text.split(/(^(.*?)の(.*?)|^(.*?))の天気は？/)
      return [matched_text[2], matched_text[3]] if matched_text.count == 4
      return [matched_text[1]] if matched_text.count == 3

      []
    end

    # テキストと一致したdailynameを取得
    def match_daily_name(text)
      case text
      when /今日/
        'currently'
      when /明日/
        'tomorrow'
      when /(１|1|一)週間/
        'weekly'
      end
    end
  end
end
