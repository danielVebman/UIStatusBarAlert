//
//  UIStatusBarAlert.swift
//  UIStatusBarAlert
//
//  Created by Daniel Vebman on 8/20/17.
//  Copyright © 2017 Daniel Vebman. All rights reserved.
//

import Foundation
import UIKit

final class UIStatusBarAlert {
    static var shared = UIStatusBarAlert()
    
    private var window: UIWindow!
    private var alertViewController: AlertViewController!
    
    private init() {
        let size = CGSize(width: UIScreen.main.bounds.width, height: UIApplication.shared.statusBarFrame.height)
        window = UIWindow(frame: CGRect(origin: CGPoint.zero, size: size))
        window.windowLevel = UIWindowLevelStatusBar + 1
        alertViewController = AlertViewController()
        window.rootViewController = alertViewController
    }
    
    var size: CGSize { return window.frame.size }
    
    var isHidden: Bool {
        get {
            return window.isHidden
        }
        set(bool) {
            window.isHidden = bool
        }
    }
    
    func setConfiguration(_ configuration: Configuration) {
        alertViewController.titleLabel.text = configuration.title
        alertViewController.titleLabel.textColor = configuration.tintColor
        alertViewController.titleLabel.font = configuration.font
        alertViewController.view.backgroundColor = configuration.backgroundColor
    }
    
    func setHidden(_ hidden: Bool, with animation: UIStatusBarAnimation) {
        let duration = TimeInterval(UINavigationControllerHideShowBarDuration)
        if hidden {
            hideStatusBar(animation: animation, animationDuration: duration)
        } else {
            showStatusBar(animation: animation, animationDuration: duration)
        }
    }
    
    func show(for duration: TimeInterval, with animation: UIStatusBarAnimation) {
        setHidden(false, with: animation)
        Timer.scheduledTimer(withTimeInterval: duration, repeats: false) { (timer) in
            self.setHidden(true, with: animation)
        }
    }
    
    private func hideStatusBar(animation: UIStatusBarAnimation, animationDuration: TimeInterval) {
        switch animation {
        case .fade:
            UIView.animate(withDuration: animationDuration, animations: {
                self.window.alpha = 0
            }, completion: { (Bool) in
                self.isHidden = true
            })
        case .slide:
            UIView.animate(withDuration: animationDuration, animations: {
                self.window.frame.origin.y = -self.window.frame.height
            }, completion: { (Bool) in
                self.isHidden = true
            })
        case .none:
            self.isHidden = true
        }
    }
    
    private func showStatusBar(animation: UIStatusBarAnimation, animationDuration: TimeInterval) {
        switch animation {
        case .fade:
            if isHidden {
                window.alpha = 0
                window.isHidden = false
                window.frame.origin.y = 0
            }
            UIView.animate(withDuration: animationDuration, animations: {
                self.window.alpha = 1
            })
        case .slide:
            if isHidden {
                window.alpha = 1
                window.isHidden = false
                window.frame.origin.y = -window.frame.height
            }
            UIView.animate(withDuration: animationDuration, animations: {
                self.window.frame.origin.y = 0
            })
        case .none:
            window.alpha = 1
            isHidden = false
            window.frame.origin.y = 0
        }
    }
    
    private class AlertViewController: UIViewController {
        var titleLabel = UILabel()
        override func viewDidLoad() {
            titleLabel.frame = CGRect(origin: CGPoint.zero, size: UIStatusBarAlert.shared.size)
            titleLabel.textAlignment = .center
            view.addSubview(titleLabel)
        }
    }
    
    public class Configuration {
        var title = ""
        var tintColor = UIColor.black
        var backgroundColor = UIColor.white
        var font = UIFont.systemFont(ofSize: 15)
    }
}
