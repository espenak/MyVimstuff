{
    "~/code/": {
        "handler": "hiddendirectory",
        "devilry-django": {
            "handler": "project",
            "devilry": {
                "handler": "pythonsrc",
                "layout": "flat"
            },
            "static": {
                "directory": "devilry",
                "handler": "directory",
                "ignore": ["*.py", "*.pyc", "*deliverystore/*", "*/extjshelpers/extjs/*", "*/icons/*"]
            },
            "templates": {
                "directory": "devilry",
                "handler": "includedirectory",
                "include": ["*.django.html"]
            },
            "devilryclient": {
                "handler": "pythonsrc",
                "layout": "flat"
            },
            "docs": {
                "handler": "directory",
                "ignore": [".build*", "restfulapi*"]
            }
        }
    }
}
