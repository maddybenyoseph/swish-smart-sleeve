# Swish Basketball Smart Sleeve

Utilizing a Raspberry Pi Zero and Adafruit I2S 3W Stereo Speaker pHAT, the Swish Basketball Smart Sleeve uses Python in Processing to play audio cues and help improve the accuracy of a basketball player's shot. The eventual goal of this project was to create and develop a basketball smart sleeve that used sensors and accelerometers to determine the correctness of the angle made when making a shot, then play an audio cue accordingly. The first prototype was to provide
instructional guidance on what to do to correctly throw a basketball and provide a *beep if their angle was not in an acceptable range. After some initial feedback from basketball players I talked with at Georgia Tech's Campus Recreation Center, it was decided we should make a more focused effort on the audio aspect of the project in order to determine the correct form of a basketball player's shot. For the final implementation, an ascending or descending audio cue was provided to the basketball player, based on the arm angles, indicating that the angle is too far to the left or too far to the right. Additionally, as the angle of the arm gets closer and closer to the acceptable range, the ascending and descending audio cues get shorter to reflect that the user is making the correct changes. If the angle is in an acceptable range, another audio cue will be played to reflect that.

A Raspberry Pi Zero and Adafruit I2S 3W Stereo Speaker pHAT were used to store the Python Processing code that played the audio cues. To simulate the basketball player's shot, two images of an arm represented the forearm and upper arm. These two images are each controlled by sliders that rotate the angle of the arms. We use this to represent how a real-life basketball player tries to throw the ball.

## Installation

Download the Processing (https://processing.org/download/) application.
