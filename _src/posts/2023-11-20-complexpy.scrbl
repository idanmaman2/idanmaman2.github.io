#lang scribble/manual

@(require (for-label racket))
@(require racket/string)
@(require frog/scribble)

Title: complexPy
Date: 2023-11-20T20:41:34
Tags: Py , IDHMStyle


<!-- more -->


@table-of-contents[]



@pygment-code[#:lang "python"]{
import timeit 
from collections import defaultdict
import itertools 
import math 
import random 
import re
def isprime1(r : int ) -> (bool , tuple[tuple[int]]):
    divs =  list(map(lambda x : r%x or not isprime1(x)[0]  ,range(2,r)))
    return all(divs),tuple(map(lambda x: (x[0] ,sum(map(lambda z : not r % x[0]**z , range(1,int(r**0.5)+1)) )) ,filter(lambda x : not x[1] , zip(range(2,r ),divs))))

def isprime2(r : int ) -> (bool , tuple[tuple[int]]):
    a,b= __import__("itertools").tee(filter(lambda i : not(r % i) ,  range(r-1 ,1 , -1 ))) 
    return (True,((r,1),)) if  all(map(lambda x : r%x , range(2,int(r**0.5)+1) )) else (False ,tuple(__import__("functools").reduce(lambda x , y : x | {y[0] : x[y[0]]+y[1]}, isprime2(r//next(a))[1]+isprime2(next(b))[1] , __import__("collections").defaultdict(int)).items()))
    
def isprime3(r : int )-> (bool , tuple[tuple[int]]): 
    total =  defaultdict(int)
    isprime = True 
    def iterate_prime(prime:int)->(int,bool): 
        isprime2,z = isprime ,r
        while not(z % prime) :
            isprime2 = False 
            total[prime] += 1
            z = z// prime
        return z, isprime2
    r,isprime=iterate_prime(2)
    for i in range(3,math.ceil(math.sqrt(r)) ,2):
        r,isprime =iterate_prime(i)
        if r <= 2  : 
            break 
    if r >2 : 
        total[r] = 1 
    return isprime,  tuple(total.items())

def check_me(sep: (bool , tuple[tuple[int]]) , r :int ) -> bool : 
    return   (sep[0] and all(map(lambda x : r%x, range(2,r))) )   or  __import__("functools").reduce(lambda x  ,y :x *  y[0] ** y[1] ,sep[1] ,1)  == r

TESTS = 1
primes = len(list(filter(lambda x : re.match("isprime\d+" , x) , globals() ))) 
for i in range(TESTS): 
    num = random.randint(0,1000)
    print(f"=============={num}==============")
    for i in range(1,primes+1): 
        globals()[f"result{i}"]=timeit.timeit(stmt=f'isprime{i}({num})', globals=globals() , number = 1000 )
    for i in range(1,primes+1): 
        print(f"res{i} " , globals()[f"result{i}"] , globals()[f"isprime{i}"](num),check_me(globals()[f"isprime{i}"](num) ,num))
    for i1,i2 in itertools.combinations(range(1,primes+1) , r=2) :     
        exec(f"print('res{i1}/{i2}' ,result{i1} / result{i2})",globals()) 
    print(f"=============={num}==============")


}


so let's see the refactored way and how the "Sachi" people write this code

must know functions :


must know shortcuts :

must know ugly code style : 

must know moudles :



