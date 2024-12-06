//
//  LocatizationViewController.swift
//  Care4Senior
//
//  Created by Aneesha on 16/02/24.
//

import UIKit

class LocatizationViewController: UIViewController {

    //MARK: - Outlets
    
    @IBOutlet weak var lblSkip: UILabel!
    @IBOutlet weak var viewInnerMandarin: UIView!
    @IBOutlet weak var viewOuterMandarin: UIView!
    @IBOutlet weak var viewInnerEnglish: UIView!
    @IBOutlet weak var viewOuterEnglish: UIView!
    @IBOutlet weak var viewForLanguage: UIView!
    @IBOutlet weak var lblChoose: UILabel!
    @IBOutlet weak var lblGetStart: UILabel!
    
    //MARK: - Variables
    
    var strLocal = String()
    
    //MARK: - LifeCycles
   
    override func viewDidLoad() {
        super.viewDidLoad()
        
        strLocal = "en"
        let underlineAttribute = [NSAttributedString.Key.underlineStyle: NSUnderlineStyle.thick.rawValue]
        let underlineAttributedString = NSAttributedString(string: "Skip", attributes: underlineAttribute)
        lblSkip.attributedText = underlineAttributedString
        
    }
    
    //MARK: - Functions
    
    func dissableColor() {
        viewInnerEnglish.backgroundColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 0)
        viewOuterEnglish.layer.borderColor = #colorLiteral(red: 0.6666666865, green: 0.6666666865, blue: 0.6666666865, alpha: 1)
        viewInnerMandarin.backgroundColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 0)
        viewOuterMandarin.layer.borderColor = #colorLiteral(red: 0.6666666865, green: 0.6666666865, blue: 0.6666666865, alpha: 1)
    }
    
    func languageChange(strLang: String) {
        lblChoose.text = "ImM-dW-Yc3.text".localizableString(loc: strLang)
        lblGetStart.text = "fCb-AC-dXL.text".localizableString(loc: strLang)
        lblSkip.text = "2na-ts-C3z.text".localizableString(loc: strLang)
    }
    
    //MARK: - ButtonAction
    
    @IBAction func buttonChoose(_ sender: UIButton) {
        if sender.tag == 1 {
            viewForLanguage.roundCorners(corners: [.topLeft, .topRight], radius: 35.0)
            dissableColor()
            viewInnerEnglish.backgroundColor = #colorLiteral(red: 0.3921568627, green: 0.337254902, blue: 0.8392156863, alpha: 1)
            viewOuterEnglish.layer.borderColor = #colorLiteral(red: 0.3921568627, green: 0.337254902, blue: 0.8392156863, alpha: 1)
            languageChange(strLang: "en")
            strLocal = "en"
        }else if sender.tag == 2{
            viewForLanguage.roundCorners(corners: [.topLeft, .topRight], radius: 35.0)
            dissableColor()
            viewOuterMandarin.layer.borderColor = #colorLiteral(red: 0.3921568627, green: 0.337254902, blue: 0.8392156863, alpha: 1)
            viewInnerMandarin.backgroundColor = #colorLiteral(red: 0.3921568627, green: 0.337254902, blue: 0.8392156863, alpha: 1)
            languageChange(strLang: "zh-Hans")
            strLocal = "zh-Hans"
        }
    }
    
    @IBAction func buttonStart(_ sender: UIButton) {
        let vc = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "HomeViewController") as! HomeViewController
        vc.Strlocal = strLocal
        navigationController?.pushViewController(vc, animated: true)
    }
}

extension String {
    func localizableString(loc: String) -> String {
        let path = Bundle.main.path(forResource: loc, ofType: "lproj")
        let bundle = Bundle(path: path!)
        return NSLocalizedString(self, tableName: nil, bundle: bundle!, value: "",  comment: "")
    }
}
