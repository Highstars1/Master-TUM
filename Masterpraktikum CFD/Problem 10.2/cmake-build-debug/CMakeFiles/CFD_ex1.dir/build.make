# CMAKE generated file: DO NOT EDIT!
# Generated by "Unix Makefiles" Generator, CMake Version 3.10

# Delete rule output on recipe failure.
.DELETE_ON_ERROR:


#=============================================================================
# Special targets provided by cmake.

# Disable implicit rules so canonical targets will work.
.SUFFIXES:


# Remove some rules from gmake that .SUFFIXES does not remove.
SUFFIXES =

.SUFFIXES: .hpux_make_needs_suffix_list


# Suppress display of executed commands.
$(VERBOSE).SILENT:


# A target that is always out of date.
cmake_force:

.PHONY : cmake_force

#=============================================================================
# Set environment variables for the build.

# The shell in which to execute make rules.
SHELL = /bin/sh

# The CMake executable.
CMAKE_COMMAND = /Applications/CLion.app/Contents/bin/cmake/bin/cmake

# The command to remove a file.
RM = /Applications/CLion.app/Contents/bin/cmake/bin/cmake -E remove -f

# Escaping for special characters.
EQUALS = =

# The top-level source directory on which CMake was run.
CMAKE_SOURCE_DIR = /Users/gaoyingqiang/CLionProjects/CFD_ex1

# The top-level build directory on which CMake was run.
CMAKE_BINARY_DIR = /Users/gaoyingqiang/CLionProjects/CFD_ex1/cmake-build-debug

# Include any dependencies generated for this target.
include CMakeFiles/CFD_ex1.dir/depend.make

# Include the progress variables for this target.
include CMakeFiles/CFD_ex1.dir/progress.make

# Include the compile flags for this target's objects.
include CMakeFiles/CFD_ex1.dir/flags.make

CMakeFiles/CFD_ex1.dir/main.c.o: CMakeFiles/CFD_ex1.dir/flags.make
CMakeFiles/CFD_ex1.dir/main.c.o: ../main.c
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green --progress-dir=/Users/gaoyingqiang/CLionProjects/CFD_ex1/cmake-build-debug/CMakeFiles --progress-num=$(CMAKE_PROGRESS_1) "Building C object CMakeFiles/CFD_ex1.dir/main.c.o"
	/Library/Developer/CommandLineTools/usr/bin/cc $(C_DEFINES) $(C_INCLUDES) $(C_FLAGS) -o CMakeFiles/CFD_ex1.dir/main.c.o   -c /Users/gaoyingqiang/CLionProjects/CFD_ex1/main.c

CMakeFiles/CFD_ex1.dir/main.c.i: cmake_force
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green "Preprocessing C source to CMakeFiles/CFD_ex1.dir/main.c.i"
	/Library/Developer/CommandLineTools/usr/bin/cc $(C_DEFINES) $(C_INCLUDES) $(C_FLAGS) -E /Users/gaoyingqiang/CLionProjects/CFD_ex1/main.c > CMakeFiles/CFD_ex1.dir/main.c.i

CMakeFiles/CFD_ex1.dir/main.c.s: cmake_force
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green "Compiling C source to assembly CMakeFiles/CFD_ex1.dir/main.c.s"
	/Library/Developer/CommandLineTools/usr/bin/cc $(C_DEFINES) $(C_INCLUDES) $(C_FLAGS) -S /Users/gaoyingqiang/CLionProjects/CFD_ex1/main.c -o CMakeFiles/CFD_ex1.dir/main.c.s

CMakeFiles/CFD_ex1.dir/main.c.o.requires:

.PHONY : CMakeFiles/CFD_ex1.dir/main.c.o.requires

CMakeFiles/CFD_ex1.dir/main.c.o.provides: CMakeFiles/CFD_ex1.dir/main.c.o.requires
	$(MAKE) -f CMakeFiles/CFD_ex1.dir/build.make CMakeFiles/CFD_ex1.dir/main.c.o.provides.build
.PHONY : CMakeFiles/CFD_ex1.dir/main.c.o.provides

CMakeFiles/CFD_ex1.dir/main.c.o.provides.build: CMakeFiles/CFD_ex1.dir/main.c.o


