//
//  UIStatusBarAlert.swift
//  UIStatusBarAlert
//
//  Created by Daniel Vebman on 8/20/17.
//  Copyright © 2017 Daniel Vebman. All rights reserved.
//

import Foundation
import UIKit

class UIStatusBarAlert {
    private var window: UIWindow!
    private var alertViewController: AlertViewController!
    
    init() {
        let size = CGSize(width: UIScreen.main.bounds.width, height: UIApplication.shared.statusBarFrame.height)
        window = UIWindow(frame: CGRect(origin: CGPoint.zero, size: size))
        window.windowLevel = UIWindowLevelStatusBar + 1
        alertViewController = AlertViewController()
        window.rootViewController = alertViewController
    }
    
    var size: CGSize { return window.frame.size }
    
    private var isHidden: Bool {
        get {
            return window.isHidden
        }
        set(bool) {
            window.isHidden = bool
        }
    }
    
    var title: String? {
        get { return alertViewController.titleLabel.text }
        set(text) { alertViewController.titleLabel.text = text }
    }
    
    var tintColor: UIColor {
        get { return alertViewController.titleLabel.textColor }
        set(color) { alertViewController.titleLabel.textColor = color }
    }
    
    var font: UIFont {
        get { return alertViewController.titleLabel.font }
        set(font) { alertViewController.titleLabel.font = font }
    }
    
    var backgroundColor: UIColor? {
        get { return alertViewController.view.backgroundColor }
        set(color) { alertViewController.view.backgroundColor = color }
    }
    
    func show(for duration: TimeInterval, with animation: UIStatusBarAnimation) {
        let animationDuration = TimeInterval(UINavigationControllerHideShowBarDuration)
        showStatusBar(animation: animation, animationDuration: animationDuration)
        Timer.scheduledTimer(withTimeInterval: duration, repeats: false) { (timer) in
            self.hideStatusBar(animation: animation, animationDuration: animationDuration)
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
            let size = CGSize(width: UIScreen.main.bounds.width, height: UIApplication.shared.statusBarFrame.height)
            titleLabel.frame = CGRect(origin: CGPoint.zero, size: size)
            titleLabel.textAlignment = .center
            view.addSubview(titleLabel)
        }
    }
}
