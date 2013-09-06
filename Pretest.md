# Pretest

Write a program in a language of your choice that prints the numbers from 1 to 100, but for multiples of three, print "Fizz" instead of the number, and for multiples of five, print "Buzz" instead. For multiples of both three and five, print "FizzBuzz".
The output should start like this:

    1
    2
    Fizz
    4
    Buzz
    Fizz
    7
    8
    Fizz
    Buzz
    11
    Fizz
    13
    14
    FizzBuzz

To make things interesting, your program cannot use loops, and cannot be a giant wall of print statements, either.

Create a file in your COMP501 folder for your solution. This shouldn't take more than 5 minutes to finish, so when the time has passed, add the file to git, commit and push. For example, if your solution is in a file called solution.cpp, type in the following:

	git add solution.cpp
	git commit -m "FizzBuzz solution"
	git push --all origin

So what was the point of all of this, besides making you squirm?

Programming languages encourage certain ways of thinking about how to solve problems, and I asked you to solve a simple problem in a different way. Chances are, the language you chose did not encourage programming without loops. Many programming languages encourage you to write programs as a sequence of instructions with some minor variations to produce a result as a side effect of changing state. This *imperative* style of programming is natural for object-oriented, procedural, and even most assembly languages. Unfortunately, imperative programming does not make debugging easy. In contrast, *declarative* programming languages, including functional and logic programming languages encourage you to use pattern matching and recursion to describe the problem, not the steps. Reasoning about declarative programs tends to be easier than imperative programs. This may explain why advancements in programming such as structured programming, procedures, object, types, recursion, and so forth, have shifted the practice of programming to a more declarative style.