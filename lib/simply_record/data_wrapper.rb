class SimplyRecord::DataWrapper
  def initialize(model)
    @model = model
  end

  def collection(data)
    data.to_a.inject([]) do |arr, o|
      @new_object = @model.new
      o.each { |k, v| @new_object.instance_variable_set(:"@#{k}", v) }
      arr << @new_object
    end
  end

  def single_object(data)
    @new_object = @model.new
    data.first.each { |k, v| @new_object.instance_variable_set(:"@#{k}", v) }
    @new_object
  end
end
