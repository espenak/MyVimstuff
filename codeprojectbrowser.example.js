{
    "~/code/": {
        "handler": "hiddendirectory",
        "devilry-django": {
            "handler": "project",
            "devilry": {
                "handler": "pythonsrc",
                "layout": "flat"
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
