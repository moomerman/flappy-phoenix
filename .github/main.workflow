workflow "Perform checks" {
  on = "push"
  resolves = [
    "mix release",
  ]
}

action "mix deps.get" {
  uses = "docker://moomerman/elixir-master"
  runs = "mix"
  args = "deps.get"
}

action "mix format.check" {
  uses = "docker://moomerman/elixir-master"
  runs = "mix"
  args = "format --check-formatted"
  needs = ["mix deps.get"]
}

action "yarn install" {
  uses = "docker://node:latest"
  needs = ["mix deps.get"]
  runs = "yarn"
  args = "--cwd assets install"
}

action "branch master" {
  uses = "actions/bin/filter@3c0b4f0e63ea54ea5df2914b4fabf383368cd0da"
  args = "branch master"
  needs = [
    "yarn install",
    "mix format.check",
  ]
}

action "yarn deploy" {
  uses = "docker://node:latest"
  runs = "yarn"
  args = "--cwd assets deploy"
  needs = ["branch master"]
}

action "mix deps.compile" {
  uses = "docker://moomerman/elixir-master"
  runs = "mix"
  args = "deps.compile"
  env = {
    MIX_ENV = "prod"
  }
  needs = ["branch master"]
}

action "mix phx.digest" {
  uses = "docker://moomerman/elixir-master"
  runs = "mix"
  args = "phx.digest"
  env = {
    MIX_ENV = "prod"
  }
  needs = ["yarn deploy", "mix deps.compile"]
}

action "mix release" {
  uses = "docker://moomerman/elixir-master"
  runs = "mix"
  args = "release"
  env = {
    MIX_ENV = "prod"
  }
  needs = ["mix phx.digest"]
}
