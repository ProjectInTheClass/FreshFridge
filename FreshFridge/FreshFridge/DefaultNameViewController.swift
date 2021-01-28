//
//  DefaultNameViewController.swift
//  FreshFridge
//
//  Created by changae choi on 2021/01/17.
//

import UIKit

class DefaultNameViewController: UIViewController {
    
    var selectedName = ""

    override func viewDidLoad() {
        super.viewDidLoad()

        self.title = ""
        // Do any additional setup after loading the view.
        let marginHeight: CGFloat = navigationController?.navigationBar.frame.height ?? 0.0
        let spacing: CGFloat = 5.0
        let countOfRowButtons: Int = 4
        let viewWidth = view.frame.width
        
        let buttonWidth: CGFloat = (viewWidth - 2 * spacing) / CGFloat(countOfRowButtons)
        let buttonHeight: CGFloat = 44.0
        var x = 0, y = 0, index = 0
        let sorted = defaultNames.sorted(by: {$0.0 < $1.0}).sorted(by: {$0.1.rawValue < $1.1.rawValue})
        for (key,_) in sorted
        {
            x = index % 4
            y = index / 4
            let button = UIButton(frame: CGRect(x: CGFloat(x) * buttonWidth + spacing,
                                                y: CGFloat(y) * buttonHeight + spacing + marginHeight,
                                                width: buttonWidth, height: buttonHeight))
            button.backgroundColor = .clear
            button.setTitle(key, for: .normal)
            button.setTitleColor(.label, for: .normal)
            button.addTarget(self, action: #selector(buttonTapped(_:)), for: .touchUpInside)
            button.titleLabel?.font = systemFont15
            
            view.addSubview(button)
            
            index += 1
        }
    }
    
    @IBAction func buttonTapped(_ sender: UIButton)
    {
        selectedName = sender.title(for: .normal) ?? ""
        performSegue(withIdentifier: "defaultNameSeque", sender: self)
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
