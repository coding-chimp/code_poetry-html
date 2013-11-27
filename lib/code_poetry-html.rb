require 'erb'
require 'cgi'
require 'fileutils'
require 'digest/sha1'
require 'time'

class CodePoetry::Formatter::HTMLFormatter
  def format(stats)
    Dir[File.join(File.dirname(__FILE__), '../public/*')].each do |path|
      FileUtils.cp_r(path, asset_output_path)
    end

    File.open(File.join(output_path, "index.html"), "w+") do |file|
      file.puts template('layout').result(binding)
    end

    puts "Code Poetry report generated to #{output_path}."
  end

private

  def template(name)
    ERB.new(File.read(File.join(File.dirname(__FILE__), '../views/', "#{name}.erb")))
  end

  def output_path
    CodePoetry.coverage_path
  end

  def asset_output_path
    return @asset_output_path if defined? @asset_output_path and @asset_output_path
    @asset_output_path = File.join(output_path, 'assets')
    FileUtils.mkdir_p(@asset_output_path)
    @asset_output_path
  end

  def formatted_source_file(stat)
    template('source_file').result(binding)
  end

  def formatted_file_list(stats)
    template('file_list').result(binding)
  end

  def class_complexity_css_class(complexity)
    if complexity > 150
      'red'
    elsif complexity > 100
      'yellow'
    else
      'green'
    end
  end

  def method_complexity_css_class(complexity)
    if complexity > 40
      'red'
    elsif complexity > 20
      'yellow'
    else
      'green'
    end
  end

  def id(stat)
    Digest::SHA1.hexdigest(stat.file)
  end

  def timeago(time)
    %Q(<abbr class="timeago" title="#{time.iso8601}">#{time.iso8601}</abbr>)
  end

  def link_to_source_file(stat)
    %Q(<a href="##{id(stat)}" class="src_link" title="#{stat.name}">#{stat.name}</a>)
  end

  def line_status(stat, line_number)
    method = stat.get_method_at_line(line_number)

    unless method.nil?
      'smelly' if method[:complexity] > 20
    end
  end
end

$LOAD_PATH.unshift(File.join(File.dirname(__FILE__)))
require 'code_poetry-html/version'
