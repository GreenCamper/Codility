
fileprivate struct BinarySequence {
    
    let bitRepresentationOfN : [UInt8]
    var leftIndex            : Int
    var rightIndex           : Int
    
}

fileprivate func calculateBinaryGapIn (binarySequence     : BinarySequence,
                                       zeroCounter counter: Int,
                                       maxCounter max: [Int] ) -> [Int] {
    
    
    var sequence    : BinarySequence = binarySequence
    var zeroCounter : Int            = counter
    var maxCounter  : [Int]          = max // stores the numbers of zeros in every consecutive 0 sequence found
    let leftValue   : UInt8          = sequence.bitRepresentationOfN[sequence.leftIndex]
    let rightValue  : UInt8          = sequence.bitRepresentationOfN[sequence.rightIndex]
    
    
    
    // if we hit the last element and its a 0 bit means that the last sequence is not a gap
    if ((sequence.rightIndex == sequence.leftIndex) && (leftValue == 0))
    {
        return maxCounter
    }
        
        // if we hit the last element and its a 1 bit means that the last sequence was probably a gap
    else if ((sequence.rightIndex == sequence.leftIndex) && (leftValue == 1)) {
        maxCounter.append(zeroCounter)
        zeroCounter = 0
        return maxCounter
    }
    
    // otherwise
    if (leftValue == 1) {
        maxCounter.append(zeroCounter)
        zeroCounter         = 0
        sequence.leftIndex += 1
        return calculateBinaryGapIn(binarySequence: sequence, zeroCounter: zeroCounter, maxCounter: maxCounter)
    }
    else if (leftValue == 0) {
        zeroCounter        += 1
        sequence.leftIndex += 1
        return calculateBinaryGapIn(binarySequence: sequence, zeroCounter: zeroCounter, maxCounter: maxCounter)
    }
    
    return maxCounter
}


fileprivate func IntegerToBinary(decimalNumber Number : Int) -> [UInt8] {
    
    /* To avoid the extensive allocation load , and since we do know for a fact that the maximum allowed
     entry is 647 which is represented by 10 digit maximum in binary base. */
    var bitArray                            = [UInt8]()
    let ArrayOfStringfiedBits : [Character] = Array(String(Number, radix : 2))
    
    bitArray.reserveCapacity(10)
    for character in ArrayOfStringfiedBits {
        bitArray.append(UInt8(String(character))!)
    }
    
    return bitArray
}


public func solution( _ N : Int) -> Int {
    
    let bitRepresentationOfN = IntegerToBinary(decimalNumber: N)
    let indexOfLastItem      = bitRepresentationOfN.count - 1
    let maxCounter           = [Int]()
    let sequence             = BinarySequence(bitRepresentationOfN: bitRepresentationOfN,
                                              leftIndex: 0, rightIndex: indexOfLastItem)
    let zeros                = calculateBinaryGapIn(binarySequence: sequence, zeroCounter: 0, maxCounter: maxCounter)
    return zeros.max()! // the max corresponds to the longest sequence in terms of 0 numbers
}








