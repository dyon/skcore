###############################################################################
# FileMerger                                                                  #
# Author: Dyon                                                                #
# Description: Script that merges TrinityCore sql files into one single file. #
###############################################################################

import os
import fnmatch

#########################
# CONFIGURATION SECTION #
#########################

config = {
        'sameDirForMergedFiles': True,  # Set this to True to save all merged files to the same directory
        'mergedFilesPath': '../../sql/merged',  # The path where merged files are going to be saved if 'saveDirForMergedFiles' is set to True
        'pattern': '*.sql',  # Pattern to follow when searching for files
        'paths': [
            # Copy and paste a section to merge files in more directories
            # World
            {
                'source': '../../sql/updates/world',
                'destination': '../../sql/merged/world',
                'filename': 'all_world.sql'
            },
            # Characters
            {
                'source': '../../sql/updates/characters',
                'destination': '../../sql/merged/characters',
                'filename': 'all_characters.sql'
            },
            # Auth
            {
                'source': '../../sql/updates/auth',
                'destination': '../../sql/merged/auth',
                'filename': 'all_auth.sql'
            },
            # Custom
            {
                'source': '../../sql/custom_sk',
                'destination': '../../sql/merged/custom',
                'filename': 'all_custom.sql'
            }
        ]
    }

##########################################
# DONT TOUCH ANYTHING BEYOND THIS LINE!! #
##########################################


class FileMerger:

    sameDirForMergedFiles = False
    mergedFilesPath = ''
    pattern = '*'

    def __init__(self):
        self.sameDirForMergedFiles = config['sameDirForMergedFiles']
        self.mergedFilesPath = config['mergedFilesPath']
        self.pattern = config['pattern']

    def get_files(self, directory, pattern):
        files = []

        for root, dirnames, filenames in os.walk(directory):
            for filename in fnmatch.filter(filenames, pattern):
                files.append(os.path.join(root, filename))

        return files

    def merge_files(self):
        for path in config['paths']:
            source = path['source']
            destination = self.mergedFilesPath if self.sameDirForMergedFiles else path['destination']
            filename = path['filename']

            if not os.path.exists(destination):
                os.makedirs(destination)

            result = open(os.path.join(destination, filename), 'w+')
            files = self.get_files(source, self.pattern)
            
            for file in sorted(files):
                for line in open(file):
                    result.write(line)

            print 'Merged file saved to "' + result.name + '".'

            result.close()


fm = FileMerger()

fm.merge_files()
