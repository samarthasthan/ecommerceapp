class FilterProductsModel {
  Options? options;
  List<Colors>? colors;

  FilterProductsModel({this.options, this.colors});

  FilterProductsModel.fromJson(Map<String, dynamic> json) {
    options =
        json['options'] != null ? new Options.fromJson(json['options']) : null;
    if (json['colors'] != null) {
      colors = <Colors>[];
      json['colors'].forEach((v) {
        colors!.add(new Colors.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.options != null) {
      data['options'] = this.options!.toJson();
    }
    if (this.colors != null) {
      data['colors'] = this.colors!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Options {
  List<Size>? size;

  Options({this.size});

  Options.fromJson(Map<String, dynamic> json) {
    if (json['Size'] != null) {
      size = <Size>[];
      json['Size'].forEach((v) {
        size!.add(new Size.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.size != null) {
      data['Size'] = this.size!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Size {
  String? name;
  int? productCount;

  Size({this.name, this.productCount});

  Size.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    productCount = json['product_count'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['name'] = this.name;
    data['product_count'] = this.productCount;
    return data;
  }
}

class Colors {
  String? color;
  String? colorHex;
  int? productCount;

  Colors({this.color, this.colorHex, this.productCount});

  Colors.fromJson(Map<String, dynamic> json) {
    color = json['color'];
    colorHex = json['color_hex'];
    productCount = json['product_count'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['color'] = this.color;
    data['color_hex'] = this.colorHex;
    data['product_count'] = this.productCount;
    return data;
  }
}
