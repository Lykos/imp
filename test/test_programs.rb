require 'ftools'

module ProgramsHelper
  PROGRAMS = {}
  
  PROGRAMS_PATH = 'test/programs/'

  Dir.foreach(PROGRAMS_PATH) {|fname|
    next unless File.fnmatch('*.imp', fname)
    PROGRAMS[fname.gsub(/\.imp$/,"")] = File.read(PROGRAMS_PATH + fname)
  }
end
