import multiprocessing
import concurrent.futures
import math
import time
import sys

#PRIMES = [x for x in range(10000000000,10010000000)]

def is_prime(n):
	if n < 2:
		return False
	if n == 2:
		return True
	if n % 2 == 0:
		return False
	sqrt_n = int(math.floor(math.sqrt(n)))
	for i in range(3, sqrt_n + 1, 2):
		if n % i == 0:
			return False
	return True

def print_primes(results, X):
	for y in range(0,len(results)):
		if results[y] == True:
			print(f'{X[y]} is prime = {results[y]}')

if __name__ == '__main__':
	args = sys.argv
	if len(args) != 4:
		sys.exit('error')
	lower = int(args[1])
	upper = int(args[2])
	granularity = int(args[3])
	X = [n for n in range(lower, upper + 1)]
	t1 = time.time()
	p = multiprocessing.Pool(granularity)
	results = p.map(is_prime, X)
	print_primes(results, X)
	p.close()
	t2 = time.time()
	print(f'compute time {t2 - t1} s')

