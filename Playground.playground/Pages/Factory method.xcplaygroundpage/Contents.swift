//https://www.youtube.com/watch?v=JdZGvsxblF0
import UIKit

enum ProfileType {
    case normal
    case privileged
}

protocol ProfileView: AnyObject {
    var profileImageView: UIImageView { get }
    var usernameLabel: UILabel { get }
    var coinsLabel: UILabel { get }
}

struct User {
    
}

protocol ProfileViewFactoryProtocol {
    func getProfileView(user: User)
}

class NewyorkProfileViewFactory: ProfileViewFactoryProtocol {
    let profileviewFactory = ProfileViewFactory()
    
    func getProfileView(user: User) {
        
    }
}

class ProfileViewFactory {
    func getProfileView(type: ProfileType) -> ProfileView {
        switch type {
        case .normal:
            return NormalProfileView()
        case .privileged:
            return PrivilegedProfileView()
        }
    }
}

class NormalProfileView: UIView, ProfileView {
    var profileImageView: UIImageView = UIImageView()
    var usernameLabel: UILabel = UILabel()
    var coinsLabel: UILabel = UILabel()
}

class PrivilegedProfileView: UIView, ProfileView {
    var profileImageView: UIImageView = UIImageView()
    var usernameLabel: UILabel = UILabel()
    var coinsLabel: UILabel = UILabel()
}
