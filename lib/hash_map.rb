class HashMap
  attr_accessor :load_factor, :capacity, :buckets
  
  def initialize (load_factor, capacity)
    @load_factor = load_factor
    @capacity = capacity
    @buckets = []
  end

  def hash(key)
    hash_code = 0
    prime_number = 31
    key.each_char { |char| hash_code = prime_number * hash_code + char.ord}
    hash_code
  end

  def set (key, value)
    hash = hash(key)
    @buckets.each_with_index do |current_obj, index|
      raise IndexError if index.negative? || index >= @buckets.length
      if current_obj.key?(hash) 
        @buckets[index] = {hash => {key => value}}
        return
      end
    end
    @buckets.push({hash => {key => value}})
  end

end

my_hash_map = HashMap.new(0.5,8)

my_hash_map.set('Link', '1')
my_hash_map.set('Mario', '2')
my_hash_map.set('Bomberman', '3')
my_hash_map.set('Link', '45')

puts my_hash_map.buckets