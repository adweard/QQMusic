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
  })
  PixelMap.release().then(() => {
  }).catch((error: BusinessError) => {
  })
  PixelMap.release()
  return colorList
}