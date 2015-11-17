require 'pry-byebug'

class SundayCount

  def initialize
    @start_year = 1901
    @end_year = 2000
  end

  def new_years
    jan_1 = 1
    (@start_year..@end_year).map.with_object({}) do |yr, boys|
      boys[yr] = jan_1
      jan_1 += 365
      jan_1 += 1 if yr % 4 == 0
      jan_1 -= 1 if yr % 100 == 0
      jan_1 += 1 if yr % 400 == 0
      boys
    end
  end

  def month_starts
    new_years.map.with_object({}) do |(yr, jan_1), boms|
      boms[yr] = {jan: jan_1}
      boms[yr][:feb] = boms[yr][:jan] + 31 
      boms[yr][:mar] = boms[yr][:feb] + 28 
      boms[yr][:mar] += 1 if yr % 4 == 0
      boms[yr][:mar] -= 1 if yr % 100 == 0
      boms[yr][:mar] += 1 if yr % 400 == 0
      boms[yr][:april] = boms[yr][:mar] + 31
      boms[yr][:may] = boms[yr][:april] + 30
      boms[yr][:june] = boms[yr][:may] + 31
      boms[yr][:july] = boms[yr][:june] + 30
      boms[yr][:aug] = boms[yr][:july] + 31
      boms[yr][:sept] = boms[yr][:aug] + 31
      boms[yr][:oct] = boms[yr][:sept] + 30
      boms[yr][:nov] = boms[yr][:oct] + 31
      boms[yr][:dec] = boms[yr][:nov] + 30
    end
  end

  def sunday_count
    sunday_boms = 0
    month_starts.each do |year, month_hash|
      month_hash.each do |month, day_count|
        sunday_boms += 1 if day_count % 7 == 6
      end
    end
    sunday_boms
  end
end


puts "finding your sabbath days"
puts SundayCount.new.sunday_count
