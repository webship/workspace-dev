---
name: dev-workflow
description: How work is done in the `dev/` folder of the Webship Workspace — which `cmd-*.sh` builds which site, the flags of each command, how a site is tested with Webship-js, cloned, backed up and removed, and the settings keys of the folder. Use when asked to "build a site in dev", "which builder is there for Drupal CMS", "what does this dev command take", "set up testing on a dev site", "clone or remove a dev site", or when a command of `dev/` is about to be run.
argument-hint: '[what you are about to do in dev]'
---

# dev-workflow

`~/workspace/dev` is the Dev folder of a Webship Workspace (container-based, DDEV by default):
day-to-day development builds, where a site gets made to try something on and is tested with
Webship-js. It comes with the Dev plugin (`@webship.co/workspace-dev`), which places the commands
below in the folder. Every command finds the workspace from its own path; run it from the folder,
and read `bash <command> --help` before quoting a flag.

## The order of work

1. **Build** a site with a builder: `bash cmd-drupal11-recommended-project.sh mysite --install`.
   The name is the folder, the container project and the address (`https://mysite.ddev.site`).
   A builder deletes a project of the same name first.
2. **Set the testing stack up**: `bash cmd-tools-testing.sh mysite`. It adds Webship-js and the
   first feature (`mysite/tests/features/check-homepage.feature`), and keeps what was changed when
   it is run again.
3. **Match, then run**: `bash cmd-tools-testing.sh mysite --dry-run`, then
   `bash cmd-tools-testing.sh mysite --run`.
4. **Keep or clear**: `bash cmd-tools-backup-dev.sh mysite`, `bash cmd-tools-clone.sh mysite --to mysite2`,
   `bash cmd-tools-remove.sh mysite`.

## Builders

| Command | Builds | Flags |
| --- | --- | --- |
| `cmd-drupal11-recommended-project.sh` | Drupal 11, the latest release | `--install` `--add-users` `--profile` `--require` `--enable` `--dev` `--php-version` `--launch` |
| `cmd-drupal12-recommended-project.sh` | Drupal 12, the latest release | the same |
| `cmd-drupal11-4-x-recommended-project.sh`, `cmd-drupal11-4-0-recommended-project.sh`, `cmd-drupal11-0-x-recommended-project.sh` | One Drupal 11 line or release | the same |
| `cmd-drupal10-recommended-project.sh`, `cmd-drupal10-3-x-recommended-project.sh`, `cmd-drupal9-recommended-project.sh` | Older Drupal lines | the same |
| `cmd-drupalcms2-x-project.sh`, `cmd-drupalcms2-1-0-project.sh` | Drupal CMS 2 | `--install` `--add-users` `--php-version` |
| `cmd-webship11-0-x-project.sh`, `cmd-webship11-0-0-project.sh` | Webship 11 | `--install` `--add-users` `--require` `--enable` `--php-version` `--skip-set-default-settings` `--skip-drop-database` |
| `cmd-webships2-0-x-project.sh`, `cmd-webships2-0-0-project.sh` | Webships 2 | the same as Webship |
| `cmd-webships3-0-x-project.sh` | Webships 3, from a site template | `--template` `--add-users` `--php-version` |
| `cmd-cucumber11-0-x-project.sh` | Cucumber 11 | the same as Webship |
| `cmd-wordpress-project.sh`, `cmd-wpbedrock1-project.sh`, `cmd-odoo20-project.sh` | Example builders for other platforms; a platform's plugin brings the full one | `--install` `--launch` |

`--install` installs the site (without it the installer waits at the address); `--add-users` adds
the default accounts of the distribution; `--profile` is `standard`, `minimal` or `umami`;
`--require "drupal/token:~1.0"` adds packages and `--enable "token"` turns modules on after the
install; `--dev` builds the development branch.

## Tools

| Command | What it does | Flags |
| --- | --- | --- |
| `cmd-tools-testing.sh` | Sets the Webship-js testing stack up on a site, or runs its suite in the site's container | `--configure` `--run` `--dry-run` `--path` `--tags` `--browser` `--headed` `--retry` |
| `cmd-tools-checks.sh` | Runs the code-quality checks the site's `package.json` declares | `--list` `--only` `--skip` `--e2e` `--browser` `--install` `--runner` `--fail-fast` |
| `cmd-tools-add-users.sh`, `cmd-tools-cancel-users.sh` | Adds or removes the default accounts: `<site> <distribution>` | none |
| `cmd-tools-hostnames.sh` | The addresses a site answers at, and one more | `--add` `--with-workspace` `--remove` `--start` |
| `cmd-tools-clone.sh` | Folder and database under a new name, here or in another folder | `--to` `--target-workspace` `--worktree` `--branch` `--no-build-copy` `--extra-hostname` `--with-workspace-hostname` `--no-db` |
| `cmd-tools-backup-dev.sh` | The folder as an archive and the database as a dump, into `backups/dev/` | none |
| `cmd-tools-remove.sh` | Containers, volumes and folder together | `--orphans` `--force` `--backup` |
| `cmd-tools-reclaim.sh` | Disk held by projects whose folder is gone: a dry run unless `--apply` | `--apply` `--only` `--keep-days` `--list-protected` |
| `cmd-tools-screen.sh` | A detached session with a log the dashboard follows | `--run` `--list` `--log` `--follow` `--stop` |
| `cmd-tools-update-all.sh` | `composer update` in every site, **on the host**: not yet moved into the containers. Do not run it unasked; use `ddev composer update` in one site | none |

## Settings

| Key | File | What it says |
| --- | --- | --- |
| `doc.name` | `core/config/workspace.dev.settings.yml` | The folder under the workspace root: `dev` |
| `type` | `core/config/workspace.dev.settings.yml` | `sites`: the rows of the page are built sites, with the Build, Tests, Checks, Users, Backup and Remove actions |
| `composer` | `core/config/workspace.dev.settings.yml` | `full`: the COMPOSER menu may install and update here, in the site's container |
| `assistant.name`, `assistant.placeholder` | `core/config/workspace.dev.settings.yml` | What the assistant is called on this page; `default` takes the workspace's |
| `account.name`, `account.mail` | `core/config/settings.yml` | The workspace account: the administrator of every site a builder installs |
| `workspaces` | `core/config/settings.yml` | The active folders; `dev` is on it once the plugin is activated |

## Rules

- Containers only: never `composer`, `drush`, `php`, `npm` or `mysql` on the host for a site. In the
  site's folder: `ddev composer …`, `ddev drush …`, `ddev export-db --file=…`, `ddev start -y`,
  `ddev stop` (no `-y`).
- Never write database settings into `settings.php`.
- One build at a time. A site built to try something is cleared when the work is done, after
  asking: `bash cmd-tools-remove.sh mysite`.

The agent `dev-site-builder`, the command `/dev-build` and the prompt `dev-build-and-test` come
with the same plugin.
