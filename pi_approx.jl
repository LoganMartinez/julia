using Random.Random

struct Point{T}
  x::T
  y::T
end

function imperative_pi(samples_length::Int64)
  num_inside = 0
  for i in range(1, samples_length)
    sample = rand(Float32, 2)
    if sample[1]*sample[1]+sample[2]*sample[2] <= 1.0
      num_inside += 1
    end
  end
  return 4num_inside/samples_length
end

function functional_pi(samples_length::Int64)
  num_inside = map(fill(0, samples_length)) do s
    sample = rand(Float32, 2) 
    sample[1]*sample[1]+sample[2]*sample[2]
  end |> filter(d -> d <= 1.0) |> length
  return 4num_inside/samples_length
end

function functional_pi_map_only(samples_length::Int64)
  num_inside = map(fill(0, samples_length)) do s
    sample = rand(Float32, 2)
    sample[1]*sample[1]+sample[2]*sample[2] <= 1.0 
  end |> sum
  return 4num_inside/samples_length
end

function functional_pi_filter_only(samples_length::Int64)
  num_inside = filter(fill(0, samples_length)) do s
    sample = rand(Float32, 2)
    sample[1]*sample[1]+sample[2]*sample[2] <= 1.0 
  end |> length
  return 4num_inside/samples_length
end

n = 1000000000

# 18.000356 seconds (1.00 G allocations: 59.605 GiB, 1.03% gc time)
@time print(imperative_pi(n))

# 26.920990 seconds (1.00 G allocations: 74.506 GiB, 1.20% gc time)
@time print(functional_pi(n))

# 20.231583 seconds (1.00 G allocations: 67.987 GiB, 2.27% gc time)
@time print(functional_pi_map_only(n))

# 24.513869 seconds (1.00 G allocations: 74.506 GiB, 1.44% gc time)
@time print(functional_pi_filter_only(n))