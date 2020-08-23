Pod::Spec.new do |spec|


  spec.name         = "SignaturePadViewLib"
  spec.version      = "1.1.0"
  spec.summary      = "A CocoaPods library written in Swift"

 
  spec.description  = <<-DESC
  Simple swift library to capture the signature or any shape drawn on the screen
                   DESC

  spec.homepage     = "https://github.com/nnovalbos/SignaturePadViewLib"
  spec.license      = { :type => "MIT", :file => "LICENSE" }
  spec.author       = { "Nicolás Novalbos" => "nicolas.novalbos@gmail.com" }

  spec.ios.deployment_target = "12.0"
  spec.swift_version = "5"


  spec.source       = { :git => "https://github.com/nnovalbos/SignaturePadViewLib.git", :tag => "#{spec.version}" }
  spec.source_files  = "SignaturePadViewLib/**/*.{h,m,swift}"


end
