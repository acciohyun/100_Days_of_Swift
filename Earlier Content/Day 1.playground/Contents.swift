import UIKit

func hammingWeight(_ n: Int) -> UInt32 {
    var bitForm = UInt32(n)
    print("\(bitForm)")
    var strForm = "\(bitForm)"
    print(strForm)
    var sum = 0
    for char in strForm{
        if Int(String(char)) == 1{
            sum += 1
        }
    }
    return bitForm
}

print(hammingWeight(11))
