//
//  UIViewController+Extension.swift
//  Httper
//
//  Created by Meng Li on 2018/06/18.
//  Copyright © 2018 MuShare Group. All rights reserved.
//

import UIKit

extension UIViewController {

    var topPadding: CGFloat {
        return UIApplication.shared.statusBarFrame.height + (navigationController?.navigationBar.frame.height ?? 0)
    }
    
    var topPaddingFullScreen: CGFloat {
        let padding = UIApplication.shared.statusBarFrame.height
        return padding == 20 ? 0 : padding
    }
    
    var bottomPadding: CGFloat {
        var bottom: CGFloat = 0
        if #available(iOS 11.0, *) {
            if let window = UIApplication.shared.keyWindow {
                bottom += window.safeAreaInsets.bottom
            }
        }
        return bottom
    }
    
    func showTip(_ tip: String) {
        showAlert(title: R.string.localizable.tip_name(),
                  content: tip)
    }

    func showAlert(title: String, content: String) {
        DispatchQueue.main.async { [weak self] in
            let alertController = UIAlertController(title: title,
                                                    message: content,
                                                    preferredStyle: .alert)
            alertController.addAction(UIAlertAction.init(title: R.string.localizable.ok_name(), style: .cancel))
            self?.present(alertController, animated: true)
        }
        
    }

    func replaceBarButtonItemWithActivityIndicator() {
        let activityIndicatorView = UIActivityIndicatorView.init(frame: CGRect(x: 0, y: 0, width: 20, height: 20))
        activityIndicatorView.startAnimating()
        replaceBaeButtonItemWithView(view: activityIndicatorView)
    }

    func replaceBaeButtonItemWithView(view: UIView) {
        let barButton = UIBarButtonItem(customView: view)
        self.navigationItem.rightBarButtonItem = barButton
    }

}
