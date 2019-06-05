//
//  ViewController.swift
//  Project1
//
//  Created by Andy Lochan on 2/8/19.
//  Copyright © 2019 Andy Lochan. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    var dispNum : Double = 0;
    var prevNum : Double = 0;
    var calculating = false;
    var opHolder = 0; //Math operation to perform
    var isDecimal = false; //Stops multiple decimal points
    var opRepeat = false; //Stops multiple operator inputs
    
    @IBOutlet weak var label: UILabel!
    
    @IBAction func numbers(_ sender: UIButton) {
        if calculating == true
        {
            label.text = String(sender.tag-1)
            dispNum = Double(label.text!)!
            calculating = false;
        }
        else
        {
            label.text = label.text! + String(sender.tag-1)
            dispNum = Double(label.text!)!
        }
    }
    //******* Implement Decimal ***********
    @IBAction func Decimal(_ sender: UIButton) {
        if isDecimal == false
        {
            if label.text == "" || label.text == "+" || label.text == "-" || label.text == "/" || label.text == "x" || label.text == "%" || label.text == "Neg()" || label.text == "Mod()"
            {
                label.text = ""
                label.text = "0." + label.text!;
                isDecimal = true;
            }
            else
            {
                label.text = label.text! + ".";
                isDecimal = true;
            }
        }
        else
        {
            //if true, then don't add a 2nd decimal
        }
    }
    
    @IBAction func op(_ sender: UIButton) {
        if label.text != "" && sender.tag != 11 && sender.tag != 16 && opRepeat == false && label.text != "Undefined"
        { // 11:C 12:/ 13:* 14:- 15:+ 16:= 17:. 18:+/- 19:percent 20:[modulo]
            prevNum = Double(label.text!)!
            
            switch sender.tag
            {
            case 12:
                label.text = "/";
            case 13:
                label.text = "x";
            case 14:
                label.text = "-";
            case 15:
                label.text = "+";
            case 18:
                label.text = "Neg()"
            case 19:
                label.text = "%";
            case 20:
                label.text = "Mod()"
            default:
                break;
            }
            opHolder = sender.tag;
            calculating = true;
            isDecimal = false;
            opRepeat = true;
        }
        else if sender.tag == 16 //equal button
        {
            switch opHolder
            {
            case 12:
                if (dispNum == 0){
                    label.text = "Undefined"
                } else {
                 label.text = String(prevNum / dispNum)
                }
            case 13:
                 label.text = String(prevNum * dispNum)
            case 14:
                 label.text = String(prevNum - dispNum)
            case 15:
                 label.text = String(prevNum + dispNum)
            case 18:
                 label.text = String(prevNum *   -1   )
            case 19:
                 label.text = String(prevNum * (dispNum / 100))
            case 20: //Modulo
                 label.text = String(abs(prevNum.remainder(dividingBy: dispNum)))
            default:
                 break;
            }
            calculating = true; //auto clears text field
            isDecimal = false;
            opRepeat = false;
        }
        else if sender.tag == 11
        {
            label.text = ""
            prevNum = 0; dispNum = 0; opHolder = 0;
            isDecimal = false;
            opRepeat = false;
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }


}

