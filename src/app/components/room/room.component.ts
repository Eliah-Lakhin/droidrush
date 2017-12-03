import { Component, OnInit } from '@angular/core';
import { AngularFireDatabase, AngularFireList } from 'angularfire2/database';
import { Observable } from 'rxjs';

import * as model from '../../services/model';

@Component({
  selector: 'room',
  templateUrl: './room.component.html'
})
export class RoomComponent implements OnInit {
  constructor(
    private db: AngularFireDatabase
  ) {
  }

  ngOnInit() {
  }
}
