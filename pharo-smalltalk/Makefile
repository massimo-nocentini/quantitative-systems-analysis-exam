
run-pharo:
	./pharo-ui Pharo.image

download-pharo:
	curl get.pharo.org | bash

download-eps:
	wget https://www.dropbox.com/s/7ozn54ny9984fnr/eps.tar.gz 
	tar xfvz eps.tar.gz
	mv eps/ ../documentation/
	rm eps.tar.gz

download-snort-logs:
	wget https://www.dropbox.com/s/ch5slx2hlchi98a/snort-logs.tar.gz
	tar xfvz snort-logs.tar.gz
	mv snort-logs/ ../
	rm snort-logs.tar.gz

clean: 
	rm ../documentation/*.aux
	rm ../documentation/*.log
	rm ../documentation/*.out
	rm ../documentation/*.pdf
	rm ../documentation/*.toc
	rm ../snort-logs/*.eps
	rm ../snort-logs/*.coordinates
	rm ../snort-logs/*.gnuplot

clean-all:
	rm -r ../documentation/eps
	rm -r ../snort-logs/
