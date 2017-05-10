//
//  ViewController.swift
//  CoordinateSpace
//
//  Created by Joesus on 5/9/17.
//  Copyright © 2017 Joesus. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var secondImageView: UIImageView!

    @IBAction func swapImages(_ sender: Any) {
        guard let imageViewCopy = imageView.snapshotView(afterScreenUpdates: true) else {
                fatalError("Oh no!")
        }

        imageViewCopy.frame = imageView.positionIn(view: view)

        view.addSubview(imageViewCopy)
        imageView.isHidden = true

        UIView.animate(withDuration: 2.0, animations: {
            imageViewCopy.frame = self.secondImageView.frame
        }) { [weak self] completed in
            self?.secondImageView.image = self?.imageView.image // set the image
            self?.secondImageView.isHidden = false
            imageViewCopy.removeFromSuperview()
        }
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
