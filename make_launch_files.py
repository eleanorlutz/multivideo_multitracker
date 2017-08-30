import glob, csv, os

fnames = glob.glob(os.environ["VIDEO_SRC"]+'*')
save_dir = os.environ["LAUNCH_FILES_SRC"]

launch_text_before = '<launch>\n    <include file="$(find video_stream_opencv)/launch/camera.launch" >\n        <arg name="camera_name" value="camera" />\n        <arg name="video_stream_provider" value="'
launch_text_after = '" />\n        <arg name="fps" value="30" />\n    </include>\n</launch>'

for name in fnames:
	name_short = name.split('/')[-1].split('.')[0]
	savename = os.environ["LAUNCH_FILES_SRC"] + name_short + '.launch'
	with open(savename, 'w') as towrite:
		towrite.write(launch_text_before + name + launch_text_after)
