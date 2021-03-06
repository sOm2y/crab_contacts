#!/usr/bin/env python
import os, json, re, csv, sys, datetime


#import beautifulsoup 
from bs4 import BeautifulSoup



#varible define
soup = BeautifulSoup(open("contact.html"))
table = soup.find('table')
csv_header = ['email','college name','coaches name','coaches phone','city','state','school type','academic rating']
rows = table.find_all('tr', attrs={'class':'listing'})
#get current time
now = datetime.datetime.now()
now_str=now.strftime("%H:%M:%S-%d-%m-%Y")

# Write out to a file for today
outfilename = 'data-{}.csv'.format(now_str)


#get a tag link's email
def mailto_link(e):
    '''Return the email address if the element is is a mailto link,
    otherwise return None'''
    if e.name != 'a':
        return None
    for key, value in e.attrs.iteritems():
        if key == 'href':
            m = re.search('mailto:(.*)',value)
            if m:
                return m.group(1)
    return None


#wgenerate out.csv and write data into it
with open(outfilename, 'wb') as outcsv:
	wr = csv.writer(outcsv,dialect='excel')
	wr.writerow(csv_header)
	for row in rows:
	    cols = row.find_all('td')
	    mailtos = row.select('a[href^=mailto]')
	    mailtos = [mailto_link(mailto).encode('utf-8').strip() for mailto in mailtos if mailto] 
	    cols = [ele.text.encode('utf-8').strip() for ele in cols]
	    wr.writerow(mailtos+cols)
	   
print('csv file has been made and updated! file name is: '+outfilename)
