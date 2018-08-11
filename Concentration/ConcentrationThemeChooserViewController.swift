//
//  ConcentrationThemeChooserViewController.swift
//  Concentration
//
//  Created by Xhandsome on 2018/8/11.
//  Copyright © 2018年 Xhandsome. All rights reserved.
//

import UIKit

class ConcentrationThemeChooserViewController: UIViewController {

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
//    let themes = ["Expression":"😀😆☺️😅😂🤣😇😍😝",
//        "Animal":"🐶🐱🐭🐹🐰🦊🐻🐼🐨",
//        "Food":"🍏🍊🍋🍌🍉🍇🍓🍈🥝"]

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "Choose Theme" {
            if let button = sender as? UIButton {
                if let themeName = button.currentTitle {
                    var theme: [String] = [""]
                    for item in themeDict {
                        if item.value.themeName == themeName {
                            theme = item.value.themeContent
                            break
                        }
                    }
                    if let cvc = segue.destination as? ConcentrationViewController {
                        cvc.theme = theme
                    }
                }
            }
        }
    }
    
}
