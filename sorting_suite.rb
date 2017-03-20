# Sorting Suite

require 'pry'
require 'benchmark'

class String # This is so cool! Dangerous I think, but cool

  def plus(array)
    [self]+array
  end  

end

class Fixnum # Added this so merge sort can do both nums and chars. Fun, but totaly not needed.

  def plus(array)
    [self]+array
  end

end

class Array # What I think unshift should be called!

  def promote(string)
    self.unshift(string)
  end

end

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

class InsertionSort

  attr_reader :set

  def initialize(set)
    @set = set
  end

  def sort
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

    @set = sorted
  end
end

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

  def merge(front, back)
    if front.empty?
      back
    elsif back.empty?
      front
    elsif front.first <= back.first
      #front.first.plus(merge(front.drop(1), back))      # Just playing with around with syntax here
      merge(front.drop(1), back).unshift(front.first)
      #[front.first] + merge(front.drop(1), back)         # Probably the best way
    elsif back.first <= front.first
      #back.first.plus(merge(back.drop(1), front))
      merge(back.drop(1), front).unshift(back.first)
      #[back.first] + merge(back.drop(1), front)
    end
  end

end

# Test Proofs and Benchmarks
# Sorting Characters

set_size = 20

chars_to_sort = []
set_size.times { chars_to_sort << ("a".."z").to_a.sample }

puts "\nCharacters To Sort"
#print chars_to_sort; puts"\n\n"

bubble_sorted = BubbleSort.new(Array.new(chars_to_sort))
insertion_sorted = InsertionSort.new(Array.new(chars_to_sort))
merge_sorted = MergeSort.new(Array.new(chars_to_sort))

Benchmark.bm(20) do |bm|
  bm.report('Bubble Sort') { bubble_sorted.sort }
  #print bubble_sorted.set; puts""
  bm.report('Insertion Sort') { insertion_sorted.sort }
  #print insertion_sorted.set; puts""
  bm.report('Merge Sort') { merge_sorted.sort }
  #print merge_sorted.set; puts""
end

# Sorting Numbers

nums_to_sort = []
set_size.times { nums_to_sort << rand(0..100) }

puts "\n\nNumbers To Sort"
#print nums_to_sort; puts"\n\n"

bubble_sorted = BubbleSort.new(Array.new(nums_to_sort))
insertion_sorted = InsertionSort.new(Array.new(nums_to_sort))
merge_sorted = MergeSort.new(Array.new(nums_to_sort))

Benchmark.bm(20) do |bm|
  bm.report('Bubble Sort') { bubble_sorted.sort }
  #print bubble_sorted.set; puts""
  bm.report('Insertion Sort') { insertion_sorted.sort }
  #print insertion_sorted.set; puts""
  bm.report('Merge Sort') { merge_sorted.sort }
  #print merge_sorted.set; puts""
end

