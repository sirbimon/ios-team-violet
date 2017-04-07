
import UIKit

protocol InstantiateViewControllerDelegate {
    func instantiateBreakTimeVC()
}

class ProductiveTimeViewController: UIViewController {

    lazy var viewWidth: CGFloat = self.view.frame.width
    lazy var viewHeight: CGFloat = self.view.frame.height
    
    var viewModel: ProductiveTimeViewModel!
    var progressBarWidthAnchor: NSLayoutConstraint!

    let totalTimeLabel = UILabel()
    let popsWindowView = UIView()
    let pepTalkLabel = UILabel()
    let popsIcon = UIImageView()
    let cancelSessionButton = UIButton()
    let progressBar = UIView()
    let propsLabel = UILabel()
    var popsBottomAnchorConstraint: NSLayoutConstraint!
    
    let characterMessageHeader = UILabel()
    let characterMessageBody = UILabel()
    let lockIconImageView = UIImageView()
    let lockLabel = UILabel()
    
    var delegate: InstantiateViewControllerDelegate?
    
    //properties that handle displaying data
    var totalTime = 0 {
        didSet {
            totalTimeLabel.text = viewModel.formatTime(time: totalTime)
        }
    }
    var props = 0 {
        didSet {
            propsLabel.text = "\(props) props"
        }
    }
    
    var progress = 0.0 {
        didSet {
            self.progressBarWidthAnchor.constant = CGFloat(self.view.frame.width * CGFloat(self.progress) )
            self.view.layoutIfNeeded()
        }
    }
    
    override func viewDidLoad() { //remember to call the setup function here!
        super.viewDidLoad()
        viewModel = ProductiveTimeViewModel(vc: self)
        view.backgroundColor = Palette.darkHeader.color
        
        setupProgressBar()
        setupPropsLabel()
        setupLockImageView()
        setupLockLabel()
        
        setupCancelSessionButton()
        setupTotalTimeLabel()
        setupCharacterMessageBody()
        setupCharacterMessageHeader()
        setupPopsWindow()
        setupPopsIcon()
       
        viewModel.startTimers()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        animatePopsPopup()
    }

    func dismissView() {
        self.dismiss(animated: true, completion: nil)
    }

}

extension ProductiveTimeViewController {
    
