import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?

    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {

        guard let windowScene = (scene as? UIWindowScene) else { return }
        window = UIWindow(frame: windowScene.coordinateSpace.bounds)
        window?.windowScene = windowScene

        let defaultMargin: CGFloat = 32
        let sectionInset = UIEdgeInsets(
            top: defaultMargin,
            left: defaultMargin,
            bottom: defaultMargin,
            right: defaultMargin
        )

        let itemHeight = window!.frame.width / 2.75
        let itemWidth = window!.frame.width - (sectionInset.left + sectionInset.right)

        let layout = UICollectionViewFlowLayout()
        layout.itemSize = CGSize(width: itemWidth, height: itemHeight)
        layout.sectionInset = sectionInset

        layout.minimumLineSpacing = defaultMargin

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

