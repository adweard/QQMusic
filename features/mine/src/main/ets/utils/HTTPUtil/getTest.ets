import { http } from '@kit.NetworkKit'

interface testm {
  code: number,
  message: string
}

class testHTTP {
  getTest(): Promise<testm> {
    return new Promise((resolve, reject) => {
      //创建http请求
      let httpRequest = http.createHttp()

      //发送http请求
      httpRequest.request(
        `http://127.0.0.1:18090/hi/invoke`,
        {
          method: http.RequestMethod.POST,
          extraData: {}
        }
      )
        .then(resp => {
          if (resp.responseCode == 200) {
            console.log('testTag', '测试成功!', resp.result)
            resolve(JSON.parse(resp.result.toString()))

          } else {
            console.log('testTag', '测试失败', JSON.stringify(resp))
            reject('测试失败')
          }
        })

    })
  }
}

const testHttp = new testHTTP()

export default testHttp as testHTTP