//
//  ViewController.swift
//  Concurrency-IMG
//
//  Created by vietanh on 1/17/18.
//  Copyright © 2018 vietanh. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.splitViewController?.delegate = self
    }

    // MARK: Navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Giá trị đầu vào của func NASAImageNamed là tên của Show Detail segue "..."
        if let url = DemoURL.NASAImageNamed(imageName: segue.identifier) {
            if let imageVC = segue.destination.contentViewController as? IMGViewController {
                imageVC.imageURL = url
                imageVC.title = segue.identifier
            }
        }
    }
}
// Đảm bảo rằng sẽ truy cập đến màn phía sau NavigationController
extension UIViewController {
    var contentViewController: UIViewController {
        if let navContentVC = self as? UINavigationController {
            return navContentVC.visibleViewController!
        } else {
            return self
        }
    }
}
// Hiển thị màn Master đầu tiên
extension ViewController: UISplitViewControllerDelegate {
    func splitViewController(_ splitViewController: UISplitViewController, collapseSecondary secondaryViewController: UIViewController, onto primaryViewController: UIViewController) -> Bool {
        if primaryViewController.contentViewController == self {
            if let ivc = secondaryViewController.contentViewController as? IMGViewController,
                ivc.imageURL == nil {
                return true
            }
        }
        return false
    }
}

