# Binaural_Soundscape
Binaural Soundscape is a small project to dinamically generate your personalized binaural soundscape, with several sounds flying around your head.

The principle is very easy: the app loads all the sounds in a folder data and draws them as planets orbiting around your head. If the sound is at your left, you will hear it coming from left, and if it is at your right, you will hear it coming from your right. 
The further the planet, the lower its sound and viceversa. Also the color of the planets change depending on how close to you they are.

You don't have to look at them, you can simply start it and enjoy your soundscape while you are working, focusing, trying to sleep or, why not, experiment a different mix for your music. 

## How to use it with Processing
Install Processing from www.processing.org

Put some monophonic wav files in the data folder. You can remove the default one, if you don't want it. Then you simply execute it and here's your soundscape.

### How to customize it
You can customize your soundscape in different ways. Fist of all, you can choose whichever sound you prefer. Second, here the customizable parameters from the config.json file and their use:

**Visual parameters**
- ```OPACITY_BACKGROUND```: the opacity, between 0 and 255, of the black background;  
- ```MIN_SATURATION```: the minimum value of the planets' color saturation, maximum is 255 when the distance from the center is 0;
- ```MIN_BRIGHTNESS```:  the minimum value of the planets' color brightness, maximum is 255 when the distance from the center is 0;
- ```MIN_HUE``` and  ```MAX_HUE```: range of the hue values from 0 to 255, as explained in https://purple11.com/basics/hue-saturation-lightness/. If you want to select range beween the borders (red values), you can select a ```MAX_HUE```<```MIN_HUE```, for example: ```MAX_HUE=30```, ```MIN_HUE=225``` and the app will take
- ```MINAXIS_FACTOR```: 0.3499999940395355,
- ```CENTER_RADIUS```: 100,
- ```MAXRADIUS```: 20,


**Audio parameters**
- ```LIMITPAN```: 0.9900000095367432,
- ```MINRADIUS_FACTOR```: 0.009999999776482582,
- ```MINFREQ```: 0.01666666753590107,
- ```MIN_PHASE_DIFF```: 0.7853981852531433,
- ```MINAMP```: 0.10000000149011612,
- ```MAXAXIS_FACTOR```: 0.949999988079071,
- ```MAXFREQ```: 0.03333333507180214


### Support for mp3 files
If you have an mp3 decoder installed in your system, you can use mp3s by changing the line

```
if(!filenames[i].endsWith(".wav")){
```
into

```
if(!filenames[i].endsWith(".mp3")){
```


## How to use it with Processing.js
To be done