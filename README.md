# Multivideo multitracker
[![License](https://img.shields.io/github/license/mashape/apistatus.svg)](http://doge.mit-license.org) 
[![No Maintenance Intended](http://unmaintained.tech/badge.svg)](http://unmaintained.tech/)

Python and Bash scripts to automate [multi_tracker](https://github.com/florisvb/multi_tracker) by [florisvb](https://github.com/florisvb) to run the same analysis for multiple video files. This is an unmaintained script tested only on Ubuntu 17.04.

## Video tracking
1. Place all videos to be analyzed in one directory.
2. In the `track_videos` folder, edit `config.sh` (config parameters are described in the file comments). This is the only file that needs to be edited. 
3. Load environmental variables from `config.sh`.
4. Run `make_directories.sh` to create all of the necessary multitracker directories for each video.
5. Run `make_launch_files.py` to write a separate ROS launch file for each video. 
6. Run `edit_src.py` to specify where the data should be saved for each video. 
7. Run `launch_videos.sh` to analyze all videos.

This is what the process should look like: 
```shell
$ cd ~/Documents/multivideo_multitracker/track_videos/
$ source config.sh
$ bash make_directories.sh
$ python make_launch_files.py
$ python edit_src.py
$ bash launch_videos.sh
```

## Data analysis
After loading each video manually and editing the trajectories as needed, run these scripts to automate the propogation of necessary config files for data analysis and visualization. 

1. In the `analyze_data` folder, edit `config.sh` (config parameters are described in the file comments).
2. Load environmental variables from `config.sh`.
3. Run `make_directories.sh` to copy the parent configuration file into each video folder (and rename it so that the data-time stamp matches the prefix of the hdf5 file). 

```shell
$ cd ~/Documents/multivideo_multitracker/analyze_data/
$ source config.sh
$ bash make_directories.sh
```

## Manually editing video trajectories
To view and verify the animal trajectories calculated by Multitracker, open each video, one at a time, using the Multitracker trajectory viewer. To do this, first navigate to the folder containing the code: 
```bash
cd ~/catkin_ws/src/multi_tracker/multi_tracker_analysis
```
Next, use this command to run the trajectory viewer: 
```bash
python trajectory_viewer_gui_v2.py --path=
```
Right after the `--path=` text, drag and drop the data folder from the video you want to analyze. This should be located in `Documents/analysis_files_temp/(videoname)/data`. This should open a GUI (graphical user interface) that you can use to join, add, or remove trajectories. 

## Post-processing
Because Multitracker is intended for real-time video tracking, it will not register objects until they begin to move. In some videos, animals do not start to move until several seconds into the experiment. 

The Jupyter notebook in the `postprocess_data` folder identifies all analyzed videos with less than the expected number of frames. These videos can then be checked manually to confirm lack of movement in the initial frames. Once the video is reviewed, the Jupyter Notebook also automatically propagates
the tracker's position when the larva was first detected to the beginning of the movie. 

## Troubleshooting
If you experience dropped frames at the beginning or end of your video, there are several parameters that might be causing the issue. Each of these should be checked to make sure they are right for your video and PC. 

1. `fps` : Frames will be dropped when the tracker processing speed is slower than the video frame rate. `fps` should be set in `/track_videos/make_launch_files.py` to be slow enough to not throw ROS warnings in your shell, but fast enough for reasonable analysis speed. This `fps` variable does not have to reflect the actual fps of the video. It is used to determine how fast the video stream is published to the ROS image topic. 
2. `buffer_queue_size` should be set in `/track_videos/make_launch_files.py` to be reasonably large, depending on your video size. 
3. `ROS_KILL_TIMER` in `/track_videos/config.sh` sets the amount of time allowed to analyze each video before moving onto the next. 
4. `ROS_INITIALIZE_TIMER` in `/track_videos/config.sh` sets the amount of time allowed for the ROS tracker to initialize before the video stream begins. 

*Note:* The `/track_videos/launch_videos.sh` script routinely kills all ROS nodes as part of its cleanup loop. If you'd like to run other ROS processes concurrently, this file should be edited to exclude the nodes you would like to keep.
