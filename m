Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2577EF36BA5
	for <dpdk-dev@archiver.kernel.org>; Sat, 11 Apr 2026 07:30:16 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 088D04021E;
	Sat, 11 Apr 2026 09:30:15 +0200 (CEST)
Received: from dkmailrelay1.smartsharesystems.com
 (smartserver.smartsharesystems.com [77.243.40.215])
 by mails.dpdk.org (Postfix) with ESMTP id 8B927400D5
 for <dev@dpdk.org>; Sat, 11 Apr 2026 09:30:13 +0200 (CEST)
Received: from smartserver.smartsharesystems.com
 (smartserver.smartsharesys.local [192.168.4.10])
 by dkmailrelay1.smartsharesystems.com (Postfix) with ESMTP id 7289620B42;
 Sat, 11 Apr 2026 09:30:12 +0200 (CEST)
Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="utf-8"
Content-Transfer-Encoding: base64
Subject: RE: [EXTERNAL] Re: [PATCH v3 0/7] Rework device probing
Date: Sat, 11 Apr 2026 09:30:10 +0200
Message-ID: <98CBD80474FA8B44BF855DF32C47DC35F657E1@smartserver.smartshare.dk>
In-Reply-To: <LV0PR21MB6670C8CFBCD121494E58FEE2CE592@LV0PR21MB6670.namprd21.prod.outlook.com>
X-MS-Has-Attach: 
X-MimeOLE: Produced By Microsoft Exchange V6.5
X-MS-TNEF-Correlator: 
Thread-Topic: [EXTERNAL] Re: [PATCH v3 0/7] Rework device probing
Thread-Index: AQHcyPc50Ql2KKjC90G84r6D56BGo7XYj2uAgAAT8cCAANAhoA==
References: <20260323105306.1531689-1-david.marchand@redhat.com><20260407115211.1903623-1-david.marchand@redhat.com><98CBD80474FA8B44BF855DF32C47DC35F657DF@smartserver.smartshare.dk>
 <20260410103717.5a52289a@phoenix.local>
 <LV0PR21MB6670C8CFBCD121494E58FEE2CE592@LV0PR21MB6670.namprd21.prod.outlook.com>
From: =?utf-8?B?TW9ydGVuIEJyw7hydXA=?= <mb@smartsharesystems.com>
To: "Long Li" <longli@microsoft.com>,
 "Stephen Hemminger" <stephen@networkplumber.org>
Cc: "David Marchand" <david.marchand@redhat.com>,
 "Bruce Richardson" <bruce.richardson@intel.com>,
 "Robin Jarry" <rjarry@redhat.com>,
 "Hemant Agrawal" <hemant.agrawal@nxp.com>,
 "Maxime Leroy" <maxime@leroys.fr>, "Kevin Traynor" <ktraynor@redhat.com>,
 <dev@dpdk.org>, <matan@nvidia.com>, "Wei Hu" <weh@microsoft.com>
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

