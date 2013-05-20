# encoding: utf-8
require 'guard'
require 'guard/guard'
require 'guard/minitest/runner'
require 'guard/minitest/inspector'
require 'minitest/autorun'

module Guard
  class Minitest < Guard

    def initialize(watchers = [], options = {})
      super
      @options = {
        :all_on_start => true
      }.merge(options)

      @runner = Runner.new(@options)
      @inspector = Inspector.new(@runner.test_folders, @runner.test_file_patterns)
    end

    def start
      UI.info "Guard::Minitest is running, with Minitest::Unit #{::MiniTest::Unit::VERSION}!"
      run_all if @options[:all_on_start]
    end

    def stop
      true
    end

    def reload
      true
    end

    def run_all
      paths = @inspector.clean_all
      @runner.run(paths, :message => 'Running all tests')
    end

    def run_on_changes(paths = [])
      paths = @inspector.clean(paths)
      @runner.run(paths)
    end
  end
end
