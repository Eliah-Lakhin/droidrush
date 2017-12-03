import * as _ from 'lodash';

import { stun } from '../../environment/ice-servers';
import { AngularFireDatabase } from 'angularfire2/database';

const AdapterJS = require('adapterjs');

export class P2PService {
  private connection: Promise<RTCPeerConnection>;
  private global = (window as any);

  public keepAlive = true;

  constructor() {
    this.connection = new Promise<RTCPeerConnection>((resolve) => {
      AdapterJS.webRTCReady(() => {
        const connection = new this.global.RTCPeerConnection(
          {
            iceServers: _.map(stun, server => ({
              url: `stun:${server}`
            }))
          },
          {
            optional: [{ RtpDataChannels: true }]
          }
        ) as RTCPeerConnection;

        connection.onicecandidate = (event) => {
          console.log(event);
        };

        resolve(connection);

        // const channel = this
        //   .connection
        //   .createDataChannel('channel');

        // channel.onerror = (error) => console.error('WebRTC channel', error);
        // channel.onmessage = (event) => console.log(event);
        // channel.onclose = (event) => console.log('WebRTC channel closed');
      });
    });
  }

  openPeer(): Promise<RTCSessionDescription> {
    return this.connection
      .then(connection => new Promise<RTCSessionDescription>((resolve, reject) =>
        connection.createOffer(
          (offer) => {
            connection.setLocalDescription(offer);
            resolve(offer);
          },
          error => reject(error)
        )));
  }
}