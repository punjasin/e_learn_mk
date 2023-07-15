import xml.etree.ElementTree as ET
import sys
import os
import subprocess
filepath=sys.argv[1]
#'/Users/somdoppio/Documents/GitHub/makro-mango/output.xml'
tree = ET.parse(filepath)
root = tree.getroot()
count = 0
tc_pass = 0
tc_fail = 0
all_tags= []
for d in root.findall("statistics"):
    for s in d:
        if s.tag == 'tag':
            for x in s:
                l = (x.text).lower()
                if l.startswith("maknet-"):
                    all_tags.append(l)
                    count = count + 1
                    if x.attrib['pass'] == '1':
                        tc_pass = tc_pass +1
                    elif x.attrib['fail'] == '1':
                        tc_fail = tc_fail + 1

print(f'\n `TOTAL ` : {tc_pass+tc_fail} \n `PASSED` : {tc_pass} \n `FAILED` : {tc_fail}')
print(all_tags)



