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
include CMakeFiles/Midicontroller.dir/depend.make

# Include the progress variables for this target.
include CMakeFiles/Midicontroller.dir/progress.make

# Include the compile flags for this target's objects.
include CMakeFiles/Midicontroller.dir/flags.make

CMakeFiles/Midicontroller.dir/midicontroller.cpp.o: CMakeFiles/Midicontroller.dir/flags.make
CMakeFiles/Midicontroller.dir/midicontroller.cpp.o: midicontroller.cpp
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green --progress-dir=/home/nando/programming/spheric_harmonies/object_recognition_c++/CMakeFiles --progress-num=$(CMAKE_PROGRESS_1) "Building CXX object CMakeFiles/Midicontroller.dir/midicontroller.cpp.o"
	/usr/bin/c++   $(CXX_DEFINES) $(CXX_INCLUDES) $(CXX_FLAGS) -o CMakeFiles/Midicontroller.dir/midicontroller.cpp.o -c /home/nando/programming/spheric_harmonies/object_recognition_c++/midicontroller.cpp

CMakeFiles/Midicontroller.dir/midicontroller.cpp.i: cmake_force
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green "Preprocessing CXX source to CMakeFiles/Midicontroller.dir/midicontroller.cpp.i"
	/usr/bin/c++  $(CXX_DEFINES) $(CXX_INCLUDES) $(CXX_FLAGS) -E /home/nando/programming/spheric_harmonies/object_recognition_c++/midicontroller.cpp > CMakeFiles/Midicontroller.dir/midicontroller.cpp.i

CMakeFiles/Midicontroller.dir/midicontroller.cpp.s: cmake_force
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green "Compiling CXX source to assembly CMakeFiles/Midicontroller.dir/midicontroller.cpp.s"
	/usr/bin/c++  $(CXX_DEFINES) $(CXX_INCLUDES) $(CXX_FLAGS) -S /home/nando/programming/spheric_harmonies/object_recognition_c++/midicontroller.cpp -o CMakeFiles/Midicontroller.dir/midicontroller.cpp.s

CMakeFiles/Midicontroller.dir/midicontroller.cpp.o.requires:

.PHONY : CMakeFiles/Midicontroller.dir/midicontroller.cpp.o.requires

CMakeFiles/Midicontroller.dir/midicontroller.cpp.o.provides: CMakeFiles/Midicontroller.dir/midicontroller.cpp.o.requires
	$(MAKE) -f CMakeFiles/Midicontroller.dir/build.make CMakeFiles/Midicontroller.dir/midicontroller.cpp.o.provides.build
.PHONY : CMakeFiles/Midicontroller.dir/midicontroller.cpp.o.provides

CMakeFiles/Midicontroller.dir/midicontroller.cpp.o.provides.build: CMakeFiles/Midicontroller.dir/midicontroller.cpp.o


# Object files for target Midicontroller
Midicontroller_OBJECTS = \
"CMakeFiles/Midicontroller.dir/midicontroller.cpp.o"

# External object files for target Midicontroller
Midicontroller_EXTERNAL_OBJECTS =

libMidicontroller.a: CMakeFiles/Midicontroller.dir/midicontroller.cpp.o
libMidicontroller.a: CMakeFiles/Midicontroller.dir/build.make
libMidicontroller.a: CMakeFiles/Midicontroller.dir/link.txt
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green --bold --progress-dir=/home/nando/programming/spheric_harmonies/object_recognition_c++/CMakeFiles --progress-num=$(CMAKE_PROGRESS_2) "Linking CXX static library libMidicontroller.a"
	$(CMAKE_COMMAND) -P CMakeFiles/Midicontroller.dir/cmake_clean_target.cmake
	$(CMAKE_COMMAND) -E cmake_link_script CMakeFiles/Midicontroller.dir/link.txt --verbose=$(VERBOSE)

# Rule to build all files generated by this target.
CMakeFiles/Midicontroller.dir/build: libMidicontroller.a

.PHONY : CMakeFiles/Midicontroller.dir/build

CMakeFiles/Midicontroller.dir/requires: CMakeFiles/Midicontroller.dir/midicontroller.cpp.o.requires

.PHONY : CMakeFiles/Midicontroller.dir/requires

CMakeFiles/Midicontroller.dir/clean:
	$(CMAKE_COMMAND) -P CMakeFiles/Midicontroller.dir/cmake_clean.cmake
.PHONY : CMakeFiles/Midicontroller.dir/clean

CMakeFiles/Midicontroller.dir/depend:
	cd /home/nando/programming/spheric_harmonies/object_recognition_c++ && $(CMAKE_COMMAND) -E cmake_depends "Unix Makefiles" /home/nando/programming/spheric_harmonies/object_recognition_c++ /home/nando/programming/spheric_harmonies/object_recognition_c++ /home/nando/programming/spheric_harmonies/object_recognition_c++ /home/nando/programming/spheric_harmonies/object_recognition_c++ /home/nando/programming/spheric_harmonies/object_recognition_c++/CMakeFiles/Midicontroller.dir/DependInfo.cmake --color=$(COLOR)
.PHONY : CMakeFiles/Midicontroller.dir/depend

