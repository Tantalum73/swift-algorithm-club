# Knuth-Morris-Pratt String Search

Goal: Write a string search algorithm in pure Swift without importing Foundation or using `NSString`'s `rangeOfString()` method.

In other words, we want to implement an `indexOf(pattern: String)` extension on `String` that returns the `String.Index` of the first occurrence of the search pattern, or `nil` if the pattern could not be found inside the string.

For example:

```swift
// Input:
let s = "Hello, World"
s.indexOf(pattern: "World")

// Output:
<String.Index?> 7

// Input:
let animals = "🐶🐔🐷🐮🐱"
animals.indexOf(pattern: "🐮")

// Output:
<String.Index?> 6
```

> **Note:** The index of the cow is 6, not 3 as you might expect, because the string uses more storage per character for emoji. The actual value of the `String.Index` is not so important, just that it points at the right character in the string.

The algorithm was developed 1977 by Donald Ervin Knuth, James Hiram Morris und Vaughan Ronald Pratt. It based on the Naive Search Algorithm as it is described in [brute-force approach](../Brute-Force String Search/). The Naive Search compared each character of the text to the pattern. If a character doesn't match, the pattern is slided forward by one. The KMP algorithm speeds up the search by sliding it more than one character per mismatch without missing any potential mismatches.

![Naive Algorithm when a mismatch occurs](Graphics/StringMatchingKMPNaiveDumpENG.png "Naive Algorithm when a mismatch")

## How it works

### Prefix Function Calculation

In the first step a prefix function is calculated. The prefix function is an array that maps every character of the pattern to a number. This number determines by which amount of characters the pattern can be moved forward if a mismatch occurs.

Technical speaking, the prefix function on position `j`, `π[j]` holds the number of the longest prefix of the text, that is simultaniously a suffix of `pattern[0..j]`. It is calculated by comparing the pattern to itself: Iterating `i` from 0 to the length of the pattern, every possible suffix from `pattern[0...i]` is built and checked if it a prefix of the original pattern. The longest matching prefix is then stored in `π[i]`.

![Prefix function calculation](Graphics/StringMatchingKMPPreflightENG.png "Prefix function calculation")

### Searching the Text

Once the prefix function is calculated, the text is iterated. By comparing character by character (like the Naive Algorithm) eventually a mismatch occurs. Now, the pattern is not slided by one character to the right but by an number of characters that the prefix function specifies.

![Searching the text](Graphics/StringMatchingKMPSearchENG.png "Searching the text")

## Performance Considerations

The KMP algorithm needs to compute a prefix function before the search can take place. This prefix function is considered Θ(pattern.length). In addition to that, the search has a complexity of Θ(text.length).

> **Note:** If the search pattern consists of only a few characters, it's faster to do a brute-force search. There's a trade-off between the time it takes to build the prefix function and doing brute-force for short patterns.

A faster way of string matching is the [Boyer-Moore Algorithm](../Boyer-Moore/).

## Credits

This code is based on the book "Algorithmen – Eine Einführung. 3" by Prof. Dr. Thomas H. Cormen et alias (Oldenbourg Verlag München, 2010), "Algorithmen und Datenstrukturen." by Thomas Ottmann and Peter Widmayer (4\. Spektrum Akademischer Verlag Heidelberg Berlin, 2002) and "Fast Pattern Matching in Strings." by the authors of the algorithm D. E. Knuth, J. H. Morris und V. R. Pratt (in: SIAM Journal of Computing Vol. 6, No 2 6.2 (1977), S. 323–350).

_Written for Swift Algorithm Club by [Andreas Neusüß](https://github.com/Tantalum73)_.
