import * as THREE from 'three';
import { OrbitControls } from 'OrbitControls';
import { GLTFLoader } from 'GLTFLoader';

if(!window.matchMedia("(max-width: 600px)").matches) {
  const myCanvas = document.querySelector('#myCanvas');
  var clock = new THREE.Clock();
  var mixer1,mixer2,mixer3 , mixer4 ; 
  var hat ; 
  var neckless ; 
  var parrot  = [] ; 
  var sx,sy,sz ; 
  var shx,shy,shz ;
  var snx,sny,snz ;
  var factor = 1 ; 
  var speed = 3000 ; 
  var radius = 100 ; 
  var shift_x = 20  ; 
  var shift_y = -30  ; 
  var mobile = false ; 
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

  const renderer = new THREE.WebGLRenderer({ canvas: myCanvas });
  renderer.setClearColor(0xffffff, 1.0); 
  renderer.setPixelRatio(window.devicePixelRatio);
  renderer.setSize(myCanvas.offsetWidth, myCanvas.offsetHeight);
  renderer.autoClear = false;

    const loader = new GLTFLoader();
    loader.load('/css/threejs/model/hat_x_parrot.glb', function (gltf) {
      const model1 = gltf.scene.children[0];
      const model2 = model1.clone(); // Clone the first model
      const model3 = gltf.scene.children[1];
      const model4 = gltf.scene.children[2];
    
      // Clone the animation clip for each model
      const clip1 = gltf.animations[0].clone();
      const clip2 = clip1.clone();
      const clip3 =  gltf.animations[1].clone();
      const clip4 =  gltf.animations[2].clone();
    
       mixer1 = new THREE.AnimationMixer(model1);
       mixer2 = new THREE.AnimationMixer(model2);
       mixer3 = new THREE.AnimationMixer(model3);
       mixer4 = new THREE.AnimationMixer(model4);
        
      mixer1.clipAction(clip1).play();
      mixer2.clipAction(clip2).play();
      mixer3.clipAction(clip3).play();
      mixer4.clipAction(clip4).play();
    
      const wireframeMaterial = new THREE.MeshBasicMaterial({color : 0xff0000 , wireframe: true})
    
      model1.material = wireframeMaterial;
    
      // Add both models to the parrots array
      parrot.push(model1, model2);
      hat = model3 ; 
      neckless = model4 ; 
      orbitControls.target.copy(model1.position);
    
      scene.add(model1);
      scene.add(model2);
      scene.add(model3);
      scene.add(model4);
    
      sx = model1.position.x;
      sy = model1.position.y;
      sz = model1.position.z;

      shx = model3.position.x;
      shy = model3.position.y;
      shz = model3.position.z;

      snx = model4.position.x;
      sny = model4.position.y;
      snz = model4.position.z;




    }, undefined, function (error) {
      console.error(error);
    });



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


    if ( mixer1 && mixer2 && mixer3 && mixer4) {
        mixer1.update( delta );
        mixer2.update( delta );
        mixer3.update( delta );
        for(var model of parrot){
          model.position.x = sx + shift_x + Math.cos(angle1) * radius ;
          model.position.y= sy + shift_y+ Math.sin(angle1) *  radius ; 
          model.position.z = sz + Math.sin(angle1) * radius ; 
         // model.rotation.x =  Math.cos(angle1) * Math.PI/3
       //   model.rotation.y =  Math.cos(angle1 + Math.random() * Math.PI / 100) * Math.PI/6 
        }
        hat.position.x = shx + shift_x + Math.cos(angle1) * radius ;
        hat.position.y= shy + shift_y + Math.sin(angle1) *  radius ; 
        hat.position.z = shz + Math.sin(angle1) * radius ; 

        neckless.position.x = snx + shift_x + Math.cos(angle1) * radius ;
        neckless.position.y= sny + shift_y + Math.sin(angle1) *  radius ; 
        neckless.position.z = snz + Math.sin(angle1) * radius ; 

         
       // hat.rotation.x =  Math.cos(angle1) * Math.PI/3
       // hat.rotation.y =  Math.cos(angle1 + Math.random() * Math.PI / 100) * Math.PI/6 



        parrot[0].material.color.setHex(Math.abs(Math.cos(angle1)) * 256 * 256)
      }

    renderer.render( scene, camera );

  }
}






