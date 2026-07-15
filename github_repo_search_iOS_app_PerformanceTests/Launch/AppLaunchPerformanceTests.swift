//
//  AppLaunchPerformanceTests.swift
//  PerformanceTests
//
//  Performance tests for app launch metrics
//

import XCTest

/// Performance Tests - measuring speed, memory, and CPU usage
/// These tests establish baselines and fail if performance regresses
final class AppLaunchPerformanceTests: XCTestCase {

    override func setUpWithError() throws {
    }

    override func tearDownWithError() throws {
    }

    // MARK: - Launch Performance

    func testAppLaunchPerformance() throws {
        // Measures how long it takes to launch the app (MIGRATED FROM OLD STRUCTURE)

        if #available(macOS 10.15, iOS 13.0, tvOS 13.0, *) {
            measure(metrics: [XCTApplicationLaunchMetric()]) {
                XCUIApplication().launch()
            }
        }

        // This test runs 5 iterations and calculates:
        // - Average launch time
        // - Standard deviation
        // - Fails if regression > 10%
    }

    func testAppLaunchMemory() throws {
        // Measure memory footprint during launch

        if #available(iOS 13.0, *) {
            let app = XCUIApplication()

            measure(metrics: [XCTMemoryMetric()]) {
                app.launch()
                app.terminate()
            }
        }
    }

    func testAppLaunchCPU() throws {
        // Measure CPU usage during launch

        if #available(iOS 13.0, *) {
            let app = XCUIApplication()

            measure(metrics: [XCTCPUMetric()]) {
                app.launch()
                // Let app settle
                sleep(2)
                app.terminate()
            }
        }
    }

    // MARK: - Cold Start vs Warm Start

    func testColdStartPerformance() throws {
        // Test completely cold start (first launch)

        if #available(iOS 13.0, *) {
            let app = XCUIApplication()

            measure(metrics: [XCTClockMetric()]) {
                app.launch()
                // Wait for app to fully load
                _ = app.navigationBars.firstMatch.waitForExistence(timeout: 10)
                app.terminate()
            }
        }
    }

    func testWarmStartPerformance() throws {
        // Test warm start (app was recently closed)

        if #available(iOS 13.0, *) {
            let app = XCUIApplication()

            // Prime the app first
            app.launch()
            app.terminate()

            // Now measure warm start
            measure(metrics: [XCTClockMetric()]) {
                app.launch()
                _ = app.navigationBars.firstMatch.waitForExistence(timeout: 10)
                app.terminate()
            }
        }
    }

    // MARK: - Splash Screen Performance

    func testSplashScreenDuration() throws {
        // Measure how long splash screen takes

        let app = XCUIApplication()
        app.launch()

        let startTime = Date()

        // Wait for splash to finish and home screen to appear
        let homeNavBar = app.navigationBars["GitHub Search"]
        _ = homeNavBar.waitForExistence(timeout: 10)

        let splashDuration = Date().timeIntervalSince(startTime)

        print("✅ Splash screen duration: \(splashDuration)s")

        // Assert splash is not too long (should be around 3 seconds)
        XCTAssertLessThan(splashDuration, 5.0,
                         "Splash screen should complete within 5 seconds")
        XCTAssertGreaterThan(splashDuration, 2.0,
                            "Splash screen should show for at least 2 seconds")
    }
}
