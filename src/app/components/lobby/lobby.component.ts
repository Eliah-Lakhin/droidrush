import { Component, OnInit } from '@angular/core';
import { AngularFireDatabase, AngularFireList } from 'angularfire2/database';
import { Observable } from 'rxjs';

import * as model from '../../services/model';

@Component({
  selector: 'lobby',
  templateUrl: './lobby.component.html'
})
export class LobbyComponent implements OnInit {
  roomStream: Observable<model.Room[]>;
  room = new model.Room();

  private rooms: AngularFireList<model.Room>;

  constructor(
    private db: AngularFireDatabase
  ) {
    this.rooms = this.db.list<model.Room>('rooms');
  }

  ngOnInit() {
    this.roomStream = this.rooms.valueChanges();
  }

  createRoom() {
    this.rooms.push(this.room);
  }
}
