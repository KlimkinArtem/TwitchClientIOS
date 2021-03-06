import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?

    enum selectNC{
        case allGames, fvStreamers
    }

    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {

        guard let _ = (scene as? UIWindowScene) else { return }
        
        guard let windowScence = (scene as? UIWindowScene) else { return }
        
        window = UIWindow(frame: windowScence.coordinateSpace.bounds)
        window?.windowScene = windowScence
        window?.rootViewController = createTabBar()
        configureTintColor()
        window?.makeKeyAndVisible()
    }
    
    func createNC(controller: selectNC) -> UINavigationController{
        switch controller {
        case .allGames:
            let searchVC = GamesVC()
            searchVC.title = "All Games"
            searchVC.tabBarItem = UITabBarItem(tabBarSystemItem: .mostViewed, tag: 0)
            return UINavigationController(rootViewController: searchVC)
        case .fvStreamers:
            let favoritesVC = FavoritesVC()
            favoritesVC.title = "Favorites"
            favoritesVC.tabBarItem = UITabBarItem(tabBarSystemItem: .favorites, tag: 1)
            return UINavigationController(rootViewController: favoritesVC)
        }
    }
    
    func createTabBar() -> UITabBarController{
        let tabBar = UITabBarController()
        
        
        tabBar.viewControllers = [createNC(controller: .allGames), createNC(controller: .fvStreamers)]
        return tabBar
    }
    
    func configureTintColor(){
        UITabBar.appearance().tintColor = .systemPurple
        
        let navBarAppearance = UINavigationBar.appearance()
        navBarAppearance.tintColor = .systemPurple
        navBarAppearance.titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.systemPurple]
    }


    func sceneDidDisconnect(_ scene: UIScene) {
        // Called as the scene is being released by the system.
        // This occurs shortly after the scene enters the background, or when its session is discarded.
        // Release any resources associated with this scene that can be re-created the next time the scene connects.
        // The scene may re-connect later, as its session was not neccessarily discarded (see `application:didDiscardSceneSessions` instead).
    }

    func sceneDidBecomeActive(_ scene: UIScene) {
        // Called when the scene has moved from an inactive state to an active state.
        // Use this method to restart any tasks that were paused (or not yet started) when the scene was inactive.
    }

    func sceneWillResignActive(_ scene: UIScene) {
        // Called when the scene will move from an active state to an inactive state.
        // This may occur due to temporary interruptions (ex. an incoming phone call).
    }

    func sceneWillEnterForeground(_ scene: UIScene) {
        // Called as the scene transitions from the background to the foreground.
        // Use this method to undo the changes made on entering the background.
    }

    func sceneDidEnterBackground(_ scene: UIScene) {
        (UIApplication.shared.delegate as? AppDelegate)?.saveContext()
    }


}

