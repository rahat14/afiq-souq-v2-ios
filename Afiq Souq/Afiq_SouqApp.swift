//
//  Afiq_SouqApp.swift
//  Afiq Souq
//
//  Created by GAMEKILLER on 2/15/21.
//

import SwiftUI
import Firebase
import OneSignal

@main
struct Afiq_SouqApp: App {
    @UIApplicationDelegateAdaptor(AppDelegate.self) var delegate
    var body: some Scene {
        WindowGroup {
            
            MainUIView()
            //LoginUIView()
            //GalleryUIView()
            // RegisterUIView()
            //PhoneVerfication()
            //DashBoardUIView()
            //ProductDetailsUIView()
            //ProductListUIView()
            //OldOrderListUIView()
        }
    }
    
    
    class  AppDelegate : NSObject  , UIApplicationDelegate {
        func application(_ application: UIApplication , didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
            FirebaseApp.configure()
            
            // Remove this method to stop OneSignal Debugging
            //  OneSignal.setLogLevel(.LL_VERBOSE, visualLevel: .LL_NONE)

              // OneSignal initialization
              OneSignal.initWithLaunchOptions(launchOptions)
              OneSignal.setAppId("2bdd4d9e-42b0-45d2-987a-c534090cab29")

              // promptForPushNotifications will show the native iOS notification permission prompt.
              // We recommend removing the following code and instead using an In-App Message to prompt for notification permission (See step 8)
              OneSignal.promptForPushNotifications(userResponse: { accepted in
                print("User accepted notifications: \(accepted)")
              })
            
            
            return true
        }
        func application(_ application: UIApplication, didReceiveRemoteNotification userInfo: [AnyHashable : Any], fetchCompletionHandler completionHandler: @escaping (UIBackgroundFetchResult) -> Void) {
            
        }
        
        
    }
    
}
