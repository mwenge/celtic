#!/bin/sh

set -x
rm -f ogham.db
sqlite3 ogham.db < 010-ogham.sql


set +x
