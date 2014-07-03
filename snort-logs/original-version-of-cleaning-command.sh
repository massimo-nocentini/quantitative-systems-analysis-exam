#!/bin/bash

snort -v -r $1 > snort.log			# produce plain text log file

# remove any dumped information due to ICMP received packet
# this occurs mainly when an error happen.
sed -i '/^\*\* ORIGINAL DATAGRAM DUMP:$/,/^\*\* END OF DUMP$/d' snort.log

sed -i '/^$/d' snort.log			# remove empty lines
sed -i '/^Len:/d' snort.log			# remove all lines starting with `Len:' for UDP
sed -i '/^PACKET FILTERED/d' snort.log		# remove this lines produced by ICMP packets
sed -i '/^=+=+=+=+/d' snort.log			# remove separating lines
sed -i '/^TCP Options/d' snort.log		# remove TCP Options since seems to be all equals
ex -c "%g/^TCP /j" -c "wq" snort.log		# join a TCP starting line with the following one containing flags information
ex -c "%g/^ICMP /j" -c "wq" snort.log		# join a ICMP starting line with the following one containing detailed messages
sed -i 'N;s/\n/ /' snort.log			# join pairwise line in order to have a line for each incoming/outgoing packet. 

sed -i "s/^[0-9][0-9]\/[0-9][0-9]/$2\/$3/g" snort.log
