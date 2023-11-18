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
@subsection[#:style 'unnumbered]{VmWare Fusion}
For Virtualization I am using VMWare Fusion(12)
@image["img/posts/2023-11-13-m1-2-setup-for-pwning-and-reversing/Screenshot 2023-11-14 at 21.33.58.png"]
Personaly I am using Windows 11 and Fedora . 
Disclaimer: Windows 11 arm is sucks - you can't use a lot of tools becuase you can't run x64 drivers and any type of Remote process memory write didnt work for me in windows arm so a lot of tools like cmder doesn't work as well . 
@subsubsection{Linux}
@image["img/posts/2023-11-13-m1-2-setup-for-pwning-and-reversing/Screenshot 2023-11-14 at 21.37.44.png"]
@subsubsection{Windows}
@image["img/posts/2023-11-13-m1-2-setup-for-pwning-and-reversing/Screenshot 2023-11-14 at 21.39.10.png"]



@section[#:style 'unnumbered]{Terminal}
@subsection{Warp}
At start I used the default terminal for a while - it is pretty nice but @bold{Warp}
is a major upgrade to that . 
link to warp : @hyperlink["warp.dev"]
so with warp you have AI chat  , tmux like windows spliting , warp supporting ssh with bash/fish/zsh - that means you can use all warp's features with your remote machine . 
so it is pretty cool and have a realy nice gui and text complete so try it ! 
@image["img/posts/2023-11-13-m1-2-setup-for-pwning-and-reversing/Screenshot 2023-11-19 at 0.59.30.png"]



@section[#:style 'unnumbered]{Packge Manager}
@pygment-code[#:lang "bash"]{
  /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
}

@section[#:style 'unnumbered]{Reversing and pwning}
so most of ur real job will be probaly in linux - but for static analysis it will much nicer to use gui on macos . 
so I will show a few tools - and mayn I will upload part B on linux later on . 
@subsection[#:style 'unnumbered]{PE edit tools}
@subsubsection{PE BEAR}
tool to analyze the PE format . 
@image["img/posts/2023-11-13-m1-2-setup-for-pwning-and-reversing/Screenshot 2023-11-16 at 2.58.43.png"]
@subsubsection{PortEx}
another tool to analyze the PE format with support of yara rules run in gui and rsrc files extraction and visualization of the enatropy of the sections . 
@image["img/posts/2023-11-13-m1-2-setup-for-pwning-and-reversing/Screenshot 2023-11-16 at 2.56.17.png"]
@subsubsection{Detect It Easy}
tools to recognize the compilers , linkers , packers that used to create that PE . 
@image["img/posts/2023-11-13-m1-2-setup-for-pwning-and-reversing/Screenshot 2023-11-16 at 3.09.36.png"]
@subsection[#:style 'unnumbered]{ELF edit tools}
@subsubsection{XELFViewer}
tool to analyze the ELF format 
@image["img/posts/2023-11-13-m1-2-setup-for-pwning-and-reversing/Screenshot 2023-11-19 at 1.09.24.png"]
@subsection[#:style 'unnumbered]{Reversing tools}
@subsubsection{IDA}
Interactive debuger to show the PE file code deassembled in graph mode and decompile it as well as advanced searches and tools and in the pro version there is option to add plugins and programming with python with the ida API . 
@image["img/posts/2023-11-13-m1-2-setup-for-pwning-and-reversing/Screenshot 2023-11-16 at 2.54.52.png"]
@subsubsection{Ghidra}
Like ida - open source not like ida with better decompiling in some cases and free decompiling to all the archs . 
@image["img/posts/2023-11-13-m1-2-setup-for-pwning-and-reversing/Screenshot 2023-11-19 at 1.05.59.png"]
@subsection[#:style 'unnumbered]{Netowrk analyze tools}
@subsubsection{wireshark}
packet analsis tool . 
@image["img/posts/2023-11-13-m1-2-setup-for-pwning-and-reversing/Screenshot 2023-11-19 at 1.10.31.png"]
@subsubsection{burpsuite}
tool to research of web applications .
@image["img/posts/2023-11-13-m1-2-setup-for-pwning-and-reversing/Screenshot 2023-11-19 at 1.13.56.png"]
@subsection[#:style 'unnumbered]{CLI tools}
@subsubsection{tshark}
@subsubsection{pev-tools : pestr , pecheck , peldd ... }

@section[#:style 'unnumbered]{Developing}
@subsection{Docker}
so I can't say much - it works pretty nice , you can emualte x86 containers or use arm 
it doesn't use the native kernel it is Virtualalized but it still works great . 
@section[#:style 'unnumbered]{Etc}
