using GLMakie

fig1, ax1, plt1 = heatmap(rand(50, 50))
fig2, ax2, plt2 = scatterlines(0:0.1:10, sin)

# multiple windows
display(GLMakie.Screen(), fig1)
display(GLMakie.Screen(), fig2)

# close everything
GLMakie.closeall()
