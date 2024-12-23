//
//  ShieldActionExtension.swift
//  Shield Action Extension
//
//  Created on 29/05/24.
//
//

import DeviceActivity
import Foundation
import ManagedSettings
import os.log

private let logger = Logger(subsystemName: "ShieldActionExtension", category: "ShieldActionDelegate")

// Override the functions below to customize the shield actions used in various situations.
// The system provides a default response for any functions that your subclass doesn't override.
// Make sure that your class name matches the NSExtensionPrincipalClass in your Info.plist.
class ShieldActionExtension: ShieldActionDelegate {
    let store = ManagedSettingsStore.shared
    
    override func handle(action: ShieldAction, for application: ApplicationToken, completionHandler: @escaping (ShieldActionResponse) -> Void) {
        print("In ShieldActionExtension")
        // Handle the action as needed.
        switch action {
        case .primaryButtonPressed:
            logger.debug( "Removed app from shielded applications (1)")
            store.shield.applications?.remove(application)
            completionHandler(.none)
        case .secondaryButtonPressed:
            logger.debug( "Did not remove app from shielded applications (1)")
            completionHandler(.close)

        @unknown default:
            fatalError()
        }
    }
    
    override func handle(action: ShieldAction, for webDomain: WebDomainToken, completionHandler: @escaping (ShieldActionResponse) -> Void) {
        // Handle the action as needed.
        completionHandler(.close)
    }
    
    override func handle(action: ShieldAction, for category: ActivityCategoryToken, completionHandler: @escaping (ShieldActionResponse) -> Void) {
        // Handle the action as needed.
        switch action {
        case .primaryButtonPressed:
            logger.debug( "Removed app from shielded applications (2)")

            store.shield.applicationCategories = nil
            completionHandler(.none)
        case .secondaryButtonPressed:
            logger.debug( "Removed app from shielded applications (2)")

            completionHandler(.close)
        @unknown default:
            fatalError()
        }
    }
}
