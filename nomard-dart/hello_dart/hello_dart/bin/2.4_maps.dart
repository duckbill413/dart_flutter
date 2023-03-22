void main() {
  var player = {
    // or Map<int>
    'name': 'duckbill',
    'xp': 19.99,
    'superpower': false,
  };
  player['hi'] = 'bye';
  print(player);
  print(player.keys);
  print(player.values);
  print(player.entries);
}
