require 'pry'
# Bubble Sort

# loop through all elements to end of "collection" until counter equals collection length
  # starting at index i compare i to i+1 until length is 1
    # if i > i+1 move i+1 to "temp_collection" and delete from "collection"
    # if i < i+1 move i to "temp_collection" and delete from "collection"
  # move last element to beginning of sorted array
  # increment counter
# make collection temp_collection


collection = []
100.times { collection << rand(0..100) }
sorted_collection = []

until collection.empty?
  temp = []
  until collection.length == 1
    collection[0] >= collection[1] ? temp << collection.slice!(1) : temp << collection.slice!(0)
  end
  sorted_collection.unshift(collection[0])
  collection = temp
end

puts ""
print sorted_collection
puts ""