# Changelog

All notable changes to this project will be documented in this file.

The format is based on [Keep a Changelog](https://keepachangelog.com/en/1.0.0/).

## [Unreleased]

## [0.3.4] - 2023-05-23

### Added

- Some usability assembly testcases

### Changed

- Organize the project structure a little bit
- Format the interfaces' names for every module

### Fixed

- A bug of uart found (might relate to PC ports or Project caches) and fixed
- Fix some micro-bugs, now synthesis design passed

### Removed

- Project cache files and folders, only upload source files

## [0.3.3] - 2023-05-22

### Added

- `uart` IP core for uart input
- Complete the basic connection between modules in `top.v`

### Changed

- Modify the definition headers to accommodate more features
- Strengthen the `InstDecoder.v`  ,`ALU.v`, `reg.v` module for more functions
- Implement `J type` instructions by reinforcing `PC.v`
- Simplified the ISA, making the project *lightweight* as a feather

### Fixed

- Fix some bugs of `keyboard.v`
- Fix the Minisys board LED problem

## [0.3.2] - 2023-05-14

### Added

- Add `DMA.v`, the memory-mapped IO module
- Add `keyboard.v` and `segtube.v`, handling the hardware IO
- Add `top.v`, initialize the development of the top module

## [0.3.1] - 2023-05-04

### Added

- Add `PC.v` module
- Add `reg.v` module

### Changed

- Complete basic `InstDecoder`, a relative complete ID module
- Complete basic `ALU.v` module

## [0.3.0] - 2023-04-26

### Added

- Add definition headers: `ParamDef.vh`, `ALUDef.vh`, `InstDef.vh`
- Add `ALU.v`
- Add `InstDecoder.v`, naive version of controller
- Add `InstMemory` and `DataMemory`

## [0.2.0] - 2023-04-19

### Added

- Create the Vivado project source
- Add `.gitignore`
- Add `rars2coe.cpp` to convert rars output assemble code to coe file
- Add Chinese version README and TODOs
- Basic ISA design done, introduction of ISA split into `doc/FeatherISA.md`

## [0.1.0] - 2023-04-12

### Added

- Initialize the repository.
- Add `README.md` and `CHANGELOG.md`.

---

<font style="font-size: 1.5rem"><a href="https://keepachangelog.com/en/1.1.0/">How to keep a changelog?</a></font>

1. For each version, put the new log on the top of the changelog.

2. Format:

   ```markdown
   ## [x.x.x] - YYYY-MM-DD
   ### TYPE 1
   - Description 1
   - Description 2
   ### TYPE 2
   - Description 1
   - Description 2
   ...
   ```

3. Update types:

   - `Added` for new features.
   - `Changed` for changes in existing functionality.
   - `Deprecated` for soon-to-be removed features.
   - `Removed` for now removed features.
   - `Fixed` for any bug fixes.
   - `Security` in case of vulnerabilities.

4. Chinese accepted, as long as we can translate this changelog into English by DDL :)