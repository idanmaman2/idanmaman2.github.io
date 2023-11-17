import * as THREE from 'three';
import { OrbitControls } from 'OrbitControls';
import { GLTFLoader } from 'GLTFLoader';
const myCanvas = document.querySelector('#myCanvas');
const clock = new THREE.Clock();
let mixer;
let parrot;
let sx, sy, sz;
let factor = 1;
let speed = 3000;
let radius = 100;
let shift_x = 20;
let shift_y = -20;

if (window.matchMedia('(max-width: 600px)').matches) {
  radius = 50;
  shift_x = 20;
  shift_y = 0;
}

if (myCanvas.width != myCanvas.clientWidth || myCanvas.height != myCanvas.clientHeight) {
  myCanvas.width = myCanvas.clientWidth;
  myCanvas.height = myCanvas.clientHeight;
}

const scene = new THREE.Scene();

const camera = new THREE.PerspectiveCamera(50, myCanvas.offsetWidth / myCanvas.offsetHeight);
camera.position.set(1, 20, 230);
camera.lookAt(scene.position);

const hemiLight = new THREE.HemisphereLight( 0xccFFFF, 0xffffff, 4.5 );
hemiLight.color.setHSL( 0.6, 1, 0.6, THREE.SRGBColorSpace );
hemiLight.groundColor.setHSL( 0.095, 1, 0.75, THREE.SRGBColorSpace );
hemiLight.position.set( 0, 50, 0 );
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

loader.load('/css/threejs/model/Parrot.glb', function (gltf) {
  const model = gltf.scene.children[0];
  const clip = gltf.animations[0];
  parrot = model;
  mixer = new THREE.AnimationMixer(gltf.scene);

  gltf.animations.forEach((clip) => {
    mixer.clipAction(clip).play();
  });

  orbitControls.target.copy(model.position);
  scene.add(model);
  sx = model.position.x;
  sy = model.position.y;
  sz = model.position.z;
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
camera.aspect = window.innerWidth / window.innerHeight;
camera.updateProjectionMatrix();
renderer.setSize(window.innerWidth, window.innerHeight);
animate();

window.addEventListener('resize', onWindowResize, false);

// Debounce function
function debounce(func, wait) {
  let timeout;
  return function () {
    const context = this;
    const args = arguments;
    clearTimeout(timeout);
    timeout = setTimeout(() => {
      func.apply(context, args);
    }, wait);
  };
}

// Debounced scroll handler
const debouncedScroll = debounce(() => {
  animate();
}, 200); // Adjust the wait time as needed

document.addEventListener('scroll', debouncedScroll);

function onWindowResize() {
  camera.aspect = window.innerWidth / window.innerHeight;
  camera.updateProjectionMatrix();
  renderer.setSize(window.innerWidth, window.innerHeight);
}

function animate() {
  requestAnimationFrame(animate);
  const interval = 1 / 60;
  const delta = clock.getDelta();
  const time = Date.now() / speed;
  renderer.clearDepth();

  if (time % 50 == 0) {
    factor = Math.random();
  }

  const [angle1, angle2] = [time, time];

  if (mixer) {
    mixer.update(delta);
    parrot.position.x = sx + shift_x - 40 + Math.cos(angle1) * radius;
    parrot.position.y = sy + shift_y + Math.sin(angle1) * radius;
    parrot.position.z = sz + Math.sin(angle1) * radius;
    parrot.rotation.x = Math.cos(angle1) * Math.PI / 3;
    parrot.rotation.x = Math.cos(angle1) * Math.PI / 6;
  }

  renderer.render(scene, camera);
}
