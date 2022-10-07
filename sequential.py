import math
import time
import sys

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

def print_primes(x):
	if is_prime(x) == True:
		print(f'{x} is prime = True')

if __name__ == '__main__':
	args = sys.argv
	if len(args) != 3:
		sys.exit('error')
	lower = int(args[1])
	upper = int(args[2])
	t1 = time.time()
	for x in range(lower, upper + 1):
		print_primes(x)
	t2 = time.time()
	print(f'compute time {t2 - t1} s')

