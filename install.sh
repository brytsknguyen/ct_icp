#!bin/bash

WS_DIR=/home/tmn/dev_ws/src
CTICP_ROOT=$(pwd)

echo root dir: $CTICP_ROOT

mkdir .cmake-build-superbuild && cd .cmake-build-superbuild     #< Creates the cmake folder
cmake ../superbuild                                             #< (1) Configure step 
cmake --build . --config Release                                #< Build step (Downloads and install the dependencies), add -DWITH_VIZ3D=ON to install with the GUI

# Inside the main directory
cd $CTICP_ROOT
mkdir cmake-build-release && cd cmake-build-release                   #< Create the build directory
cmake .. -DCMAKE_BUILD_TYPE=Release                                   #< (2) Configure with the desired options (specify arguments with -D<arg_name>=<arg_value>), add -DWITH_VIZ3D=ON to install with the GUI
cmake --build . --target install --config Release --parallel 12       #< Build and Install the project

# Make a symbolic link
cd $CTICP_ROOT
cd $WS_DIR
ln -s /home/tmn/Libraries/ct_icp/ros/catkin_ws/ct_icp_odometry ct_icp_odometry        #< Make a symbolic link to the `catkin_ws` folder
ln -s /home/tmn/Libraries/ct_icp/ros/catkin_ws/slam_roscore slam_roscore              #< Make a symbolic link to the `catkin_ws` folder
cd ..                                                                                 #< Move back to the root of the catkin workspace
catkin build -DPYTHON_EXECUTABLE=/usr/bin/python3 -DPYTHON_INCLUDE_DIR=/usr/include/python3.8 -DSUPERBUILD_INSTALL_DIR=$CTICP_ROOT/install