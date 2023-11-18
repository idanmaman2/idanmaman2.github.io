import * as THREE from 'three';
import { OrbitControls } from 'OrbitControls';
import { GLTFLoader } from 'GLTFLoader';
const myCanvas = document.querySelector('#myCanvas');
var clock = new THREE.Clock();
var mixer ; 
var parrot ; 
var sx,sy,sz ; 
var factor = 1 ; 
var speed = 3000 ; 
var radius = 100 ; 
var shift_x = 20  ; 
var shift_y = -30  ; 
var mobile = false ; 
if(window.matchMedia("(max-width: 600px)").matches) {
  mobile = true ; 
  radius = 50 ; 
  speed = 15000;
  shift_x = 20 ; 
  shift_y = 0 ;  
}

if(myCanvas.width != myCanvas.clientWidth || myCanvas.height != myCanvas.clientHeight){
  //Resize
  myCanvas.width = myCanvas.clientWidth;
  myCanvas.height = myCanvas.clientHeight;
}



const scene = new THREE.Scene();

var parrot ; 

const camera = new THREE.PerspectiveCamera(
  50,
  myCanvas.offsetWidth / myCanvas.offsetHeight
);
camera.position.set(1, 20, 230);
camera.lookAt(scene.position);

const hemiLight = new THREE.HemisphereLight( 0xccFFFF, 0xffffff, 4.5 );
hemiLight.color.setHSL( 0.6, 1, 0.6, THREE.SRGBColorSpace );
hemiLight.groundColor.setHSL( 0.095, 1, 0.75, THREE.SRGBColorSpace );
hemiLight.position.set( 0, 0, 0 );
scene.add( hemiLight );

const dirLight = new THREE.DirectionalLight( 0x00CED1, 2.0 );
dirLight.color.setHSL( 0.1, 1, 0.95, THREE.SRGBColorSpace );
dirLight.position.set( - 1, 1.75, 1 );
dirLight.position.multiplyScalar( 30 );
scene.add( dirLight );


var geometry , material , torusKnot ; 
if(mobile){
 geometry = new THREE.TorusKnotGeometry(10, 3, 100, 16);
 var material = new THREE.ShaderMaterial({
  uniforms: {
    color1: {
      value: new THREE.Color("red")
    },
    color2: {
      value: new THREE.Color("purple")
    } , 
    color3 : {
      value : new THREE.Color("orange")
    }
  },
  vertexShader: `
    varying vec2 vUv;

    void main() {
      vUv = uv;
      gl_Position = projectionMatrix * modelViewMatrix * vec4(position,1.0);
    }
  `,
  fragmentShader: `
    uniform vec3 color1;
    uniform vec3 color2;
    uniform vec3 color3;
  
    varying vec2 vUv;
    
    void main() {
      
      gl_FragColor = vec4(mix(color3 * 0.1 + color1, color3 * 0.1  + color2 , vUv.y), vUv.x);
    }
  `,
  wireframe: true
});
 torusKnot = new THREE.Mesh(geometry, material);
 scene.add(torusKnot);
}


const renderer = new THREE.WebGLRenderer({ canvas: myCanvas });
renderer.setClearColor(0xffffff, 1.0); 
renderer.setPixelRatio(window.devicePixelRatio);
renderer.setSize(myCanvas.offsetWidth, myCanvas.offsetHeight);
renderer.autoClear = false;






if(!mobile) {
  const loader = new GLTFLoader();
  loader.load( '/css/threejs/model/Parrot.glb', function ( gltf ) {
    const model = gltf.scene.children[0];
    const clip = gltf.animations[0];
    parrot = model ; 
    mixer = new THREE.AnimationMixer( gltf.scene );
          
    gltf.animations.forEach( ( clip ) => {
      
        mixer.clipAction( clip ).play();
      
    } );
    orbitControls.target.copy(model.position);
    scene.add( model );
    sx = model.position.x ; 
    sy = model.position.y ; 
    sz = model.position.z;
  }, undefined, function ( error ) {

    console.error( error );

  } );
}


const orbitControls = new OrbitControls(camera, renderer.domElement);
orbitControls.maxPolarAngle = Math.PI * 0.5;
orbitControls.minDistance = 0.1;
orbitControls.maxDistance = 100;
orbitControls.autoRotate = true;
orbitControls.enabled = false;
orbitControls.autoRotateSpeed = 1.0; 
camera.aspect = window.innerWidth / window.innerHeight
camera.updateProjectionMatrix()
renderer.setSize(window.innerWidth, window.innerHeight)
animate()

window.addEventListener('resize', onWindowResize, false)
function onWindowResize() {
    camera.aspect = window.innerWidth / window.innerHeight
    camera.updateProjectionMatrix()
    renderer.setSize(window.innerWidth, window.innerHeight)
}

document.addEventListener("scroll", (event) => {
  animate()
});


function animate() {
  requestAnimationFrame( animate );
  const interval = 1 / 60 ; 
  var delta = clock.getDelta();
  var time = Date.now() / speed ; 
  renderer.clearDepth();
  var [angle1 , angle2 ] = [time  , time] ; 
  if(mobile){
    torusKnot.material.uniforms.color1.value.set(-Math.abs(Math.cos(angle1) * 256))
    torusKnot.material.uniforms.color2.value.set(Math.abs(Math.sin(angle1) * 256))
    torusKnot.scale.setScalar( Math.sin(angle1) * radius/10);
    torusKnot.tube = Math.sin(angle1) * radius ; 
    torusKnot.rotation.x =  Math.sin(angle1)  ;
    torusKnot.rotation.y=  Math.sin(angle1) ; 
    console.log(JSON.stringify(torusKnot));
  }
  else{
  if ( mixer ) {
      mixer.update( delta );
      parrot.position.x = sx + shift_x - 40  + Math.cos(angle1) * radius ;
      parrot.position.y= sy + shift_y+ Math.sin(angle1) *  radius ; 
      parrot.position.z = sz + Math.sin(angle1) * radius ; 
      parrot.rotation.x =  Math.cos(angle1) * Math.PI/3
      parrot.rotation.y =  Math.cos(angle1 + Math.random() * Math.PI / 100) * Math.PI/6 
    }
  }
  renderer.render( scene, camera );

}







