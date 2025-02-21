## Davinci Resolve AAC to flac fix

### Issue
Currently, v19 of the excellent Blackmagic DaVinci Resolve video editor does not handle AAC on Linux.

Because of this, I - along with ChatGPT to help with my poor bash syntax underastanding these days - created a script to navigate a simple folder structure, and when it finds an mp4 video file, it converts the audio stream from AAC to flac and appends '- flac' to the name, leaving the original as is.

It sounds limited, but it's really just for dealing with my pile of action camera clips on my Mint Linux 22.1 box, so I can edit them with audio!

#### Requirements:
bash :)
ffmpeg - all powerful audio visual toolkit
parallel - I added this to spin up more instances of ffmpeg.