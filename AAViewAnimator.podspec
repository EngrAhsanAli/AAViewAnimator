Pod::Spec.new do |s|
s.name             = 'AAViewAnimator'
s.version          = '1.0'
s.summary          = 'AAViewAnimator is a set of animations designed for UIView, UIButton, UIImageView with options in iOS, written in Swift.'

s.description      = <<-DESC
AAViewAnimator is a collection of animations and transitions for UIView designed to apply animations on every UIView with options in iOS, written in Swift. It allows various options for animations and parameters to make them unique!
DESC

s.homepage         = 'https://github.com/EngrAhsanAli/AAViewAnimator'
s.screenshots     = 'https://raw.githubusercontent.com/EngrAhsanAli/AAViewAnimator/master/Screenshots/AAViewAnimator.png'
s.license          = { :type => 'MIT', :file => 'LICENSE' }
s.author           = { 'EngrAhsanAli' => 'hafiz.m.ahsan.ali@gmail.com' }
s.source           = { :git => 'https://github.com/EngrAhsanAli/AAViewAnimator.git', :tag => s.version.to_s }

s.ios.deployment_target = '8.0'

s.source_files = 'AAViewAnimator/Classes/**/*'

end
