require 'json'
require "csv"

# ハッシュの配列をCSVに変換するメソッド
def hash_list_to_csv_array( list, key_order=nil )
  key_order ||= list.map(&:keys).flatten.uniq
  arr = list.map do |hash|
    key_order.map{|key| hash[key]}
  end
  arr.unshift(key_order)
end

# jsonファイルを開く
File.open("channels.json") do |file|
  list = JSON.load(file)
  # メソッドを実行
  csv_data = hash_list_to_csv_array(list)

  # csvファイルを開く
  CSV.open("runteq_channels.csv", "w", :encoding => "utf-8") do |csv_file|
  # csvファイルに実行結果を追加
    csv_data.each do |row|
      csv_file << row
    end
  end
end
