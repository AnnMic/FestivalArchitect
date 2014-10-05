
Pod::Spec.new do |s|


  s.name         = "Entitas-Swift"
  s.version      = "0.0.1"
  s.summary      = "A short description of Entitas-Swift."
  s.description  = "EntitasSwift is an Entity-Component game framework. This means that all game objects are implemented as entities that contain components as their data."
  s.license      = "MIT" 
  s.author       = "Arne Schroppe"
  s.platform     = :ios, "8.0"
  s.source       = {:git => "https://github.com/arne-schroppe/Entitas-Swift"}
  s.source_files  = "Classes", "Classes/**/*.{h,m}"
  s.exclude_files = "Classes/Exclude"


end
