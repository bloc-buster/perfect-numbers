import multiprocessing
import math
import time
import sys

def sum_of_divisors(n):
	i = 2
	summation = 1
	while i < math.sqrt(n):
		if n % i == 0:
			summation += i
			if n / i != i:
				summation += int(n / i)
		i += 1
	return summation

def is_perfect(n):
	return sum_of_divisors(n) == n

def print_results(results, X):
	for y in range(0,len(results)):
		if results[y] == True:
			print(f'{X[y]} is perfect = {results[y]}')

if __name__ == '__main__':
	args = sys.argv
	if len(args) != 3:
		sys.exit('error')
	lower = int(args[1])
	upper = int(args[2])
	X = [n for n in range(lower, upper + 1)]
	t1 = time.time()
	results = list(map(is_perfect, X))
	print_results(results, X)
	t2 = time.time()
	print(f'compute time {t2 - t1} s')

