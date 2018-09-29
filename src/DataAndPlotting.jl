module DataAndPlotting

using HDF5
using Plots

# wave params
const ki = 3
const kj = 4

# grid size
const ni = 300
const nj = 200

function index2coord(i, ni)
   @assert ni > 1
   @assert 1 <= i <= ni
   (i-1)/(ni -1)
end

   
# set up standing wave
export initialize
function initialize()
   arr = zeros(Float64, ni, nj)
   for j in 1:nj, i in 1:ni
      # i ranges from 1...ni
      # x ranges from 0...1
      x = index2coord(i,ni)
      y = index2coord(j,nj)
      arr[i,j] = sin(2*pi*ki*x)*sin(2*pi*kj*y)
   end
   arr
end

# write data to file

export output
function output(arr::Array{Float64,2}, filename::String)
   h5write(filename, "data", arr)
end

# read data files
export input
function input(filename::String)
    arr = h5read(filename, "data") 
end

# create plot

export makeplot
function makeplot(arr::Array{Float64,2}, filename::String)
    heatmap(arr, clim = (-1.0, 1.0), color =:viridis)
    savefig(filename)
end


end
