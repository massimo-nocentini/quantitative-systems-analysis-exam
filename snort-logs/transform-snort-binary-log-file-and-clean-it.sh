#!/bin/bash

plainTextLogFile=$4
snort -v -r $1 > $plainTextLogFile			# produce plain text log file

# remove any dumped information due to ICMP received packet
# this occurs mainly when an error happen.
sed -i '/^\*\* ORIGINAL DATAGRAM DUMP:$/,/^\*\* END OF DUMP$/d' $plainTextLogFile

sed -i '/^$/d' $plainTextLogFile			# remove empty lines
sed -i '/^Len:/d' $plainTextLogFile			# remove all lines starting with `Len:' for UDP
sed -i '/^PACKET FILTERED/d' $plainTextLogFile		# remove this lines produced by ICMP packets
sed -i '/^=+=+=+=+/d' $plainTextLogFile				# remove separating lines
sed -i '/^TCP Options/d' $plainTextLogFile			# remove TCP Options since seems to be all equals
ex -c "%g/^TCP /j" -c "wq" $plainTextLogFile			# join a TCP starting line with the following one containing flags information
ex -c "%g/^ICMP /j" -c "wq" $plainTextLogFile			# join a ICMP starting line with the following one containing detailed messages
sed -i 'N;s/\n/ /' $plainTextLogFile				# join pairwise line in order to have a line for each incoming/outgoing packet. 

sed -i "s/^[0-9][0-9]\/[0-9][0-9]/$2\/$3/g" $plainTextLogFile
