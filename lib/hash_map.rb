class HashMap
  attr_accessor :load_factor, :capacity, :buckets
  
  def initialize (load_factor = 0.5, capacity = 8)
    @load_factor = load_factor
    @capacity = capacity
    @buckets = Array.new(capacity)
  end

  def hash(key)
    hash_code = 0
    prime_number = 31
    key.each_char { |char| hash_code = prime_number * hash_code + char.ord}
    hash_code
  end

  #has no collision handling.... yet
  
  def set (key, value)
    hash = hash(key)
    @buckets.each_with_index do |current_obj, index|
      raise IndexError if index.negative? || index >= @buckets.length
      if current_obj && current_obj.key?(hash) 
        @buckets[index] = {hash => {key => value}}
        return
      end
    end
    @buckets.each_with_index do |current_obj, index|
      raise IndexError if index.negative? || index >= @buckets.length
      if !current_obj
        @buckets[index] = {hash => {key => value}}
        if self.length > @load_factor * @buckets.length
          @capacity.times {@buckets.push(nil)}
        end
        return
      end
    end
  end

  def get(key)
    hash = hash(key)
    @buckets.each do |current_obj|
      if current_obj.key?(hash) 
        return current_obj.dig(hash, key)
      end
    end
    nil
  end

  def has?(key)
    hash = hash(key)
    @buckets.each do |current_obj|
      if current_obj.key?(hash) 
        return true
      end
    end
    return false
  end

  def remove(key)
    hash = hash(key)
    @buckets.each_with_index do |current_obj, index|
      raise IndexError if index.negative? || index >= @buckets.length
      if current_obj && current_obj.key?(hash) 
        to_delete = @buckets[index]
        @buckets[index] = nil
        return to_delete
      end
    end
    nil
  end

  def length
    buckets_with_value = 0
    @buckets.each do |bucket|
      if bucket
        buckets_with_value += 1
      end
    end
    buckets_with_value
  end

  def clear
    @buckets.each_with_index do |bucket,index|
      @buckets[index] = nil
    end
  end

  def keys
    arr = []
    @buckets.each do |current_obj|
      if current_obj
        arr << current_obj.to_a[0][1].keys.join()
      end
    end
    arr
  end

  def values
    arr = []
    @buckets.each do |current_obj|
      if current_obj
        arr << current_obj.to_a[0][1].to_a[0][1]
      end
    end
    arr
  end

  def entries
    arr = []
    self.length.times {|num| arr << [keys[num], values[num]]}
    arr
  end

end