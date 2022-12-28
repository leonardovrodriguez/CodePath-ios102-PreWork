//
//  ViewController.swift
//  preWork_ios102
//
//  Created by Leonardo Rodriguez on 12/28/22.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var morePetsSwitch: UISwitch!
    @IBOutlet weak var morePetsStepper: UIStepper!
    @IBOutlet weak var firstNameTextField: UITextField!
    @IBOutlet weak var lastNameTextField: UITextField!
    @IBOutlet weak var schoolNameTextField: UITextField!
    @IBOutlet weak var hobbyTextField: UITextField!
    @IBOutlet weak var numberOfPetsLabel: UILabel!
    @IBOutlet weak var yearSegmentedControl: UISegmentedControl!
    @IBOutlet weak var introSelfButton: UIButton!
    @IBOutlet weak var saveIntroButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //apply styles and load cached data
        applyStyles()
        loadSavedIntro()
    }
    
    @IBAction func stepperDidChange(_ sender: UIStepper) {
        numberOfPetsLabel.text = "\(Int(sender.value))"
    }
    
    @IBAction func introduceSelfDidTapped(_ sender: UIButton) {
        introAlert()
    }
    
    @IBAction func saveIntroDidTapped(_ sender: UIButton) {
        saveIntro()
        saveAlert()
    }
    
    func loadSavedIntro(){
        
        //Load saved data from UserDefaultsManager
        firstNameTextField.text = UserDefaultsManager.getName(first:true)
        lastNameTextField.text = UserDefaultsManager.getName(first:false)
        schoolNameTextField.text = UserDefaultsManager.getSchool()
        hobbyTextField.text = UserDefaultsManager.getHobby()
        yearSegmentedControl.selectedSegmentIndex = UserDefaultsManager.getYear()
        numberOfPetsLabel.text = UserDefaultsManager.getNumberOfPets()
        morePetsSwitch.isOn = UserDefaultsManager.getMorePets()
        if let stepperValue =  Double(UserDefaultsManager.getNumberOfPets()){
            morePetsStepper.value = stepperValue
        }
    }
    
    func saveIntro(){
        
        //Save current data to UserDefaultsManager
        UserDefaultsManager.setName(name: firstNameTextField.text!, first:true)
        UserDefaultsManager.setName(name: lastNameTextField.text!, first:false)
        UserDefaultsManager.setSchool(schoolName: schoolNameTextField.text!)
        UserDefaultsManager.setHobby(favoriteHobby: hobbyTextField.text!)
        UserDefaultsManager.setYear(segmentIndex: yearSegmentedControl.selectedSegmentIndex)
        UserDefaultsManager.setNumberOfPets(numberOfPets: numberOfPetsLabel.text!)
        UserDefaultsManager.setMorePets(morePets: morePetsSwitch.isOn)
        print(morePetsSwitch.isOn)
    }
    
    func saveAlert(){
        let saveMessage = "Your introduction has been sucessfully saved"
        let alertController = UIAlertController(title: "Intro Saved 🎉", message: saveMessage, preferredStyle: .alert)
        let action = UIAlertAction(title: "Confirm", style: .default, handler: nil)
        alertController.addAction(action)
        present(alertController, animated: true, completion: nil)
    }
    
    func introAlert(){
        let year = yearSegmentedControl.titleForSegment(at: yearSegmentedControl.selectedSegmentIndex)
        let introduction = "Hi! My name is \(firstNameTextField.text!) \(lastNameTextField.text!) and I am attending \(schoolNameTextField.text!). I am currently in my \(year!.lowercased()) year. My favorite hobby is \(hobbyTextField.text!) and I own \(numberOfPetsLabel.text!) pets. \(morePetsSwitch.isOn ? "Although, I have \(numberOfPetsLabel.text!) pets, I would love to have more pets!":"As of now, I would not like any more pets")"
        let alertController = UIAlertController(title: "About me 🌎", message: introduction, preferredStyle: .alert)
        let action = UIAlertAction(title: "Looking forward to meeting you!", style: .default, handler: nil)
        alertController.addAction(action)
        present(alertController, animated: true, completion: nil)
    }
    
    func applyStyles(){
        morePetsSwitch.onTintColor = #colorLiteral(red: 0.8446564078, green: 0.5145705342, blue: 1, alpha: 1)
        morePetsSwitch.tintColor = #colorLiteral(red: 0.5818830132, green: 0.2156915367, blue: 1, alpha: 1)
        morePetsSwitch.thumbTintColor = UIColor.black
        morePetsSwitch.backgroundColor = #colorLiteral(red: 0.8446564078, green: 0.5145705342, blue: 1, alpha: 1)
        morePetsSwitch.layer.cornerRadius = 16
        saveIntroButton.tintColor = #colorLiteral(red: 0.8446564078, green: 0.5145705342, blue: 1, alpha: 1)
        introSelfButton.tintColor = #colorLiteral(red: 0.8446564078, green: 0.5145705342, blue: 1, alpha: 1)
        morePetsStepper.layer.cornerRadius = 16
    }
}

//Class to handle data saved to UserDefualt
class UserDefaultsManager{
    
    static let shared = UserDefaultsManager()
    
    let defaults = UserDefaults(suiteName: "com.preWork_ios102.introInfo")!
    
    static func setName(name: String, first: Bool){
        first ? shared.defaults.setValue(name, forKey:"firstName"):shared.defaults.setValue(name, forKey:"lastName")
    }
    
    static func getName(first: Bool) -> String{
        let savedInfo = first ? shared.defaults.value(forKey:"firstName") as? String : shared.defaults.value(forKey:"lastName") as? String
        return savedInfo != nil ? savedInfo! : ""
    }
    
    static func setSchool(schoolName: String){
        shared.defaults.setValue(schoolName, forKey:"schoolName")
    }
    
    static func getSchool() -> String{
        let savedInfo = shared.defaults.value(forKey:"schoolName") as? String
        return savedInfo != nil ? savedInfo! : ""
    }
    
    static func setHobby(favoriteHobby: String){
        shared.defaults.setValue(favoriteHobby, forKey:"favoriteHobby")
    }
    
    static func getHobby() -> String{
        let savedInfo = shared.defaults.value(forKey:"favoriteHobby") as? String
        return savedInfo != nil ? savedInfo! : ""
    }
    
    static func setYear(segmentIndex: Int){
        shared.defaults.setValue(segmentIndex, forKey:"studentYearSegmentIndex")
    }
    
    static func getYear() -> Int{
        let savedInfo = shared.defaults.value(forKey:"studentYearSegmentIndex") as? Int
        return savedInfo != nil ? savedInfo! : 0
    }
    
    static func setNumberOfPets(numberOfPets:String){
        shared.defaults.setValue(numberOfPets, forKey:"numberOfPets")
    }
    
    static func getNumberOfPets() -> String{
        let savedInfo = shared.defaults.value(forKey:"numberOfPets") as? String
        return savedInfo != nil ? savedInfo! : "0"
    }
    
    static func setMorePets(morePets: Bool){
        shared.defaults.setValue(morePets, forKey:"morePets")
    }
    
    static func getMorePets()-> Bool{
        let savedInfo = shared.defaults.value(forKey:"morePets") as? Bool
        return savedInfo != nil ? savedInfo!:true
    }
    
}
