
import UIKit

class ConversationsViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .red
    }
    
    override func viewDidAppear(_ animated: Bool) {
        let isLogin = UserdefaultsData().fetch(key: isLogin, type: Bool.self) ?? false
        if !AuthManager.shared.currentAuth() {
            let vc = LoginViewController()
            let nav = UINavigationController.init(rootViewController: vc)
            nav.modalPresentationStyle = .fullScreen
            self.present(nav, animated: true, completion: nil)
        }
    }
}
