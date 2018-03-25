//
//  NewGoalViewController.swift
//  GoCard
//
//  Created by ナム Nam Nguyen on 3/13/17.
//  Copyright © 2017 GoCard, Ltd. All rights reserved.
//

import UIKit
import AssetsLibrary
import RealmSwift

final class NewGoalViewController: BaseViewController, SliderListener{

    @IBOutlet weak var minusButton: UIButton!
    @IBOutlet weak var plusButton: UIButton!
    @IBOutlet weak var slider: Slider!
    @IBOutlet var frequentButtons: [UIButton]!
    @IBOutlet var contentViews: [UIView]!
    @IBOutlet weak var finishButton: UIButton!
    @IBOutlet weak var valueLabel: UILabel!
    @IBOutlet weak var sliderValueLabel: UILabel!
    @IBOutlet weak var contentView1HeightConstraint: NSLayoutConstraint!
    @IBOutlet weak var contentView1WidthConstraint: NSLayoutConstraint!
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var contentView2: UIView!
    @IBOutlet weak var contentView1: UIView!
    @IBOutlet weak var featuredImageView: UIImageView!
    @IBOutlet weak var descriptTextView: UITextView!
    @IBOutlet weak var goalTitleField: UITextField!
    
    @IBOutlet weak var howmuchLabel:UILabel!
    @IBOutlet var sectionTitles:[UILabel]!
    @IBOutlet weak var enableAutoDetailInfoLabel:UILabel!
    @IBOutlet weak var swipeLabel: UILabel!
    
    private func prepareData(title goalTitle:String, detail goalDescription:String, featuredPhotoUrl photoUrl:String ) -> [String:Any] {
        var aGoal:[String:Any] = [:]
        if dataIsValid() {
            aGoal[Key.Goal.title.rawValue] = goalTitle
            aGoal[Key.Goal.detail.rawValue] = goalDescription
            aGoal[Key.Goal.featurePhotoUrl.rawValue] = photoUrl
        }
        return aGoal
    }
    
    private var newGoalData:[String: Any] = [:]
    
    func dataIsValid() -> Bool {
        return true
    }
    
