require_relative 'hash_map'

test = HashMap.new(0.75)

test.set('apple', 'red')
test.set('banana', 'yellow')
test.set('carrot', 'orange')
test.set('dog', 'brown')
test.set('elephant', 'gray')
test.set('frog', 'green')
test.set('grape', 'purple')
test.set('hat', 'black')
test.set('ice cream', 'white')
test.set('jacket', 'blue')
test.set('kite', 'pink')
test.set('lion', 'golden')
test.set('lion', '22')
test.set('apple', 'GOLDEN')
test.set('moon', 'silver')

p test.buckets

p test.get('apple')
p test.has?('kite')
p test.remove ('moon')
p test.length
p test.keys
p test.values
p test.clear
p test.entries