# CMAKE generated file: DO NOT EDIT!
# Generated by "Unix Makefiles" Generator, CMake Version 3.5

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
CMAKE_COMMAND = /usr/bin/cmake

# The command to remove a file.
RM = /usr/bin/cmake -E remove -f

# Escaping for special characters.
EQUALS = =

# The top-level source directory on which CMake was run.
CMAKE_SOURCE_DIR = /home/nando/programming/spheric_harmonies/object_recognition_c++

# The top-level build directory on which CMake was run.
CMAKE_BINARY_DIR = /home/nando/programming/spheric_harmonies/object_recognition_c++

# Include any dependencies generated for this target.
include CMakeFiles/Relief.dir/depend.make

# Include the progress variables for this target.
include CMakeFiles/Relief.dir/progress.make

# Include the compile flags for this target's objects.
include CMakeFiles/Relief.dir/flags.make

CMakeFiles/Relief.dir/Relief.cpp.o: CMakeFiles/Relief.dir/flags.make
CMakeFiles/Relief.dir/Relief.cpp.o: Relief.cpp
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green --progress-dir=/home/nando/programming/spheric_harmonies/object_recognition_c++/CMakeFiles --progress-num=$(CMAKE_PROGRESS_1) "Building CXX object CMakeFiles/Relief.dir/Relief.cpp.o"
	/usr/bin/c++   $(CXX_DEFINES) $(CXX_INCLUDES) $(CXX_FLAGS) -o CMakeFiles/Relief.dir/Relief.cpp.o -c /home/nando/programming/spheric_harmonies/object_recognition_c++/Relief.cpp

CMakeFiles/Relief.dir/Relief.cpp.i: cmake_force
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green "Preprocessing CXX source to CMakeFiles/Relief.dir/Relief.cpp.i"
	/usr/bin/c++  $(CXX_DEFINES) $(CXX_INCLUDES) $(CXX_FLAGS) -E /home/nando/programming/spheric_harmonies/object_recognition_c++/Relief.cpp > CMakeFiles/Relief.dir/Relief.cpp.i

CMakeFiles/Relief.dir/Relief.cpp.s: cmake_force
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green "Compiling CXX source to assembly CMakeFiles/Relief.dir/Relief.cpp.s"
	/usr/bin/c++  $(CXX_DEFINES) $(CXX_INCLUDES) $(CXX_FLAGS) -S /home/nando/programming/spheric_harmonies/object_recognition_c++/Relief.cpp -o CMakeFiles/Relief.dir/Relief.cpp.s

CMakeFiles/Relief.dir/Relief.cpp.o.requires:

.PHONY : CMakeFiles/Relief.dir/Relief.cpp.o.requires

CMakeFiles/Relief.dir/Relief.cpp.o.provides: CMakeFiles/Relief.dir/Relief.cpp.o.requires
	$(MAKE) -f CMakeFiles/Relief.dir/build.make CMakeFiles/Relief.dir/Relief.cpp.o.provides.build
.PHONY : CMakeFiles/Relief.dir/Relief.cpp.o.provides

CMakeFiles/Relief.dir/Relief.cpp.o.provides.build: CMakeFiles/Relief.dir/Relief.cpp.o


# Object files for target Relief
Relief_OBJECTS = \
"CMakeFiles/Relief.dir/Relief.cpp.o"

# External object files for target Relief
Relief_EXTERNAL_OBJECTS =

libRelief.a: CMakeFiles/Relief.dir/Relief.cpp.o
libRelief.a: CMakeFiles/Relief.dir/build.make
libRelief.a: CMakeFiles/Relief.dir/link.txt
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green --bold --progress-dir=/home/nando/programming/spheric_harmonies/object_recognition_c++/CMakeFiles --progress-num=$(CMAKE_PROGRESS_2) "Linking CXX static library libRelief.a"
	$(CMAKE_COMMAND) -P CMakeFiles/Relief.dir/cmake_clean_target.cmake
	$(CMAKE_COMMAND) -E cmake_link_script CMakeFiles/Relief.dir/link.txt --verbose=$(VERBOSE)

# Rule to build all files generated by this target.
CMakeFiles/Relief.dir/build: libRelief.a

.PHONY : CMakeFiles/Relief.dir/build

CMakeFiles/Relief.dir/requires: CMakeFiles/Relief.dir/Relief.cpp.o.requires

.PHONY : CMakeFiles/Relief.dir/requires

CMakeFiles/Relief.dir/clean:
	$(CMAKE_COMMAND) -P CMakeFiles/Relief.dir/cmake_clean.cmake
.PHONY : CMakeFiles/Relief.dir/clean

CMakeFiles/Relief.dir/depend:
	cd /home/nando/programming/spheric_harmonies/object_recognition_c++ && $(CMAKE_COMMAND) -E cmake_depends "Unix Makefiles" /home/nando/programming/spheric_harmonies/object_recognition_c++ /home/nando/programming/spheric_harmonies/object_recognition_c++ /home/nando/programming/spheric_harmonies/object_recognition_c++ /home/nando/programming/spheric_harmonies/object_recognition_c++ /home/nando/programming/spheric_harmonies/object_recognition_c++/CMakeFiles/Relief.dir/DependInfo.cmake --color=$(COLOR)
.PHONY : CMakeFiles/Relief.dir/depend