    func setupProgressBar() {
        view.addSubview(progressBar)
        progressBar.backgroundColor = Palette.salmon.color
        
        progressBar.translatesAutoresizingMaskIntoConstraints = false
        progressBar.topAnchor.constraint(equalTo: view.topAnchor, constant: 0).isActive = true
        progressBar.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 0).isActive = true
        progressBar.heightAnchor.constraint(equalToConstant: 5).isActive = true
        progressBarWidthAnchor = progressBar.widthAnchor.constraint(equalToConstant: 0.0)
        progressBarWidthAnchor.isActive = true
    }
    
    func setupPropsLabel() {
        view.addSubview(propsLabel)
        propsLabel.text = "\(props) \nprops"
        propsLabel.font = UIFont(name: "Avenir-Heavy", size: 14)
        propsLabel.textColor = UIColor.white
        
        propsLabel.translatesAutoresizingMaskIntoConstraints = false
        propsLabel.topAnchor.constraint(equalTo: progressBar.bottomAnchor, constant: 25).isActive = true
        propsLabel.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 30).isActive = true
        propsLabel.widthAnchor.constraint(equalToConstant: 200).isActive = true
        propsLabel.heightAnchor.constraint(equalToConstant: 20).isActive = true
    }
    
    func setupLockImageView() {
        lockIconImageView.image = UIImage(named: "IC_Lock")
        lockIconImageView.contentMode = .scaleAspectFill
        view.addSubview(lockIconImageView)
        lockIconImageView.translatesAutoresizingMaskIntoConstraints = false
        lockIconImageView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -viewWidth * (30/375)).isActive = true
        lockIconImageView.widthAnchor.constraint(equalToConstant: viewWidth * (20/375)).isActive = true
        lockIconImageView.heightAnchor.constraint(equalToConstant: viewHeight * (16/667)).isActive = true
        lockIconImageView.topAnchor.constraint(equalTo: view.topAnchor, constant: viewHeight * (104/667)).isActive = true
    }
    
    func setupLockLabel() {
        view.addSubview(lockLabel)
        lockLabel.text = "lock"
        lockLabel.font = UIFont(name: "Avenir-Heavy", size: 14)
        lockLabel.textColor = UIColor.white
        
        lockLabel.translatesAutoresizingMaskIntoConstraints = false
        lockLabel.centerYAnchor.constraint(equalTo: lockIconImageView.centerYAnchor).isActive = true
        lockLabel.trailingAnchor.constraint(equalTo: lockIconImageView.leadingAnchor, constant: -15).isActive = true
    }
    
    func setupCancelSessionButton() {
        view.addSubview(cancelSessionButton)
        cancelSessionButton.setTitle("im weak", for: .normal)
        cancelSessionButton.titleLabel?.text = "im weak"
        cancelSessionButton.titleLabel?.textColor = Palette.grey.color
        cancelSessionButton.titleLabel?.font = UIFont(name: "AvenirNext-Medium", size: 13.0)
        cancelSessionButton.addTarget(self, action: #selector(skipBreak), for: .touchUpInside)
        
        cancelSessionButton.translatesAutoresizingMaskIntoConstraints = false
        cancelSessionButton.centerXAnchor.constraint(equalTo: view.centerXAnchor, constant: 0).isActive = true
        cancelSessionButton.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -40).isActive = true
        cancelSessionButton.widthAnchor.constraint(equalToConstant: 50).isActive = true
        cancelSessionButton.heightAnchor.constraint(equalToConstant: 20).isActive = true
    }
    
    func setupTotalTimeLabel() {
        view.addSubview(totalTimeLabel)
        totalTimeLabel.text = "\(viewModel.formatTime(time: totalTime))"
        totalTimeLabel.textAlignment = .center
        totalTimeLabel.font = UIFont(name: "Avenir-Heavy", size: 20)
        totalTimeLabel.textColor = UIColor.white
        
        totalTimeLabel.translatesAutoresizingMaskIntoConstraints = false
        totalTimeLabel.topAnchor.constraint(equalTo: cancelSessionButton.topAnchor, constant: -viewHeight * (120/667)).isActive = true
        totalTimeLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor, constant: 0).isActive = true
        totalTimeLabel.widthAnchor.constraint(equalToConstant: 150).isActive = true
        totalTimeLabel.heightAnchor.constraint(equalToConstant: 25).isActive = true
    }
    
    func setupCharacterMessageBody() {
        characterMessageBody.numberOfLines = 0
        characterMessageBody.textColor = Palette.grey.color
        characterMessageBody.textAlignment = .left
        characterMessageBody.font = UIFont(name: "Avenir-Heavy", size: 14.0)
        characterMessageBody.text = "I’ll notify you when it’s time for a break. If I see you playing with your phone while you should be working bad things will happen."
        
        view.addSubview(characterMessageBody)
        characterMessageBody.translatesAutoresizingMaskIntoConstraints = false
        characterMessageBody.bottomAnchor.constraint(equalTo: totalTimeLabel.topAnchor, constant: -viewHeight * (30/667)).isActive = true
        characterMessageBody.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: viewWidth * (53/375)).isActive = true
        characterMessageBody.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -viewWidth * (53/375)).isActive = true
    }
    
    func setupCharacterMessageHeader() {
        characterMessageHeader.numberOfLines = 0
        characterMessageHeader.textColor = UIColor.white
        characterMessageHeader.textAlignment = .left
        characterMessageHeader.font = UIFont(name: "Avenir-Black", size: 14.0)
        characterMessageHeader.text = "Lock your phone now."
        
        view.addSubview(characterMessageHeader)
        characterMessageHeader.translatesAutoresizingMaskIntoConstraints = false
        characterMessageHeader.bottomAnchor.constraint(equalTo: characterMessageBody.topAnchor, constant: -viewHeight * (5/667)).isActive = true
        characterMessageHeader.leadingAnchor.constraint(equalTo: characterMessageBody.leadingAnchor).isActive = true
        characterMessageHeader.trailingAnchor.constraint(equalTo: characterMessageBody.trailingAnchor).isActive = true
    }

    func setupPopsWindow() {
        view.addSubview(popsWindowView)
        popsWindowView.translatesAutoresizingMaskIntoConstraints = false
        popsWindowView.backgroundColor = Palette.salmon.color
        popsWindowView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        popsWindowView.bottomAnchor.constraint(equalTo: characterMessageHeader.topAnchor, constant: -viewHeight * (35/667)).isActive = true
        popsWindowView.heightAnchor.constraint(equalToConstant: 100).isActive = true
        popsWindowView.widthAnchor.constraint(equalToConstant: 100).isActive = true
        popsWindowView.layer.cornerRadius = 50.0
        popsWindowView.layer.masksToBounds = true
    }
    
    func setupPopsIcon() {
        popsIcon.image = UIImage(named: "IC_POPS")
        popsIcon.contentMode = .scaleAspectFit
        
        popsWindowView.addSubview(popsIcon)
        popsIcon.translatesAutoresizingMaskIntoConstraints = false
        popsIcon.backgroundColor = UIColor.clear
        
        popsBottomAnchorConstraint = popsIcon.bottomAnchor.constraint(equalTo: popsWindowView.bottomAnchor, constant: 100)
        popsBottomAnchorConstraint.isActive = true
        popsIcon.centerXAnchor.constraint(equalTo: popsWindowView.centerXAnchor, constant: 0).isActive = true
        popsIcon.heightAnchor.constraint(equalToConstant: 80).isActive = true
        popsIcon.widthAnchor.constraint(equalToConstant: 52).isActive = true
        popsIcon.layer.masksToBounds = true
    }

    func skipBreak() {
        viewModel.timer.invalidate()
        viewModel.backgroundTimer.invalidate()
        self.dismiss(animated: true, completion: nil)
        delegate?.instantiateBreakTimeVC()
    }
    
    func animatePopsPopup() {
        self.view.layoutIfNeeded()
        UIView.animate(withDuration: 1) {
            self.popsBottomAnchorConstraint.constant = 10
            self.view.layoutIfNeeded()
        }
    }
}