export PATH=~/bin:“$PATH” 

# Reorganize the 2019 taxi datasets by vendorid and put into corresponding files
sed -n '/^1.0/ p' ~/2019-01-h1.csv > $(date "+%F-%T")-1.0.csv
sed -n '/^2.0/ p' ~/2019-01-h1.csv > $(date "+%F-%T")-2.0.csv
sed -n '/^4.0/ p' ~/2019-01-h1.csv > $(date "+%F-%T")-4.0.csv

# Add above files to gitignore
for i in *.csv; do
	echo "ws4/$i" >> ../.gitignore
done

# Add wc of each file to ws4.txt
touch ws4.txt
for i in *.csv; do
        wc $i >> ws4.txt
done

cat ../.gitignore >> ws4.txt
