#!/usr/bin/env ruby

$:.unshift File.join(File.dirname(__FILE__),'..','lib')

LANGUAGE = "IMP"

# TODO: Use something else than require.
require 'compiler/compile'
