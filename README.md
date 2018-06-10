# Template C++ Project

[![codecov](https://codecov.io/gh/OxfordRSE/template-project-cpp/branch/master/graph/badge.svg)](https://codecov.io/gh/OxfordRSE/template-project-cpp)
[![Build
Status](https://travis-ci.org/OxfordRSE/template-project-cpp.svg?branch=master)](https://travis-ci.org/OxfordRSE/template-project-cpp)
[![Build status](https://ci.appveyor.com/api/projects/status/5245a76r7ikhaass/branch/master?svg=true)](https://ci.appveyor.com/project/fcooper8472/template-project-cpp/branch/master)

##### WARNING: still under construction

## Overview

This repository is a template to help get you set up quickly when starting a new C++ project.
We have tried to conform to common software engineering 'best practices', and to that end this repository features the following:

- C++14
- [CMake](cmakelists.txt) build script for cross-platform configuration
- [Catch](mytests.cpp) unit testing framework
- [Travis](.travis.yml) integration for automated testing on Linux and macOS
- [AppVeyor](appveyor.yml) integration for automated testing on Windows
- [Codecov](codecov) integration for automated coverage testing
- [ClangFormat](.clang-format) for automated source code formatting
- [Clang-Tidy](.clang-tidy) for static analysis to catch coding errors
- [AddressSanitizer](AddressSanitizer) for catching memory-related issues


In addition, the project is set up to use the [boost libraries](https://www.boost.org/), and we will hopefully add other common libraries to the configuration soon.


## Getting started

We strongly recommend that you use `git` to keep your copy of this project under version control.

Feel free to:
- [Duplicate this 
  repository](https://help.github.com/articles/duplicating-a-repository), or
- [Download a 
  zip](https://github.com/OxfordRSE/template-project-cpp/archive/master.zip), 
  and then initialise it as a git repository

Note: if you just [Fork this 
repository](https://github.com/OxfordRSE/template-project-cpp#fork-destination-box) 
then it will *not* be independent of the original repo (i.e. no separate GitHub 
issues)


## Where does it run?

We expect this project to be usable on all modern systems
It is regularly tested on the following operating systems:
- Linux: Ubuntu 14.04
- masOS: High Sierra
- Windows: Windows Server 2012

and with the following C++ compilers/toolchains:
- GCC 5.x, 6.x, 7.x
- Clang 4.x, 5.x
- Xcode 9.3
- Visual Studio 2015

## First run

### Linux

- Install [CMake](https://cmake.org/download/) and a C++ compiler. E.g. for 
  Ubuntu you can use the command-line and type:

```bash
$ sudo apt install build-essential cmake
```

- Make a build directory and configure the project. E.g. Assuming you are in a 
  directory containing the template source code:

```bash
$ mkdir build
$ cd build
$ cmake ..
```

- Compile the project

```bash
$ make
```

- Run all the tests using CTest (this is bundled with CMake)

```bash
$ ctest --output-on-failure
```

### macOS

### Windows

First, install the following software:
- [Visual Studio Community](https://www.visualstudio.com/downloads/)
- [CMake](https://cmake.org/download/)

Next, we assume the use of Microsoft's C++ package manager, vcpkg, for installing dependencies.
The following instructions assume you install vcpkg to `C:\vcpkg`:
- Install and configure [vcpkg](https://github.com/Microsoft/vcpkg)
- Ensure you have run `vcpkg integrate install`
- Install boost for 64 bit targets: `vcpkg install boost:x64-windows`

From Visual Studio, configure the project to use the vcpkg toolchain file:
- Open the project with `File -> Open -> Folder`, and select this project
- Edit the build configurations: `CMake -> Change CMake Settings -> Template`
  - We suggest removing both `x86` targets; just keep both `x64` targets
  - Add the following to both `x64` targets:
```
"variables": [
                {
                    "name": "CMAKE_TOOLCHAIN_FILE",
                    "value": "C:\\vcpkg\\scripts\\buildsystems\\vcpkg.cmake"
                }
            ],
```

Build the project and run the tests:
- `CMake -> Build All`
- `CMake -> Tests -> Run Template CTests`

## Documentation

### MyLibrary.{hpp,cpp}

This template C++ project implements a single function, `get_nth_prime`, within 
the namespace `cpp_template`.

- *Note1*: It is good practice in C++ to put all your code within a namespace, 
  so that definitions in separate projects do not conflict with each other.

- *Note2*: `get_nth_prime` simply wraps the Boost prime number 
  [implementation](https://www.boost.org/doc/libs/1_64_0/libs/math/doc/html/math_toolkit/number_series/primes.html)

- *Note3*: To start using this template in your own projects, simply replace 
  these files with your own, and make sure to update the filenames in 
  `CMakeLists.txt`.

### Exception.h

The argument to `get_nth_prime` must be greater than zero, and less than 
`boost::math::max_prime`. If either of these conditions are not satisfied the 
function throws an exception, which is defined in this file.

- *Note1*: Throwing an 
  [exception](http://www.cplusplus.com/doc/tutorial/exceptions/) when an error 
  is detected allows programs to react to run-time errors. This is in contrast 
  [asserts](http://www.cplusplus.com/reference/cassert/assert/), which 
  immediately halt program execution.

### MyTests.cpp

Write the unit tests for your code here. Our example uses the 
[Catch](https://github.com/catchorg/Catch2) framework, and includes tests that 
check the accuracy of the `get_nth_prime` function, and check that the function 
throws the appropriate exceptions on invalid input.

- *Note1*: You probably will want to change the filename, or add separate files 
  containing more tests. In this case, make sure to update the filenames in 
  `CMakeLists.txt`.
- *Note2*: You probably want to use your C++ code to actually **do** something, 
  for example running a simulation. One option is to run this through your 
  testing framework (e.g. you might want to check that your simulation ran 
  correctly, and you can use Catch's assertions to do this). Alternatively, it 
  might be more suitable to write an entirely separate executable. You can 
  easily do this by using the `add_executable` CMake function (in 
  `CMakeLists.txt`), exactly like we have done for `MyTests.cpp`

### CMakeTests.txt

[CMake](https://cmake.org/) is a cross-platform build configuration tool, which 
generates compilation scripts (e.g. using `Makefiles` in linux, or Visual Studio 
projects for windows) that you can run to compile your C++ project.

Edit the 
[CMakeTests.txt](https://github.com/OxfordRSE/template-project-cpp/blob/master/CMakeLists.txt) 
configuration file to do things like:
    - setup the overall structure of your project, creating libraries and 
      executables and specifying the dependencies between these.
    - setup the flags you wish to pass to the compiler
    - search for any libraries on the current system, and link/include them in 
      your project
    - setup testing using 
      [ctest](https://cmake.org/cmake/help/latest/module/CTest.html)
    - setup how to install your project on the current system

### .travis.yml

This template uses [Travis CI](https://docs.travis-ci.com/) for automated 
testing. This is fully defined in the `.travis.yml` file and includes:

- A matrix of build configurations: 
    - MacOS X with XCode 9.3 
    - Ubuntu 14.04 with GCC 5,6,7 & Clang 4,5
- Test coverage data collection with 
  [lcov](http://ltp.sourceforge.net/coverage/lcov.php) and reporting with 
  [codecov](https://codecov.io/) 

The results of the automated testing are reported on the [Travis CI project 
page](https://travis-ci.org/OxfordRSE/template-project-cpp)
  
### appveyor.yml

For windows testing we use [AppVeyor](https://www.appveyor.com/), testing with 
just a single windows configuration:

- Visual Studio 2017 with boost v1.64

### codecov

Code coverage allow you to see how much of your code is actually covered by your 
test suite. That is, which lines of code are actually run during the tests. 

To do this, the code must be compiled with compiler flags that allow the 
executable to collect information about which lines of code are called during 
execution. For GCC or Clang this means adding the `--coverage` flag, which is 
done in the 
[`CMakeLists.txt`](https://github.com/OxfordRSE/template-project-cpp/blob/master/CMakeLists.txt) 
configuration file.

You can see the 
[.travis.yml](https://github.com/OxfordRSE/template-project-cpp/blob/master/.travis.yml) 
for an example of how to collect the coverage data in a readable format using 
[lcov](http://ltp.sourceforge.net/coverage/lcov.php) (see the "after_success:" 
section). This data is then sent to 
[codecov](https://codecov.io/gh/OxfordRSE/template-project-cpp) for an even 
easier-to-read web interface.

### .clang-format

[Clang Format](https://clang.llvm.org/docs/ClangFormat.html) is a tool to 
automatically format your code according to a set style configuration. This is 
incredibly useful because it frees you up from having to worry about things like 
indenting, spacing out your code or breaking long lines of code, just type in 
your code and let Clang Format clean it up for you.

You can install Clang Format on Ubuntu using `apt`:

```bash
$ sudo apt install clang-format
```

You can set the particular style you wish to apply using the 
[.clang-format](https://github.com/OxfordRSE/template-project-cpp/blob/master/.clang-format) 
configuration file. The [clang-format 
configurator](https://zed0.co.uk/clang-format-configurator/) is a useful web app 
for generating this file.

Note that most IDEs will allow you to automatically run Clang Format when the 
file is saved, which even saves you from manually running the tool in the first 
place.

### .clang-tidy

[Clang Tidy](http://clang.llvm.org/extra/clang-tidy/) is a clang-based C++ 
linter tool. A *linter* will analyzing your code to check for common programming 
bugs and stylistic errors. This might seem similar to the warnings often given 
by the compiler, but a linter will have a much more comprehensive set of tests 
that examines the *structure* of your code rather than the often line-by-line 
checking done by the compiler.  

You can install Clang Tidy on Ubuntu using `apt`:

```bash
$ sudo apt install clang-tidy
```

The 
[.clang-tidy](https://github.com/OxfordRSE/template-project-cpp/blob/master/.clang-tidy) 
configuration file allows you to set or turn off individual or sets of checks 
done by clang-tidy. We also setup the 
[CMakeLists.txt](https://github.com/OxfordRSE/template-project-cpp/blob/master/CMakeLists.txt) 
file so that clang-tidy is run automatically during compile-time.

### AddressSanitizer

There is an optional component enabled via CMake that can use the [LLVM AddressSanitizer](https://clang.llvm.org/docs/AddressSanitizer.html) to detect memory errors.
This is turned on by default for the clang builds on Travis, so you will see any errors on there if it's configured.

You can also run it yourself, provided you are using the clang compiler, by using the `Template_MEMCHECK` option when running CMake.
Simply enable the option, then configure, build, and test:

```bash
cmake -DTemplate_MEMCHECK=TRUE /path/to/project
make
ctest
```
The test will fail at the first error.
It is unlikely that you will encounter a false positive when using the address sanitizer, so if you do see an error, best not to ignore it!

## Feedback and suggestions

If you have any feedback or suggestions about this project, please get in touch or open an issue.
