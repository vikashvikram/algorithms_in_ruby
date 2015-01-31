require_relative 'sorting/selection_sort'
require_relative 'sorting/merge_sort'
require_relative 'searching/binary_search'
require_relative 'searching/sequential_search'
require_relative 'array_inversions'

class NewArray < Array

#Include sorting algorithms
include SelectionSort
include MergeSort

include ArrayInversion
#include searching algorithms
include SequentialSearch
include BinarySearch
end
