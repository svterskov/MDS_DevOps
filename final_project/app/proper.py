def fibonacci_proper(n):
    return fibonacci(n)


def fibonacci(n, memo={0: 0, 1: 1}):
    if n in memo:
        return memo[n]
    
    if n > 1:
        memo[n] = fibonacci(n - 1, memo) + fibonacci(n - 2, memo)
    elif n < 0:
        sign = 1 if n % 2 else -1
        memo[n] = sign * fibonacci(-n, memo)
    
    return int(memo[n])
    