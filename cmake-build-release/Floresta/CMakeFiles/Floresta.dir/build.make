# CMAKE generated file: DO NOT EDIT!
# Generated by "MinGW Makefiles" Generator, CMake Version 3.29

# Delete rule output on recipe failure.
.DELETE_ON_ERROR:

#=============================================================================
# Special targets provided by cmake.

# Disable implicit rules so canonical targets will work.
.SUFFIXES:

# Disable VCS-based implicit rules.
% : %,v

# Disable VCS-based implicit rules.
% : RCS/%

# Disable VCS-based implicit rules.
% : RCS/%,v

# Disable VCS-based implicit rules.
% : SCCS/s.%

# Disable VCS-based implicit rules.
% : s.%

.SUFFIXES: .hpux_make_needs_suffix_list

# Command-line flag to silence nested $(MAKE).
$(VERBOSE)MAKESILENT = -s

#Suppress display of executed commands.
$(VERBOSE).SILENT:

# A target that is always out of date.
cmake_force:
.PHONY : cmake_force

#=============================================================================
# Set environment variables for the build.

SHELL = cmd.exe

# The CMake executable.
CMAKE_COMMAND = "C:\Program Files\JetBrains\CLion 2024.2.1\bin\cmake\win\x64\bin\cmake.exe"

# The command to remove a file.
RM = "C:\Program Files\JetBrains\CLion 2024.2.1\bin\cmake\win\x64\bin\cmake.exe" -E rm -f

# Escaping for special characters.
EQUALS = =

# The top-level source directory on which CMake was run.
CMAKE_SOURCE_DIR = C:\Users\molin\Desktop\Floresta

# The top-level build directory on which CMake was run.
CMAKE_BINARY_DIR = C:\Users\molin\Desktop\Floresta\cmake-build-release

# Include any dependencies generated for this target.
include Floresta/CMakeFiles/Floresta.dir/depend.make
# Include any dependencies generated by the compiler for this target.
include Floresta/CMakeFiles/Floresta.dir/compiler_depend.make

# Include the progress variables for this target.
include Floresta/CMakeFiles/Floresta.dir/progress.make

# Include the compile flags for this target's objects.
include Floresta/CMakeFiles/Floresta.dir/flags.make

Floresta/CMakeFiles/Floresta.dir/main.cpp.obj: Floresta/CMakeFiles/Floresta.dir/flags.make
Floresta/CMakeFiles/Floresta.dir/main.cpp.obj: Floresta/CMakeFiles/Floresta.dir/includes_CXX.rsp
Floresta/CMakeFiles/Floresta.dir/main.cpp.obj: C:/Users/molin/Desktop/Floresta/Floresta/main.cpp
Floresta/CMakeFiles/Floresta.dir/main.cpp.obj: Floresta/CMakeFiles/Floresta.dir/compiler_depend.ts
	@$(CMAKE_COMMAND) -E cmake_echo_color "--switch=$(COLOR)" --green --progress-dir=C:\Users\molin\Desktop\Floresta\cmake-build-release\CMakeFiles --progress-num=$(CMAKE_PROGRESS_1) "Building CXX object Floresta/CMakeFiles/Floresta.dir/main.cpp.obj"
	cd /d C:\Users\molin\Desktop\Floresta\cmake-build-release\Floresta && C:\PROGRA~1\JETBRA~1\CLION2~1.1\bin\mingw\bin\G__~1.EXE $(CXX_DEFINES) $(CXX_INCLUDES) $(CXX_FLAGS) -MD -MT Floresta/CMakeFiles/Floresta.dir/main.cpp.obj -MF CMakeFiles\Floresta.dir\main.cpp.obj.d -o CMakeFiles\Floresta.dir\main.cpp.obj -c C:\Users\molin\Desktop\Floresta\Floresta\main.cpp

