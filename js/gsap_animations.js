gsap.fromTo(`#gsap_author`,
            { y : "-100px" , x:"-100px",  color: "#10ff48", rotation: 0 ,scale : 10  },
            {
                x: "0px" ,
                y : "0px",
                color: "#000000" , 
                duration: 1.5,
                ease: "expo",
                rotation: 360,
                scale: 1,

            })
setTimeout(function(){
    gsap.fromTo(`#gsap_content`,
            { y : "-100px" , x:"-100px"},
            {
                x: "0px" ,
                y : "0px",
                display : "block", 
                duration: 1 ,
                ease: "bounce",


            })
} , 1500 ) 