//
//  ToDoBySwiftUIApp.swift
//  ToDoBySwiftUI
//
//  Created by 李佳林 on 2021/8/29.
//

import SwiftUI

//let quickActionSettings = QuickActionSettings()
//var shortcutItemToProcess: UIApplicationShortcutItem?

@main
struct ToDoBySwiftUIApp: App {
//    @Environment(\.scenePhase) var phase
 //   @UIApplicationDelegateAdaptor(AppDelegate.self) var appDelegate
    
    var body: some Scene {
        
        WindowGroup {
            ToDoView()
                .environmentObject(ToDoStore())
                .environmentObject(TeamStore())
                .environmentObject(BookStore())
                .environmentObject(MessageStore())
                .environmentObject(UserStore())
                .environmentObject(UIStateModel())
                .environmentObject(UserData())
             //   .environmentObject(quickActionSettings)
        }
  /*      .onChange(of: phase) { (newPhase) in
            switch newPhase {
            case.active :
                print("App is active")
                guard let name = shortcutItemToProcess?.userInfo?["name"] as? String else {
                    return
                }
                switch name {
                case "待办DDL":
                    print("待办DDL is selected")
                    quickActionSettings.quickAction = .details(name: name)
                case "团队":
                    print("团队 is selected")
                    quickActionSettings.quickAction = .details(name: name)
                case "备忘录":
                    print("备忘录 is selected")
                    quickActionSettings.quickAction = .details(name: name)
                case "消息":
                    print("消息 is selected")
                    quickActionSettings.quickAction = .details(name: name)
                default:
                    print("default ")
                }
            case.inactive:
                print("App is inactive")
            case.background:
                print("App in background")
                addQuickActions()
            @unknown default:
                print("defult")
            }
            
        }  */
        
    }
/*    @available (iOSApplicationExtension, unavailable)
    func addQuickActions() {
        var DDLInfo: [String: NSSecureCoding] {
            return ["name" : "待办DDL" as NSSecureCoding]
        }
        var teamInfo: [String: NSSecureCoding] {
            return ["name" : "团队" as NSSecureCoding]
        }
        var bookInfo: [String: NSSecureCoding] {
            return ["name" : "备忘录" as NSSecureCoding]
        }
        var messageInfo: [String: NSSecureCoding] {
            return ["name" : "消息" as NSSecureCoding]
        }
 /*       UIApplication.shared.shortcutItems = [
            UIApplicationShortcutItem(type: "待办DDL", localizedTitle: "你的待办", localizedSubtitle: "", icon: UIApplicationShortcutIcon(type: .task), userInfo: DDLInfo),
            UIApplicationShortcutItem(type: "团队", localizedTitle: "团队", localizedSubtitle: "", icon: UIApplicationShortcutIcon(type: .cloud), userInfo: teamInfo),
            UIApplicationShortcutItem(type: "备忘录", localizedTitle: "备忘录", localizedSubtitle: "", icon: UIApplicationShortcutIcon(type: .bookmark), userInfo: bookInfo),
            UIApplicationShortcutItem(type: "消息", localizedTitle: "消息", localizedSubtitle: "", icon: UIApplicationShortcutIcon(type: .message), userInfo: messageInfo)
        ]   */
    }   */
    
}


/*class AppDelegate: NSObject, UIApplicationDelegate {
    func application(_ application: UIApplication, configurationForConnecting connectingSceneSession: UISceneSession, options: UIScene.ConnectionOptions) -> UISceneConfiguration {
        if let shortcutItem = options.shortcutItem {
            shortcutItemToProcess = shortcutItem
        }
        
        let sceneConfiguration = UISceneConfiguration(name: "Custom Configuration", sessionRole: connectingSceneSession.role)
        sceneConfiguration.delegateClass = CustomSceneDelegate.self
        
        return sceneConfiguration
    }
}

class CustomSceneDelegate: UIResponder, UIWindowSceneDelegate {
    func windowScene(_ windowScene: UIWindowScene, performActionFor shortcutItem: UIApplicationShortcutItem, completionHandler: @escaping (Bool) -> Void) {
        shortcutItemToProcess = shortcutItem
    }
}     */


