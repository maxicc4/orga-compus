# CMAKE generated file: DO NOT EDIT!
# Generated by "Unix Makefiles" Generator, CMake Version 3.7

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
CMAKE_COMMAND = /home/darius/Documentos/Taller2017/CLION/clion-2017.1.1/bin/cmake/bin/cmake

# The command to remove a file.
RM = /home/darius/Documentos/Taller2017/CLION/clion-2017.1.1/bin/cmake/bin/cmake -E remove -f

# Escaping for special characters.
EQUALS = =

# The top-level source directory on which CMake was run.
CMAKE_SOURCE_DIR = /home/darius/CLionProjects/TP0_orga

# The top-level build directory on which CMake was run.
CMAKE_BINARY_DIR = /home/darius/CLionProjects/TP0_orga/cmake-build-debug

# Include any dependencies generated for this target.
include CMakeFiles/TP0_orga.dir/depend.make

# Include the progress variables for this target.
include CMakeFiles/TP0_orga.dir/progress.make

# Include the compile flags for this target's objects.
include CMakeFiles/TP0_orga.dir/flags.make

CMakeFiles/TP0_orga.dir/main.c.o: CMakeFiles/TP0_orga.dir/flags.make
CMakeFiles/TP0_orga.dir/main.c.o: ../main.c
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green --progress-dir=/home/darius/CLionProjects/TP0_orga/cmake-build-debug/CMakeFiles --progress-num=$(CMAKE_PROGRESS_1) "Building C object CMakeFiles/TP0_orga.dir/main.c.o"
	/usr/bin/cc  $(C_DEFINES) $(C_INCLUDES) $(C_FLAGS) -o CMakeFiles/TP0_orga.dir/main.c.o   -c /home/darius/CLionProjects/TP0_orga/main.c

CMakeFiles/TP0_orga.dir/main.c.i: cmake_force
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green "Preprocessing C source to CMakeFiles/TP0_orga.dir/main.c.i"
	/usr/bin/cc  $(C_DEFINES) $(C_INCLUDES) $(C_FLAGS) -E /home/darius/CLionProjects/TP0_orga/main.c > CMakeFiles/TP0_orga.dir/main.c.i

CMakeFiles/TP0_orga.dir/main.c.s: cmake_force
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green "Compiling C source to assembly CMakeFiles/TP0_orga.dir/main.c.s"
	/usr/bin/cc  $(C_DEFINES) $(C_INCLUDES) $(C_FLAGS) -S /home/darius/CLionProjects/TP0_orga/main.c -o CMakeFiles/TP0_orga.dir/main.c.s

CMakeFiles/TP0_orga.dir/main.c.o.requires:

.PHONY : CMakeFiles/TP0_orga.dir/main.c.o.requires

CMakeFiles/TP0_orga.dir/main.c.o.provides: CMakeFiles/TP0_orga.dir/main.c.o.requires
	$(MAKE) -f CMakeFiles/TP0_orga.dir/build.make CMakeFiles/TP0_orga.dir/main.c.o.provides.build
.PHONY : CMakeFiles/TP0_orga.dir/main.c.o.provides

CMakeFiles/TP0_orga.dir/main.c.o.provides.build: CMakeFiles/TP0_orga.dir/main.c.o


CMakeFiles/TP0_orga.dir/fileHandler.c.o: CMakeFiles/TP0_orga.dir/flags.make
CMakeFiles/TP0_orga.dir/fileHandler.c.o: ../fileHandler.c
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green --progress-dir=/home/darius/CLionProjects/TP0_orga/cmake-build-debug/CMakeFiles --progress-num=$(CMAKE_PROGRESS_2) "Building C object CMakeFiles/TP0_orga.dir/fileHandler.c.o"
	/usr/bin/cc  $(C_DEFINES) $(C_INCLUDES) $(C_FLAGS) -o CMakeFiles/TP0_orga.dir/fileHandler.c.o   -c /home/darius/CLionProjects/TP0_orga/fileHandler.c

