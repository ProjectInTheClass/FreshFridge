//
//  DefaultNameViewController.swift
//  FreshFridge
//
//  Created by changae choi on 2021/01/17.
//

import UIKit

class DefaultNameViewController: UIViewController, UIScrollViewDelegate {
    
    lazy var scrollView: UIScrollView = {
           let scroll = UIScrollView()
           scroll.translatesAutoresizingMaskIntoConstraints = false
           scroll.delegate = self
           
           return scroll
       }()
    
    var selectedName = ""

    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.addSubview(scrollView)
        

        self.title = ""
        // Do any additional setup after loading the view.
    }
    
    override func viewDidLayoutSubviews() {
            super.viewDidLayoutSubviews()
            let layout = view.safeAreaLayoutGuide
            scrollView.centerXAnchor.constraint(equalTo: layout.centerXAnchor).isActive = true
            scrollView.centerYAnchor.constraint(equalTo: layout.centerYAnchor).isActive = true
            scrollView.widthAnchor.constraint(equalTo: layout.widthAnchor).isActive = true
            scrollView.heightAnchor.constraint(equalTo: layout.heightAnchor).isActive = true
        }
    
    override func viewWillAppear(_ animated: Bool) {
        
        
        
        //
        let marginHeight: CGFloat = navigationController?.navigationBar.frame.height ?? 0.0
        let spacing: CGFloat = 5.0
        
        let countOfRowButtons: Int = 4
        let viewWidth = view.frame.width
        
        let buttonWidth: CGFloat = 44.0//(viewWidth - 2 * spacing) / CGFloat(countOfRowButtons)
        let buttonHeight: CGFloat = 44.0
        let widthSpacing: CGFloat = ( viewWidth - buttonWidth * CGFloat(countOfRowButtons) ) / CGFloat(countOfRowButtons + 1)
        
        let labelWidth: CGFloat = 60.0//(viewWidth - 2 * spacing) / CGFloat(countOfRowButtons)
        let lableHeight: CGFloat = 44.0
        
        var x = 0, y = 0, index = 0
        let sorted = defaultNames.sorted(by: {$0.0 < $1.0}).sorted(by: {$0.1.description < $1.1.description})
        for (key,_) in sorted
        {
            x = index % 4
            y = index / 4
            let button = UIButton(frame: CGRect(x: CGFloat(x) * (buttonWidth+widthSpacing) + widthSpacing,
                                                y: CGFloat(y) * buttonHeight + CGFloat(y) * lableHeight + spacing + marginHeight,
                                                width: buttonWidth, height: buttonHeight))
            button.backgroundColor = .clear
            //button.contentEdgeInsets = UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)
            button.setTitle(key, for: .normal)
            button.setTitleColor(.clear, for: .normal)
            button.setImage(UIImage(named: key), for: .normal)
            button.imageView?.contentMode = .scaleAspectFill
            button.addTarget(self, action: #selector(buttonTapped(_:)), for: .touchUpInside)
            button.imageView?.layer.cornerRadius = 3
            button.imageView?.clipsToBounds = true
            //view.addSubview(button)
            scrollView.addSubview(button)
            
            let lableButton = UIButton(frame: CGRect(x: CGFloat(x) * (buttonWidth+widthSpacing) + widthSpacing - (labelWidth - buttonWidth) * 0.5,
                                                y: CGFloat(y) * buttonHeight + CGFloat(y) * lableHeight + buttonHeight + spacing + marginHeight,
                                                width: labelWidth, height: lableHeight))
            lableButton.backgroundColor = .clear
            lableButton.setTitle(key, for: .normal)
            lableButton.setTitleColor(.label, for: .normal)
            lableButton.contentVerticalAlignment = .top
            lableButton.contentHorizontalAlignment = .center
            lableButton.addTarget(self, action: #selector(buttonTapped(_:)), for: .touchUpInside)
            lableButton.titleLabel?.font = systemFont18
            lableButton.titleLabel?.numberOfLines = 0
            lableButton.titleLabel?.lineBreakMode = .byWordWrapping
            lableButton.titleLabel?.textAlignment = .center
            //view.addSubview(lableButton)
            scrollView.addSubview(lableButton)
            
            index += 1
        }

        scrollView.contentSize = CGSize(width: self.view.frame.size.width, height: (buttonHeight + lableHeight + spacing) * CGFloat(y + 1) + marginHeight)
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
