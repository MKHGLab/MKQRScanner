Pod::Spec.new do |s|
  s.name             = 'MKQRScanner'
  s.version          = '0.1.3'
  s.summary          = 'MKQRScanner is the very lightweight QR code scanner'
 
  s.description      = <<-DESC
Now your QR code scanning life more easy. Lets enjoy this.
                       DESC
 
  s.homepage         = 'https://github.com/MKHGLab/MKQRScanner'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'MKHG Lab' => 'mkhglab@gmail.com' }
  s.source           = { :git => 'https://github.com/MKHGLab/MKQRScanner.git', :tag => s.version.to_s }
 
  s.ios.deployment_target = '9.0'
  s.source_files = 'MKQRScanner/**/*.swift'
  
  s.resources = 'MKQRScanner/**/*.{storyboard,xib,xcassets,json,imageset,png}'

  s.resource_bundles = {
      'MKQRScanner' => ['MKQRScanner/**/*.{storyboard,xib,xcassets,json,imageset,png}']
  }
end
