import getPixelMap from "./getPixelMapItem"
import { Context } from "@kit.AbilityKit"
import { effectKit } from "@kit.ArkGraphics2D"
import { BusinessError } from "@kit.BasicServicesKit"

export default function getAverageColor(context: Context, imgName: string): string[] {
  // 获取pixelMap对象
  let PixelMap = getPixelMap(context, imgName)
  let colorList: string[] = ['', '']
  effectKit.createColorPicker(PixelMap).then(cp => {
    let color = cp.getAverageColor()
    colorList[0] = 'rgb(' + color.red + ',' + color.green + ',' + color.blue + ')'
    colorList[1] = 'rgba(' + color.red + ',' + color.green + ',' + color.blue + ',0)'
    // t = parseInt(t).toString(16).toUpperCase()
    console.log('测试t' + colorList.toString())
  })
  PixelMap.release().then(() => {
    console.log('测试Succeeded in releasing pixelmap object.');
  }).catch((error: BusinessError) => {
    console.log(`测试Failed to release pixelmap object. code is ${error.code}, message is ${error.message}`);
  })
  PixelMap.release()
  return colorList
}