CMakeFiles/CFD_ex1.dir/helper.c.o: CMakeFiles/CFD_ex1.dir/flags.make
CMakeFiles/CFD_ex1.dir/helper.c.o: ../helper.c
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green --progress-dir=/Users/gaoyingqiang/CLionProjects/CFD_ex1/cmake-build-debug/CMakeFiles --progress-num=$(CMAKE_PROGRESS_2) "Building C object CMakeFiles/CFD_ex1.dir/helper.c.o"
	/Library/Developer/CommandLineTools/usr/bin/cc $(C_DEFINES) $(C_INCLUDES) $(C_FLAGS) -o CMakeFiles/CFD_ex1.dir/helper.c.o   -c /Users/gaoyingqiang/CLionProjects/CFD_ex1/helper.c

CMakeFiles/CFD_ex1.dir/helper.c.i: cmake_force
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green "Preprocessing C source to CMakeFiles/CFD_ex1.dir/helper.c.i"
	/Library/Developer/CommandLineTools/usr/bin/cc $(C_DEFINES) $(C_INCLUDES) $(C_FLAGS) -E /Users/gaoyingqiang/CLionProjects/CFD_ex1/helper.c > CMakeFiles/CFD_ex1.dir/helper.c.i

CMakeFiles/CFD_ex1.dir/helper.c.s: cmake_force
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green "Compiling C source to assembly CMakeFiles/CFD_ex1.dir/helper.c.s"
	/Library/Developer/CommandLineTools/usr/bin/cc $(C_DEFINES) $(C_INCLUDES) $(C_FLAGS) -S /Users/gaoyingqiang/CLionProjects/CFD_ex1/helper.c -o CMakeFiles/CFD_ex1.dir/helper.c.s

CMakeFiles/CFD_ex1.dir/helper.c.o.requires:

.PHONY : CMakeFiles/CFD_ex1.dir/helper.c.o.requires

CMakeFiles/CFD_ex1.dir/helper.c.o.provides: CMakeFiles/CFD_ex1.dir/helper.c.o.requires
	$(MAKE) -f CMakeFiles/CFD_ex1.dir/build.make CMakeFiles/CFD_ex1.dir/helper.c.o.provides.build
.PHONY : CMakeFiles/CFD_ex1.dir/helper.c.o.provides

CMakeFiles/CFD_ex1.dir/helper.c.o.provides.build: CMakeFiles/CFD_ex1.dir/helper.c.o


CMakeFiles/CFD_ex1.dir/init.c.o: CMakeFiles/CFD_ex1.dir/flags.make
CMakeFiles/CFD_ex1.dir/init.c.o: ../init.c
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green --progress-dir=/Users/gaoyingqiang/CLionProjects/CFD_ex1/cmake-build-debug/CMakeFiles --progress-num=$(CMAKE_PROGRESS_3) "Building C object CMakeFiles/CFD_ex1.dir/init.c.o"
	/Library/Developer/CommandLineTools/usr/bin/cc $(C_DEFINES) $(C_INCLUDES) $(C_FLAGS) -o CMakeFiles/CFD_ex1.dir/init.c.o   -c /Users/gaoyingqiang/CLionProjects/CFD_ex1/init.c

CMakeFiles/CFD_ex1.dir/init.c.i: cmake_force
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green "Preprocessing C source to CMakeFiles/CFD_ex1.dir/init.c.i"
	/Library/Developer/CommandLineTools/usr/bin/cc $(C_DEFINES) $(C_INCLUDES) $(C_FLAGS) -E /Users/gaoyingqiang/CLionProjects/CFD_ex1/init.c > CMakeFiles/CFD_ex1.dir/init.c.i

CMakeFiles/CFD_ex1.dir/init.c.s: cmake_force
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green "Compiling C source to assembly CMakeFiles/CFD_ex1.dir/init.c.s"
	/Library/Developer/CommandLineTools/usr/bin/cc $(C_DEFINES) $(C_INCLUDES) $(C_FLAGS) -S /Users/gaoyingqiang/CLionProjects/CFD_ex1/init.c -o CMakeFiles/CFD_ex1.dir/init.c.s

CMakeFiles/CFD_ex1.dir/init.c.o.requires:

.PHONY : CMakeFiles/CFD_ex1.dir/init.c.o.requires

