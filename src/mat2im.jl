import ColorTypes: Colorant, RGB
import ColorSchemes: colormap
import IndirectArrays: IndirectArray
import MappedArrays: mappedarray
#import FileIO: save

const CURRENT_COLORMAP = colormap("Blues", 256)
current_colormap() = CURRENT_COLORMAP

function set_colormap(cmap::AbstractVector{T}) where T <:Colorant
    
    if(length(cmap) == 256)
        @. CURRENT_COLORMAP = RGB(cmap)
    end
    CURRENT_COLORMAP
end

function matshow(A::AbstractMatrix{T}; cmap=current_colormap()) where T <: Real
    @assert length(cmap) == 256 "Colormap's length must be 256, got $(length(cmap))"
    
    f = s -> clamp(ceil(Int, 256*s), 1, 256)
    IndirectArray(mappedarray(f, A), cmap)
end