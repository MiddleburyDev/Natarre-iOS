<?xml version="1.0" encoding="UTF-8" standalone="no"?>
<document type="com.apple.InterfaceBuilder3.CocoaTouch.Storyboard.XIB" version="1.1" toolsVersion="2182" systemVersion="11E53" targetRuntime="iOS.CocoaTouch" propertyAccessControl="none" initialViewController="2">
    <dependencies>
        <deployment defaultVersion="1296" identifier="iOS"/>
        <development defaultVersion="4200" identifier="xcode"/>
        <plugIn identifier="com.apple.InterfaceBuilder.IBCocoaTouchPlugin" version="1181"/>
    </dependencies>
    <scenes>
        <!--Root View Controller-->
        <scene sceneID="5">
            <objects>
                <placeholder placeholderIdentifier="IBFirstResponder" id="4" sceneMemberID="firstResponder"/>
                <viewController id="2" customClass="TNBRootViewController" sceneMemberID="viewController">
                    <view key="view" contentMode="scaleToFill" id="3">
                        <rect key="frame" x="0.0" y="20" width="320" height="460"/>
                        <autoresizingMask key="autoresizingMask" flexibleMaxX="YES" flexibleMaxY="YES"/>
                        <color key="backgroundColor" white="1" alpha="1" colorSpace="custom" customColorSpace="calibratedWhite"/>
                    </view>
                </viewController>
            </objects>
        </scene>
        <!--Table View Controller - Root View Controller-->
        <scene sceneID="JLf-XS-uL9">
            <objects>
                <placeholder placeholderIdentifier="IBFirstResponder" id="tig-sM-y27" userLabel="First Responder" sceneMemberID="firstResponder"/>
                <tableViewController id="Ogr-4Z-1lI" sceneMemberID="viewController">
                    <tableView key="view" opaque="NO" clipsSubviews="YES" clearsContextBeforeDrawing="NO" contentMode="scaleToFill" alwaysBounceVertical="YES" dataMode="prototypes" style="plain" rowHeight="44" sectionHeaderHeight="22" sectionFooterHeight="22" id="n0V-Xr-uKG">
                        <rect key="frame" x="0.0" y="64" width="320" height="416"/>
                        <autoresizingMask key="autoresizingMask" widthSizable="YES" heightSizable="YES"/>
                        <color key="backgroundColor" white="1" alpha="1" colorSpace="calibratedWhite"/>
                        <prototypes>
                            <tableViewCell contentMode="scaleToFill" selectionStyle="blue" hidesAccessoryWhenEditing="NO" indentationLevel="1" indentationWidth="0.0" id="odH-gI-fre">
                                <rect key="frame" x="0.0" y="22" width="320" height="44"/>
                                <autoresizingMask key="autoresizingMask"/>
                                <view key="contentView" opaque="NO" clipsSubviews="YES" multipleTouchEnabled="YES" contentMode="center">
                                    <rect key="frame" x="0.0" y="0.0" width="320" height="43"/>
                                    <autoresizingMask key="autoresizingMask"/>
                                    <color key="backgroundColor" white="0.0" alpha="0.0" colorSpace="calibratedWhite"/>
                                </view>
                            </tableViewCell>
                        </prototypes>
                    </tableView>
                    <navigationItem key="navigationItem" title="Root View Controller" id="EgX-zu-q42"/>
                </tableViewController>
            </objects>
            <point key="canvasLocation" x="1228" y="74"/>
        </scene>
        <!--Navigation Controller-->
        <scene sceneID="M5P-1V-xUm">
            <objects>
                <placeholder placeholderIdentifier="IBFirstResponder" id="zuo-8N-Mfb" userLabel="First Responder" sceneMemberID="firstResponder"/>
                <navigationController definesPresentationContext="YES" id="yDe-GU-xiZ" sceneMemberID="viewController">
                    <navigationBar key="navigationBar" opaque="NO" clipsSubviews="YES" multipleTouchEnabled="YES" contentMode="scaleToFill" id="JOV-Ba-cwo">
                        <autoresizingMask key="autoresizingMask"/>
                    </navigationBar>
                    <connections>
                        <segue destination="Ogr-4Z-1lI" kind="relationship" relationship="rootViewController" id="Ged-Um-bd5"/>
                    </connections>
                </navigationController>
            </objects>
            <point key="canvasLocation" x="694" y="74"/>
        </scene>
        <!--Login View Controller-->
        <scene sceneID="oWB-8H-STI">
            <objects>
                <placeholder placeholderIdentifier="IBFirstResponder" id="TfA-Du-k7n" userLabel="First Responder" sceneMemberID="firstResponder"/>
                <viewController storyboardIdentifier="loginViewController" id="MMH-lK-Seq" customClass="TNBLoginViewController" sceneMemberID="viewController">
                    <view key="view" contentMode="scaleToFill" id="tfO-Y1-PD3">
                        <rect key="frame" x="0.0" y="20" width="320" height="460"/>
                        <autoresizingMask key="autoresizingMask" flexibleMaxX="YES" flexibleMaxY="YES"/>
                        <subviews>
                            <textField opaque="NO" clipsSubviews="YES" contentMode="scaleToFill" contentHorizontalAlignment="left" contentVerticalAlignment="center" borderStyle="roundedRect" placeholder="rliebowitz@middlebury.edu" minimumFontSize="17" id="ZoA-4d-QQt" userLabel="Email Field">
                                <rect key="frame" x="20" y="20" width="280" height="31"/>
                                <autoresizingMask key="autoresizingMask" flexibleMaxX="YES" flexibleMaxY="YES"/>
                                <fontDescription key="fontDescription" type="system" pointSize="14"/>
                                <textInputTraits key="textInputTraits"/>
                            </textField>
                            <textField opaque="NO" clipsSubviews="YES" contentMode="scaleToFill" contentHorizontalAlignment="left" contentVerticalAlignment="center" borderStyle="roundedRect" placeholder="supersecretpassword" minimumFontSize="17" id="jzF-pO-4wu" userLabel="Password Field">
                                <rect key="frame" x="20" y="59" width="280" height="31"/>
                                <autoresizingMask key="autoresizingMask" flexibleMaxX="YES" flexibleMaxY="YES"/>
                                <fontDescription key="fontDescription" type="system" pointSize="14"/>
                                <textInputTraits key="textInputTraits" secureTextEntry="YES"/>
                            </textField>
                            <button opaque="NO" contentMode="scaleToFill" contentHorizontalAlignment="center" contentVerticalAlignment="center" buttonType="roundedRect" lineBreakMode="middleTruncation" id="tIK-Nf-Fkg" userLabel="Submit">
                                <rect key="frame" x="228" y="98" width="72" height="37"/>
                                <autoresizingMask key="autoresizingMask" flexibleMaxX="YES" flexibleMaxY="YES"/>
                                <fontDescription key="fontDescription" type="boldSystem" pointSize="15"/>
                                <state key="normal" title="Shoot">
                                    <color key="titleColor" red="0.19607843459999999" green="0.30980393290000002" blue="0.52156865600000002" alpha="1" colorSpace="calibratedRGB"/>
                                    <color key="titleShadowColor" white="0.5" alpha="1" colorSpace="calibratedWhite"/>
                                </state>
                                <state key="highlighted">
                                    <color key="titleColor" white="1" alpha="1" colorSpace="calibratedWhite"/>
                                </state>
                                <connections>
                                    <action selector="sumbitButtonWasPressed:" destination="MMH-lK-Seq" eventType="touchUpInside" id="svG-Dt-bPS"/>
                                </connections>
                            </button>
                        </subviews>
                        <color key="backgroundColor" white="1" alpha="1" colorSpace="custom" customColorSpace="calibratedWhite"/>
                    </view>
                    <connections>
                        <outlet property="emailField" destination="ZoA-4d-QQt" id="ntk-Gv-2wI"/>
                        <outlet property="passwordField" destination="jzF-pO-4wu" id="8jp-qP-XTZ"/>
                    </connections>
                </viewController>
            </objects>
            <point key="canvasLocation" x="158" y="783"/>
        </scene>
    </scenes>
    <classes>
        <class className="TNBLoginViewController" superclassName="UIViewController">
            <source key="sourceIdentifier" type="project" relativePath="./Classes/TNBLoginViewController.h"/>
            <relationships>
                <relationship kind="action" name="sumbitButtonWasPressed:"/>
                <relationship kind="outlet" name="emailField" candidateClass="UITextField"/>
                <relationship kind="outlet" name="passwordField" candidateClass="UITextField"/>
            </relationships>
        </class>
        <class className="TNBRootViewController" superclassName="UIViewController">
            <source key="sourceIdentifier" type="project" relativePath="./Classes/TNBRootViewController.h"/>
        </class>
    </classes>
    <simulatedMetricsContainer key="defaultSimulatedMetrics">
        <simulatedStatusBarMetrics key="statusBar"/>
        <simulatedOrientationMetrics key="orientation"/>
        <simulatedScreenMetrics key="destination"/>
    </simulatedMetricsContainer>
</document>