CMakeFiles/CFD_ex1.dir/init.c.o.provides: CMakeFiles/CFD_ex1.dir/init.c.o.requires
	$(MAKE) -f CMakeFiles/CFD_ex1.dir/build.make CMakeFiles/CFD_ex1.dir/init.c.o.provides.build
.PHONY : CMakeFiles/CFD_ex1.dir/init.c.o.provides

CMakeFiles/CFD_ex1.dir/init.c.o.provides.build: CMakeFiles/CFD_ex1.dir/init.c.o


CMakeFiles/CFD_ex1.dir/sor.c.o: CMakeFiles/CFD_ex1.dir/flags.make
CMakeFiles/CFD_ex1.dir/sor.c.o: ../sor.c
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green --progress-dir=/Users/gaoyingqiang/CLionProjects/CFD_ex1/cmake-build-debug/CMakeFiles --progress-num=$(CMAKE_PROGRESS_4) "Building C object CMakeFiles/CFD_ex1.dir/sor.c.o"
	/Library/Developer/CommandLineTools/usr/bin/cc $(C_DEFINES) $(C_INCLUDES) $(C_FLAGS) -o CMakeFiles/CFD_ex1.dir/sor.c.o   -c /Users/gaoyingqiang/CLionProjects/CFD_ex1/sor.c

CMakeFiles/CFD_ex1.dir/sor.c.i: cmake_force
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green "Preprocessing C source to CMakeFiles/CFD_ex1.dir/sor.c.i"
	/Library/Developer/CommandLineTools/usr/bin/cc $(C_DEFINES) $(C_INCLUDES) $(C_FLAGS) -E /Users/gaoyingqiang/CLionProjects/CFD_ex1/sor.c > CMakeFiles/CFD_ex1.dir/sor.c.i

CMakeFiles/CFD_ex1.dir/sor.c.s: cmake_force
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green "Compiling C source to assembly CMakeFiles/CFD_ex1.dir/sor.c.s"
	/Library/Developer/CommandLineTools/usr/bin/cc $(C_DEFINES) $(C_INCLUDES) $(C_FLAGS) -S /Users/gaoyingqiang/CLionProjects/CFD_ex1/sor.c -o CMakeFiles/CFD_ex1.dir/sor.c.s

CMakeFiles/CFD_ex1.dir/sor.c.o.requires:

.PHONY : CMakeFiles/CFD_ex1.dir/sor.c.o.requires

CMakeFiles/CFD_ex1.dir/sor.c.o.provides: CMakeFiles/CFD_ex1.dir/sor.c.o.requires
	$(MAKE) -f CMakeFiles/CFD_ex1.dir/build.make CMakeFiles/CFD_ex1.dir/sor.c.o.provides.build
.PHONY : CMakeFiles/CFD_ex1.dir/sor.c.o.provides

CMakeFiles/CFD_ex1.dir/sor.c.o.provides.build: CMakeFiles/CFD_ex1.dir/sor.c.o


CMakeFiles/CFD_ex1.dir/visual.c.o: CMakeFiles/CFD_ex1.dir/flags.make
CMakeFiles/CFD_ex1.dir/visual.c.o: ../visual.c
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green --progress-dir=/Users/gaoyingqiang/CLionProjects/CFD_ex1/cmake-build-debug/CMakeFiles --progress-num=$(CMAKE_PROGRESS_5) "Building C object CMakeFiles/CFD_ex1.dir/visual.c.o"
	/Library/Developer/CommandLineTools/usr/bin/cc $(C_DEFINES) $(C_INCLUDES) $(C_FLAGS) -o CMakeFiles/CFD_ex1.dir/visual.c.o   -c /Users/gaoyingqiang/CLionProjects/CFD_ex1/visual.c

CMakeFiles/CFD_ex1.dir/visual.c.i: cmake_force
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green "Preprocessing C source to CMakeFiles/CFD_ex1.dir/visual.c.i"
	/Library/Developer/CommandLineTools/usr/bin/cc $(C_DEFINES) $(C_INCLUDES) $(C_FLAGS) -E /Users/gaoyingqiang/CLionProjects/CFD_ex1/visual.c > CMakeFiles/CFD_ex1.dir/visual.c.i

