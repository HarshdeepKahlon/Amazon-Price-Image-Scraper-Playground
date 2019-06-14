import Foundation
import PlaygroundSupport

// Returns price in USD of a given Amazon Link.
func priceCheck(url: URL, completion: @escaping(String) -> Void) {
    var finalString: String?
    let task = URLSession.shared.dataTask(with: url) { (data, response, error) in
        if let data = data,
            let string = String(data: data, encoding: .utf8)
        {
            if let startIndex = string.range(of: "<b>Price:</b>&nbsp;$")?.upperBound {
                let parsedString = string[startIndex...]
                finalString = String(parsedString[parsedString.startIndex..<parsedString.firstIndex(of: "&")!])
                return completion(finalString!)
            }
            else {
                return completion("0")
            }
        }
        else {
            finalString = nil
            return completion("0")
        }
    }
    task.resume()
}

// Returns an image url of a given Amazon Link.
// In the URL, you can change the 'SL110' portion of code to 'SL500' or 'SL1000'
// for higher resolution images.
func imageCheck(url: URL, completion: @escaping(String) -> Void) {
    var finalString: String?
    let task = URLSession.shared.dataTask(with: url) { (data, response, error) in
        if let data = data,
            let string = String(data: data, encoding: .utf8)
        {
            
            if let startIndex = string.range(of: "<img src=\"")?.upperBound {
                let parsedString = string[startIndex...]
                finalString = String(parsedString[parsedString.startIndex..<parsedString.firstIndex(of: "\"")!])
                return completion(finalString!)
            }
            else {
                return completion("0")
            }
        }
        else {
            finalString = nil
            return completion("0")
        }
    }
    task.resume()
}

let url = URL(string: "https://amzn.to/2WGa8zj")!

priceCheck(url: url) { (data) in
    print("Price: \(data)")
}


imageCheck(url: url) { (data) in
    print("Image Link: \(data)")
}
