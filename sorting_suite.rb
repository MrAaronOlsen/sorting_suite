require 'pry'
require 'benchmark'
# Bubble Sort

# loop through all elements of "collection" until empty
  # starting at index i compare i to i+1 until length is 1
    # if i >= i+1 move i+1 to "temp_collection" and delete from "collection"
    # if i < i+1 move i to "temp_collection" and delete from "collection"
  # move last element to beginning of sorted array
# make collection equal to temp_collection

def bubble_sort_slice(set)

  sorted = []

  until set.empty?
    
    temp = []

    until set.length == 1
      set[0] >= set[1] ? temp << set.slice!(1) : temp << set.slice!(0)
    end

    sorted.unshift(set[0])
    set = temp
  
  end

  sorted

end

def bubble_sort_inplace(set)

end

# Insertion Sort

# loop through set until empty
# set index to 0
  # loop through sorted_set until break or end of sorted set
    # if first element in set is less than element at index insert element before index
    # otherwise add 1 to index
  #remove first element from set

def insertion_sort(set)

  sorted = []

  until set.empty?

    i = 0
    
    while true
      
      if sorted.empty? || i == sorted.length || set[0] <= sorted[i]
        sorted.insert(i, set[0])
        break
      end

      i+=1

    end

    set.shift

  end

  sorted

end

def merge_sort(set)
end

to_sort = []
10.times { to_sort << rand(0..10) }

print to_sort; puts ""

bubble_sorted = []
insertion_sorted = []

Benchmark.bm(30) do |bm|
  bm.report('Bubble Sort') { bubble_sorted = bubble_sort_slice(Array.new(to_sort)) }
  print bubble_sorted; puts ""
  bm.report('Insertion Sort') { insertion_sorted = insertion_sort(Array.new(to_sort)) }
  print insertion_sorted; puts ""
end



