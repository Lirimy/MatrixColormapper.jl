import ColorTypes: Colorant
import Plots: frame
import FileIO: save
import IndirectArrays: IndirectArray

using Plots

mutable struct CurrentColorMap
    cs::AbstractVector{T} where T <: Colorant
end

const ccmap = CurrentColorMap(AbstractVector{Colorant}([]))
const value_range = [0., 1.]

function set_colormap(cg=:blues, n=31)
    ccmap.cs = RGB.(getindex.(cgrad(cg), linspace(0, 1, n)))
end

function set_cm_range(vmin::T, vmax::T) where T <: Real
    if vmin > vmax
        vmin, vmax = vmax, vmin
    end
    value_range .= vmin, vmax
end

function matshow(A::AbstractMatrix{T}, mode="none"::AbstractString) where T <: Real
    if length(ccmap.cs) == 0
        set_colormap()
    end
    
    if mode=="auto"
        vmin, vmax = minimum(A), maximum(A)
        An = (A - vmin) / (vmax - vmin)
    elseif mode=="range"
        vmin, vmax = value_range
        An = (A - vmin) / (vmax - vmin)
    else # mode=="none"
        An = A
    end
    
    n = length(ccmap.cs)
    #getindex(ccmap.cs, clamp.(ceil.(Int, n*An), 1, n))
    IndirectArray(clamp.(ceil.(Int, n*An), 1, n), ccmap.cs)
end

function Plots.frame(anim::Animation, img::AbstractMatrix{T}) where T<:Colorant
    i = length(anim.frames) + 1
    filename = @sprintf("%06d.png", i)
    save(joinpath(anim.dir, filename), img)
    push!(anim.frames, filename)
end