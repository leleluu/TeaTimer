import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?

    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {

        guard let windowScene = (scene as? UIWindowScene) else { return }
        window = UIWindow(frame: windowScene.coordinateSpace.bounds)
        window?.windowScene = windowScene

        let itemSizeConstant = ((window?.frame.width)!)/2.75

        let layout = UICollectionViewFlowLayout()
        layout.itemSize = CGSize(width: itemSizeConstant, height: itemSizeConstant)
        layout.sectionInset = UIEdgeInsets(top: 32, left: 32, bottom: 32, right: 32)
        layout.minimumLineSpacing = 32

        let viewController = TeaCollectionViewController(collectionViewLayout: layout)
        let navigationViewController = UINavigationController(rootViewController: viewController)

        window?.rootViewController = navigationViewController
        window?.makeKeyAndVisible()

    }

    func sceneDidDisconnect(_ scene: UIScene) {
    }

    func sceneDidBecomeActive(_ scene: UIScene) {
    }

    func sceneWillResignActive(_ scene: UIScene) {
    }

    func sceneWillEnterForeground(_ scene: UIScene) {
    }

    func sceneDidEnterBackground(_ scene: UIScene) {
    }
}

