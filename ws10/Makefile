all : clean.csv

trimmed.csv :
	cut -d "," -f 1,3,5 raw.csv > trimmed.csv

clean.csv : trimmed.csv
	awk -F ',' '{ if (length($$1) > 0 && length($$2) > 0 && length($$3) > 0) print $$0 }' trimmed.csv > clean.csv

clean :
	rm -f trimmed.csv clean.csv
