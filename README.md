# MatrixColormapper

[![Build Status](https://travis-ci.org/Lirimy/MatrixColormapper.jl.svg?branch=master)](https://travis-ci.org/Lirimy/MatrixColormapper.jl) [![Coverage Status](https://coveralls.io/repos/Lirimy/MatrixColormapper.jl/badge.svg?branch=master&service=github)](https://coveralls.io/github/Lirimy/MatrixColormapper.jl?branch=master) [![codecov.io](http://codecov.io/github/Lirimy/MatrixColormapper.jl/coverage.svg?branch=master)](http://codecov.io/github/Lirimy/MatrixColormapper.jl?branch=master)

MatrixColormapper.jl converts matrices to images, according to colormap.


## Sample Code

### Simple Show & Save

```julia
import Images: display # To show images as png, not as svg (so heavy at browser)
using MatrixColormapper

img = matshow(rand(100, 100)) # Image is displayed in Jupyter Notebook
#FileIO.save("sample.png", img)
```

![sample image](https://user-images.githubusercontent.com/31124605/41716042-2e327774-7590-11e8-9b3b-648877bcbf53.png)

### Animation with Plots

```julia
using Plots
using MatrixColormapper

anim = Animation()
for i in 1:10
    img = matshow(rand(100, 100));
    frame(anim, img)
end

gif(anim, "sample.gif")
#mp4(anim, "sample.mp4")
```

![sample gif](https://user-images.githubusercontent.com/31124605/41716360-27355378-7591-11e8-986e-4f964284846c.gif)

### Color Mapping

```julia
using MatrixColormapper

using Plots
cgradients() # List color gradients
set_colormap(:pu_or, 15) # 15-gradation

using ColorSchemes
schemes # List color schemes
set_colormap(ColorSchemes.alpine, 20)
x = sinpi.(0:0.01:2) .+ sinpi.(0:0.01:2)'
matshow(x, "auto") # In "auto" mode, matrix is scaled by (min, max)

# Set range manually
set_cm_range(-2, 2)
matshow(x, "range")
```

![cmap](https://user-images.githubusercontent.com/31124605/41717392-98f753a0-7594-11e8-94c3-f6590513cd60.png)


## Acknowledgments

MatrixColormapper.jl contains copy and modification of Plots.jl.  
Plots.jl: Copyright (c) 2015: Thomas Breloff.
