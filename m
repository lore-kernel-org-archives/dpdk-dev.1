Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5DFD0C5AE59
	for <dpdk-dev@archiver.kernel.org>; Tue,  3 Jun 2025 06:34:50 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 30A7E4028E;
	Tue,  3 Jun 2025 08:34:50 +0200 (CEST)
Received: from dkmailrelay1.smartsharesystems.com
 (smartserver.smartsharesystems.com [77.243.40.215])
 by mails.dpdk.org (Postfix) with ESMTP id 61E074025A
 for <dev@dpdk.org>; Tue,  3 Jun 2025 08:34:48 +0200 (CEST)
Received: from smartserver.smartsharesystems.com
 (smartserver.smartsharesys.local [192.168.4.10])
 by dkmailrelay1.smartsharesystems.com (Postfix) with ESMTP id 2B72020100;
 Tue,  3 Jun 2025 08:34:48 +0200 (CEST)
Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="UTF-8"
Content-Transfer-Encoding: base64
Subject: RE: rte_lcore_has_role() return value
X-MimeOLE: Produced By Microsoft Exchange V6.5
Date: Tue, 3 Jun 2025 08:34:45 +0200
Message-ID: <98CBD80474FA8B44BF855DF32C47DC35E9FCAE@smartserver.smartshare.dk>
In-Reply-To: <PH7PR12MB859673BB32BC7B05B6ACD55E826DA@PH7PR12MB8596.namprd12.prod.outlook.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: rte_lcore_has_role() return value
Thread-Index: AdvIpLZJaWj+3Hu4QLKxOy27D7eK3AAIZ8owAAB9vyAC4Vs18AAA58eg
References: <98CBD80474FA8B44BF855DF32C47DC35E9FC69@smartserver.smartshare.dk>
 <PH0PR18MB40869A3A3B6E5F0C4D7F02CFDE9CA@PH0PR18MB4086.namprd18.prod.outlook.com>
 <PH0PR18MB40867CA69B24733163400ADCDE9CA@PH0PR18MB4086.namprd18.prod.outlook.com>
 <PH7PR12MB859673BB32BC7B05B6ACD55E826DA@PH7PR12MB8596.namprd12.prod.outlook.com>
From: =?UTF-8?B?TW9ydGVuIEJyw7hydXA=?= <mb@smartsharesystems.com>
To: "Varghese, Vipin" <Vipin.Varghese@amd.com>,
 "Pavan Nikhilesh Bhagavatula" <pbhagavatula@marvell.com>
Cc: "dev" <dev@dpdk.org>
X-BeenThere: dev@dpdk.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: DPDK patches and discussions <dev.dpdk.org>
List-Unsubscribe: <https://mails.dpdk.org/options/dev>,
 <mailto:dev-request@dpdk.org?subject=unsubscribe>
List-Archive: <http://mails.dpdk.org/archives/dev/>
List-Post: <mailto:dev@dpdk.org>
List-Help: <mailto:dev-request@dpdk.org?subject=help>
List-Subscribe: <https://mails.dpdk.org/listinfo/dev>,
 <mailto:dev-request@dpdk.org?subject=subscribe>
Errors-To: dev-bounces@dpdk.org

