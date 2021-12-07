//
//  UIViewController+Extensions.swift
//  GuessTheMovie
//
//  Created by Ahmed Ramy on 07/12/2021.
//

import Foundation
import UIKit

public typealias AlertAction = (title: String, style: UIAlertAction.Style, action: () -> Void)

public extension UIViewController {
    func present(_ view: UIViewController, shouldBeFullScreen: Bool = true) {
        if shouldBeFullScreen {
            view.modalPresentationStyle = .fullScreen
        }
        present(view, animated: true, completion: nil)
    }

    func dismiss(_ afterDismiss: Callback<UIViewController?>? = nil) {
        dismiss(animated: true, completion: {
            afterDismiss?(UIApplication.shared.topMostViewController())
        })
    }

    func pop(animated: Bool) {
        _ = navigationController?.popViewController(animated: animated)
    }

    func popToRoot() {
        _ = navigationController?.popToRootViewController(animated: true)
    }

    func popTo(vc: BaseViewController.Type) {
        guard let targetVC = navigationController?.viewControllers.first(
            where: { type(of: $0) == vc }
        ) else {
            let assertionError = "Couldn't find TargetVC of type: \(type(of: vc)), this shouldn't happen in Production so please make sure everything is fine."
            assertionFailure(assertionError)
            LoggersManager.error(message: assertionError)
            navigationController?.pop(animated: true)
            return
        }
        _ = navigationController?.popToViewController(targetVC, animated: true)
    }

    func push(_ view: BaseViewController) {
        ((self as? UINavigationController) ?? self.navigationController)?
            .pushViewController(view, animated: true)
    }

    func alert(error: Error) {
        alert(title: "Error", message: error.localizedDescription, actions: [("Ok", .default)])
    }

    func alert(title: String, message: String, actions: [(title: String, style: UIAlertAction.Style)]) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        actions
            .map {
                UIAlertAction(title: $0.title, style: $0.style, handler: nil)
            }
            .forEach {
                alert.addAction($0)
            }
        present(alert, animated: true)
    }

    func alertWithAction(title: String?,
                         message: String?,
                         alertStyle: UIAlertController.Style,
                         tintColor: UIColor?,
                         actions: [AlertAction])
    {
        let alert = UIAlertController(title: title, message: message, preferredStyle: alertStyle)
        actions.map { action in
            UIAlertAction(title: action.title, style: action.style, handler: { _ in
                action.action()
            })
        }.forEach {
            alert.addAction($0)
        }

        if let tintColor = tintColor {
            alert.view.tintColor = tintColor
        }

        present(alert, animated: true)
    }

    func popOrDismiss() {
        if navigationController != nil {
            pop(animated: true)
        } else {
            dismiss(nil)
        }
    }

    func popToRootOrDismiss() {
        if navigationController != nil {
            popToRoot()
        } else {
            dismiss(nil)
        }
    }
}

extension UIApplication {
    func topMostViewController() -> UIViewController? {
        UIWindow.key?.rootViewController?.topMostViewController()
    }
}

extension UIWindow {
    static var key: UIWindow? {
        if #available(iOS 13, *) {
            return UIApplication.shared.windows.first { $0.isKeyWindow }
        } else {
            return UIApplication.shared.keyWindow
        }
    }
}

extension UIViewController {
    func topMostViewController() -> UIViewController? {
        if presentedViewController == nil {
            return self
        }
        if let navigation = presentedViewController as? UINavigationController {
            return navigation.visibleViewController?.topMostViewController()
        }
        if let tab = presentedViewController as? UITabBarController {
            if let selectedTab = tab.selectedViewController {
                return selectedTab.topMostViewController()
            }
            return tab.topMostViewController()
        }
        return presentedViewController?.topMostViewController()
    }
}