Floresta/CMakeFiles/Floresta.dir/main.cpp.i: cmake_force
	@$(CMAKE_COMMAND) -E cmake_echo_color "--switch=$(COLOR)" --green "Preprocessing CXX source to CMakeFiles/Floresta.dir/main.cpp.i"
	cd /d C:\Users\molin\Desktop\Floresta\cmake-build-release\Floresta && C:\PROGRA~1\JETBRA~1\CLION2~1.1\bin\mingw\bin\G__~1.EXE $(CXX_DEFINES) $(CXX_INCLUDES) $(CXX_FLAGS) -E C:\Users\molin\Desktop\Floresta\Floresta\main.cpp > CMakeFiles\Floresta.dir\main.cpp.i

Floresta/CMakeFiles/Floresta.dir/main.cpp.s: cmake_force
	@$(CMAKE_COMMAND) -E cmake_echo_color "--switch=$(COLOR)" --green "Compiling CXX source to assembly CMakeFiles/Floresta.dir/main.cpp.s"
	cd /d C:\Users\molin\Desktop\Floresta\cmake-build-release\Floresta && C:\PROGRA~1\JETBRA~1\CLION2~1.1\bin\mingw\bin\G__~1.EXE $(CXX_DEFINES) $(CXX_INCLUDES) $(CXX_FLAGS) -S C:\Users\molin\Desktop\Floresta\Floresta\main.cpp -o CMakeFiles\Floresta.dir\main.cpp.s

# Object files for target Floresta
Floresta_OBJECTS = \
"CMakeFiles/Floresta.dir/main.cpp.obj"

# External object files for target Floresta
Floresta_EXTERNAL_OBJECTS =

Floresta/Floresta.exe: Floresta/CMakeFiles/Floresta.dir/main.cpp.obj
Floresta/Floresta.exe: Floresta/CMakeFiles/Floresta.dir/build.make
Floresta/Floresta.exe: _deps/raylib-build/raylib/libraylib.a
Floresta/Floresta.exe: Mistral/libMistral.a
Floresta/Floresta.exe: _deps/raylib-build/raylib/libraylib.a
Floresta/Floresta.exe: _deps/raylib-build/raylib/external/glfw/src/libglfw3.a
Floresta/Floresta.exe: Floresta/CMakeFiles/Floresta.dir/linkLibs.rsp
Floresta/Floresta.exe: Floresta/CMakeFiles/Floresta.dir/objects1.rsp
Floresta/Floresta.exe: Floresta/CMakeFiles/Floresta.dir/link.txt
	@$(CMAKE_COMMAND) -E cmake_echo_color "--switch=$(COLOR)" --green --bold --progress-dir=C:\Users\molin\Desktop\Floresta\cmake-build-release\CMakeFiles --progress-num=$(CMAKE_PROGRESS_2) "Linking CXX executable Floresta.exe"
	cd /d C:\Users\molin\Desktop\Floresta\cmake-build-release\Floresta && $(CMAKE_COMMAND) -E cmake_link_script CMakeFiles\Floresta.dir\link.txt --verbose=$(VERBOSE)

# Rule to build all files generated by this target.
Floresta/CMakeFiles/Floresta.dir/build: Floresta/Floresta.exe
.PHONY : Floresta/CMakeFiles/Floresta.dir/build

Floresta/CMakeFiles/Floresta.dir/clean:
	cd /d C:\Users\molin\Desktop\Floresta\cmake-build-release\Floresta && $(CMAKE_COMMAND) -P CMakeFiles\Floresta.dir\cmake_clean.cmake
.PHONY : Floresta/CMakeFiles/Floresta.dir/clean

Floresta/CMakeFiles/Floresta.dir/depend:
	$(CMAKE_COMMAND) -E cmake_depends "MinGW Makefiles" C:\Users\molin\Desktop\Floresta C:\Users\molin\Desktop\Floresta\Floresta C:\Users\molin\Desktop\Floresta\cmake-build-release C:\Users\molin\Desktop\Floresta\cmake-build-release\Floresta C:\Users\molin\Desktop\Floresta\cmake-build-release\Floresta\CMakeFiles\Floresta.dir\DependInfo.cmake "--color=$(COLOR)"
.PHONY : Floresta/CMakeFiles/Floresta.dir/depend
