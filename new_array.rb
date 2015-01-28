require_relative 'sorting'
require_relative 'searching'

class NewArray < Array

#Include sorting algorithms
include Sorting

#include searching algorithms
include Searching
end
