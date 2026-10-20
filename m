Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 13EA7606A31A
	for <dpdk-dev@archiver.kernel.org>; Tue, 20 Oct 2026 08:53:13 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 6D89340270;
	Tue, 20 Oct 2026 10:53:12 +0200 (CEST)
Received: from dkmailrelay1.smartsharesystems.com
 (smartserver.smartsharesystems.com [77.243.40.215])
 by mails.dpdk.org (Postfix) with ESMTP id 5495840144
 for <dev@dpdk.org>; Tue, 20 Oct 2026 10:53:11 +0200 (CEST)
Received: from smartserver.smartsharesystems.com
 (smartserver.smartsharesys.local [192.168.4.10])
 by dkmailrelay1.smartsharesystems.com (Postfix) with ESMTP id 3401B20678;
 Tue, 20 Oct 2026 10:53:11 +0200 (CEST)
Content-class: urn:content-classes:message
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="utf-8"
Content-Transfer-Encoding: base64
Subject: RE: [PATCH v7 0/2] introduce pile stack and mempool driver
X-MimeOLE: Produced By Microsoft Exchange V6.5
Date: Tue, 20 Oct 2026 10:53:09 +0200
Message-ID: <98CBD80474FA8B44BF855DF32C47DC35F65AC7@smartserver.smartshare.dk>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: [PATCH v7 0/2] introduce pile stack and mempool driver
Thread-Index: Ad1f0agawBP1wDrURZKFqsaWOOdNIgAFpJawACIEciA=
References: <20260901064331.594276-1-mb@smartsharesystems.com>
 <20260914155901.943571-1-mb@smartsharesystems.com>
 <ItqMX3UyR721OV9AeSB9fA@monjalon.net>
 <f515d29c-525d-4854-bede-ffcc01303062@nvidia.com> 
From: =?utf-8?B?TW9ydGVuIEJyw7hydXA=?= <mb@smartsharesystems.com>
To: "Ali Alnubani" <alialnu@nvidia.com>,
 "Thomas Monjalon" <thomas@monjalon.net>
Cc: <dev@dpdk.org>, "Andrew Rybchenko" <andrew.rybchenko@oktetlabs.ru>,
 "Bruce Richardson" <bruce.richardson@intel.com>,
 "Stephen Hemminger" <stephen@networkplumber.org>
X-BeenThere: dev@dpdk.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: DPDK patches and discussions <dev.dpdk.org>
List-Archive: <http://mails.dpdk.org/archives/dev/>
List-Post: <mailto:dev@dpdk.org>
List-Help: <mailto:dev-request@dpdk.org?subject=help>
List-Subscribe: <https://mails.dpdk.org/listinfo/dev>,
 <mailto:dev-request@dpdk.org?subject=subscribe>
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

PiBGcm9tOiBNb3J0ZW4gQnLDuHJ1cA0KPiBTZW50OiBNb25kYXksIDE5IE9jdG9iZXIgMjAyNiAx
OC40MA0KPiANCj4gPiBGcm9tOiBBbGkgQWxudWJhbmkgW21haWx0bzphbGlhbG51QG52aWRpYS5j
b21dDQo+ID4gU2VudDogTW9uZGF5LCAxOSBPY3RvYmVyIDIwMjYgMTUuNTYNCj4gPg0KPiA+IE9u
IDEwLzE1LzI2IDg6MjIgUE0sIFRob21hcyBNb25qYWxvbiB3cm90ZToNCj4gPg0KPiA+ID4gMTQv
MDkvMjAyNiAxNzo1OCwgTW9ydGVuIEJyw7hydXA6DQo+ID4gPj4gQWRkZWQgYSBuZXcgaGlnaC1w
ZXJmb3JtYW5jZSBsb2NrLWZyZWUgInBpbGUiLCB1c2luZyB0aGUgU3RhY2sNCj4gQVBJLA0KPiA+
ID4+IGFuZCBhbiBhY2NvbXBhbnlpbmcgbWVtcG9vbCBkcml2ZXIuDQo+ID4gPj4NCj4gPiA+PiBN
b3J0ZW4gQnLDuHJ1cCAoMik6DQo+ID4gPj4gICAgc3RhY2s6IGludHJvZHVjZSBwaWxlDQo+ID4g
Pj4gICAgbWVtcG9vbDogaW50cm9kdWNlIHBpbGUgZHJpdmVyDQo+ID4gPiBBcHBsaWVkLCB0aGFu
a3MuDQo+ID4NCj4gPiBIZWxsbywNCj4gPg0KPiA+IERlYnVnIGJ1aWxkIGZhaWxzIG9uIFVidW50
dSAyNC4wNCAoYWFyY2g2NCkgd2l0aCB0aGlzIHBhdGNoc2V0LiBCdWc6DQo+ID4NCj4gPiBodHRw
czovL2J1Z3MuZHBkay5vcmcvc2hvd19idWcuY2dpP2lkPTIwNjENCj4gPg0KPiA+IFJlZ2FyZHMs
DQo+ID4gQWxpDQo+IA0KPiBJIGFtIGFibGUgdG8gcmVwcm9kdWNlLg0KPiBIYXZlIHdvcmtpbmcg
d29ya2Fyb3VuZC4NCj4gV2lsbCBzdWJtaXQgdG9tb3Jyb3cuDQoNClBhdGNoIHNlbnQ6DQpodHRw
czovL3BhdGNod29yay5kcGRrLm9yZy9wcm9qZWN0L2RwZGsvcGF0Y2gvMjAyNjEwMjAwODQ5NDQu
MzE4ODk4Ny0xLW1iQHNtYXJ0c2hhcmVzeXN0ZW1zLmNvbS8NCg0KLU1vcnRlbg0KDQo=
