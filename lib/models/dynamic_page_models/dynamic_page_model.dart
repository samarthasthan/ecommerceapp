class DynamicPageModel {
  String? pageTitle;
  List<Widgets>? widgets;

  DynamicPageModel({this.pageTitle, this.widgets});

  DynamicPageModel.fromJson(Map<String, dynamic> json) {
    pageTitle = json['page_title'];
    if (json['widgets'] != null) {
      widgets = <Widgets>[];
      json['widgets'].forEach((v) {
        widgets!.add(Widgets.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['page_title'] = pageTitle;
    if (widgets != null) {
      data['widgets'] = widgets!.map((v) => v.toJson()).toList();
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
        widgetItems!.add(WidgetItems.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['widget_title'] = widgetTitle;
    data['widget_type'] = widgetType;
    data['rank'] = rank;
    data['has_header'] = hasHeader;
    data['has_background'] = hasBackground;
    data['header'] = header;
    data['background'] = background;
    data['items_height'] = itemsHeight;
    data['items_width'] = itemsWidth;
    if (widgetItems != null) {
      data['widget_items'] = widgetItems!.map((v) => v.toJson()).toList();
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
    final Map<String, dynamic> data = <String, dynamic>{};
    data['image_url'] = imageUrl;
    data['url'] = url;
    data['type'] = type;
    data['rank'] = rank;
    return data;
  }
}
