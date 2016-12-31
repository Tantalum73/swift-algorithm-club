
extension String {
    
    public func index(of needle: String) -> Int? {
        let selfCount = self.characters.count
        let needleCount = needle.characters.count
        let needleStartIndex = needle.startIndex
        
        guard needleCount > 0 else {
            return nil
        }
        guard selfCount >= needleCount else {
            // Needle must not be larger than the heystack.
            return nil
        }
        
        // Compute the prefix function.
        let π = computePrefixFunction(for: needle)
        
        var numberOfMatchingElements = 0
        
        func subscriptableNeedleIndex(for offset: Int) -> String.CharacterView.Index {
            return needle.index(needleStartIndex, offsetBy: offset)
        }
        
        // Iterate through the array from left to right.
        for (index, element) in self.characters.enumerated() {
            while numberOfMatchingElements > 0 && needle[subscriptableNeedleIndex(for: numberOfMatchingElements)] != element{
                // The element does not match. Skip ahead.
                
                numberOfMatchingElements = π[numberOfMatchingElements]
            }
            if needle[subscriptableNeedleIndex(for: numberOfMatchingElements)] == element {
                // The element does match. Go on and compare the next element.
                
                numberOfMatchingElements = numberOfMatchingElements+1
            }
            if numberOfMatchingElements == needleCount {
                // Every element of the needle was compared and no mismatch occured. Therefore the needle is found.
                return index-needleCount+1
            }
        }
        
        return nil
    }
    
    private func computePrefixFunction(for needle: String) -> [Int] {
        let needleCount = needle.characters.count
        let needleStartIndex = needle.startIndex
        
        guard needleCount > 0 else {
            return [Int]()
        }
        
        // Initialize π by filling it with needleCount 0s
        var π = [Int](repeatElement(0, count: needleCount))
        
        // Explicitly setting the first element to 0.
        π[π.startIndex] = 0
        
        var index = 1//needle.index(needle.startIndex, offsetBy: 1)
        var lengthOfPreviousLargestSuffix = 0//needle.startIndex
        
        // Iterate through all elements of the needle, staring at 1 because the 0th element was already filled (with a 0).
        while index < needleCount {
            
            let indexInNeedle = needle.index(needleStartIndex, offsetBy: index)
            let lengthOfPreviousLargestSuffixInNeedle = needle.index(needleStartIndex, offsetBy: lengthOfPreviousLargestSuffix)
            
            if needle.characters[indexInNeedle] == needle.characters[lengthOfPreviousLargestSuffixInNeedle] {
                
                lengthOfPreviousLargestSuffix += 1
                π[index] = lengthOfPreviousLargestSuffix
                index += 1
            }
            else {
                if lengthOfPreviousLargestSuffix != 0 {
                    lengthOfPreviousLargestSuffix = π[lengthOfPreviousLargestSuffix-1]
                }
                else {
                    //lengthOfPreviousLargestSuffix == 0
                    π[index] = lengthOfPreviousLargestSuffix
                    index+=1
                }
            }
        }
        
        return π
    }
}
