# Table of Contents

- [AAViewAnimator](#section-id-4)
  - [Description](#section-id-10)
  - [Demonstration](#section-id-16)
  - [Requirements](#section-id-26)
- [Installation](#section-id-32)
  - [CocoaPods](#section-id-37)
  - [Carthage](#section-id-63)
  - [Manual Installation](#section-id-82)
- [Getting Started](#section-id-87)
  - [Animate your view!](#section-id-90)
  - [Apply transition on your view!](#section-id-104)
  - [Animation types](#section-id-132)
  - [Transition types](#section-id-150)
- [Contributions & License](#section-id-156)


<div id='section-id-4'/>

#AAViewAnimator

[![Swift 3.0](https://img.shields.io/badge/Swift-3.0-orange.svg?style=flat)](https://developer.apple.com/swift/) [![Carthage compatible](https://img.shields.io/badge/Carthage-compatible-4BC51D.svg?style=flat)](https://github.com/Carthage/Carthage) [![CocoaPods](https://img.shields.io/cocoapods/v/AAViewAnimator.svg)](http://cocoadocs.org/docsets/AAViewAnimator) [![License MIT](https://img.shields.io/badge/License-MIT-blue.svg?style=flat)](https://github.com/Carthage/Carthage) [![Build Status](https://travis-ci.org/EngrAhsanAli/AAViewAnimator.svg?branch=master)](https://travis-ci.org/EngrAhsanAli/AAViewAnimator) 
![License MIT](https://img.shields.io/github/license/mashape/apistatus.svg) [![CocoaPods](https://img.shields.io/cocoapods/p/AAViewAnimator.svg)]()


<div id='section-id-10'/>

##Description


AAViewAnimator is a simple, lightweight & easy-to-use rating bar designed to get and set ratings in iOS, written in Swift. It is a customised storyboard based `UIView` class that allows to customise in the `UIStoryboard` without writing code.


<div id='section-id-16'/>

##Demonstration

AAViewAnimator is a collection of animations and transitions for `UIView` designed to apply animations on every `UIView` with options in iOS, written in Swift. It allows various options for animations and parameters to make them unique!

![](https://github.com/EngrAhsanAli/AAViewAnimator/blob/master/Screenshots/demo.gif)


To run the example project, clone the repo, and run `pod install` from the Example directory first.


<div id='section-id-26'/>

##Requirements

- iOS 8.0+
- Xcode 8.0+
- Swift 3+

<div id='section-id-32'/>

# Installation

`AAViewAnimator` can be installed using CocoaPods, Carthage, or manually.


<div id='section-id-37'/>

##CocoaPods

`AAViewAnimator` is available through [CocoaPods](http://cocoapods.org). To install CocoaPods, run:

`$ gem install cocoapods`

Then create a Podfile with the following contents:

```
source 'https://github.com/CocoaPods/Specs.git'
platform :ios, '8.0'
use_frameworks!

target '<Your Target Name>' do
pod 'AAViewAnimator'
end

```

Finally, run the following command to install it:
```
$ pod install
```



<div id='section-id-63'/>

##Carthage

To install Carthage, run (using Homebrew):
```
$ brew update
$ brew install carthage
```
Then add the following line to your Cartfile:

```
github "EngrAhsanAli/AAViewAnimator" 
```

Then import the library in all files where you use it:
```ruby
import AAViewAnimator
```


<div id='section-id-82'/>

##Manual Installation

If you prefer not to use either of the above mentioned dependency managers, you can integrate `AAViewAnimator` into your project manually by adding the files contained in the Classes folder to your project.


<div id='section-id-87'/>

#Getting Started
----------

<div id='section-id-90'/>

##Animate your view!

You can simply animate your view just by calling `aa_animate` function with animation option

**Usage:**
```
yourView.aa_animate(duration: 0.5, animation: .scale(rate: 1.2))

```




<div id='section-id-104'/>

##Apply transition on your view!

You can simply apply transition your view just by calling `aa_animate` function with animation option

**Usage:**
```

yourView.aa_animate(duration: 1.2, springDamping: .slight, animation: animator) { inAnimating in
if inAnimating {
// View is animating
}
else {
// View's animation is done
}
}

```


> Note that the function signature for animation is:
```func aa_animate(duration: TimeInterval, springDamping: AAViewDamping, animation: AAViewAnimators, completion: ((_ isAnimating: Bool)->())? = nil)```

<div id='section-id-132'/>

##Animation types

|  AAViewAnimators	 	 	| Description		    				  |
|---------------------------|-----------------------------------------|
| `scale(rate:Float)`   	| Animation with scale effect   		  |
| `vibrateX(rate:CGFloat)` 	| Animation with vibrate at x axis effect |
| `vibrateY(rate:CGFloat)`  | Animation with vibrate at y axis effect |
| `rotateLeft`      	 	| Animation with left rotation effect	  |
| `rotateRight`   	 		| Animation with right rotation effect 	  |
| `rotateRound`     	 	| Animation with round rotation effect	  |

<div id='section-id-150'/>

##Transition types

You can use following animation transition: 

|  AAViewAnimators  | Description		    				       		|
|-------------------|---------------------------------------------------|
| `fromTop`   	    | Transition from Top (View will be visible)    	|
| `fromBottom` 		| Transition from Bottom (View will be visible)  	|
| `fromLeft`   		| Transition from Left (View will be visible)	   	|
| `fromRight`  		| Transition from Right (View will be visible)	   	|
| `fromFade`  		| Transition with Fade (View will be visible) 		|
| `toTop`     		| Transition to Top (View will not be visible)    	|
| `toBottom` 		| Transition to Bottom (View will not be visible)   |
| `toLeft`    		| Transition to Left (View will not be visible)		|
| `toRight`   		| Transition to Right (View will not be visible)    |
| `toFade`  		| Transition with Fade (View will not be visible)   |

<div id='section-id-156'/>

#Contributions & License

`AAViewAnimator` is available under the MIT license. See the [LICENSE](./LICENSE) file for more info.

Pull requests are welcome! The best contributions will consist of substitutions or configurations for classes/methods known to block the main thread during a typical app lifecycle.

I would love to know if you are using `AAViewAnimator` in your app, send an email to [Engr. Ahsan Ali](mailto:hafiz.m.ahsan.ali@gmail.com)

