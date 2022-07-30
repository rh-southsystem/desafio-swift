//
//  EventDetailsViewController.swift
//  EventsApp
//
//  Created by Rodrigo Ryo Aoki on 29/07/22.
//

import UIKit
import RxCocoa
import RxSwift

class EventDetailsViewController: UIViewController {

	// MARK: - Properties
	
	private var viewModel: EventDetailsViewModelProtocol?
	private var outputHandler: ((EventDetailsViewController.Output) -> Void)?
	
	private var bag = DisposeBag()
	
	private var scrollView: UIScrollView = {
		var view = UIScrollView()
		
		view.isScrollEnabled = true
		
		
		view.translatesAutoresizingMaskIntoConstraints = false
		return view
	}()
	
	private var scrollContentView: UIStackView = {
		var view = UIStackView()
		
		view.distribution = .equalSpacing
		view.axis = .vertical
		view.spacing = 15
		
		view.translatesAutoresizingMaskIntoConstraints = false
		return view
	}()
	
	private var imageView: UIImageView = {
		var view = UIImageView()
		
		view.contentMode = .scaleAspectFill
		view.image = UIImage(named: "placeHolder")
		view.translatesAutoresizingMaskIntoConstraints = false
		view.clipsToBounds = true
		
		return view
	}()
	
	private var detailsCard: DetailsCard = {
		var view = DetailsCard()
		
		view.translatesAutoresizingMaskIntoConstraints = false
		
		return view
	}()
	
	private var descriptionCard: DescriptionCard = {
		var view = DescriptionCard()
		
		view.translatesAutoresizingMaskIntoConstraints = false
		
		return view
	}()
	
	// MARK: - Init
	
	required init(viewModel: EventDetailsViewModelProtocol,
				  outputHandler: @escaping (EventDetailsViewController.Output) -> Void) {
		super.init(nibName: nil, bundle: nil)
		
		self.viewModel = viewModel
		self.outputHandler = outputHandler
	}
	
	required init?(coder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
	
	// MARK: - Output
	
	enum Output {
		case close
	}
	
	// MARK: - Overrides
	
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
		self.view.backgroundColor = .white
		
		setupView()
		subEvent()
		
    }
}

extension EventDetailsViewController: ComponentCreation {
	func buildViewHierarchy() {
		view.addSubview(scrollView)
		scrollView.addSubview(scrollContentView)

		scrollView.addSubview(imageView)
		scrollContentView.addArrangedSubview(detailsCard)
		scrollContentView.addArrangedSubview(descriptionCard)
	}
	
	func setupConstraints() {
		NSLayoutConstraint.activate([
			scrollView.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor),
			scrollView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor),
			scrollView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor),
			scrollView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor),

			scrollContentView.topAnchor.constraint(equalTo: self.imageView.bottomAnchor, constant: 15),
			scrollContentView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 10),
			scrollContentView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: -10),
			scrollContentView.bottomAnchor.constraint(equalTo: self.scrollView.bottomAnchor),

			imageView.heightAnchor.constraint(equalTo: self.view.heightAnchor, multiplier: 0.3),
			imageView.topAnchor.constraint(equalTo: self.scrollView.topAnchor),
			imageView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor),
			imageView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor),
		])
	}
	
	func setupAdditionalConfiguration() {
		
	}
}

private extension EventDetailsViewController {
	func subEvent() {
		viewModel?.event.subscribe({ [weak self] (event) in
			DispatchQueue.main.async { [self] in
				self?.detailsCard.dateLabel.text = event.element?.date
				self?.detailsCard.localLabel.text = event.element?.local
				self?.detailsCard.titleLabel.text = event.element?.title
				
				let priceText = (event.element?.price ?? 0) == 0 ? EAStrings.free.rawValue : String(event.element?.price ?? 0)
				self?.detailsCard.priceLabel.text = "\(EAStrings.price.rawValue) R$\(priceText)"
				
				self?.descriptionCard.descriptionLabel.text = event.element?.description
				
				if let imageData = event.element?.image, let image = UIImage(data: imageData) {
					self?.imageView.contentMode = .scaleAspectFill
					self?.imageView.image = image
				} else {
					self?.defaultImage()
				}
				
				self?.title = event.element?.title
			}
		}).disposed(by: bag)
		
		viewModel?.fetchEvent(finish: { error in })
	}
	
	func defaultImage() {
		self.imageView.contentMode = .scaleAspectFit
		self.imageView.image = UIImage(systemName: "nosign")
	}
}
