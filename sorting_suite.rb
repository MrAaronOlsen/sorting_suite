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

# break set into atom state
  # compare each pair and sort
    # merge each pair by comparing 1st in each

# I totaly don't get this and I need to study more into recursive loops

def merge_sort(set)

  pairs = atomize([set])
  pairs.map! { |pair| (pair.length > 1) ? sort(pair) : pair }

  until pairs.length == 1
    binding.pry
    pairs << merge(pairs.slice!(0), pairs.slice!(pairs.length))
  end

  pairs.flatten

end

def merge(set1, set2)

  merged = []

  checker = set1[0]
    
  until set1.empty? || set2.empty?
    
    binding.pry
    if checker >= set2[0]
      merged << set2.slice!(0)
    else 
      merged << set1.slice!(0)
      checker = set2[0]
    end
    binding.pry
  end

  binding.pry
  unless set1.empty? then merged << set1.each { |num| num } end
  unless set2.empty? then merged << set2.each { |num| num } end
  binding.pry

  merged.flatten

end

def sort(pair)

  pair[0] >= pair[1] ? swap(pair) : pair

end

def swap(pair)

  pair[0], pair[1] = pair[1], pair[0]

end

def atomize(sets)

  until atomized?(sets)

    sets.map! { |set| set.length > 2 ? split(set) : [set] }

  end

  sets
end

def atomized?(sets)

  sets.each { |set| return false if set.length > 2 }

  true

end

def split(set)

  [set.slice!(0, set.length/2), set]

end

to_sort = []
6.times { to_sort << rand(0..10) }

print to_sort; puts "\n\n"

bubble_sorted_slice = []
bubble_sorted_inplace = []
insertion_sorted = []
merge_sorted = []

=begin
Benchmark.bm(30) do |bm|
  bm.report('Bubble Sort Slice') { bubble_sorted_slice = bubble_sort_slice(Array.new(to_sort)) }
  print bubble_sorted_slice; puts ""
  bm.report('Bubble Sort Inplace') { bubble_sorted_inplace = bubble_sort_inplace(Array.new(to_sort)) }
  print bubble_sorted_inplace; puts ""
  bm.report('Insertion Sort') { insertion_sorted = insertion_sort(Array.new(to_sort)) }
  print insertion_sorted; puts ""
=end

merge_sorted = merge_sort(Array.new(to_sort))
print merge_sorted; puts ""