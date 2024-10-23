import { image } from '@kit.ImageKit';
import { resourceManager } from '@kit.LocalizationKit';

export default function getPixelMap(context: Context, imageName: string): image.PixelMap {
  const resourceMgr: resourceManager.ResourceManager = context.resourceManager
  const fileData: Uint8Array = resourceMgr.getRawFileContentSync(imageName)
  const buffer = fileData.buffer.slice(0)
  const imageSource: image.ImageSource = image.createImageSource(buffer)
  return imageSource.createPixelMapSync()

}