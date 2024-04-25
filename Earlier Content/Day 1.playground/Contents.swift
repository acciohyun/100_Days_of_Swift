class Solution {
    func encode(_ s: [String]) -> String {
        var result = ""
        for i in s{
            var numChar = i.count
            let (hq, hr) = numChar.quotientAndRemainder(dividingBy: 100)
            let (tq, tr) = hr.quotientAndRemainder(dividingBy: 10)
            result += String(hq)
            result += String(tq)
            result += String(tr)
            result += i
        }
        return result
    }
    func decode(_ s: String) -> [String]{
        var myArray = Array(s)
        var index = 0
        var result = [String]()
        var checkEncode = true
        var charCount = 0
        var currStr = ""
        while index < myArray.count{
            if checkEncode{
                var myString = String(myArray[index]) + String(myArray[index + 1]) + String(myArray[index + 2])
                charCount = Int(myString) ?? 0
                index += 3
                checkEncode = false
            }else{
                currStr += String(myArray[index])
                charCount -= 1
                index += 1
                if charCount == 0{
                    result.append(currStr)
                    checkEncode = true
                    currStr = ""
                }
            }
        }
        if result.isEmpty{
            return [""]
        }
        return result
    }
}

let solution = Solution()
//print(solution.encode(["Hello","World"]))
print(solution.decode(solution.encode([""])))
