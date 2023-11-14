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
@section[#:style 'unnumbered]{Terminal}
@section[#:style 'unnumbered]{Docker}
@section[#:style 'unnumbered]{Reversing tools}
@section[#:style 'unnumbered]{Developing}
@section[#:style 'unnumbered]{Etc}
