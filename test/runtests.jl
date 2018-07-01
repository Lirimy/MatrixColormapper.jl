using MatrixColormapper
@static if VERSION < v"0.7.0-DEV.2005"
    using Base.Test
else
    using Test
end


img = Array(matshow([0. 0.3; 0.7 1.]))
@test img[2].g ≈ 0.5269898088662904

fn = tempname() * ".mp4"
anim = openanim(fn) do aio
    addframe(aio, img)
end

@test typeof(anim) == MatrixColormapper.AnimationFile