CMakeFiles/CFD_ex1.dir/visual.c.s: cmake_force
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green "Compiling C source to assembly CMakeFiles/CFD_ex1.dir/visual.c.s"
	/Library/Developer/CommandLineTools/usr/bin/cc $(C_DEFINES) $(C_INCLUDES) $(C_FLAGS) -S /Users/gaoyingqiang/CLionProjects/CFD_ex1/visual.c -o CMakeFiles/CFD_ex1.dir/visual.c.s

CMakeFiles/CFD_ex1.dir/visual.c.o.requires:

.PHONY : CMakeFiles/CFD_ex1.dir/visual.c.o.requires

CMakeFiles/CFD_ex1.dir/visual.c.o.provides: CMakeFiles/CFD_ex1.dir/visual.c.o.requires
	$(MAKE) -f CMakeFiles/CFD_ex1.dir/build.make CMakeFiles/CFD_ex1.dir/visual.c.o.provides.build
.PHONY : CMakeFiles/CFD_ex1.dir/visual.c.o.provides

CMakeFiles/CFD_ex1.dir/visual.c.o.provides.build: CMakeFiles/CFD_ex1.dir/visual.c.o


CMakeFiles/CFD_ex1.dir/inple.c.o: CMakeFiles/CFD_ex1.dir/flags.make
CMakeFiles/CFD_ex1.dir/inple.c.o: ../inple.c
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green --progress-dir=/Users/gaoyingqiang/CLionProjects/CFD_ex1/cmake-build-debug/CMakeFiles --progress-num=$(CMAKE_PROGRESS_6) "Building C object CMakeFiles/CFD_ex1.dir/inple.c.o"
	/Library/Developer/CommandLineTools/usr/bin/cc $(C_DEFINES) $(C_INCLUDES) $(C_FLAGS) -o CMakeFiles/CFD_ex1.dir/inple.c.o   -c /Users/gaoyingqiang/CLionProjects/CFD_ex1/inple.c

CMakeFiles/CFD_ex1.dir/inple.c.i: cmake_force
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green "Preprocessing C source to CMakeFiles/CFD_ex1.dir/inple.c.i"
	/Library/Developer/CommandLineTools/usr/bin/cc $(C_DEFINES) $(C_INCLUDES) $(C_FLAGS) -E /Users/gaoyingqiang/CLionProjects/CFD_ex1/inple.c > CMakeFiles/CFD_ex1.dir/inple.c.i

CMakeFiles/CFD_ex1.dir/inple.c.s: cmake_force
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green "Compiling C source to assembly CMakeFiles/CFD_ex1.dir/inple.c.s"
	/Library/Developer/CommandLineTools/usr/bin/cc $(C_DEFINES) $(C_INCLUDES) $(C_FLAGS) -S /Users/gaoyingqiang/CLionProjects/CFD_ex1/inple.c -o CMakeFiles/CFD_ex1.dir/inple.c.s

CMakeFiles/CFD_ex1.dir/inple.c.o.requires:

.PHONY : CMakeFiles/CFD_ex1.dir/inple.c.o.requires

CMakeFiles/CFD_ex1.dir/inple.c.o.provides: CMakeFiles/CFD_ex1.dir/inple.c.o.requires
	$(MAKE) -f CMakeFiles/CFD_ex1.dir/build.make CMakeFiles/CFD_ex1.dir/inple.c.o.provides.build
.PHONY : CMakeFiles/CFD_ex1.dir/inple.c.o.provides

CMakeFiles/CFD_ex1.dir/inple.c.o.provides.build: CMakeFiles/CFD_ex1.dir/inple.c.o


CMakeFiles/CFD_ex1.dir/uvp.c.o: CMakeFiles/CFD_ex1.dir/flags.make
CMakeFiles/CFD_ex1.dir/uvp.c.o: ../uvp.c
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green --progress-dir=/Users/gaoyingqiang/CLionProjects/CFD_ex1/cmake-build-debug/CMakeFiles --progress-num=$(CMAKE_PROGRESS_7) "Building C object CMakeFiles/CFD_ex1.dir/uvp.c.o"
	/Library/Developer/CommandLineTools/usr/bin/cc $(C_DEFINES) $(C_INCLUDES) $(C_FLAGS) -o CMakeFiles/CFD_ex1.dir/uvp.c.o   -c /Users/gaoyingqiang/CLionProjects/CFD_ex1/uvp.c

