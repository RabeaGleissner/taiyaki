# Taiyaki

Another Slack bot.

```
  mix deps.get
```

### Run it in iex

```
ies -S mix

{ok, pid} = Slack.Bot.start_link(SlackRtm, [], 'GENERATED_SLACK_TOKEN')
```

Stop it with:

```
Process.exit(pid, :kill)
```

### Run tests

```
mix test
```
