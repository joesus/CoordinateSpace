//
//  ViewController.swift
//  CoordinateSpace
//
//  Created by Joesus on 5/9/17.
//  Copyright © 2017 Joesus. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UINavigationControllerDelegate {
    var animator = TransitionAnimator()
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        guard let navController = navigationController else {
            fatalError()
        }
        
        navController.delegate = self
    }
    
    func navigationController(_ navigationController: UINavigationController, animationControllerFor operation: UINavigationControllerOperation, from fromVC: UIViewController, to toVC: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        if operation == .pop {
            
            if let toVC = toVC as? ViewController,
                let toImageView = toVC.imageViewForSelectedCell(),
                let fromVC = fromVC as? DetailViewController {
                
                animator.toAvatarView = toImageView
                animator.fromAvatarView = fromVC.imageView
            }
        }
        
        return animator
    }
    
    func navigationController(_ navigationController: UINavigationController, willShow viewController: UIViewController, animated: Bool) {
        if let detailVC = viewController as? DetailViewController,
            let imageView = detailVC.imageView,
            let fromImageView = imageViewForSelectedCell() {
            animator.fromAvatarView = fromImageView
            animator.toAvatarView = imageView
        }
    }
    
    func imageViewForSelectedCell() -> UIImageView? {
        if let indexPath = tableView.indexPathForSelectedRow,
            let cell = tableView.cellForRow(at: indexPath),
            let imageView = cell.imageView {
            return imageView
        }
        return nil
    }
}

extension ViewController: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 5
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        return tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
    }
}

extension UIView {
    func positionIn(view: UIView) -> CGRect {
        if let superview = superview {
            return superview.convert(frame, to: view)
        }
        return frame
    }
}
