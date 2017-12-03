import { BrowserModule } from '@angular/platform-browser';
import { NgModule } from '@angular/core';
import { RouterModule, Routes } from '@angular/router';
import { FormsModule } from '@angular/forms';
import { NgbModule } from '@ng-bootstrap/ng-bootstrap';
import { AngularFireModule } from 'angularfire2';
import { AngularFireDatabaseModule } from 'angularfire2/database';
import { AngularFireAuthModule } from 'angularfire2/auth';
import { CustomFormsModule } from 'ng2-validation';

import { LayoutComponent } from './components/layout/layout.component';
import { LobbyComponent } from './components/lobby/lobby.component';
import { RoomComponent } from './components/room/room.component';
import { P2PService } from './services/p2p.service';

import { credentials } from '../environment/firebase';


const appRoutes: Routes = [
  {
    path: 'lobby',
    component: LobbyComponent
  },
  {
    path: 'room/:id',
    component: RoomComponent
  },
  {
    path: '',
    redirectTo: '/lobby',
    pathMatch: 'full'
  }
];

@NgModule({
  declarations: [
    LayoutComponent,
    LobbyComponent,
    RoomComponent
  ],
  imports: [
    BrowserModule,
    FormsModule,
    CustomFormsModule,
    NgbModule.forRoot(),
    AngularFireModule.initializeApp(credentials, credentials.projectId),
    AngularFireDatabaseModule,
    AngularFireAuthModule,
    RouterModule.forRoot(
      appRoutes,
      // { enableTracing: process.env.development as any as boolean }
    )
  ],
  providers: [
    P2PService
  ],
  bootstrap: [LayoutComponent]
})
export class AppModule { }
