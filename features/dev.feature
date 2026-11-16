Feature: The Dev workspace plugin
  Once the plugin is activated and installed, the dev workspace is on the dashboard, and the
  Plugins page lists the plugin with its four steps.

  Scenario: The workspace page is there
    Given I am on "/dev"
     Then the element "h1" should be displayed
      And "#webship-workspace-projects, .items-list, .workspace-page" should be attached

  # The Plugins page names each plugin; the package is on the plugin's own page (the row shows it on hover only).
  Scenario: The plugin is listed on the Plugins page, and its own page names its package
    Given I am on "/settings/plugins"
     Then I should see "Dev"
     When I go to "/settings/plugin/dev"
     Then I should see "@webship.co/workspace-dev"

  # The AI folders are searched by name: with every plugin on, a folder lists more than one page of items.
  Scenario: The AI Agents folder lists the agent the plugin ships
    Given I am on "/ai-agents?q=dev-site-builder"
     Then I should see "dev-site-builder"

  Scenario: The AI Skills folder lists the skill the plugin ships
    Given I am on "/ai-skills?q=dev-workflow"
     Then I should see "dev-workflow"

  Scenario: The AI Commands folder lists the command the plugin ships
    Given I am on "/ai-commands?q=dev-build"
     Then I should see "dev-build"

  Scenario: The AI Prompts folder lists the prompt the plugin ships
    Given I am on "/ai-prompts?q=dev-build-and-test"
     Then I should see "dev-build-and-test"
