
<div align=center>  <h1> 8XLib v0.0.1 </h1>  </div>

# Table of Contents

- [Table of Contents](#table-of-contents)
- [Disclaimer](#disclaimer)
- [Installation](#installation)
- [Modules](#modules)
  - [Clock](#clock)
  - [Submarine](#submarine)
  - [Animo](#animo)
  - [AStar](#astar)
- [Contributing](#contributing)

# Disclaimer
Nearly everything in this repository is work-in-progress, so not every Module will be available yet. Feel free to contribute to make that faster!

# Installation
Here's how to install:
1. Download the latest release/prerelease from Tags.
2. Open GameMaker
3. Goto Tools -> Import Local Package

# Modules
Modules are marked "released" or "unreleased" depending on if they are available in the GitHub release

## Clock
**Prerelease**

This module features;
- Timer structs
- Timer Controllers

Timers can be modified with a bunch of different options like randomized tick-rates, set time, callbacks etc.
Timer controllers can be used to control groups of timers at once.

## Submarine
**Prerelease**

This module features;
- Event Handler
- Event subscription and publication

Objects or Structs can be subscribed to an event and when an event is published, a callback ( if defined ) will execute.

## Animo
**Unreleased**

This module will feature;
- Lightweight animation structs that are highly modular.
- Globally scoped animation map that you can store individual character animations in.
- Single, Looped and Chained animation types.
	- Single: Will only animate once.
	- Looped: Will animate based on an amount of iterations defined.
	- Chained: Will animate based on iterations and switch to another defined animation once it reaches its maximum iterations.

## AStar
**Unreleased**

This module will feature;
- AStar Grids
- AStar Search

# Contributing
Issues, PRs, etc. are all welcome!
