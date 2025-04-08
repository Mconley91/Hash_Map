class HashMap
  attr_accessor :load_factor, :capacity, :buckets
  
  def initialize (load_factor, capacity)
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

end


#testing zone
my_hash_map = HashMap.new(0.5,8)

my_hash_map.set('Link', '1')
my_hash_map.set('Mario', '2')
my_hash_map.set('Bomberman', '3')
my_hash_map.set('Wario', '3')
my_hash_map.set('Samus', '3')
p my_hash_map.remove('Samus')
p my_hash_map.buckets
puts my_hash_map.length
