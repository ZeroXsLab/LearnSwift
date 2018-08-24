//
//  ConcentrationThemeChooserViewController.swift
//  Concentration
//
//  Created by Xhandsome on 2018/8/11.
//  Copyright © 2018年 Xhandsome. All rights reserved.
//

import UIKit

class ConcentrationThemeChooserViewController: VCLLoggingViewController, UISplitViewControllerDelegate {

    override var vclLoggingName: String {
        return "ThemeChooser"
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    struct Theme {
        var themeName = ""
        var themeContent=[""]
    }
    var themeDict:[Int:Theme] = [0:Theme(themeName: "Expression", themeContent: ["😀","😆","☺️","😅","😂","🤣","😇","😍","😝"]),                            1:Theme(themeName: "Animal", themeContent: ["🐶","🐱","🐭","🐹","🐰","🦊","🐻","🐼","🐨"]),2:Theme(themeName: "Food", themeContent: ["🍏","🍊","🍋","🍌","🍉","🍇","🍓","🍈","🥝"])]

    override func awakeFromNib() {
        super.awakeFromNib()
        splitViewController?.delegate = self
    }
    
    func splitViewController(
        _ splitViewController: UISplitViewController,
        collapseSecondary secondaryViewController: UIViewController,
        onto primaryViewController: UIViewController
    ) -> Bool {
        if let cvc = secondaryViewController as? ConcentrationViewController {
            if cvc.theme == nil {
                return true
            }
        }
        return false
    }
    
    @IBAction func changeTheme(_ sender: Any) {
//        var successFlag = false
        if let cvc = splitViewDetailConcentrationViewController {   // find theme from splitView
            if let themeName = (sender as? UIButton)?.currentTitle {
                var theme: [String] = [""]
                for item in themeDict {
                    if item.value.themeName == themeName {
                        theme = item.value.themeContent
//                        successFlag = true
                        cvc.theme = theme
                        
                    }
                }
            }
        } else if let cvc = lastSeguedToConcentrationViewController{
            if let themeName = (sender as? UIButton)?.currentTitle {
                var theme: [String] = [""]
                for item in themeDict {
                    if item.value.themeName == themeName {
                        theme = item.value.themeContent
                        //                        successFlag = true
                        cvc.theme = theme
                        
                    }
                }
            }
            navigationController?.pushViewController(cvc, animated: true)   //push theme to navigation stack without segue
        }
        else {
//            if !successFlag {
                performSegue(withIdentifier: "Choose Theme", sender: sender) // make the food button segue by code
//            }
        }
    }
    
    private var splitViewDetailConcentrationViewController: ConcentrationViewController? {
        return splitViewController?.viewControllers.last as? ConcentrationViewController
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */
    
    private var lastSeguedToConcentrationViewController: ConcentrationViewController?

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "Choose Theme" {
            if let button = sender as? UIButton {
                if let themeName = button.currentTitle {
                    var theme: [String] = [""]
                    for item in themeDict {
                        if item.value.themeName == themeName {
                            theme = item.value.themeContent
                            // "Choose Theme" Segue && Got the themeContent which belong to themeName(button's current title)
                            if let cvc = segue.destination as? ConcentrationViewController {
                                cvc.theme = theme
                                lastSeguedToConcentrationViewController = cvc
                                break
                            }
                        }
                    }
                }
            }
        }
    }
}
