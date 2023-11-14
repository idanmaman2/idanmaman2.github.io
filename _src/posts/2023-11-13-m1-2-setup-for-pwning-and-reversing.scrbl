#lang scribble/manual

Title: My setup for apple M1/2
Date: 2023-11-14T16:58:33
Tags: M1,M2,Pwning,Reversing

@(require (for-label racket))
@(require racket/string)
The source of this post is Scribble format (not Markdown) - SO YEY I guess or somethind IDC.

So Today I am going to show you my setup .
that will include :
@table-of-contents[]


<!-- more -->

@section[#:style 'unnumbered]{Emulation}


So Emulation in macos in the m series is a nightmare everthing is so slow if we are trying to use any graphicl feature or something like that . 
this is why I recommend to install a server version or any os without desktop env . 
Personaly I use Ubuntu server . 
any kind of modern windows will not be useable !!! 
only old version like xp or 95 . 

@subsection[#:style 'unnumbered]{Setup}

So firstly you need to Install  
@hyperlink["https://mac.getutm.app"
"UTM"].

UTM is just a gui warpper of qemu - so if you are in kernel pwning just use qemu directly . 

so after that we can add a machine - 

@image["img/posts/2023-11-13-m1-2-setup-for-pwning-and-reversing/Screenshot 2023-11-14 at 0.00.15.png"]

Or if we want to directly use qemu - just 

@(require frog/scribble)

@pygment-code[#:lang "bash"]{
  qemu-system-x86_64 disk_image 
}

later on I will show more things about qenu - this is the most basic form . 

@section[#:style 'unnumbered]{Virtualization}
For Virtualization I am using VMWare Fusion(12)
@image["img/posts/2023-11-13-m1-2-setup-for-pwning-and-reversing/Screenshot 2023-11-14 at 21.33.58.png"]
Personaly I am using Windows 11 and Fedora . 
Disclaimer: Windows 11 arm is sucks - you can't use a lot of tools becuase you can't run x64 drivers and any type of Remote process memory write didnt work for me in windows arm so a lot of tools like cmder doesn't work as well . 
@subsection[#:style 'unnumbered]{Linux}
@image["img/posts/2023-11-13-m1-2-setup-for-pwning-and-reversing/Screenshot 2023-11-14 at 21.37.44.png"]
@subsection[#:style 'unnumbered]{Windows}
@image["img/posts/2023-11-13-m1-2-setup-for-pwning-and-reversing/Screenshot 2023-11-14 at 21.39.10.png"]



@section[#:style 'unnumbered]{Terminal}
At start I used the default terminal for a while - it is pretty nice but @bold{Warp}
is a major upgrade to that . 
link to warp : @hyperlink["warp.dev"]
so with warp you have AI chat  , tmux like windows spliting , warp supporting ssh with bash/fish/zsh - that means you can use all warp's features with your remote machine . 
so it is pretty cool and have a realy nice gui and text complete so try it ! 
@section[#:style 'unnumbered]{Docker}
so I can't say much - it works pretty nice , you can emualte x86 containers or use arm 
it is not uses the native kernel it is Virtualalized but it still works great . 
@section[#:style 'unnumbered]{Reversing tools}
so that is going to be a long section : 
@subsection[#:style 'unnumbered]{PE edit tools}


@section[#:style 'unnumbered]{Developing}
@section[#:style 'unnumbered]{Etc}
