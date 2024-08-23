//
//  AppDelegate.swift
//  Weather
//
//  Created by Trần Đức on 28/7/24.
//

import UIKit
import CoreData

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        let window = UIWindow(frame: UIScreen.main.bounds)
        window.rootViewController = UINavigationController(rootViewController: SplashViewController())
        window.makeKeyAndVisible()
        self.window = window
        UINavigationBar.appearance().isHidden = true
        return true
    }
    
    func resetRoot(uiViewController: UIViewController) {
        let newRootViewController = uiViewController
        let navigationController = UINavigationController(rootViewController: newRootViewController)
        window?.rootViewController = navigationController
        window?.makeKeyAndVisible()
    }
    
    lazy var persistentContainer: NSPersistentContainer = {
        let container = NSPersistentContainer(name: "WeatherData")
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error as NSError? {
                
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        })
        return container
    }()
    
    func saveContext () {
        let context = persistentContainer.viewContext
        if context.hasChanges {
            do {
                try context.save()
            } catch {
//                fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
            }
        }
    }
    
}

