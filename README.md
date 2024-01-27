# Blog

Reproduces a mix recompilation issue when copying a directory with compiled
artifacts.

## Reproduction steps

1. Checkout this branch in your local elixir folder:
   https://github.com/sabiwara/elixir/pull/new/mix-debug-recompile
2. Run the following script a couple of times:

```sh
LOCAL_ELIXIR_PATH="../path/to/elixir" ./relocate.sh
```

## Behavior

Sometimes it would run without recompiling any dependency:

```elixir
[lib/mix/dep/converger.ex:169: Mix.Dep.Converger.init_all/8]
for y <- deps do
  {y.app, y.status}
end #=> [
  ecto_sql: {:ok, "3.11.1"},
  postgrex: {:ok, "0.17.4"},
  db_connection: {:ok, "2.6.0"},
  decimal: {:ok, "2.1.1"},
  telemetry: {:ok, "1.2.1"},
  ecto: {:ok, "3.11.1"}
]
```

Sometimes it would flag some dependencies as stale:

```elixir
[lib/mix/dep/converger.ex:169: Mix.Dep.Converger.init_all/8]
for y <- deps do
  {y.app, y.status}
end #=> [
  ecto_sql: :compile,
  postgrex: {:ok, "0.17.4"},
  db_connection: :compile,
  decimal: {:ok, "2.1.1"},
  telemetry: :compile,
  ecto: {:ok, "3.11.1"}
]
```

The stale check is done
[here](https://github.com/elixir-lang/elixir/blob/main/lib/mix/lib/mix/dep/loader.ex#L407-L410),
and often shows a difference of `1` between `sources` and `targets` timestamps:

```elixir
 sources: [{"/private/tmp/relocated/deps/telemetry/.fetch", 1706324073}],
 targets: [
   {"/private/tmp/relocated/_build/dev/lib/telemetry/.mix/compile.fetch",
    1706324072}
 ]}
```

This bug does not happen when copying with `cp -pR` (preserves modification
time), so it is probably because `cp` does not create all files with the exact
same timestamp.
