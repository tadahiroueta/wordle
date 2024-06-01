# Wordle
***My adaptation of iOS adaptation of [Wordle](https://www.nytimes.com/games/wordle/index.html)***

[Built With](#built-with) · [Features](#features) · [Installation](#installation) · [Usage](#usage)

## Built With

- ![UIkit](https://img.shields.io/badge/uikit-2581d0?style=for-the-badge&logo=uikit&logoColor=white)
- ![Swift](https://img.shields.io/badge/swift-F54A2A?style=for-the-badge&logo=swift&logoColor=white)
- ![iOS](https://img.shields.io/badge/iOS-000000?style=for-the-badge&logo=ios&logoColor=white)

## Features

### Faithful to the original [Wordle](https://www.nytimes.com/games/wordle/index.html)
The game follows the same rules, general graphics, and a similar vocabulary

<img src="https://github.com/tadahiroueta/wordle/blob/master/samples/good-game.gif" alt="good-game" width="33%" />

### Model-View-Controller design

The code is divided among
- ```Game.swift``` (Model)
- ```Tile.swift``` and ```TileTable``` (View)
- ```MainViewController.swift```, ```HelpViewController.swift```, and ```SettingsViewController.swift``` (Controller)

### Dark-Mode setting
All views have their colour properties updated dynamically to adjust to the setting

<img src="https://github.com/tadahiroueta/wordle/blob/master/samples/dark-mode.gif" alt="dark-mode" width="33%" />

### Multiple Views
The app includes two views on top of the main game view: the intructions and the dark-mode settings. These are opened with segues as "pop-ups".

<img src="https://github.com/tadahiroueta/wordle/blob/master/samples/instructions.gif" alt="instructions" width="33%" />

## Installation

1. Install [Xcode](https://developer.apple.com/xcode/)

2. Clone repository
    - Open Xcode
    - "Clone an existing project"
    - Enter ```https://github.com/tadahiroueta/wordle.git```

## Usage
1. Run the iOS simulator by clicking the ```▶``` button
  
<img src="https://github.com/tadahiroueta/wordle/blob/master/samples/bad-game.gif" alt="bad-game" width="33%" />