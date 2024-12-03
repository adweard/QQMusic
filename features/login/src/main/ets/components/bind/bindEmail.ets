import auth from "@hw-agconnect/auth"
import { getVerByEmail } from "../getVer/getVerByEmail"
import { BusinessError } from "@kit.BasicServicesKit"
import { promptAction } from "@kit.ArkUI"

@Component
export struct bindEmail {
  @StorageLink('pageIndexInfos') pageIndexInfos: NavPathStack = new NavPathStack()
  //邮箱
  @Provide email: string = ''
  //验证码
  @Provide verCode: string = ''

  build() {
    Column({ space: 20 }) {

      //占位
      Blank()
        .height('20%')

      //输入邮箱
      TextInput({ placeholder: '请输入邮箱' })
        .type(InputType.Email)
        .width('80%')
        .onChange(val => {
          this.email = val
        })

      //获取验证码
      getVerByEmail()
        .width('80%')

      //确认更改按钮
      Button('确认')
        .onClick(() => {
          this.bind()
        })


    }
  }

  async linkEmail() {
    let user = await auth.getCurrentUser()
    user?.link({
      kind: 'email',
      email: this.email,
      verifyCode: this.verCode
    }).then((res) => {
      promptAction.showToast({message:'绑定成功！',duration:2000})
      this.pageIndexInfos.clear()
    }).catch((err: BusinessError) => {
      if (err.message == 'please log in before operation') {
        promptAction.showToast({ message: '绑定出错!\n请重新登陆后再试！', duration: 2500 })
      }
      promptAction.showToast({ message: '绑定出错，请稍后再试!' })
      console.log('测试 绑定出错' + JSON.stringify(err))
    })
  }

  async updateEmail() {
    let user = await auth.getCurrentUser()
    user?.updateEmail({
      email: this.email,
      lang: 'zh_CN',
      verifyCode: this.verCode
    }).then(res => {
      this.pageIndexInfos.clear()
    }).catch((err: BusinessError) => {
      promptAction.showToast({ message: '绑定出错，请稍后再试!' })
      console.log('测试 绑定出错' + JSON.stringify(err))
    })
  }

  async bind() {
    let use = await auth.getCurrentUser()
    if ((typeof use?.getEmail()) === 'undefined' || use?.getEmail() == '') {
      //没有绑定过邮箱
      this.linkEmail()
    } else if ((use?.getEmail())!.length > 0) {
      this.updateEmail()
    }
  }
}