import ColorTypes: Colorant, RGB
import ColorSchemes: colormap
import IndirectArrays: IndirectArray
import MappedArrays: mappedarray
import FileIO: open, close, save, @format_str, Stream

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

file_extension(fn) = lowercase(Base.Filesystem.splitext(fn)[2][2:end])

struct AnimationFile
    filename::String
end

function Base.show(io::IO, ::MIME"text/html", anim::AnimationFile)
    ext = file_extension(anim.filename)

    if ext == "mp4"
        write(io, "<video controls><source src=\"$(relpath(anim.filename))?$(rand())>\" type=\"video/mp4\"></video>")
    elseif ext == "gif"
        write(io, "<img src=\"$(relpath(anim.filename))?$(rand())>\" />")
    else
        error("Only support mp4/gif: $ext")
    end
    
    nothing
end

function openanim(f::Function, filename::String="out.mp4")
    filename = abspath(filename)
    ext = file_extension(filename)
    
    if ext == "mp4"
        open(f, `ffmpeg -v 0 -i pipe:0 -pix_fmt yuv420p -y $filename`, "w")
        return AnimationFile(filename)
    elseif ext == "gif"
        palette = tempname() * ".bmp"
        save(palette, IndirectArray(reshape(1:256, 16, 16)', current_colormap()))
        open(f, `ffmpeg -v 0 -i pipe:0 -i $palette -lavfi paletteuse=dither=sierra2_4a -y $filename`, "w")
        return AnimationFile(filename)
    else
        error("Only support mp4/gif: $ext")
    end
end

function addframe(io, img::AbstractMatrix)
    save(Stream(format"BMP", io), img)
end