class HomePageModel {
  String? pageTitle;
  List<Widgets>? widgets;

  HomePageModel({this.pageTitle, this.widgets});

  HomePageModel.fromJson(Map<String, dynamic> json) {
    pageTitle = json['page_title'];
    if (json['widgets'] != null) {
      widgets = <Widgets>[];
      json['widgets'].forEach((v) {
        widgets!.add(new Widgets.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['page_title'] = this.pageTitle;
    if (this.widgets != null) {
      data['widgets'] = this.widgets!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Widgets {
  String? widgetTitle;
  String? widgetType;
  int? rank;
  bool? hasHeader;
  bool? hasBackground;
  String? header;
  String? background;
  double? itemsHeight;
  double? itemsWidth;
  List<WidgetItems>? widgetItems;

  Widgets(
      {this.widgetTitle,
      this.widgetType,
      this.rank,
      this.hasHeader,
      this.hasBackground,
      this.header,
      this.background,
      this.itemsHeight,
      this.itemsWidth,
      this.widgetItems});

  Widgets.fromJson(Map<String, dynamic> json) {
    widgetTitle = json['widget_title'];
    widgetType = json['widget_type'];
    rank = json['rank'];
    hasHeader = json['has_header'];
    hasBackground = json['has_background'];
    header = json['header'];
    background = json['background'];
    itemsHeight = json['items_height'];
    itemsWidth = json['items_width'];
    if (json['widget_items'] != null) {
      widgetItems = <WidgetItems>[];
      json['widget_items'].forEach((v) {
        widgetItems!.add(new WidgetItems.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['widget_title'] = this.widgetTitle;
    data['widget_type'] = this.widgetType;
    data['rank'] = this.rank;
    data['has_header'] = this.hasHeader;
    data['has_background'] = this.hasBackground;
    data['header'] = this.header;
    data['background'] = this.background;
    data['items_height'] = this.itemsHeight;
    data['items_width'] = this.itemsWidth;
    if (this.widgetItems != null) {
      data['widget_items'] = this.widgetItems!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class WidgetItems {
  String? imageUrl;
  String? url;
  String? type;
  int? rank;

  WidgetItems({this.imageUrl, this.url, this.type, this.rank});

  WidgetItems.fromJson(Map<String, dynamic> json) {
    imageUrl = json['image_url'];
    url = json['url'];
    type = json['type'];
    rank = json['rank'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['image_url'] = this.imageUrl;
    data['url'] = this.url;
    data['type'] = this.type;
    data['rank'] = this.rank;
    return data;
  }
}
