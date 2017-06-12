# Ricty Generator

Generate Ricty using Docker.

## Dependencies

- [Docker](https://www.docker.com/)

## Usage

Clone this repository and run `make` command.

```zsh
$ git clone https://github.com/waltarix/ricty_generator
$ cd ricty_generator
$ make
```

The font files will be generated in `fonts` directory.

```
$ tree fonts
fonts
|-- Ricty-Bold.ttf
|-- Ricty-Regular.ttf
|-- RictyDiscord-Bold-for-Powerline.ttf
|-- RictyDiscord-Bold.ttf
|-- RictyDiscord-Regular-for-Powerline.ttf
|-- RictyDiscord-Regular.ttf
`-- windows
    |-- Ricty-Bold.ttf
    |-- Ricty-Regular.ttf
    |-- RictyDiscord-Bold-for-Powerline.ttf
    |-- RictyDiscord-Bold.ttf
    |-- RictyDiscord-Regular-for-Powerline.ttf
    `-- RictyDiscord-Regular.ttf

1 directory, 12 files
```

### Misc

You can specify Ricty's `-d` option using `RICTY_DISCORD_OPT`.

```zsh
# default: "'*+,-.07:;<>=DZ^`rz|~

$ make RICTY_DISCORD_OPT=DZz
# => ricty_generator.sh -d DZz

$ make RICTY_DISCORD_OPT=
# => ricty_generator.sh
```
