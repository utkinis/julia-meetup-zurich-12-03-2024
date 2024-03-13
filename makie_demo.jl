using GLMakie

# setup the backend
GLMakie.activate!(; decorated=true, title="Julia Meetup Zürich")

# simple 1D
scatterlines(range(0, 2π, 100), sin)

# update plot with mutating functions
scatterlines!(range(0, 2π, 100), cos)

# clear axis
empty!(current_axis())

# clear figure
empty!(current_figure())

# switching backends
using CairoMakie
CairoMakie.activate!()

# simple 2D
heatmap(rand(50, 50); colormap=:copper)

# switch back for 3D and interactivity
GLMakie.activate!()

# simple 3D
# FPS camera (wasd, q/e for tilting, r/f for up/down)
contour(rand(10, 10, 10))

# layout
fig = Figure(size=(800, 600))

ax1 = Axis(fig[1, 1]; title="Axis 1")
ax2 = Axis(fig[1, 2][1, 1]; title="Axis 2", aspect=DataAspect())
ax3 = Axis3(fig[2, 1][1, 1]; title="Axis 3")
ax4 = Axis3(fig[2, 2][1, 1]; title="Axis 4")

lines!(ax1, cumsum(randn(1000)))

hm = heatmap!(ax2, rand(50, 50); colormap=:copper)
Colorbar(fig[1, 2][1, 2], hm)

scatter!(ax3, rand(3, 100); color=rand(100))

DataInspector()

xs = range(-2π, 2π, 50)
ys = range(-2π, 2π, 50)
zs = range(-2π, 2π, 50)

data = [sin(x) * cos(y) * sin(z) for x in xs, y in ys, z in zs]

vs = volumeslices!(ax4, xs, ys, zs, data; inspectable=false)

rowsize!(fig.layout, 1, Relative(1 / 3))

# sliders
sg = SliderGrid(fig[2, 2][2, 1],
    (label="X", range=1:50, startvalue=25),
    (label="Y", range=1:50, startvalue=25),
    (label="Z", range=1:50, startvalue=25)
)

sl_yz, sl_xz, sl_xy = sg.sliders

on(sl_yz.value) do v
    vs[:update_yz][](v)
end
on(sl_xz.value) do v
    vs[:update_xz][](v)
end
on(sl_xy.value) do v
    vs[:update_xy][](v)
end
