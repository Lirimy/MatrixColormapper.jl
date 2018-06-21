# MatrixColormapper

[![Build Status](https://travis-ci.org/Lirimy/MatrixColormapper.jl.svg?branch=master)](https://travis-ci.org/Lirimy/MatrixColormapper.jl)

[![Coverage Status](https://coveralls.io/repos/Lirimy/MatrixColormapper.jl/badge.svg?branch=master&service=github)](https://coveralls.io/github/Lirimy/MatrixColormapper.jl?branch=master)

[![codecov.io](http://codecov.io/github/Lirimy/MatrixColormapper.jl/coverage.svg?branch=master)](http://codecov.io/github/Lirimy/MatrixColormapper.jl?branch=master)


MatrixColormapper.jl shows matrices as images.

```julia: Sample of matrix showing and saving
using MatrixColormapper

img = matshow(rand(100, 100))
#FileIO.save("sample.png", img)
```

![sample image](https://user-images.githubusercontent.com/31124605/41716042-2e327774-7590-11e8-9b3b-648877bcbf53.png)

```julia: Animation sample
using Plots
using MatrixColormapper

anim = Animation()
for i in 1:10
    img = matshow(rand(100, 100))
    frame(anim, img)
end

gif(anim, "sample.gif")
#mp4(anim, "sample.mp4")
```


