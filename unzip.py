#!/usr/bin/python

#Author: Marcus Andrews (marcus.k.s.andrews@gmail.com)

import sys
import gzip
import glob
import os
import os.path

argList = sys.argv
inputLoad = argList[1]
inputSave = argList[2]
inputExtension = argList[3]

def unzipFile(loadPath, savePath, extension):
	for gzip_path in glob.glob(loadPath + "/*" + extension):
		if os.path.isdir(gzip_path) == False:
			inF = gzip.open(gzip_path, 'rb')
			# uncompress the gzip_path INTO THE 's' variable
			s = inF.read()
			inF.close()

			# get gzip filename (without directories)
			gzip_fname = os.path.basename(gzip_path)
			# get original filename (remove 'len(extension)' characters from the end)
			fname = gzip_fname[:-len(extension)]
			uncompressed_path = os.path.join(savePath, fname)

			# store uncompressed file data from 's' variable
			open(uncompressed_path, 'w').write(s)
			
unzipFile(inputLoad, inputSave, inputExtension)
			
			

