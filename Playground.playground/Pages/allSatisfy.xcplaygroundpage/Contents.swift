import UIKit

let nums = [1, 2, 4, 6, 63, 11, 22, 43]
let answers = ["Apple", "Google", "Microsoft", "Facebook"]

let allEven = nums.allSatisfy { $0 % 2 == 0 }
allEven

let answerValidation = answers.allSatisfy { $0.count >= 5 }
answerValidation

struct Message {
    var message: String
    var canDelete: Bool
}

let messages = Array(0...100).map { Message(message: "\($0)", canDelete: true) }
let messageDeletion = messages.allSatisfy { $0.canDelete == true }
messageDeletion
