using MatrixColormapper
@static if VERSION < v"0.7.0-DEV.2005"
    using Base.Test
else
    using Test
end

using Plots

bnw = [RGB{Float64}(i, i, i) for i in [0.1, 0.9]]
set_colormap(bnw, 3)
@test MatrixColormapper.ccmap.cs[2] == RGB{Float64}(0.5, 0.5, 0.5)

img = matshow([0 0; 1 1])
@test typeof(img) == Array{ColorTypes.RGB{Float64},2}

anim = Animation()
frame(anim, img)
@test typeof(gif(anim, joinpath(anim.dir, "tmp.gif"))) == Plots.AnimatedGif
@test typeof(mp4(anim, joinpath(anim.dir, "tmp.mp4"))) == Plots.AnimatedGif
