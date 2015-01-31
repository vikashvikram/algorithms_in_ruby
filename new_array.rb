require_relative 'sorting/selection_sort'
require_relative 'sorting/merge_sort'
require_relative 'searching/binary_search'
require_relative 'searching/sequential_search'

class NewArray < Array

#Include sorting algorithms
include SelectionSort
include MergeSort

#include searching algorithms
include SequentialSearch
include BinarySearch
end
