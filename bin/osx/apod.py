#!/usr/bin/env python3
# -*- coding: utf-8 -*-
# Download the daily APOD picture and set it as the system wallpaper on OS X
# @author Alex Zylstra
# @date 2013/10/05

__author__ = 'Alex Zylstra'
__date__ = '2013-10-05'

import urllib.request
import os
import subprocess
import sys

# Define the available mirrors. The dict is keyed by location
# Each location is then mapped to a list of mirrors. Each mirror must
# have the base url and the relative url for the page in a tuple
# Base URL must have a trailing slash
all_mirrors = dict( US=[('http://apod.nasa.gov/apod/', 'astropix.html'),
                        ('http://apod.com/', '')], 
                    UK=[('http://www.star.ucl.ac.uk/~apod/apod/', 'astropix.html')])

# Parse the command line arguments
locale = 'US'  # default
spaces = 1  # default
for i in range(len(sys.argv)):
    # Check for the localization flag:
    if sys.argv[i] == '--locale' or sys.argv[i] == '-l':
        if len(sys.argv) > i+1:
            locale = sys.argv[i+1]
            if not locale in all_mirrors.keys():
                keystr = ''
                for key in all_mirrors.keys():
                    keystr += key + ','
                print('Invalid entry for locale. Available options: ' + keystr)
                sys.exit()
    # Check for the number of spaces:
    if sys.argv[i] == '--spaces' or sys.argv[i] == '-s':
        if len(sys.argv) > i+1:
            try:
                spaces = int(sys.argv[i+1])
                if spaces <= 0:
                    raise ValueError()
            except ValueError:
                print('Invalid entry for number of spaces, must be a positive non-zero integer.')
                sys.exit()

# Set the mirrors:
mirrors = all_mirrors[locale]

# loop over mirrors:
download = False
timeout = 1
for mirror in mirrors:
    # main page for APOD for this mirror:
    URL = mirror[0] + mirror[1]
    if not download:
        try:
            html_content = urllib.request.urlopen(URL, timeout=timeout).read()
            # split into lines
            source = html_content.split()

            # look for the link to the image
            img_url = ""
            for rawline in source:
                line = str(rawline)
                if 'jpg' in line or 'JPG' in line:
                    if 'href' in line:
                        img_url = line
                        break

            # now we have to parse it:
            for substr in img_url.split('''"'''):
                if 'jpg' in substr:
                    img_url = substr
                    break

            # concatenate:
            img_url = mirror[0] + img_url

            # get name of the image itself:
            img_name = img_url.split('/')[-1]
            # do the download:
            u = urllib.request.urlopen(img_url, timeout=timeout)
            raw = u.read()
            print("read {0} KB".format(int(len(raw)/1024)))
            # close the connection:
            u.close()
            # save to a temp file:
            tmp_dir = '/tmp'
            fname = os.path.join(tmp_dir, img_name)
            f = open(fname, 'wb')
            f.write(raw)
            f.close()
            download = True
            print('Downloaded image from ' + mirror[0])
        except Exception as e:
            print('Unable to download from ' + mirror[0])


if download:
    # now to set the background via somewhat clunky script
    SCRIPT = """/usr/bin/osascript << END
        tell application \"System Events\" to set picture of every desktop to \"%s\"
    """
    subprocess.Popen(SCRIPT%(fname), shell=True)
