class PaddingSizeModel {
  double? top = 0;
  double? bottom = 0;
  double? left = 0;
  double? right = 0;

  PaddingSizeModel({double? top, double? bottom,double? left,double? right}) {
    if (top == null) {
      this.top = 0;
    } else{
      this.top = top;
    }if (bottom == null) {
      this.bottom = 0;
    }else{
      this.bottom = bottom;
    }
    if (right == null) {
      this.right = 0;
    }else{
      this.right = right;
    }
    if (left == null) {
      this.left = 0;
    }else{
      this.left = left;
    }
  }
}
