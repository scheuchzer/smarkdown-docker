# Welcome to Smarkdown

Your Smarkdown Docker setup is working!

To add some content you have to mount a volume to `/smarkdown_data`

```
docker run --rm -it -p 8080:8080 -v /path/to/my/data:/smarkdown_data scheuchzer/smarkdown
```

and then add some markdown files to `/path/to/my/data`.

For more configuration options see the [GitHub page](https://github.com/scheuchzer/smarkdown-docker)
