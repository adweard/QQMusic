@Component
export struct musicCoverImg {
  @Consume musicImg: string
  @State angel: number = 0

  aboutToAppear(): void {
    animateTo({

      duration: 20000,
      iterations: -1,
      curve: Curve.Linear

    }, () => {
      this.angel = 360
    })
  }

  build() {
    Image($r(this.musicImg))
      .size({ width: 300, height: 300 })
      .borderRadius(220)
      .border({ width: 40, color: "#ff1d1d1d" })
      .rotate({
        angle: this.angel
      })
  }
}