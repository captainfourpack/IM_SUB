#!/usr/bin/python

import boto
import gcs_oauth2_boto_plugin
import os
import shutil
import StringIO
import tempfile
import time

# URI scheme for Google Cloud Storage.
GOOGLE_STORAGE = 'gs'
# URI scheme for accessing local files.
LOCAL_FILE = 'file'


# Your project ID can be found at https://console.developers.google.com/
# If there is no domain for your project, then project_id = 'YOUR_PROJECT'
project_id = 'rare-basis-686'
header_values = {"x-goog-project-id": project_id}


#list buckets
print "listing buckets\n"
uri = boto.storage_uri('', GOOGLE_STORAGE)
# If the default project is defined, call get_all_buckets() without arguments.
for bucket in uri.get_all_buckets(headers=header_values):
  print bucket.name

#list objects
print "listing objects\n"
uri = boto.storage_uri('im-training', GOOGLE_STORAGE)
for obj in uri.get_bucket():
  print '%s://%s/%s' % (uri.scheme, uri.bucket_name, obj.name)

#downloading objects
print "downloading objects\n"
dest_dir = os.getenv('HOME')
for filename in ('cities.gz', 'countries.gzip', 'regions.csv'):
  src_uri = boto.storage_uri(
      'im-training' + '/' + filename, GOOGLE_STORAGE)

  # Create a file-like object for holding the object contents.
  object_contents = StringIO.StringIO()

  # The unintuitively-named get_file() doesn't return the object
  # contents; instead, it actually writes the contents to
  # object_contents.
  src_uri.get_key().get_file(object_contents)

  local_dst_uri = boto.storage_uri(
      os.path.join(dest_dir, filename), LOCAL_FILE)

  bucket_dst_uri = boto.storage_uri(
      'im-training' + '/' + filename, GOOGLE_STORAGE)

  for dst_uri in (local_dst_uri, bucket_dst_uri):
    object_contents.seek(0)
    dst_uri.new_key().set_contents_from_file(object_contents)

  object_contents.close()