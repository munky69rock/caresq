class ImageLoader {
  constructor(image) {
    this.image = image;
    this.reader = new FileReader();

    this.reader.addEventListener('load', (e) => {
      let image = new Image();
      image.src = e.target.result;
      image.addEventListener('load', () => {
        this.didLoad(image);
      });
    })
  }

  load(didLoad) {
    const blob = this.extractBlob();
    if (!blob) {
      console.log('no blob');
      return;
    }
    this.didLoad = didLoad;
    this.reader.readAsDataURL(blob);
  }

  extractBlob() {
    const files = this.image.files;
    if (files.length === 0) {
      console.log('no files');
      return;
    }

    const file = files[0];
    if (file.type.indexOf('image') === -1) {
      console.log('no image');
      return;
    }
    return file;
  }

  didLoad(image) {}
}

class ImageDrawer {
  constructor(canvas) {
    this.canvas = canvas;
    this.ctx = canvas.getContext('2d');
  }

  get MAXSIZE() {
    return 1024;
  }

  draw(img) {
    const size = Math.max(img.height, img.width);
    let rw = img.width;
    let rh = img.height;
    let rate = this.MAXSIZE / size;
    let len = Math.min(this.MAXSIZE, size);
    if (rate < 1) {
      console.log('resized');
      rw = img.width * rate;
      rh = img.height * rate;
    }
    this.canvas.width = len;
    this.canvas.height = len;

    if (rw === rh) {
      this.ctx.drawImage(img, 0, 0, img.width, img.height, 0, 0, rw, rh);
    } else if (rw > rh) {
      let ofs = (rw - rh)/2;
      this.ctx.drawImage(img, 0, 0, img.width, img.height, 0, ofs, rw, rh);
    } else {
      let ofs = (rh - rw)/2;
      this.ctx.drawImage(img, 0, 0, img.width, img.height, ofs, 0, rw, rh);
    }
  }
}

class ImageUploader {
  constructor(form) {
    this.$form = form;
    this.formData = new FormData();
  }

  get REQUIREMENTS() {
    return ['utf8', '_method', 'authenticity_token'];
  }

  build(attr) {
    Object.entries(attr).forEach(([key, value]) =>
      this.formData.append(key, value)
    );
    this.REQUIREMENTS.forEach(name =>
      this.addFormData(name)
    );
    return this;
  }

  post() {
    return $.ajax({
      type: 'post',
      url: this.$form.action,
      data: this.formData,
      processData: false,
      contentType: false,
    });
  }

  addFormData(name) {
    this.formData.append(name, this.$form.querySelector(`input[name=${name}]`).value);
  }
}

export { ImageLoader, ImageDrawer, ImageUploader };

