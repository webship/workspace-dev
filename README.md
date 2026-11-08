# @webship.co/workspace-dev

The **Dev** workspace of the [Webship Workspace](https://github.com/webship/workspace) dashboard:
the `dev/` folder (type `sites`), its settings file (`core/config/workspace.dev.settings.yml`),
its commands and its docs, as a plugin.

## Use it

```bash
cd ~/workspace
bash core/scripts/plugins.sh --require github:webship/workspace-dev
bash core/scripts/plugins.sh --activate dev     # puts `dev` on the workspaces list of settings.yml
bash core/scripts/plugins.sh --install dev      # the folder, its settings file (once), its commands, its docs (once)
```

The settings file and the docs are placed once and never overwritten: they hold what you put there.
`--deactivate` takes the workspace off the list; the folder and its content stay.

## The commands

| Command |
| --- |
| (none) |

The bash functions these commands call live in the dashboard's `core/scripts/functions`.
