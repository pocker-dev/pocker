class RouteArgument {
  String? id;
  String? name;
  int tabIndex;

  RouteArgument({
    required this.id,
    required this.name,
    this.tabIndex = 0,
  });

  RouteArgument.id({
    required this.id,
    this.tabIndex = 0,
  });

  RouteArgument.name({
    required this.name,
    this.tabIndex = 0,
  });

  String get shortId {
    return name ?? (id!.length > 12 ? id!.substring(0, 12) : id!);
  }

  String get identity {
    return name ?? id!;
  }

  List<String> get imageRepositoryTag {
    if (name == null) {
      return ['<none>', ''];
    }
    final repoTags = name!.split(':');
    if (repoTags.length == 1) {
      repoTags.add('latest');
    }
    return repoTags;
  }
}
