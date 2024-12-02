require 'csv'

def load_data
  datas = []
  CSV.foreach('data/day_02.csv', col_sep: ' ', headers: false) do |row|
    datas << row.map(&:to_i)
  end
  datas
end

def safe?(report)
  # Find if each number in report either gets bigger by a maximum of 3 or gets smaller by a minimum of 3
  increasing = report[0] < report[1]

  report.each_with_index do |num, index|
    next unless report[index + 1]

    if increasing
      return false if !(1..3).cover?((num - report[index + 1]).abs) || num > report[index + 1]
    else
      return false if !(1..3).cover?((num - report[index + 1]).abs) || num < report[index + 1]
    end
  end
  true
end

def safe_with_one_missing?(report)
  # create multiple copies of the report with one number missing
  duplicated_reports = report.map.with_index do |num, index|
    report.dup.tap { |r| r.delete_at(index) }
  end
  duplicated_reports.each do |dup_report|
    return true if safe?(dup_report)
  end
  false
end


reports = load_data

# Challenge 1
# safe_reports = reports.count do |report|
#   p report
#   puts "Result: #{safe?(report)}"
#   puts
#   puts
#   safe?(report)
# end
# p safe_reports

# Challenge 2
safe_reports = reports.count do |report|

  if safe?(report)
    true
  else
    safe_with_one_missing?(report)
  end
end

p safe_reports
