# Klipper Config

A set of portable Klipper configuration snippets shared between my machines.

## Installation

```sh
cd
git clone https://github.com/thetic/klipper-config.git
ln -s ~/klipper-config printer_data/config/config
```

In `moonraker.conf`:

```
[include config/moonraker/*.conf]
```

In `printer.cfg`:

```
[include config/klipper/*.cfg]
```

In `KlipperScreen.conf`:

```
[include config/KlipperScreen/*.conf]
```

## Configuration

Optional configuration snippets are found in the `feature/` directories.
These snippets are typically incomplete.
Machine-specific options will need to be added to the `printer.cfg`

For example,

```
[include config/klipper/feature/beeper.cfg]

[output_pin _beeper]
pin: EXP1_1
```