CMakeFiles/CFD_ex1.dir/uvp.c.i: cmake_force
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green "Preprocessing C source to CMakeFiles/CFD_ex1.dir/uvp.c.i"
	/Library/Developer/CommandLineTools/usr/bin/cc $(C_DEFINES) $(C_INCLUDES) $(C_FLAGS) -E /Users/gaoyingqiang/CLionProjects/CFD_ex1/uvp.c > CMakeFiles/CFD_ex1.dir/uvp.c.i

CMakeFiles/CFD_ex1.dir/uvp.c.s: cmake_force
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green "Compiling C source to assembly CMakeFiles/CFD_ex1.dir/uvp.c.s"
	/Library/Developer/CommandLineTools/usr/bin/cc $(C_DEFINES) $(C_INCLUDES) $(C_FLAGS) -S /Users/gaoyingqiang/CLionProjects/CFD_ex1/uvp.c -o CMakeFiles/CFD_ex1.dir/uvp.c.s

CMakeFiles/CFD_ex1.dir/uvp.c.o.requires:

.PHONY : CMakeFiles/CFD_ex1.dir/uvp.c.o.requires

CMakeFiles/CFD_ex1.dir/uvp.c.o.provides: CMakeFiles/CFD_ex1.dir/uvp.c.o.requires
	$(MAKE) -f CMakeFiles/CFD_ex1.dir/build.make CMakeFiles/CFD_ex1.dir/uvp.c.o.provides.build
.PHONY : CMakeFiles/CFD_ex1.dir/uvp.c.o.provides

CMakeFiles/CFD_ex1.dir/uvp.c.o.provides.build: CMakeFiles/CFD_ex1.dir/uvp.c.o


CMakeFiles/CFD_ex1.dir/boundary_val.c.o: CMakeFiles/CFD_ex1.dir/flags.make
CMakeFiles/CFD_ex1.dir/boundary_val.c.o: ../boundary_val.c
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green --progress-dir=/Users/gaoyingqiang/CLionProjects/CFD_ex1/cmake-build-debug/CMakeFiles --progress-num=$(CMAKE_PROGRESS_8) "Building C object CMakeFiles/CFD_ex1.dir/boundary_val.c.o"
	/Library/Developer/CommandLineTools/usr/bin/cc $(C_DEFINES) $(C_INCLUDES) $(C_FLAGS) -o CMakeFiles/CFD_ex1.dir/boundary_val.c.o   -c /Users/gaoyingqiang/CLionProjects/CFD_ex1/boundary_val.c

CMakeFiles/CFD_ex1.dir/boundary_val.c.i: cmake_force
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green "Preprocessing C source to CMakeFiles/CFD_ex1.dir/boundary_val.c.i"
	/Library/Developer/CommandLineTools/usr/bin/cc $(C_DEFINES) $(C_INCLUDES) $(C_FLAGS) -E /Users/gaoyingqiang/CLionProjects/CFD_ex1/boundary_val.c > CMakeFiles/CFD_ex1.dir/boundary_val.c.i

CMakeFiles/CFD_ex1.dir/boundary_val.c.s: cmake_force
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green "Compiling C source to assembly CMakeFiles/CFD_ex1.dir/boundary_val.c.s"
	/Library/Developer/CommandLineTools/usr/bin/cc $(C_DEFINES) $(C_INCLUDES) $(C_FLAGS) -S /Users/gaoyingqiang/CLionProjects/CFD_ex1/boundary_val.c -o CMakeFiles/CFD_ex1.dir/boundary_val.c.s

CMakeFiles/CFD_ex1.dir/boundary_val.c.o.requires:

.PHONY : CMakeFiles/CFD_ex1.dir/boundary_val.c.o.requires

CMakeFiles/CFD_ex1.dir/boundary_val.c.o.provides: CMakeFiles/CFD_ex1.dir/boundary_val.c.o.requires
	$(MAKE) -f CMakeFiles/CFD_ex1.dir/build.make CMakeFiles/CFD_ex1.dir/boundary_val.c.o.provides.build
.PHONY : CMakeFiles/CFD_ex1.dir/boundary_val.c.o.provides

CMakeFiles/CFD_ex1.dir/boundary_val.c.o.provides.build: CMakeFiles/CFD_ex1.dir/boundary_val.c.o


