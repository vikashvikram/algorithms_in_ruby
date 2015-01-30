require_relative 'sorting/selection_sort'
require_relative 'searching/binary_search'
require_relative 'searching/sequential_search'

class NewArray < Array

#Include sorting algorithms
include SelectionSort

#include searching algorithms
include SequentialSearch
include BinarySearch
end
