//
// This file is part of Canvas.
// Copyright (C) 2023-present  Instructure, Inc.
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

import TestsFoundation

class HelpTests: E2ETestCase {
    func testHelpPage() {
        // MARK: Seed the usual stuff
        let student = seeder.createUser()
        let course = seeder.createCourse()
        seeder.enrollStudent(student, in: course)

        // MARK: Get the user logged in
        logInDSUser(student)
        let courseCard = DashboardHelper.courseCard(course: course).waitUntil(.visible)
        XCTAssertTrue(courseCard.isVisible)

        // MARK: Navigate to Help page
        HelpHelper.navigateToHelpPage()

        // MARK: Check "Search the Canvas Guides" button
        let searchTheCanvasGuidesButton = HelpHelper.searchTheCanvasGuides.waitUntil(.visible)
        XCTAssertTrue(searchTheCanvasGuidesButton.isVisible)
        searchTheCanvasGuidesButton.hit()
        var browserURL = SafariAppHelper.browserURL
        XCTAssertTrue(browserURL.contains("https://community.canvaslms.com/t5/Canvas-LMS/ct-p/canvaslms"))
        HelpHelper.returnToHelpPage()

        // MARK: Check "Ask Your Instructor a Question" button
        let askYourInstructorButton = HelpHelper.askYourInstructor.waitUntil(.visible)
        XCTAssertTrue(askYourInstructorButton.isVisible)

        askYourInstructorButton.hit()
        let newMessageLabel = app.find(label: "New Message").waitUntil(.visible)
        let cancelButton = app.find(label: "Cancel").waitUntil(.visible)
        XCTAssertTrue(newMessageLabel.isVisible)
        XCTAssertTrue(cancelButton.isVisible)

        // MARK: Check "Report a Problem" button
        cancelButton.hit()
        HelpHelper.navigateToHelpPage()
        let reportAProblemButton = HelpHelper.reportAProblem.waitUntil(.visible)
        XCTAssertTrue(reportAProblemButton.isVisible)

        reportAProblemButton.hit()
        cancelButton.waitUntil(.visible)
        let reportAProblemLabel = app.find(label: "Report a Problem").waitUntil(.visible)
        XCTAssertTrue(reportAProblemLabel.isVisible)
        XCTAssertTrue(cancelButton.isVisible)

        // MARK: Check "Submit a Feature Idea" button
        cancelButton.hit()
        HelpHelper.navigateToHelpPage()
        let submitAFeatureButton = HelpHelper.submitAFeatureIdea.waitUntil(.visible)
        XCTAssertTrue(submitAFeatureButton.isVisible)

        submitAFeatureButton.hit()
        browserURL = SafariAppHelper.browserURL
        XCTAssertTrue(browserURL.contains("https://community.canvaslms.com/t5/Canvas-Ideas-and-Themes/ct-p/canvas-ideas-themes"))

        // MARK: Check "COVID-19 Canvas Resources" button
        HelpHelper.returnToHelpPage()
        let covid19Button = HelpHelper.covid19.waitUntil(.visible)
        XCTAssertTrue(covid19Button.isVisible)

        covid19Button.hit()
        browserURL = SafariAppHelper.browserURL
        XCTAssertTrue(browserURL.contains("https://community.canvaslms.com/t5/Contingency-Resources/gh-p/contingency"))
    }
}
