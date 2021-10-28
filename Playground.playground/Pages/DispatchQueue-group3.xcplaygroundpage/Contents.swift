import UIKit
import PlaygroundSupport

/*:
 Tell the playground to continue running, even after it thinks execution has ended.
 You need to do this when working with background tasks.
 */

PlaygroundPage.current.needsIndefiniteExecution = true

/*
 if you call an asynchronous method inside of your closure, then the closure will complete before the internal asynchronous method has completed.
 
 --> Below is the solution....
 */

let group = DispatchGroup()
let queue = DispatchQueue.global(qos: .userInitiated)

let base = "https://wolverine.raywenderlich.com/books/con/image-from-rawpixel-id-"
let ids = [ 466881, 466910, 466925, 466931, 466978, 467028, 467032, 467042, 467052 ]

var images: [UIImage] = []

for id in ids {
    guard let url = URL(string: "\(base)\(id)-jpeg.jpg") else {
        continue
    }
    group.enter()
    
    // Asynchronous method
    let task = URLSession.shared.dataTask(with: url) { data, _, error in
        defer {
            group.leave()
        }
        
        if error == nil, let data = data, let image = UIImage(data: data) {
            images.append(image)
        }
    }
    
    task.resume()
}

group.notify(queue: queue) {
    print("All jobs have finished...")
    images[0]
    PlaygroundPage.current.finishExecution()
}
