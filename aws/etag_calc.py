#!/usr/bin/env python3

# based on https://teppen.io/2018/10/23/aws_s3_verify_etags/
# chunk size set to 16M (requires .aws/config : (no idea what will happen on the file with exact 16MB size)
# 
#s3 =
#  max_concurrent_requests = 3
#  multipart_threshold = 16MB
#  multipart_chunksize = 16MB
#
import sys
from hashlib import md5
import sys

psize = 16 * 1024 * 1024

def calc_etag(partsize):
    md5_digests = []
    with sys.stdin.buffer as f:
        for chunk in iter(lambda: f.read(partsize), b''):
            md5_digests.append(md5(chunk).digest())
    return md5(b''.join(md5_digests)).hexdigest() + '-' + str(len(md5_digests))

print (calc_etag(psize))
