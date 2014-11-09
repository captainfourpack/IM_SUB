#!/usr/bin/python

#Author: Marcus Andrews (marcus.k.s.andrews@gmail.com)

import MySQLdb
import csv
import gzip
import glob
import os
import os.path


'''##################################################################################
CLASS fileLoader
##################################################################################'''
class fileLoader:
	def loadDBDumpFile(self, filename):
		db = MySQLdb.connect("localhost","test_user","crusty","im_test2" )
		cursor = db.cursor()
		try:
			file = open(filename)
			sqlStatements = []

			for line in file:
				listItems = line.split('",')	#some lines have a comma in the value attribute, so split on the combo
				keys = []
				values = []

				# get the key/value pairs into appropriate lists ready to build our sql statement
				for i in range(len(listItems)):
					#strip the quotes from key (and the bracket if its there i.e. first key)
					key = listItems[i].split(':')[0].strip("{").strip("\"")
					# strip the newline from the value (and the bracket if its there i.e. last key)
					value = listItems[i].split(':')[1].strip("\n").strip("}")
					if(value.endswith('"') is False):
						value = value + '"'			# if we stripped the " from the value, add it back.  This is such a kludge!  Must be a better way
					'''
					See below for how i got to these ugly lines
					key = listItems[i].split(':')[0]
					value = listItems[i].split(':')[1]
					print listItems[i]
					print key.strip("{").strip("\"")
					print value.strip("\n").strip("}")
					'''	
					keys.append(key)
					values.append(value)

				# build up the sql statement from these lists	
				sqlInsert = "insert into cities ("
				sqlTail = ""	
				for i in range(len(keys)):
					if(i!=0):
						sqlInsert = sqlInsert + ", " + keys[i]
						sqlTail = sqlTail + ", " + values[i]
					else:
						sqlInsert = sqlInsert + keys[i]
						sqlTail = sqlTail + values[i]
				
				#finish off our sql statement	
				sqlInsert = sqlInsert + ") values (" + sqlTail + ");"
				#and add it to the DB
				cursor.execute(sqlInsert)
			
			file.close()
			db.commit()
			cursor.close()
		except MySQLdb.Error, e:
			print "Error %d: %s" % (e.args[0], e.args[1]) 
			# Rollback in case there is any error
			db.rollback()
			print "error loading cities file"
		# disconnect from server
		db.close()
			
	def loadCountries(self, countriesFileName):
		db = MySQLdb.connect("localhost","test_user","crusty","im_test2" )
		cursor = db.cursor()
		csv_data = csv.reader(file(countriesFileName))
		try:
			for row in csv_data:
				#Cast the data
				index = int(row[0])
				iso2 = str(row[1])
				iso3 = str(row[2])
				name = str(row[3])
				targetable = int(row[4])
						
				cursor.execute('INSERT INTO countries(idcountries, iso2, \
					iso3, name, targetable )' \
					'VALUES("%s","%s", "%s", "%s", "%s")', 
					(index, iso2, iso3, name, targetable))
			db.commit()
			cursor.close()
		except MySQLdb.Error, e:
			print "Error %d: %s" % (e.args[0], e.args[1]) 
			# Rollback in case there is any error
			db.rollback()
			print "error loading csv file"
		# disconnect from server
		db.close()
		
	def loadRegionsFile(self, filename):			
		db = MySQLdb.connect("localhost","test_user","crusty","im_test2" )
		cursor = db.cursor()
		csv_data = csv.reader(file(filename))

		try:
			for row in csv_data:
				#Cast the data
				index = int(row[0])
				country = int(row[1])
				name = str(row[2])
				isoCode = str(row[3])
						
				cursor.execute('INSERT INTO regions(idregions, idCountries, \
					name, iso_code )' \
					'VALUES("%s","%s", "%s", "%s")', 
					(index, country, name, isoCode))
			db.commit()
			cursor.close()
		except MySQLdb.Error, e:
			print "Error %d: %s" % (e.args[0], e.args[1]) 
			# Rollback in case there is any error
			db.rollback()
			print "error loading csv file"
		# disconnect from server
		db.close()
			
	def unzip(self, loadPath, savePath, extension):
		#credit where due, I hacked much of this for loop from a tutorial somewhere to create this function
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
	def deleteHeader(self, filename):
		file = open(filename)
		lines = file.readlines()
		file.close()
		f = open(filename,"w")
		for line in lines:
			if(line != lines[0]):
				f.write(line)
		f.close()

		
'''##################################################################################
CLASS dataExaminer
##################################################################################'''
class dataExaminer:
	def examineCity(self):
		db = MySQLdb.connect("localhost","test_user","crusty","im_test2" )
		cursor = db.cursor()

		request = raw_input("Please enter the city name you are enquiring about: ")
		while request != "exit":
			# Prepare SQL query.
			sql = "SELECT c.name, c.iso_code, r.name, co.name, co.targetable FROM cities c\
					left join countries co on c.country_id = co.idCountries\
					left join regions r on r.idregions = c.region_id\
					where lower(c.name) = lower('%s')" % request
			#get and display the data	   
			try:
				cursor.execute(sql)
				# Fetch all the rows in a list of lists.
				results = cursor.fetchall()
				output = ""
				# could give a lot more info i guess, like the iso codes for the country the city is in, but this demonstrates the functionality
				for row in results:
					name = row[0]
					iso_code = row[1]
					region = row[2]
					country = row[3]
					targetable = row[4]
					
					# Now print fetched result
					output = "name=%s\niso_code=%s\nregion=%s\ncountry=%s\ntargetable=%d\n" % \
						(name, iso_code, region, country, targetable )
					print "\n" + output	
				
						 
			except MySQLdb.Error, e:
				print "Error %d: %s" % (e.args[0], e.args[1]) 

			request = raw_input("Please enter another city name or type exit to quit the program: ")
		# disconnect from server
		db.close()

	
		
f = fileLoader()
f.deleteHeader('countries')
f.loadCountries('countries')

f.deleteHeader('SampleData.csv')
f.loadRegionsFile('SampleData.csv')

f.loadDBDumpFile('cities')

d = dataExaminer()
d.examineCity()




