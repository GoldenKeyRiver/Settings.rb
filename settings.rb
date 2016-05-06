class SettingsManager
  attr_reader :filename

  def initialize(filename)
    @filename = filename
  end

  private
  def load_file()
    is_file = File.file?(@filename)
    file_open = open(@filename, "r") if is_file
    file_array = file_open.collect {|l| l.split("\n")} if is_file
    return file_array if is_file
  end

  private
  def load_config()
    config = load_file()
    lines = config.length
    settings = Hash.new(0)
    lines.times do |line|
      compare = config[line][0].to_s.include?("=")
      two_pars = config[line][0].to_s.split("=") if compare
      two_pars[0] = two_pars[0].gsub(/\s/, "") if compare
      two_pars[1] = two_pars[1].gsub(/\s/, "") if compare
      settings[two_pars[0].to_sym] = two_pars[1] if compare
    end
    return settings
  end

  public
  def setting
    return load_config
  end
end
