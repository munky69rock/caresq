import Cropper from 'cropperjs';
import { ImageLoader, ImageUploader, ImageDrawer } from '../image';

class UserImageController {
  constructor() {
    this.$image = document.querySelector('#user_image');
    this.$canvas = document.querySelector('#canvas');
    this.$canvas_wrapper = document.querySelector('#canvas-wrapper');
    this.$form = document.querySelector('.edit_user');
    this.$submit = document.querySelector('#submit');

    this.cropper = null;
  }

  run() {
    this.$image.addEventListener('change', () => {
      this.$canvas_wrapper.style.display = 'block';
      this.$submit.disabled = false;

      const loader = new ImageLoader(this.$image);
      const drawer = new ImageDrawer(this.$canvas);
      loader.load(image => {
        drawer.draw(image);
        this.cropper = new Cropper(drawer.canvas, {
          aspectRatio: 1,
          autoCropArea: 1,
          rotatable: false,
          movable: false,
          scalable: false,
          zoomable: false
        });
      });
    });

    this.$form.addEventListener('submit', (e) => {
      this.$submit.disabled = false;
      e.preventDefault();
      e.stopPropagation();

      if (!this.cropper) {
        console.log('cropper not initialized');
        return;
      }

      this.cropper.getCroppedCanvas().toBlob(blob => {
        let uploader = new ImageUploader(this.$form);
        uploader.build({ 'user[image]': blob }).post().done(data => {
          location.href = '/user';
        }).fail(data => {
          this.$submit.disabled = true;
        });
      });
    });
  }
}

const controller = new UserImageController();
controller.run();
