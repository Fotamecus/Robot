require_relative './lib/commander'

commander = Commander.new

while line = gets do
  commander.execute(line.strip)
end
