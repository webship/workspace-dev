Build a site in the dev folder with one of its builders and prove it with its first Webship-js feature.

The launch line is for Claude Code, the default; the text between the triple quotes can be given to another AI CLI as it is.

```
claude --permission-mode bypassPermissions """
Build a site named <name> in the dev folder with <builder> and test it with Webship-js
# ~/workspace/dev · https://<name>.ddev.site · container-based (DDEV by default)
# <builder> is a cmd-*-project.sh of the folder, for example cmd-drupal11-recommended-project.sh
# the builder deletes a project of the same name first: stop if <name> is a site somebody still needs
# nothing on the host: no composer, drush, npm or mysql outside the site's container

1. bash <builder> --help
   tell me the flags it takes
2. bash <builder> <name> --install --add-users
3. bash cmd-tools-hostnames.sh <name>
   tell me the address the site answers at
4. bash cmd-tools-testing.sh <name>
   Webship-js and the first feature, in the site's container
5. bash cmd-tools-testing.sh <name> --dry-run
6. bash cmd-tools-testing.sh <name> --run

If a command fails, show the line that failed and stop. Do not retry with other flags.
When the suite is green: the address, and how many scenarios and steps passed.
Then ask me whether to keep the site or remove it with: bash cmd-tools-remove.sh <name>
"""
```
