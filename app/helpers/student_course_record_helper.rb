module StudentCourseRecordHelper


  def check_order_params(params)
    new_array = []
    params.each do |object|
      puts object
      new_array.push object unless contains_non_integer?(object["id"])
    end

    new_array
  end

  def contains_non_integer?(str)
    Integer(str)
    false
  rescue ArgumentError
    true
  end
end