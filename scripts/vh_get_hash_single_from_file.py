#!/usr/bin/env python3

import os, sys

gcontent = ''

def get_pkg_hash_from_Packages(Packages_file, package, version, hash="SHA256"):
    global gcontent
    with open(Packages_file, 'r') as Packages:
        package_list = Packages.read().split('\n\n')
    for pkg in package_list:
        if pkg.split('\n')[0] == "Package: "+package:
            xgcontent = ''
            has_version = False
            has_name = False
            for line in pkg.split('\n'):
                # Assuming Filename: comes before Version:
                if line.startswith('Filename:'):
                    xgcontent += line.split(" ")[1] + " " + "\n"
                    has_name = True
                elif line.startswith('Version:'):
                    if os.getenv('TERMUX_WITHOUT_DEPVERSION_BINDING') != 'true' and line != 'Version: '+version:
                        # Seems the repo contains the wrong version, or several versions
                        # We can't use this one so continue looking
                        break
                elif line.startswith(hash):
                    xgcontent += line.split(" ")[1] + "\n"
                    has_version = True
                    break
            if has_name and has_version:
                gcontent = xgcontent

def get_Packages_hash_from_Release(Release_file, arch, component, hash="SHA256"):
    global gcontent
    string_to_find = component+'/binary-'+arch+'/Packages'
    with open(Release_file, 'r') as Release:
        hash_list = Release.readlines()
    for i in range(len(hash_list)):
        if hash_list[i].startswith(hash+':'):
            break
    for j in range(i, len(hash_list)):
        if string_to_find in hash_list[j].strip(' '):
            hash_entry = list(filter(lambda s: s != '', hash_list[j].strip('').split(' ')))
            if hash_entry[2].startswith(".work_"):
                continue
            gcontent += hash_entry[0] + "\n"
            break

if __name__ == '__main__':
    if len(sys.argv) < 2:
        sys.exit('Too few arguments, I need the path to a Packages file, a package name and a version, or an InRelease file, an architecture and a component name. Exiting')

    if sys.argv[1].endswith('Packages'):
        get_pkg_hash_from_Packages(sys.argv[1], sys.argv[2], sys.argv[3])
        print(gcontent, end='')
    elif sys.argv[1].endswith(('InRelease', 'Release')):
        get_Packages_hash_from_Release(sys.argv[1], sys.argv[2], sys.argv[3])
        print(gcontent, end='')
    else:
        sys.exit(sys.argv[1]+' does not seem to be a path to a Packages or InRelease/Release file')
