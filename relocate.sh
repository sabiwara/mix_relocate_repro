#!/bin/sh
set -eu

localelixir=$(readlink -f $LOCAL_ELIXIR_PATH)

cd $localelixir
make
cd -

localmix="$localelixir/bin/elixir -S $localelixir/bin/mix"

$localmix compile
rm -rf /tmp/relocated

cp -R . /tmp/relocated

cd /tmp/relocated

# recompiles!
MIX_DEBUG=1 $localmix ecto.migrate --no-compile
