--[[

(DO NOT DELETE): Default, Human
Default: fallback folder is material/name not found in holes
Human: folder used to do hitmarker to human parts



Folder Names:

"Name:[insert part name]" - if part's name is the mentioned part name, then this folder will be used
"[insert material name]" - if part's material matches this folder's material name, then this folder will be used





Folder Layout:

Holes 
- a random decal from here is used to make a bullet hole

Particles
- all ParticleEmitter instances inside "Used" folder are enabled for their max lifetime values
- make sure this is inside the folder and a "Used" folder is inside of Particles folder

Sounds
- a random sound from here is played

FlashDecals
- an ImageLabel from here is used to make a "flash" billboard gui effect

DontRecolor
- add an instance named this to not recolor the bullet hole in accordance with the part color
- you can remove this

HoleSize
- double constrained value, a size will be randomly chosen within the bounds of the MaxValue and MinValue
- keep this

Special - idk??? not used...

Flash
- Light object used to flash a light on the location of the bullet hit
Flash: Duration
- a number value that determines how long the flash will stay for (default value without this inserted is 0.1)



Particles:ParticleEmitter

Duration
- time the particles are enabled for (note this is different from the particle lifetime)
- can be added, default is 0.05

HitpartColor
- can be added as any object in order to make the particle's color the hitpart's color









FlashDecals:ImageLabel

Duration
- time the label is enabled for
- can be deleted, default = 0.07?

Size
- double constained value, the size of the flash will be randomly chosen within the bounds of MaxValue and MinValue
- can be deleted, default = 1

Trans
- same as Size, determines the transparency of the flash
- can be deleted, the image label's transparency itself will be used instead





















]]