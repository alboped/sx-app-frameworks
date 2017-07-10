/**
 * 压缩图片
 * @param  {Element} img    图片元素
 * @param  {Object} options 参数
 * @return {void}
 */
export const compress = (img, options) => {
    const initSize = img.src.length;

    let width = img.width;
    let height = img.height;
    const canvas = document.createElement('canvas');
    const ctx = canvas.getContext('2d');

    /*
     如果图片大于四百万像素，计算压缩比并将大小压至400万以下
    */
    let ratio = (width * height) / 4000000;
    if (ratio > 1) {
        ratio = Math.sqrt(ratio);
        width /= ratio;
        height /= ratio;
    } else {
        ratio = 1;
    }
    canvas.width = width;
    canvas.height = height;

    /*
     铺底色
     */
    ctx.fillStyle = '#fff';
    ctx.fillRect(0, 0, canvas.width, canvas.height);
    ctx.drawImage(img, 0, 0, width, height);

    /*
     进行最小压缩
    */
    const ndata = canvas.toDataURL('image/jpeg', (options * 1024) / initSize);

    canvas.width = canvas.height = 0;
    return ndata;
};

export const base64Compress = (base64, fileSize, callback) => {
    const img = new Image();
    img.src = base64;
    img.onload = () => {
        callback(compress(img, fileSize));
    };
};