PiBGcm9tOiBMb25nIExpIFttYWlsdG86bG9uZ2xpQG1pY3Jvc29mdC5jb21dDQo+IFNlbnQ6IEZy
aWRheSwgMTAgQXByaWwgMjAyNiAyMy4xNA0KPiANCj4gPiBPbiBGcmksIDEwIEFwciAyMDI2IDE2
OjM0OjU2ICswMjAwDQo+ID4gTW9ydGVuIEJyw7hydXAgPG1iQHNtYXJ0c2hhcmVzeXN0ZW1zLmNv
bT4gd3JvdGU6DQo+ID4NCj4gPiA+IElzIHRoZXJlIGEgd29ya2Fyb3VuZCB1bnRpbCB0aGlzIHBh
dGNoIGlzIGFkZGVkLCBpZiBJIGRvbid0IHdhbnQNCj4gcnRlX2VhbF9pbml0KCkgdG8NCj4gPiBw
cm9iZSBhbnkgZGV2aWNlcywgYnV0IEkgd2FudCBteSBhcHBsaWNhdGlvbiB0byBwcm9iZSBkZXZp
Y2VzIGxhdGVyDQo+IGJ5IGNhbGxpbmcNCj4gPiBydGVfYnVzX3NjYW4oKSBmb2xsb3dlZCBieSBy
dGVfYnVzX3Byb2JlKCk/DQo+ID4gPg0KPiA+ID4gSXQncyBub3Qgc29tZXRoaW5nIHdlIHJlYWxs
eSBuZWVkLCBzbyBpZiB5b3UgZG9uJ3Qga25vdyBpdCBvZmYgdGhlDQo+IHRvcCBvZiB5b3VyDQo+
ID4gaGVhZCwgZG9uJ3Qgc3BlbmQgdGltZSB0cnlpbmcgdG8gZmlndXJlIGl0IG91dC4NCj4gPiA+
DQo+ID4gPg0KPiA+ID4gVmVubGlnIGhpbHNlbiAvIEtpbmQgcmVnYXJkcywNCj4gPiA+IC1Nb3J0
ZW4gQnLDuHJ1cA0KPiA+DQo+ID4gV2UgZG8gbmVlZCBpdCBiZWNhdXNlIG9mIHRoZSBwcm9ibGVt
cyB3aXRoIHZkZXZfbmV0dnNjLg0KPiA+IFRoZSBpc3N1ZSBpcyB0aGF0IHZkZXZfbmV0dnNjIHRy
aWVzIHRvIHNldHVwIGZhaWxzYWZlIG9uIGFsbCBuZXR2c2MNCj4gZGV2aWNlcyBpdCBzZWVzLA0K
PiA+IGFuZCBpdCBkZXRlcm1pbmVzIHdoaWNoIG9uZXMgYXJlIHVzZWQgYnkgT1MgYmFzZWQgb24g
c29tZXdoYXQgZnJhZ2lsZQ0KPiBPUw0KPiA+IHByb2JlcyB3aXRoIG5ldGxpbmsuDQo+ID4NCj4g
PiBJIHdvdWxkIHJlY29tbWVuZCBnZXR0aW5nIHJpZCBvZiB2ZGV2X25ldHZzYywgb3IgbWFrZSB0
aGUgdGhlIGF1dG8NCj4gc2Nhbm5pbmcNCj4gPiB0aGVyZSBzb21ldGhpbmcgdGhhdCBoYXMgdG8g
YmUgZm9yY2VkIGJ5IGRldmFyZ3MuDQo+ID4gQnV0IHRoYXQgcmVhbGx5IGlzIHVwIHRvIHRoZSBu
ZXR2c2MgbWFpbnRhaW5lcnMuDQo+IA0KPiBIaSBNb3J0ZW4sDQo+IA0KPiBDYW4geW91IHVzZSAt
LXZkZXY9bmV0X3ZkZXZfbmV0dnNjLGlnbm9yZT0xPyBUaGUgaWdub3JlIGRldmFyZyBpcw0KPiBh
bHJlYWR5IHN1cHBvcnRlZCBieSB0aGUgdmRldl9uZXR2c2MgUE1EIOKAlCB3aGVuIHNldCwgdGhl
IHByb2JlIGZ1bmN0aW9uDQo+IHNraXBzIGFsbCBuZXR2c2MgaW50ZXJmYWNlIGRpc2NvdmVyeSBh
bmQgcmV0dXJucyBlYXJseS4NCj4gDQo+IExvbmcNCg0KVGhhbmtzIGZvciB0aGUgc3VnZ2VzdGlv
biwgTG9uZy4NCkknbSBub3QgbG9va2luZyBmb3IgYSBuZXR2c2Mgc29sdXRpb24sIEknbSBsb29r
aW5nIGZvciBhIGdlbmVyYWwgc29sdXRpb24gdG8gbm90IHByb2JlIGFueSBkcml2ZXJzIGF0IEVB
TCBpbml0aWFsaXphdGlvbiwgYnV0IGF0IGEgbGF0ZXIgc3RhZ2UsIGNvbnRyb2xsZWQgYnkgdGhl
IGFwcGxpY2F0aW9uLg0KDQotTW9ydGVuDQoNCg==