SGkgVmlwaW4sDQoNCk5vIG5lZWQuIFBhdmFuIGZpeGVkIGl0IGFscmVhZHk6DQpodHRwczovL3Bh
dGNod29yay5kcGRrLm9yZy9wcm9qZWN0L2RwZGsvcGF0Y2gvMjAyNTA1MjAyMDE3MjYuNzQyMC0x
LXBiaGFnYXZhdHVsYUBtYXJ2ZWxsLmNvbS8NCg0KLU1vcnRlbg0KDQo+IEZyb206IFZhcmdoZXNl
LCBWaXBpbiBbbWFpbHRvOlZpcGluLlZhcmdoZXNlQGFtZC5jb21dDQo+IFNlbnQ6IFR1ZXNkYXks
IDMgSnVuZSAyMDI1IDA4LjA4DQo+IA0KPiBbUHVibGljXQ0KPiANCj4gSGkgQE1vcnRlbiBCcsO4
cnVwDQo+IA0KPiBXb3VsZCB5b3UgbmVlZCBtZSB0byBjaGVjayB0aGlzIHVuZGVyIGBydGVfdG9w
b2xvZ3lgIHBjb21pbmcgcGF0Y2hlcz8NCj4gDQo+ID4gRnJvbTogUGF2YW4gTmlraGlsZXNoIEJo
YWdhdmF0dWxhIDxwYmhhZ2F2YXR1bGFAbWFydmVsbC5jb20+DQo+ID4gU2VudDogTW9uZGF5LCBN
YXkgMTksIDIwMjUgNzo0NiBQTQ0KPiA+DQo+ID4gQ2F1dGlvbjogVGhpcyBtZXNzYWdlIG9yaWdp
bmF0ZWQgZnJvbSBhbiBFeHRlcm5hbCBTb3VyY2UuIFVzZSBwcm9wZXINCj4gY2F1dGlvbg0KPiA+
IHdoZW4gb3BlbmluZyBhdHRhY2htZW50cywgY2xpY2tpbmcgbGlua3MsIG9yIHJlc3BvbmRpbmcu
DQo+ID4NCj4gPg0KPiA+IE15IGJhZCwgSSBnb3QgaXQgY29uZnVzZWQgd2l0aCBsY29yZSB0b3Bv
bG9neSBwYXRjaGVzLg0KPiA+DQo+ID4gSSB3aWxsIGxvb2sgaW50byB0aGlzLg0KPiA+DQo+ID4g
VGhhbmtzLA0KPiA+IFBhdmFuLg0KPiA+DQo+ID4gPiBGcm9tOiBQYXZhbiBOaWtoaWxlc2ggQmhh
Z2F2YXR1bGENCj4gPiA+IFNlbnQ6IE1vbmRheSwgTWF5IDE5LCAyMDI1IDc6MzIgUE0NCj4gPiA+
DQo+ID4gPiBIaSBNb3J0ZW4sDQo+ID4gPg0KPiA+ID4gTG9va3MgbGlrZSB0aGlzIGlzIG1lYW50
IGZvciBWaXBpbi4NCj4gPiA+DQo+ID4gPiArVmlwaW4NCj4gPiA+DQo+ID4gPiBUaGFua3MsDQo+
ID4gPiBQYXZhbi4NCj4gPiA+DQo+ID4gPiA+IFBhdmFuLA0KPiA+ID4gPg0KPiA+ID4gPiBUaGUg
cnRlX2xjb3JlX2hhc19yb2xlKCkgZG9jdW1lbnRhdGlvbiBzYXlzIGl0IHJldHVybnMgYm9vbC4N
Cj4gPiA+ID4NCj4gPiA+ID4gSXRzIGltcGxlbWVudGF0aW9uIHJldHVybnMgYSB0cnVlIHZhbHVl
ICgtMSkgaWYgZ2l2ZW4gYQ0KPiA+ID4gPiBub24tY29tcGxpYW50DQo+ID4gPiBsY29yZV9pZCwN
Cj4gPiA+ID4gZS5nLiBMQ09SRV9JRF9BTlkuDQo+ID4gPiA+DQo+ID4gPiA+IEkgdGhpbmsgaXQg
c2hvdWxkIGJlaGF2ZSBsaWtlIHJ0ZV9sY29yZV9pc19lbmFibGVkKCksIGkuZS4gcmV0dXJuDQo+
ID4gPiA+IGZhbHNlIGlmIGdpdmVuIGEgbm9uLWNvbXBsaWFudCBsY29yZV9pZCwgZS5nLiBMQ09S
RV9JRF9BTlkuDQo+ID4gPiA+DQo+ID4gPiA+IFVzZSBjYXNlOg0KPiA+ID4gPiBBIGNvbnRyb2wg
dGhyZWFkIGluIGFuIGFwcGxpY2F0aW9uIG1pZ2h0IG9yIG1pZ2h0IG5vdCByZWdpc3Rlcg0KPiA+
ID4gPiBpdHNlbGYsIGFuZCB0aGUgcmVnaXN0cmF0aW9uIG1pZ2h0IG5vdCBzdWNjZWVkLg0KPiA+
ID4gPg0KPiA+ID4gPiBBdCBleGl0IG9mIHRoaXMgY29udHJvbCB0aHJlYWQsIGl0IHNob3VsZCB1
bnJlZ2lzdGVyIGl0c2VsZiBpZg0KPiByZWdpc3RlcmVkLg0KPiA+ID4gPg0KPiA+ID4gPiBGaXhp
bmcgcnRlX2xjb3JlX2hhc19yb2xlKCkgYXMgc3VnZ2VzdGVkIHdvdWxkIHNpbXBsaWZ5IHRoZQ0K
PiA+ID4gPiBhcHBsaWNhdGlvbiBmcm9tDQo+ID4gPiA+IHRoaXM6DQo+ID4gPiA+DQo+ID4gPiA+
ICAgICBpZiAocnRlX2xjb3JlX2lkKCkgIT0gTENPUkVfSURfQU5ZICYmDQo+ID4gPiA+ICAgICAg
ICAgICAgICAgICAgICAgcnRlX2VhbF9sY29yZV9yb2xlKHJ0ZV9sY29yZV9pZCgpKSA9PQ0KPiBS
T0xFX05PTl9FQUwpDQo+ID4gPiA+ICAgICAgICAgICAgIHJ0ZV90aHJlYWRfdW5yZWdpc3Rlcigp
Ow0KPiA+ID4gPg0KPiA+ID4gPiBUbyB0aGlzOg0KPiA+ID4gPg0KPiA+ID4gPiAgICAgaWYgKHJ0
ZV9sY29yZV9oYXNfcm9sZShydGVfbGNvcmVfaWQoKSwgUk9MRV9OT05fRUFMKSkNCj4gPiA+ID4g
ICAgICAgICAgICAgcnRlX3RocmVhZF91bnJlZ2lzdGVyKCk7DQo+ID4gPiA+DQo+ID4gPiA+IC1N
b3J0ZW4NCg0K