# Object files for target CFD_ex1
CFD_ex1_OBJECTS = \
"CMakeFiles/CFD_ex1.dir/main.c.o" \
"CMakeFiles/CFD_ex1.dir/helper.c.o" \
"CMakeFiles/CFD_ex1.dir/init.c.o" \
"CMakeFiles/CFD_ex1.dir/sor.c.o" \
"CMakeFiles/CFD_ex1.dir/visual.c.o" \
"CMakeFiles/CFD_ex1.dir/inple.c.o" \
"CMakeFiles/CFD_ex1.dir/uvp.c.o" \
"CMakeFiles/CFD_ex1.dir/boundary_val.c.o"

# External object files for target CFD_ex1
CFD_ex1_EXTERNAL_OBJECTS =

CFD_ex1: CMakeFiles/CFD_ex1.dir/main.c.o
CFD_ex1: CMakeFiles/CFD_ex1.dir/helper.c.o
CFD_ex1: CMakeFiles/CFD_ex1.dir/init.c.o
CFD_ex1: CMakeFiles/CFD_ex1.dir/sor.c.o
CFD_ex1: CMakeFiles/CFD_ex1.dir/visual.c.o
CFD_ex1: CMakeFiles/CFD_ex1.dir/inple.c.o
CFD_ex1: CMakeFiles/CFD_ex1.dir/uvp.c.o
CFD_ex1: CMakeFiles/CFD_ex1.dir/boundary_val.c.o
CFD_ex1: CMakeFiles/CFD_ex1.dir/build.make
CFD_ex1: CMakeFiles/CFD_ex1.dir/link.txt
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green --bold --progress-dir=/Users/gaoyingqiang/CLionProjects/CFD_ex1/cmake-build-debug/CMakeFiles --progress-num=$(CMAKE_PROGRESS_9) "Linking C executable CFD_ex1"
	$(CMAKE_COMMAND) -E cmake_link_script CMakeFiles/CFD_ex1.dir/link.txt --verbose=$(VERBOSE)

# Rule to build all files generated by this target.
CMakeFiles/CFD_ex1.dir/build: CFD_ex1

.PHONY : CMakeFiles/CFD_ex1.dir/build

CMakeFiles/CFD_ex1.dir/requires: CMakeFiles/CFD_ex1.dir/main.c.o.requires
CMakeFiles/CFD_ex1.dir/requires: CMakeFiles/CFD_ex1.dir/helper.c.o.requires
CMakeFiles/CFD_ex1.dir/requires: CMakeFiles/CFD_ex1.dir/init.c.o.requires
CMakeFiles/CFD_ex1.dir/requires: CMakeFiles/CFD_ex1.dir/sor.c.o.requires
CMakeFiles/CFD_ex1.dir/requires: CMakeFiles/CFD_ex1.dir/visual.c.o.requires
CMakeFiles/CFD_ex1.dir/requires: CMakeFiles/CFD_ex1.dir/inple.c.o.requires
CMakeFiles/CFD_ex1.dir/requires: CMakeFiles/CFD_ex1.dir/uvp.c.o.requires
CMakeFiles/CFD_ex1.dir/requires: CMakeFiles/CFD_ex1.dir/boundary_val.c.o.requires

.PHONY : CMakeFiles/CFD_ex1.dir/requires

CMakeFiles/CFD_ex1.dir/clean:
	$(CMAKE_COMMAND) -P CMakeFiles/CFD_ex1.dir/cmake_clean.cmake
.PHONY : CMakeFiles/CFD_ex1.dir/clean

CMakeFiles/CFD_ex1.dir/depend:
	cd /Users/gaoyingqiang/CLionProjects/CFD_ex1/cmake-build-debug && $(CMAKE_COMMAND) -E cmake_depends "Unix Makefiles" /Users/gaoyingqiang/CLionProjects/CFD_ex1 /Users/gaoyingqiang/CLionProjects/CFD_ex1 /Users/gaoyingqiang/CLionProjects/CFD_ex1/cmake-build-debug /Users/gaoyingqiang/CLionProjects/CFD_ex1/cmake-build-debug /Users/gaoyingqiang/CLionProjects/CFD_ex1/cmake-build-debug/CMakeFiles/CFD_ex1.dir/DependInfo.cmake --color=$(COLOR)
.PHONY : CMakeFiles/CFD_ex1.dir/depend