CMakeFiles/TP0_orga.dir/fileHandler.c.i: cmake_force
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green "Preprocessing C source to CMakeFiles/TP0_orga.dir/fileHandler.c.i"
	/usr/bin/cc  $(C_DEFINES) $(C_INCLUDES) $(C_FLAGS) -E /home/darius/CLionProjects/TP0_orga/fileHandler.c > CMakeFiles/TP0_orga.dir/fileHandler.c.i

CMakeFiles/TP0_orga.dir/fileHandler.c.s: cmake_force
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green "Compiling C source to assembly CMakeFiles/TP0_orga.dir/fileHandler.c.s"
	/usr/bin/cc  $(C_DEFINES) $(C_INCLUDES) $(C_FLAGS) -S /home/darius/CLionProjects/TP0_orga/fileHandler.c -o CMakeFiles/TP0_orga.dir/fileHandler.c.s

CMakeFiles/TP0_orga.dir/fileHandler.c.o.requires:

.PHONY : CMakeFiles/TP0_orga.dir/fileHandler.c.o.requires

CMakeFiles/TP0_orga.dir/fileHandler.c.o.provides: CMakeFiles/TP0_orga.dir/fileHandler.c.o.requires
	$(MAKE) -f CMakeFiles/TP0_orga.dir/build.make CMakeFiles/TP0_orga.dir/fileHandler.c.o.provides.build
.PHONY : CMakeFiles/TP0_orga.dir/fileHandler.c.o.provides

CMakeFiles/TP0_orga.dir/fileHandler.c.o.provides.build: CMakeFiles/TP0_orga.dir/fileHandler.c.o


# Object files for target TP0_orga
TP0_orga_OBJECTS = \
"CMakeFiles/TP0_orga.dir/main.c.o" \
"CMakeFiles/TP0_orga.dir/fileHandler.c.o"

# External object files for target TP0_orga
TP0_orga_EXTERNAL_OBJECTS =

TP0_orga: CMakeFiles/TP0_orga.dir/main.c.o
TP0_orga: CMakeFiles/TP0_orga.dir/fileHandler.c.o
TP0_orga: CMakeFiles/TP0_orga.dir/build.make
TP0_orga: CMakeFiles/TP0_orga.dir/link.txt
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green --bold --progress-dir=/home/darius/CLionProjects/TP0_orga/cmake-build-debug/CMakeFiles --progress-num=$(CMAKE_PROGRESS_3) "Linking C executable TP0_orga"
	$(CMAKE_COMMAND) -E cmake_link_script CMakeFiles/TP0_orga.dir/link.txt --verbose=$(VERBOSE)

# Rule to build all files generated by this target.
CMakeFiles/TP0_orga.dir/build: TP0_orga

.PHONY : CMakeFiles/TP0_orga.dir/build

CMakeFiles/TP0_orga.dir/requires: CMakeFiles/TP0_orga.dir/main.c.o.requires
CMakeFiles/TP0_orga.dir/requires: CMakeFiles/TP0_orga.dir/fileHandler.c.o.requires

.PHONY : CMakeFiles/TP0_orga.dir/requires

CMakeFiles/TP0_orga.dir/clean:
	$(CMAKE_COMMAND) -P CMakeFiles/TP0_orga.dir/cmake_clean.cmake
.PHONY : CMakeFiles/TP0_orga.dir/clean

CMakeFiles/TP0_orga.dir/depend:
	cd /home/darius/CLionProjects/TP0_orga/cmake-build-debug && $(CMAKE_COMMAND) -E cmake_depends "Unix Makefiles" /home/darius/CLionProjects/TP0_orga /home/darius/CLionProjects/TP0_orga /home/darius/CLionProjects/TP0_orga/cmake-build-debug /home/darius/CLionProjects/TP0_orga/cmake-build-debug /home/darius/CLionProjects/TP0_orga/cmake-build-debug/CMakeFiles/TP0_orga.dir/DependInfo.cmake --color=$(COLOR)
.PHONY : CMakeFiles/TP0_orga.dir/depend

