env:

let template = env: args:
  let
    site = env.conf.theme.site;
    lib = env.lib;
    page = args.page;
  in ''
${if page.path == "/index.html" then ''
  <nav id="menu" class="navbar navbar-default navbar-fixed-top" data-spy="affix" data-offset-top="200" role="navigation">
'' else ''
  <nav id="menu" class="navbar navbar-inverse navbar-fixed-top" role="navigation">
''}
  <div class="container">
    <!-- Brand and toggle get grouped for better mobile display -->
    <div class="navbar-header">
      <button type="button" class="navbar-toggle collapsed" data-toggle="collapse" data-target="#bs-navbar-collapse" aria-expanded="false">
        <span class="sr-only">Toggle navigation</span>
        <span class="navbar_toggle_collapsed glyphicon glyphicon-menu-hamburger"></span>
        <span class="navbar_toggle_expanded glyphicon glyphicon-remove"></span>
      </button>
      <a class="navbar-brand" href="#"></a>
    </div>

    <!-- Collect the nav links, forms, and other content for toggling -->
    <div class="collapse navbar-collapse" id="bs-navbar-collapse">
      <ul class="nav navbar-nav navbar-right">
      ${
        let
          hasMenuCurrent = currentItem: path: false;
          renderItem = currentItem:
            if currentItem ? children then ''
              <li class="dropdown ${if (hasMenuCurrent currentItem page.path) then "active" else ""}">
                <a href="#" class="dropdown-toggle" data-toggle="dropdown" role="button" aria-haspopup="true" aria-expanded="false">${currentItem.name}<span class="caret"></span></a>
                <ul class="dropdown-menu">
                  ${
                    let
                      renderChild = child: ''
                        <li class="${if page.path == child.url then "active" else ""}">
                          <a href="${child.url}">${child.name}</a>
                        </li>
                      '';
                    in
                      lib.concatStringsSep "\n" (map renderChild currentItem.children)
                  }
                </ul>
              </li>
            '' else ''
              <li class="${if page.path == currentItem.url then "active" else ""}">
                ${if currentItem ? pre then ''
                  <a href="${currentItem.url}">
                    <img alt="${currentItem.name}" src="/img/${currentItem.pre}" width="20px">
                  </a>
                '' else ''
                  <a href="${currentItem.url}">${currentItem.name}</a>
                ''}
              </li>
            '';
        in
          lib.concatStringsSep "\n" (map renderItem site.nav)
      }
      </ul>
    </div><!-- /.navbar-collapse -->
  </div><!-- /.container-fluid -->
</nav>
'';
in with env.lib; documentedTemplate {
  description = ''
    Template rendering the nav header
  '';
  inherit env template;
}