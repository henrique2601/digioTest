import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {

        window = UIWindow(frame: UIScreen.main.bounds)
        window?.backgroundColor = UIColor.white

        // Crie o seu view controller principal (ou qualquer outro view controller)
        let viewController = HomeRouter.configuredViewController()
        window?.rootViewController = viewController

        window?.makeKeyAndVisible()
        return true
    }
}
