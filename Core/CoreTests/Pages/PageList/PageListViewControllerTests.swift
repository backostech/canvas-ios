//
// This file is part of Canvas.
// Copyright (C) 2019-present  Instructure, Inc.
//
// This program is free software: you can redistribute it and/or modify
// it under the terms of the GNU Affero General Public License as
// published by the Free Software Foundation, either version 3 of the
// License, or (at your option) any later version.
//
// This program is distributed in the hope that it will be useful,
// but WITHOUT ANY WARRANTY; without even the implied warranty of
// MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
// GNU Affero General Public License for more details.
//
// You should have received a copy of the GNU Affero General Public License
// along with this program.  If not, see <https://www.gnu.org/licenses/>.
//

import XCTest
@testable import Core

class PageListViewControllerTests: CoreTestCase {
    var viewController: PageListViewController!
    let context = ContextModel(.course, id: "1")

    override func setUp() {
        super.setUp()
        viewController = PageListViewController.create(env: environment, context: context, appTraitCollection: nil, app: .student)
    }

    func testItAddsThePlusButtonInTeacherApp() {
        viewController = PageListViewController.create(env: environment, context: context, appTraitCollection: nil, app: .teacher)
        viewController.update(isLoading: false)
        XCTAssertEqual(viewController.navigationItem.rightBarButtonItems?.count, 1)
    }

    func testItDoesNotAddThePlusButtonInStudentCourse() {
        viewController = PageListViewController.create(env: environment, context: context, appTraitCollection: nil, app: .student)
        viewController.update(isLoading: false)
        XCTAssertNil(viewController.navigationItem.rightBarButtonItems)
    }

    func testItDoesAddThePlusButtonInStudentGroup() {
        viewController = PageListViewController.create(env: environment, context: ContextModel(.group, id: "1"), appTraitCollection: nil, app: .student)
        viewController.update(isLoading: false)
        XCTAssertEqual(viewController.navigationItem.rightBarButtonItems?.count, 1)
    }
}
