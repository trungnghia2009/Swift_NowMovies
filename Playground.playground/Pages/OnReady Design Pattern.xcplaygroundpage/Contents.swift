// It's fairly common, using to refresh user's access token

import UIKit

class APICaller {
    static let shared = APICaller()
    
    private init() {}
    
    private var isReady = false
    
    func WarmUp() {
        print("Warming up")
        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 5) { [weak self] in
            print("Is ready")
            self?.isReady = true
            self?.blocks.forEach { callback in
                APICaller.shared.getData(completion: callback)
            }
        }
    }
    
    typealias Completion = ((String) -> Void)
    
    private var blocks = [Completion]()
    
    func getData(completion: @escaping Completion) {
        guard isReady else {
            blocks.append(completion)
            return
        }
        completion("Was ready")
        
    }
}

let apiCaller = APICaller.shared
apiCaller.WarmUp()
apiCaller.getData { string in
    print(string)
}
apiCaller.getData { string in
    print(string)
}
apiCaller.getData { string in
    print(string)
}
