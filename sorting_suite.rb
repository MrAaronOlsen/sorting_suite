# Sorting Suite

require 'pry'
require 'benchmark'

# Bubble Sort

class BubbleSort
    
  attr_reader :set

  def initialize(set)
    @set = set
  end

  def sort

    j = set.length

    until j == 0
      
      i = 0

      until i+1 == set.length
        swap(i) if set[i] >= set[i+1]
        i+=1
      end

      j-=1
    end
  end

  def swap(i)
    set[i], set[i+1] = set[i+1], set[i]
  end

end

# Insertion Sort

class InsertionSortStable

  attr_reader :set, :copy, :sorted

  def initialize(set)
    @set = set
    @copy = Array.new(set)
    @sorted = []
  end

  def sort

    until sorted.length == set.length
      i = 0
      
      loop do
        if sorted.empty? || i == sorted.length || copy[0] <= sorted[i]
          sorted.insert(i, copy[0])
          break
        end

        i+=1
      end

      copy.shift
    end
  end
end

class InsertionSortInplace

  attr_accessor :set

  def initialize(set)
    @set = set
  end

  def sort

     (1..set.length-1).each do |i|
      check = set.slice!(i)
      index = i
  
      until index == 0 || check > set[index-1] do # Ah!
        index-=1
      end 
        
        set.insert(index, check)
    end
  end

end

# Merge Sort

class MergeSort

  attr_reader :set

  def initialize(set)
    @set = set
  end

  def sort
    @set = split(set)
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

  def merge_recursive(front, back) # Throws a "stack too deep" error on nums > ~15000
    if front.empty?
      back
    elsif back.empty?
      front
    elsif front.first <= back.first
      [front.first] + merge(front.drop(1), back)
    elsif back.first <= front.first
      [back.first] + merge(back.drop(1), front)
    end
  end

  def merge(front, back) # Instead of calling merge again just fills new array as it checks firsts of front/back 
    sorted = []

    until front.empty? || back.empty?
      front.first <= back.first ? sorted << front.slice!(0) : sorted << back.slice!(0)
    end

    sorted + front + back
  end
end

# Test Proofs and Benchmarks
# Sorting Characters

set_size = 20

chars_to_sort = []
set_size.times { chars_to_sort << ("a".."z").to_a.sample }

puts "\nCharacters Sort"
print chars_to_sort; puts"\n\n"

bubble_sorted = BubbleSort.new(Array.new(chars_to_sort))
insertion_sorted_stable = InsertionSortStable.new(Array.new(chars_to_sort))
insertion_sorted_inplace = InsertionSortInplace.new(Array.new(chars_to_sort))
merge_sorted = MergeSort.new(Array.new(chars_to_sort))

Benchmark.bm(25) do |bm|
  bm.report('Bubble Sort') { bubble_sorted.sort }
  print bubble_sorted.set; puts""
  bm.report('Insertion Sort Stable') { insertion_sorted_stable.sort }
  print insertion_sorted_stable.sorted; puts""
  bm.report('Insertion Sort Inplace') { insertion_sorted_inplace.sort }
  print insertion_sorted_inplace.set; puts""
  bm.report('Merge Sort') { merge_sorted.sort }
  print merge_sorted.set; puts""
end

# Sorting Numbers

nums_to_sort = []
set_size.times { nums_to_sort << rand(0..100) }

puts "\n\nNumbers Sort"
print nums_to_sort; puts"\n\n"

bubble_sorted = BubbleSort.new(Array.new(nums_to_sort))
insertion_sorted_stable = InsertionSortStable.new(Array.new(nums_to_sort))
insertion_sorted_inplace = InsertionSortInplace.new(Array.new(nums_to_sort))
merge_sorted = MergeSort.new(Array.new(nums_to_sort))

Benchmark.bm(25) do |bm|
  bm.report('Bubble Sort') { bubble_sorted.sort }
  print bubble_sorted.set; puts""
  bm.report('Insertion Sort Stable') { insertion_sorted_stable.sort }
  print insertion_sorted_stable.set; puts""
  print insertion_sorted_stable.sorted; puts""
  bm.report('Insertion Sort Inplace') { insertion_sorted_inplace.sort }
  print insertion_sorted_inplace.set; puts""
  bm.report('Merge Sort') { merge_sorted.sort }
  print merge_sorted.set; puts""
end

puts "\n"