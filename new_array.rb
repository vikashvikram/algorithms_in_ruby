require_relative 'sorting/selection_sort'
require_relative 'sorting/insertion_sort'
require_relative 'sorting/merge_sort'
require_relative 'sorting/quick_sort'
require_relative 'sorting/bubble_sort'
require_relative 'searching/binary_search'
require_relative 'searching/sequential_search'
require_relative 'array_inversions'
require_relative 'assignment'

class NewArray < Array

#Include sorting algorithms
include SelectionSort
include InsertionSort
include MergeSort
include BubbleSort
include QuickSort

include ArrayInversion
include Assignment2
#include searching algorithms
include SequentialSearch
include BinarySearch
end