    private var value:CGFloat = 120.00 {
        didSet{
            if let attText = valueLabel.attributedText {
                let muAttText = NSMutableAttributedString(attributedString: attText)
                muAttText.mutableString.setString(String(format: "%2.2f SGD", value))
                muAttText.setAttributes([NSFontAttributeName: UIFont.mediumRoboto(size: 16)], range: NSRange(location:muAttText.length - 3, length:3))
                valueLabel.attributedText = muAttText
            } else {
                valueLabel.text = String(format: "%2.2f SGD", value)
            }
        }
    }
    private var sliderValue:CGFloat = 20.00 {
        didSet{
            if let attText = sliderValueLabel.attributedText {
                let muAttText = NSMutableAttributedString(attributedString: attText)
                muAttText.mutableString.setString(String(format: "%2.2f SGD", sliderValue))
                muAttText.setAttributes([NSFontAttributeName: UIFont.roboto(size: 10)], range: NSRange(location:muAttText.length - 3, length:3))
                sliderValueLabel.attributedText = muAttText
            } else {
                sliderValueLabel.text = String(format: "%2.2f SGD", sliderValue)
            }
        }
    }
    private var valueStep:CGFloat = 10.00
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
    }
    
    private func setup() {
        if let goal = Session.editingGoal {
            title = "EDIT GOAL"
            goalTitleField.text = goal.title
            descriptTextView.text = goal.detail
            guard let url = URL(string: goal.featurePhotoUrl) else { return }
            featuredImageView.contentMode = .scaleAspectFill
            featuredImageView.kf.setImage(with: url)
        } else {
            title = "SET NEW GOAL"
        }
        
        contentViews.forEach {
            $0.round(5)
        }
        frequentButtons.forEach {
            $0.roundBorder(borderColor: UIColor.borderColor)
            $0.addTarget(self, action: #selector(didSelectedFrequent(_:)), for: UIControlEvents.touchUpInside)
            $0.characterSpacing(1.25, lineHeight: 12, withFont: UIFont.mediumRoboto(size: 10))
            $0.setTitleColor(UIColor.borderColor, for: .normal)
            $0.setTitleColor(UIColor.white, for: .selected)
        }
        howmuchLabel.characterSpacing(1.3, lineHeight: 23, withFont: UIFont.roboto(size: 16))
        howmuchLabel.textAlignment = .center
        valueLabel.characterSpacing(1.14, lineHeight: 33, withFont: UIFont.mediumRoboto(size: 28))
        valueLabel.textAlignment = .center
        sectionTitles.forEach {
            $0.characterSpacing(1.3, lineHeight: 15, withFont: UIFont.roboto(size: 13))
        }
        enableAutoDetailInfoLabel.characterSpacing(1.33, lineHeight: 14, withFont: UIFont.roboto(size: 10))
        slider.listener = self
        minusButton.roundBorder(borderColor: UIColor.blueLight)
        plusButton.roundBorder(borderColor: UIColor.blueLight)
        featuredImageView.clipsToBounds = true
        featuredImageView.round(5)
        goalTitleField.typingAttributes = [NSKernAttributeName:2.0]
        descriptTextView.characterSpacing(0.65, lineHeight: 20, withFont: UIFont.roboto(size: 13))
        finishButton.characterSpacing(1.5, lineHeight: 14, withFont: UIFont.boldRoboto(size: 12))
        swipeLabel.characterSpacing(1.2, lineHeight: 10, withFont: UIFont.roboto(size: 10))
        swipeLabel.textAlignment = .center
        
        value = 120.00
        sliderValue = 20.00
        
        do {
            try FileManager.default.createDirectory(
                at: NSURL(fileURLWithPath: NSTemporaryDirectory()).appendingPathComponent("upload")!,
                withIntermediateDirectories: true,
                attributes: nil)
        } catch {
            print("Creating 'upload' directory failed. Error: \(error)")
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        if let goal = Session.editingGoal {
            goalTitleField.text = goal.title
            descriptTextView.text = goal.detail
            guard let url = URL(string: goal.featurePhotoUrl) else { return }
            featuredImageView.contentMode = .scaleAspectFill
            featuredImageView.kf.setImage(with: url)
        }
        updateViews()
    }
    
    private func updateViews() {
        let screenH = UIScreen.main.bounds.size.height
        let screenW = UIScreen.main.bounds.size.width
        contentView1HeightConstraint.constant = screenH - 120.0
        contentView1WidthConstraint.constant = screenW - 40.0
        var contentSize = scrollView.contentSize
        contentSize.height = contentView1HeightConstraint.constant
        scrollView.contentSize = contentSize
        scrollView.bounces = true
        scrollView.isDirectionalLockEnabled = true
        finishButton.round()
        finishButton.backgroundColor = UIColor(hex:0x4BB5FC)
        addGradientMask()
    }
    
    func addGradientMask() {
        let gradientMask = CAGradientLayer()
        gradientMask.frame = descriptTextView.bounds
        gradientMask.colors = [UIColor.black.cgColor, UIColor.clear.cgColor]
        gradientMask.locations = [0.8, 1.0]
        let maskView: UIView = UIView(frame: descriptTextView.bounds)
        maskView.layer.addSublayer(gradientMask)
        descriptTextView.mask = maskView
        self.view.setNeedsDisplay()
    }
    
    @IBAction func didTouchMinus(_ sender: Any) {
        if value - valueStep >= valueStep {
            value = value - valueStep
        }
    }
    
    @IBAction func didTouchPlus(_ sender: Any) {
        value = value + valueStep
    }
    
    @IBAction func didSelectedFrequent(_ sender: UIButton) {
        if !sender.isSelected { sender.isSelected.toggle() }
        if sender.isSelected {
            frequentButtons.forEach {
                if $0 != sender {
                    $0.isSelected = false
                }
                if $0.isSelected {
                    $0.backgroundColor = UIColor.blueButton
                    $0.roundBorder(borderColor: UIColor.blueButton)
                } else {
                    $0.backgroundColor = UIColor.white
                    $0.roundBorder(borderColor: UIColor.borderColor)
                }
            }
        }
    }
    @IBAction func didTouchFinalize(_ sender: Any) {
        func onSavingSuccessful() { _ = self.navigationController?.popViewController(animated: true) }
        func onSavingError() { }
        // check data valid 
        //{
            
        //}
        // then
        showWaiting()
        if let goal = Session.editingGoal {
            let realm = try! Realm()
            try! realm.write {
                goal.title = goalTitleField.text!
                goal.detail = descriptTextView.text!
            }
        } else {
            if let validImage = featuredImageView.image {
                FileHelper.saveImageJPEG(image: validImage, name: self.goalTitleField.text!, savingComplete: { (path)  in
                    if let filePath = path {
                        print ("Saving completed: \(filePath)")
                        self.newGoalData = self.prepareData(title: self.goalTitleField.text!, detail: self.descriptTextView.text!, featuredPhotoUrl: filePath)
                    }
                })
            }
            
            let realm = try! Realm()
            realm.save {
                var myvalue = realm.objects(Goal.self).map{$0.goalId}.max() ?? 0
                myvalue = myvalue + 1
                newGoalData[Key.Goal.goalId.rawValue] = myvalue
                realm.create(Goal.self, value: newGoalData, update:true)
            }
        }
        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 2.0) { [unowned self] in
            self.hideWaiting()
            onSavingSuccessful()
        }
    }
    @IBAction func didTouchUpload(_ sender: Any) {
        let pickerController = DKImagePickerController()
        pickerController.singleSelect = true
        pickerController.didSelectAssets = { [unowned self] (assets: [DKAsset]) in
            guard let asset = assets.first else { return }
            asset.fetchImageWithSize(self.featuredImageView.frame.size, completeBlock: { image, info in
                self.featuredImageView.image = image
            })
        }
        if UI_USER_INTERFACE_IDIOM() == .pad {
            pickerController.modalPresentationStyle = .formSheet
        }
        
        self.present(pickerController, animated: true) {}
    }
    
    func slider(slider: Slider, didUpdate newValue: CGFloat) {
        sliderValue = newValue*10.0*valueStep
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.destination is DescriptionEditorViewController {
            if let goal = Session.editingGoal {
                let realm = try! Realm()
                try! realm.write {
                    goal.title = goalTitleField.text!
                }
            }
        }
    }
}
