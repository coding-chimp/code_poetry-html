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
      file.puts template('views', 'layout').result(binding)
    end

    puts "Code Poetry report generated to #{output_path}."
  end

private

  def template(path, name)
    ERB.new(File.read(File.join(File.dirname(__FILE__), "../#{path}/", "#{name}.erb")))
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
    template('views', 'source_file').result(binding)
  end

  def formatted_file_list(stats)
    template('views', 'file_list').result(binding)
  end

  def formatted_smell(stat, smell)
    template('views/smells', smell.type).result(binding)
  end

  def id(stat)
    Digest::SHA1.hexdigest(stat.absolute_path)
  end

  def timeago(time)
    %(<abbr class="timeago" title="#{time.iso8601}">#{time.iso8601}</abbr>)
  end

  def link_to_source_file(stat)
    %(<a href="##{id(stat)}" class="src_link" title="#{stat.name}">#{stat.name}</a>)
  end

  def line_status(stat, line_number)
    method = stat.get_method_at_line(line_number)

    unless method.nil?
      'smelly' if method.smelly? || method.duplicated?
    end
  end

  def first_line_of_smell?(stat, line_number)
    line_status(stat, line_number - 1).nil? &&
      line_status(stat, line_number) == 'smelly'
  end

  def smell_title(stat, line_number)
    method = stat.get_method_at_line(line_number)

    if method.smelly?
      'Complex Method'
    else
      'Duplication'
    end
  end
end

$LOAD_PATH.unshift(File.join(File.dirname(__FILE__)))
require 'code_poetry-html/version'
