Pod::Spec.new do |s|
  s.name	= "SpatialDBKit"
  s.version	= "0.1.1"
  s.summary	= "SpatialDBKit is the spatial RDBMS for iOS."
  s.description = "An Objective-C wrapper of SpatiaLite, the smallest and simplest while powerful Spatial RDBMS in the world!"
  s.homepage	= "https://github.com/nguyenhunga5/SpatialDBKit"
  s.license	= { :type => "Mozilla Public License v1.1",
		    :file => "LICENSE" }
  s.author	= { "Andrea Cremaschi" => "andreacremaschi@libero.it" }

  s.source     = { :git => "git@github.com:nguyenhunga5/SpatialDBKit.git", :tag => "0.1.1"}

  s.ios.deployment_target = '7.0'
  s.osx.deployment_target = '10.10'

  s.dependency "spatialite"
  s.dependency "FMDB/common"
  # s.dependency = "ShapeKit", :git => "https://github.com/nguyenhunga5/ShapeKit.git"
  s.requires_arc = true

  s.source_files = "SpatialDBKit/*.{h,m}"

  s.public_header_files = "SpatialDBKit/*.h"

end
