import { BrowserModule } from '@angular/platform-browser';
import { NgModule } from '@angular/core';
import { RouterModule, Routes } from '@angular/router';
import { NgbModule } from '@ng-bootstrap/ng-bootstrap';

import { LayoutComponent } from './components/layout/layout.component';
import { LobbyComponent } from './components/lobby/lobby.component';


const appRoutes: Routes = [
  {
    path: 'lobby',
    component: LobbyComponent
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
    LobbyComponent
  ],
  imports: [
    BrowserModule,
    NgbModule.forRoot(),
    RouterModule.forRoot(
      appRoutes,
      { enableTracing: process.env.development as any as boolean }
    )
  ],
  providers: [],
  bootstrap: [ LayoutComponent ]
})
export class AppModule { }
