class MultiDimensionalArray

  attr_accessor :dimensions, :factors, :data
  
  def initialize(*args)
    @options = args.last.is_a?(Hash) ? args.pop : { :rotational_indices => true }
    @dimensions = args
    @data = Array.new(dimensions.inject(1, &:*))
    determine_factors!
  end
  
  def [](*args)
    @data[get_offset(*args)]
  end
  
  def []=(*args)
    value = args.pop
    @data[get_offset(*args)] = value
  end
  
  def each(&blk)
    @data.each(&blk)
  end

private

  def get_offset(*indices)
    raise IndexError if (indices.length != dimensions.length)
    
    if @options[:rotational_indices]
      indices = indices.zip(dimensions).map { |pair| pair[0] % pair[1] }
    else
      indices.zip(dimensions).each { |pair| raise IndexError.new("Index #{pair[0]} exceeds #{pair[1]}") if (pair[0] < 0 || pair[0] >= pair[1]) }
    end
    indices.zip(factors).map { |pair| pair[0]*pair[1] }.inject(0, &:+)
  end
  
  def determine_factors!
    @factors = []
    offset = 1
    
    dimensions.length.downto(1) do |i|
      @factors[i - 1] = offset
      offset *= dimensions[i - 1]
    end
  end
  
end