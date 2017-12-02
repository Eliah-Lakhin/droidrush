export class Room {
  constructor(
    public title = '',
    public planets = 10,
    public maxPlayers = 4,
    public width = 400,
    public height = 300,
    public players: String[] = []
  ) {}
}