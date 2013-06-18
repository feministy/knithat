# Hat patterns only

HAT_SIZES = { infant: [13, 15], 
          child: [17, 20, 21], 
          adult: [22, 23, 25] }

def initialize_size_class_from(pattern_obj)
  if HAT_SIZES[:adult].include?(pattern_obj.hat_circumference)
    @hat = HatAdult.new(pattern_obj)
  elsif HAT_SIZES[:child].include?(pattern_obj.hat_circumference)
    @hat = HatChild.new(pattern_obj)
  elsif pattern_obj.hat_circumference == HAT_SIZES[:infant][1]
    @hat = HatToddler.new(pattern_obj)
  elsif pattern_obj.hat_circumference == HAT_SIZES[:infant][0]
    @hat = HatInfant.new(pattern_obj)
  end
end

class HatTemplate < PatternGenerator
  def generate_hat_pattern
    get_gauge
    # estimated_yardage
    cast_on_ribbing
    ribbing_rows
    body_height
    crown_decreases
  end

  def cast_on_ribbing
    raw = (@pattern.hat_circumference * @per_1 * 0.80).round(0)
    rounded = [(raw + 8 - (raw % 8)), (raw + 9 - (raw % 9))]
    if rounded.min % 8 == 0
      @cast_on = raw 
      @ribbing = "1x1 or 2x2 (k1, p1 or k2, p2)"
    elsif rounded.min % 9 == 0
      @cast_on = raw
      @ribbing = "3x3 (k3, p3)"
    end 
    @slouch = (@cast_on * 1.25).round(0)
    @beanie = (@cast_on * 0.90).round(0)
  end
end

class HatAdult < HatTemplate
  def ribbing_rows
    @ribbing_rows = "2 inches (#{(@row_1 * 2).round(0)} rows)"
  end 
  
  def body_height
    @height = "7 inches (#{(@row_1 * 7).round(0)} rows)"
  end

  def crown_decreases
    @crown = ""
  end  
end

class HatChild < HatTemplate
  def ribbing_rows
    @ribbing_rows = "1.5 inches (#{(@row_1*1.5).round(0)} rows)"
  end

  def body_height
    @height = "5.5 inches (#{(@row_1 * 5.5).round(0)} rows)"
  end 

  def crown_decreases
    @crown = ""
  end  
end

class HatToddler < HatTemplate
  def ribbing_rows
    @ribbing_rows = "1.5 inches (#{(@row_1*1.5).round(0)} rows)"
  end

  def body_height
    @height = "4.5 inches (#{(@row_1 * 4.5).round(0)})"
  end 

  def crown_decreases
    @crown = ""
  end  
end

class HatInfant < HatTemplate
  def ribbing_rows
    @ribbing_rows = "1 inch (#{@row_1.round(0)} rows)" 
  end

  def body_height
    @height = "3 inches (#{(@row_1 * 3).round(0)} rows)"
  end 

  def crown_decreases
    @crown = ""
  end  
end



# def sizing_conditionals(circumference)
#   if HAT_SIZES[:adult].include?(circumference)
#     ribbing_rows_adult
#     body_height_adult
#     crown_decreases_adult
#   elsif HAT_SIZES[:child].include?(circumference)
#     ribbing_rows_child
#     body_height_child
#     crown_decreases_child
#   elsif circumference == HAT_SIZES[:infant][1]
#     ribbing_rows_infant
#     body_height_toddler
#     crown_decreases_toddler
#   elsif circumference == HAT_SIZES[:infant][0]
#     ribbing_rows_infant
#     body_height_infant
#     crown_decreases_infant
#   end
# end


