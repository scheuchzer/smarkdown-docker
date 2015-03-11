# Smakrdown Docker Image

This is an example Dockerfile for the [Smarkown application](https://github.com/scheuchzer/smarkdown). This image is based on the latest [Wildfly image](https://github.com/JBoss-Dockerfiles/wildfly).

## Usage

To run with the default configuration

```bash
docker run --rm -it -p 8080:8080 scheuchzer/smarkdown
```

This will provide a simple page at http://127.0.0.1:8080/smarkdown/ without any other content.

## Documents publishing

### Default configuration

By default smarkdown will read content from the volume directory `/smarkdown_data`. You have two possibilities to add content to that folder

1. Mount a volume
  ```
  docker run --rm -it -p 8080:8080 -v /path/to/content:/smarkdown_data scheuchzer/smarkdown
  ```
2. Add your content in your own `Dockerfile` 
  ```
  ADD somefile.md /smarkdown_data/
  ```

### Custom configuration

You can provide your own configuration. You'll have to do this if

- you want to connect to locations outside of `/smarkdown_data` like
 - Classpath
 - Github
- you want to change the application name
- you want to change the templates

See the [Smarkdown documentation](http://smarkdown.java-adventures.com/smarkdown/configuration.html) for more infos about the configuration parameters.

## Extending the image

By default the following Smarkdown modules get loaded during the building of the image

- smarkdown-core
- smarkdown-configuration-filesystem
- smarkdown-jekyll
- smarkdown-jsf
- smarkdown-location-file
- smarkdown-location-github
- smarkdown-location-http
- smarkdown-plantuml
- smarkdown-yuml

If you don't need all of these or if you need additional modules, `ADD` a file `/opt/smarkdown/modules.cfg` to your Dockerfile. This file lists all modules that go into the build, one module per line. [See the default file.](https://github.com/scheuchzer/smarkdown-docker/modules.cfg)

After adding the file run the `/opt/smarkdown/assemble.sh` script to rebuild the war file. Ther's a environment variable `SMARKDOWN_ASSEMBLE_FILE` you can use.

```
RUN $SMARKDOWN_ASSEMBLE_FILE 
```

If you have very custom stuff to do, `ADD` a file `/opt/smarkdown/thirdparty.sh` (environment variable `SMARKDOWN_THIRDPARTY_FILE`). This is a (by default empty) script that gets called by `assemble.sh` after loading the modules and before packing the war file. In this file you can do whatever you like. 

## Source

The source is [available on GitHub](https://github.com/scheuchzer/smarkdown-docker).

## Issues

Please report any issues on [GitHub](https://github.com/scheuchzer/smarkdown-docker/issues).