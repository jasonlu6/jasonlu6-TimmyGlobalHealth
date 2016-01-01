//
//  ViewController.swift
//  FundraisingTimmy
//  Global App Initiative, Boston University
//  Created by Jason Lu on 12/20/15.
//  Copyright © 2015 Jason Lu. All rights reserved.

// This file is used to determine the constraints on what type of values are allowed on the 
// FundraisingTimmy app when entering input in the text field

// This file also contains a progress view to manipulate the fundraising bar

// Attributions: modified example from this website: 
// http: www.globalnerdy.com/2015/04/27-how-to-program-an-ios-text-field-that-takes-only-numeric-input-or-
// specific-characters-with-a-maximum-length/

// Secondary attributions to Progress View:
// http://rshankar.com/swift-demo-add-progress-bar/


import UIKit

class ProgressViewController: UIViewController {
    
    // creating the progress view bar
    var progressView: UIProgressView?
    var progressLabel: UILabel?
    var timer: NSTimer?
    
    // MARK: animate the bar so that it moves 
    // Figure out what causing the bar to stop animating
    // UIProgressView *view = [[UIProgressView alloc] initWithProgressViewStyle:someStyle];
    // view setProgress:0.75f;
    
    // MARK: Outlets
    // Outlets that will allow the app to take in monetary, non-zero inputs for the user to donate (i.e. $3000)
    
    // ensure input is positive
    @IBOutlet weak var positiveIntegersOnlyTextField: UITextField!
    // ensure input is a number 
    @IBOutlet weak var digitsOnlyTextField: UITextField!
    // ensure input is not in scientific notation 
    @IBOutlet weak var numericOnlyTextField: UITextField!
    
    // MARK: Properties

    override func viewDidLoad() {
        super.viewDidLoad()
        // controlAdd()
        // gestures()
        // Do any additional setup after loading the view.
      //  initializeTextFields()
    }
    
    
    // MARK: Controls 
    // adds a label and creates a progress view control 
    func controlAdd() {
        // create the progressive view control 
        progressView = UIProgressView(progressViewStyle: UIProgressViewStyle.Default)
        progressView?.center = self.view.center
        view.addSubview(progressView!)
        
        // add the label for the view 
        progressLabel = UILabel()
        let frame = CGRectMake(view.center.x - 25, view.center.y - 100, 100, 50)
        progressLabel?.frame = frame
        view.addSubview(progressLabel!)
    }
    
        // add the gesture recognizers 
    func gestures() {
            // add single tap gestures
            let singleTap = UITapGestureRecognizer(target:self, action: "handleTap!")
            singleTap.numberOfTapsRequired = 1
            // add double tap gestures 
            let doubleTap = UITapGestureRecognizer(target:self, action: "handleDoubleTap!")
            doubleTap.numberOfTapsRequired = 2
            
            // monitoriing the gestures 
            view.addGestureRecognizer(singleTap)
            view.addGestureRecognizer(doubleTap)
            singleTap.requireGestureRecognizerToFail(doubleTap)
        }
        
        // start the progress view 
        func tapHandler(sender: UITapGestureRecognizer) {
            // the donations are almost complete
            if sender.state == .Ended {
                // let the user know that the donations amount is updated
                timer = NSTimer.scheduledTimerWithTimeInterval(30.0, target: self, selector: "updateProgress", userInfo: nil, repeats: true)
            }
        }
        
        // MARK: Double-Tap 
        // resets the progress view 
        func doubleTapHandler (sender: UITapGestureRecognizer) {
            if sender.state == .Ended {
                progressView?.progress = 0.0
                progressLabel?.text = "0 %"
                timer?.invalidate()
            }
        }
        
        // MARK: Increment the progress bar 
        func updateProgress() {
            progressView?.progress += 0.05
            let progressValue = self.progressView?.progress
            progressLabel?.text = "\(progressValue! * 100) %"
        }
        
    }
    /*
    // function that will designate class with text fields
    func initializeTextFields() {
        digitsOnlyTextField.delegate = self
        digitsOnlyTextField.keyboardType = UIKeyboardType.NumberPad
        
        numericOnlyTextField.delegate = self
        numericOnlyTextField.keyboardType = UIKeyboardType.NumbersAndPunctuation
        
        positiveIntegersOnlyTextField.delegate = self
        positiveIntegersOnlyTextField.keyboardType = UIKeyboardType.DecimalPad
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // tap outside to hide the keyboard 
    @IBAction func userTrappedBackground(sender: AnyObject) {
        view.endEditing(true)
    }

    // MARK: User Text Field, generally check if the user text input still fills in the constraints
    func textField (textField: UITextField, shouldChangeCharactersInRange range: NSRange, replacementString string: String) -> Bool {
        // case of no input
        if string.characters.count == 0 {
            return true
        }
        
        // check if the text follows constraint, if not, return false, 
        // and ask the user to change it
        // Variables:
        // currentText = the current text of the field 
        // nextText = user input
        let currentText = textField.text ?? ""
        let nextText = (currentText as NSString).stringByReplacingCharactersInRange(range, withString: string)
        
        // switch statement to determine the constraints 
        // digitsOnlyTextField case: only allow digits 0-9, and limits chars to 4
        // numericOnlyTextField case: only allow numeric values in field, and limit chars to 7 total
        // positiveIntegersOnlyTextField case: use a decimal separator to make sure there are no "e" or "." (or any type of punctuation), and then limit the contents to 5 characters only (i.e. max donation allowed is $90,000 per chapter e-board member)
        
        switch textField {
            
            // first case: only allow digits 0-9 on this field
            case digitsOnlyTextField:
                return nextText.containsOnlyCharactersIn("0123456789") && nextText.characters.count <= 4
            
            // second case: only allow proper numeric values in the field 
            case numericOnlyTextField:
                return nextText.isNumeric() && nextText.characters.count <= 7
            
            // final case: only allow proper numeric values and discard all "e" or "." values (only nearest dollar inputs allowed)
            
        }
        
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}*/
