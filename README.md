# MatrixColormapper

[![Build Status](https://travis-ci.org/Lirimy/MatrixColormapper.jl.svg?branch=master)](https://travis-ci.org/Lirimy/MatrixColormapper.jl) [![Coverage Status](https://coveralls.io/repos/Lirimy/MatrixColormapper.jl/badge.svg?branch=master&service=github)](https://coveralls.io/github/Lirimy/MatrixColormapper.jl?branch=master) [![codecov.io](http://codecov.io/github/Lirimy/MatrixColormapper.jl/coverage.svg?branch=master)](http://codecov.io/github/Lirimy/MatrixColormapper.jl?branch=master)

MatrixColormapper.jl converts matrices to images, according to colormap.

## Installation

Julia 0.6.x  
Requirements: ffmpeg, imagemagick

```julia
Pkg.clone("https://github.com/Lirimy/MatrixColormapper.jl")
```

## Usage

### Show Matrix, Save Image

```julia
using MatrixColormapper

img = matshow(rand(100, 100)) # Image is displayed in Jupyter Notebook
#FileIO.save("sample.png", img)
```

![sample image](https://user-images.githubusercontent.com/31124605/41716042-2e327774-7590-11e8-9b3b-648877bcbf53.png)

### Animation

mp4/gif supported.

```julia
using MatrixColormapper

openanim("test.gif") do aio
    for i in 1:10
        img = matshow(rand(100, 100))
        addframe(aio, img)
    end
end
```

![sample gif](https://user-images.githubusercontent.com/31124605/41716360-27355378-7591-11e8-986e-4f964284846c.gif)

### Color Mapping

Example using ColorSchemes.jl

```julia
using MatrixColormapper
using ColorSchemes

schemes # List color schemes
set_colormap(ColorSchemes.colormap("RdBu", 256)) # Confirm 256 colors
```

## Acknowledgments

MatrixColormapper.jl contains copy and modification of Plots.jl.  
Plots.jl: Copyright (c) 2015: Thomas Breloff.
