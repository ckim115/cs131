# Calculates the average grade for each student
function calc_average(grade) {
	return grade/3
}

{ FS="," }
{
	if (NR != 1) {
		# Store student names
		names[$1] = $2
		# Stores the sum of grades for each student in an associative array.
		grade_sums[$1] = $3 + $4 + $5
	}
}

END {
	hi = $1
	low = $1

	for (i in grade_sums) {
		# Take averages and classify them as Pass (average ≥ 70) or Fail
		average[i] = calc_average(grade_sums[i])
		
		# Print student information
		printf("%s\n%d\n%.2f\n", names[i], grade_sums[i], average[i])
		if (average[i] >= 70)
			print "Pass\n"
		else
			print "Fail\n"

		# Determine the highest and lowest scoring students (total score)
		hi = grade_sums[i] > grade_sums[hi] ? i : hi
		low = grade_sums[i] < grade_sums[low] ? i : low
	}
	
	# Print highest/lowest storing student
	printf("Highest scoring student: %s, ID %d\n", names[hi], hi)
	printf("Lowest scoring student: %s, ID %d\n", names[low], low)
	
}
