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
$ cd ./track_videos/
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
$ cd ./analyze_data/
$ source config.sh
$ bash make_directories.sh
```
