1.  What if you were to cache the calculation, for example in the file system.  What would an example implementation of the cache look like?  By cache I mean, given an array input, skip the calculation of the output if you have already calculated the output at least once already.

	- The implementation I decided on memoizes previously computed values. This caching could easily be adapted to use the file system, instead of memory.


2. What is the performance of your caching implementation?  Is there any way to make it more performant.
	- The caching implementation vastly improves running time than the typical brute-force implementation would. By first sorting the array, the program will be able to skip as many computations possible.
	- I cannot think of any ways to make this significantly more performant. Perhaps using ActiveSupport's memoize feature would be slightly easier, but I believe the performance would be equivalent.


3. What if you wanted to reverse the functionality.  What if you wanted to output each integer and all the other integers in the array that is the first integer is a factor of I.E:<br>
Given an array of [10, 5, 2, 20], the output would be:
{10: [20], 5: [10,20], 2: [10, 20], 20: []}<br>
Would this change your caching algorithim?<br>
With caching, the output should be the same except the calculations are not performed.
	- This change can be made by modifying the loop in `factors` to account for it. This would still leverage the caching implementation.