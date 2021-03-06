//
//  ViewController.swift
//  Timezones
//
//  Created by Francisco Amado on 13/06/2018.
//  Copyright © 2018 franciscoamado. All rights reserved.
//

import Cocoa
import ReSwift

class MainViewController: NSViewController {

    @IBOutlet weak var startAtLoginButton: NSButton!
    
    var store: AppStore?

    var selectionViewController: TimezoneSelectionViewController? {

        return children.compactMap { $0 as? TimezoneSelectionViewController }.first
    }

    override func viewDidLoad() {

        super.viewDidLoad()
    }

    override func viewWillAppear() {

        super.viewWillAppear()
        store?.subscribe(self)
    }

    override func viewWillDisappear() {

        super.viewWillDisappear()
        store?.unsubscribe(self)
    }

    override var representedObject: Any? {
        didSet {
        // Update the view, if already loaded.
        }
    }
}

// MARK: - Configuration
extension MainViewController {

    fileprivate func configureStartAtLoginButton(with value: Bool? = nil) {

        if let value = value {

            startAtLoginButton.state = value ? .on : .off
        }
    }
}

// MARK: - Actions
extension MainViewController {

    @IBAction func didPressQuit(_ sender: Any) {

        NSApplication.shared.terminate(sender)
    }

    @IBAction func didSelectStartAtLogin(_ sender: Any) {

        guard let button = sender as? NSButton else {

            assertionFailure("didSelectStartAtLogin sender isn't a NSButton")
            return
        }

        store?.dispatch(AppAction.launchAtLogin(option: button.state == .on))
    }
}

extension MainViewController: StoreSubscriber {

    func newState(state: AppState) {

        configureStartAtLoginButton(with: store?.state.startAtLogin)

        selectionViewController?.store = store
    }
}

