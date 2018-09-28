using DataAndPlotting
using Test

filename = "/tmp/array.h5"
rm(filename, force=true)
arr = initialize()
output(arr, "/tmp/array.h5")

arr2 = input("/tmp/array.h5")

@test isequal(arr2,arr)