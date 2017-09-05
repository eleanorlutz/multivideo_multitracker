import glob, csv, os

fnames = glob.glob(os.environ["VIDEO_SRC"]+'*')

for name in fnames: 
	name = name.split('/')[-1].split('.')[0]
	save_dir = os.environ["DESTINATION"] + name
	savename = save_dir + '/src/home_directory.yaml'
	data_dir = save_dir + '/data'
	src_dir = save_dir + '/src'
    
	new_text = "/multi_tracker/1/home_directory: '" + src_dir + "'\n/multi_tracker/1/data_directory: '" + data_dir + "'"

	with open(savename, 'w') as towrite:
		towrite.write(new_text)

	configname = save_dir + '/src/delta_video_config.py'
	configtext = "class Config:\n    def __init__(self):\n        self.basename = 'delta_video'\n        self.directory = '"
	configtext = configtext + data_dir + "'\n        self.topics = ['/multi_tracker/1/delta_video',]\n        self.record_length_hours = 1"

	with open(configname, 'w') as towrite:
		towrite.write(configtext)

