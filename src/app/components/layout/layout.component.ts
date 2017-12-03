import { Component, OnInit } from '@angular/core';
import { AngularFireAuth } from 'angularfire2/auth';
import { AngularFireDatabase } from 'angularfire2/database';

import { P2PService } from '../../services/p2p.service';

@Component({
  selector: 'layout',
  templateUrl: './layout.component.html'
})
export class LayoutComponent implements OnInit {
  progress = 0;

  task = '';

  constructor(
    private db: AngularFireDatabase,
    private auth: AngularFireAuth,
    private p2p: P2PService
  ) {}

  ngOnInit() {
    this.task = 'Establishing connection to Firebase...';

    this.auth.auth.signInAnonymously()
      .then(user => {
        this.progress = 30;
        this.task = 'Preparing web-peer...';

        return this.p2p.openPeer()
      })
      .then(offer => {
        offer
      });

  }
}
