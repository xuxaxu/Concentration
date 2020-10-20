//
//  ConcentrationThemeChooserViewController.swift
//  Concentration
//
//  Created by Ксения Каштанкина on 30.03.2020.
//  Copyright © 2020 Ксения Каштанкина. All rights reserved.
//

import UIKit

class ConcentrationThemeChooserViewController: UIViewController, UISplitViewControllerDelegate {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    var themes = ["Sports" : "⚽️🏀🥎🏸🥅🏹🥊🤿🥋🛹⛸🤸🏼‍♀️🏋🏾‍♂️🤺🧘🏻‍♂️🏄🏽‍♂️🚴🏻🎳🎮",
        "Faces" : "😍🤪🤬🤥🤢💀👽👧🏽👮🏻👨🏼‍💻👩🏾‍🚀🦹‍♀️🎅🏻🧝‍♀️🤷🏿‍♂️🧟‍♀️👼🏻🤦‍♂️👩‍❤️‍💋‍👩👩‍👩‍👧‍👧",
        "Animals" : "🐶🐱🐭🦊🐼🐻🐨🐸🐽🐷🐵🐒🐔🦆🦇🦄🐛🐝🐌🐙🦑🦀🐡🦐🐬🐳🦧🦒🐫🐖🦚🦜🦩🦢🦨🦦🦔🐾🐲"]
    
    // MARK: - Navigation

    override func awakeFromNib() {
        splitViewController?.delegate = self
    }
    
    func splitViewController(_ splitViewController: UISplitViewController, collapseSecondary secondaryViewController: UIViewController, onto primaryViewController: UIViewController) -> Bool {
        if let cvc = secondaryViewController as? ConcentrationViewController, cvc.theme == nil {
            return true
        }
        else { return false }
    }
    
    @IBAction func ChangeTheme(_ sender: Any) {
        if let cvc = splitConcentrationDetailViewController {
            if let themeName = (sender as? UIButton)?.currentTitle, let theme = themes[themeName] {
                cvc.theme = theme
            }
        } else if let cvc = lastSeguedToConcentrationViewController {
            if let themeName = (sender as? UIButton)?.currentTitle, let theme = themes[themeName] {
                cvc.theme = theme
            }
            navigationController?.pushViewController(cvc, animated: true)
        }
        else {
            performSegue(withIdentifier: "Choose Theme", sender: sender)
        }
    }
    
    private var splitConcentrationDetailViewController: ConcentrationViewController? {
        return splitViewController?.viewControllers.last as? ConcentrationViewController
    }
    
    private var lastSeguedToConcentrationViewController : ConcentrationViewController?
    
    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "Choose Theme" {
            if let themeName = (sender as? UIButton)?.currentTitle, let theme = themes[themeName] {
                if let cvc = segue.destination as? ConcentrationViewController {
                    cvc.theme = theme
                    lastSeguedToConcentrationViewController = cvc
                }
            }
        }
    }
    

}
