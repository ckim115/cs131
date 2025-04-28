all : clean.csv

trimmed.csv :
	cut -d "," -f 1,3,5 raw.csv > trimmed.csv

clean.csv : trimmed.csv
	awk -F , '{ if (!(match($$1, "") || match($$2, "") || match($$3, ""))) print $$0 }' trimmed.csv > clean.csv

clean :
	rm -f trimmed.csv clean.csv
