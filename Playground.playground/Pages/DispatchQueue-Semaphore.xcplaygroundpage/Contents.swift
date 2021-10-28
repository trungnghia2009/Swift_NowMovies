import UIKit
import PlaygroundSupport

/*:
 Tell the playground to continue running, even after it thinks execution has ended.
 You need to do this when working with background tasks.
 */

PlaygroundPage.current.needsIndefiniteExecution = true

let group = DispatchGroup()
let queue = DispatchQueue.global(qos: .userInteractive)
let semaphore = DispatchSemaphore(value: 2)

let base = "https://wolverine.raywenderlich.com/books/con/image-from-rawpixel-id-"
let ids = [466881, 466910, 466925, 466931, 466978, 467028, 467032, 467042, 467052]

var images: [UIImage] = []

for id in ids {
  guard let url = URL(string: "\(base)\(id)-jpeg.jpg") else { continue }
  
  semaphore.wait()
  group.enter()
  
  let task = URLSession.shared.dataTask(with: url) { data, _, error in
    defer {
      group.leave()
      semaphore.signal()
    }
    
    if error == nil,
      let data = data,
      let image = UIImage(data: data) {
      images.append(image)
    }
  }
  
  task.resume()
}

group.notify(queue: queue) {
  images[0]
  
  //: Make sure to tell the playground you're done so it stops.
  PlaygroundPage.current.finishExecution()
}
