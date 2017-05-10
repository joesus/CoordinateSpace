//
//  UIViewExtensionsTests.swift
//  CoordinateSpace
//
//  Created by Joesus on 5/10/17.
//  Copyright © 2017 Joesus. All rights reserved.
//

@testable import CoordinateSpace
import XCTest

class UIViewExtensionsTests: XCTestCase {

    func testPositionInViewWithNoSuperview() {
        let frameForMainView = CGRect(x: 0, y: 0, width: 400, height: 700)
        let frameForSubView = CGRect(x: 10, y: 10, width: 50, height: 50)

        let mainView = UIView(frame: frameForMainView)
        let subView = UIView(frame: frameForSubView)

        mainView.addSubview(subView)

        XCTAssertEqual(subView.positionIn(view: mainView), frameForSubView,
                       "Subview's position in mainView should be unchanged")
    }

    func testPositionInViewWithSuperview() {
        let frameForMainView = CGRect(x: 0, y: 0, width: 400, height: 700)
        let frameForSubView = CGRect(x: 10, y: 10, width: 50, height: 50)
        let frameForContainerView = CGRect(x: 50, y: 50, width: 200, height: 200)

        let mainView = UIView(frame: frameForMainView)
        let containerView = UIView(frame: frameForContainerView)
        let subView = UIView(frame: frameForSubView)

        mainView.addSubview(containerView) // adds the container view to the main view
        containerView.addSubview(subView) // adds the subview to the container

        XCTAssertEqual(subView.frame, frameForSubView,
                       "Subview should maintain frame after being added to container view")
        XCTAssertEqual(subView.positionIn(view: containerView), frameForSubView,
                       "Subview's position in container view should be it's original frame")
        XCTAssertEqual(subView.positionIn(view: mainView), CGRect(x: 60, y: 60, width: 50, height: 50),
                       "Subview's position in mainView should adjust for position of container view")
    }
}
