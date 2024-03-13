using GLMakie

# observables
x = Observable(1)
on(x) do x
    println("x changed to $x")
end

# message will be printed
x[] = 2

# lifting observables
y = @lift $x^2

x[] = 3
y

# can plot observables
scatter(x, y)

# plot updates interactively
x[] = 4

# hands-on 1
# time variable 🕢
t = 1.0

xs = range(-π, π, 100)
ys = range(-π, π, 100)

points = sin.(xs .+ 0.25 * t) .* cos.(ys' .- 1.0 * t)

fig = Figure()
ax = Axis3(fig[1, 1])
plt = surface!(ax, xs, ys, points)

# use observables to animate the plot
for t in 0:0.1:10
    sleep(1 / 30)
end

# ------------------------------------
# even without using observables, Makie creates them internally
t = 1.0
points = sin.(xs .+ 0.25 * t) .* cos.(ys' .- 1.0 * t)

fig = Figure()
ax = Axis3(fig[1, 1])
plt = surface!(ax, xs, ys, points)

# observable can be accessed from the plot object
plt[3]

# hands-on 2
# animate without observables
for t in 0:0.1:10
    # ...
    sleep(1 / 30)
end
