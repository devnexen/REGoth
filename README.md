# REGoth
OpenSource-Reimplentation of the zEngine, used by the game "Gothic" and "Gothic II".

# Source
Make sure to clone this repository with the `--recursive` flag:

##### ssh:
```sh
git clone --recursive git@github.com:degenerated1123/REGoth.git
```

##### https:
```sh
git clone --recursive https://github.com/degenerated1123/REGoth.git
```

To update the repo, you need to make sure to update the submodules as well. Instead of simply pulling the repository, you can do:
```sh
git pull --recurse-submodules
git submodule update --remote --recursive
```

# Building

You will need CMake (3.1 or newer) and a C++14-capable compiler.
Currently supported are:
 - GCC
 - MinGW
 - Visual Studio 2015

Then:
```sh
cd path/to/REGoth
mkdir build
cd build
cmake -DCMAKE_BUILD_TYPE=Release ..
```
> If CMake complains about some folders missing a CMakeLists.txt, you most likely forgot to clone with the `--recursive`-flag!
> Simple do `git submodule update --init --recursive` and it should work.


Then, choose depending on your OS:

### Linux
```sh
make -j
```

### Windows
Open the generated `REGoth.sln` in VisualStudio and build as usual.



# Running
The compiled files are inside the `build/bin` directory.

Make sure to copy the `content/shaders` folder to the working directory of the compiled `REGoth`-Executable.
Then, run the program with the following flags:
```sh
REGoth -g "path/to/gothic1or2" -w startworld.zen
```

Where `path/to/gothic1or2` points to the root of a Gothic I or II installation and `startworld.zen` is one of the Zen-Files found in a `.vdf`-files in the games `data/`-directory. For example: `newworld.zen` or `addonworld.zen` for Gothic II.

> It is recommended to run this from the commandline, to see the debug-output of the program.