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

# loop until start of set (j)
  # starting at set[0] loop until end of set (i)
    # if set i > set i+1 swap
    # step i
  # step back j

def bubble_sort_inplace(set)
  j = set.length

  until j == 0
    i = 0

    until i+1 == set.length
      set[i], set[i+1] = set[i+1], set[i] if set[i] >= set[i+1]
      i+=1
    end

    j-=1
  end

  set
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
    
    loop do
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

# Merge Sort

# Split set in half in "split" method
  # Recursive: Send each half back to "split" from within until half holds only 1 or 0 element
  # Then stop recursion by sending back that element which will allow "split" to step forward to...
  # Recursive: Send other half to "split" until it holds only 1 or 0 element then step forward to...
    # First half and second half are sent to "merge" function
    # If one half is empty, return other half (ends recursion)
    # Otherwise compare first elements of both halves
    # Recursive: depending on comparison send rest of set with other half back to merge and add it to first element
      # When one half is empty recursion ends by sending back other half, which will eventually be the whole set
# I think I get it...
# I just spent an hour debugging because I forgot a <=... BUT IT WORKS!

def merge_sort(set)
  split(set)
end

def split(set)
  if set.length <= 1
    set
  else
    middle = set.length/2
    front = split(set.take(middle))
    back = split(set.drop(middle))
    merge(front, back)
  end
end

def merge(front, back)
  if front.empty?
    back
  elsif back.empty?
    front
  elsif front.first <= back.first
    merge(front.drop(1), back).unshift(front.first)
  elsif back.first <= front.first
    merge(back.drop(1), front).unshift(back.first)
  end
end

to_sort = []
bubble_sorted_slice = []
bubble_sorted_inplace = []
insertion_sorted = []
merge_sorted = []

10.times { to_sort << ("a".."z").to_a.sample }

print to_sort; puts ""

Benchmark.bm(30) do |bm|
  bm.report('Bubble Sort Slice') { bubble_sorted_slice = bubble_sort_slice(Array.new(to_sort)) }
  print bubble_sorted_slice; puts ""
  bm.report('Bubble Sort Inplace') { bubble_sorted_inplace = bubble_sort_inplace(Array.new(to_sort)) }
  print bubble_sorted_inplace; puts ""
  bm.report('Insertion Sort') { insertion_sorted = insertion_sort(Array.new(to_sort)) }
  print insertion_sorted; puts ""
  bm.report('Merge Sort') { merge_sorted = merge_sort(Array.new(to_sort)) }
  print merge_sorted; puts ""
end