Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F0C81C43458
	for <dpdk-dev@archiver.kernel.org>; Wed,  8 Jul 2026 14:08:45 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id B0E0D40268;
	Wed,  8 Jul 2026 16:08:44 +0200 (CEST)
Received: from dkmailrelay1.smartsharesystems.com
 (smartserver.smartsharesystems.com [77.243.40.215])
 by mails.dpdk.org (Postfix) with ESMTP id 7632540265
 for <dev@dpdk.org>; Wed,  8 Jul 2026 16:08:43 +0200 (CEST)
Received: from smartserver.smartsharesystems.com
 (smartserver.smartsharesys.local [192.168.4.10])
 by dkmailrelay1.smartsharesystems.com (Postfix) with ESMTP id 6C8CC20BBF;
 Wed,  8 Jul 2026 16:08:41 +0200 (CEST)
Content-class: urn:content-classes:message
Subject: RE: [PATCH v8] mempool: improve cache behaviour and performance
MIME-Version: 1.0
Content-Type: text/plain;
	charset="UTF-8"
Content-Transfer-Encoding: base64
Date: Wed, 8 Jul 2026 16:08:40 +0200
Message-ID: <98CBD80474FA8B44BF855DF32C47DC35F65962@smartserver.smartshare.dk>
In-Reply-To: <LV2PR12MB589331A1E8F78B5C9F3DC9C6A4FF2@LV2PR12MB5893.namprd12.prod.outlook.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: [PATCH v8] mempool: improve cache behaviour and performance
Thread-Index: AQHc9BgqU5MXD4EJbU6GnkYjz7nN67Y3qjmAgCwI/3CAACj5IA==
References: <20260408141315.904381-1-mb@smartsharesystems.com>
 <20260604114851.12586-1-mb@smartsharesystems.com>
 <VxW5gWu4QO2u3TstS3BuBw@monjalon.net>
 <LV2PR12MB589331A1E8F78B5C9F3DC9C6A4FF2@LV2PR12MB5893.namprd12.prod.outlook.com>
X-MimeOLE: Produced By Microsoft Exchange V6.5
From: =?UTF-8?B?TW9ydGVuIEJyw7hydXA=?= <mb@smartsharesystems.com>
To: "Wisam Jaddo" <wisamm@nvidia.com>,
 "NBU-Contact-Thomas Monjalon (EXTERNAL)" <thomas@monjalon.net>
Cc: <dev@dpdk.org>, "Andrew Rybchenko" <andrew.rybchenko@oktetlabs.ru>,
 "Raslan Darawsheh" <rasland@nvidia.com>,
 "Maayan Kashani" <mkashani@nvidia.com>
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

PiBGcm9tOiBXaXNhbSBKYWRkbyBbbWFpbHRvOndpc2FtbUBudmlkaWEuY29tXQ0KPiBTZW50OiBX
ZWRuZXNkYXksIDggSnVseSAyMDI2IDE0LjI4DQo+IA0KPiBIaSwNCj4gDQo+IE91ciBpbnRlcm5h
bCBwZXJmb3JtYW5jZSB0ZXN0aW5nIGFyZSBzaG93aW5nIGRlZ3JhZGF0aW9uIHN0YXJ0aW5nIGZy
b20NCj4gdGhpcyBjb21taXQuDQo+IFRoZSBkZWdyYWRhdGlvbiBpcyBhYm91dCAxLjglIC0gMiUg
b24gc21hbGwgbXNnIHN6aWVzLg0KDQpXaGF0IGRvIHlvdSBtZWFuICJzbWFsbCBtZXNzYWdlIHNp
emVzIj8NCg0KQWxzbywgcGxlYXNlIHNoYXJlIG1vcmUgZGV0YWlscyBhYm91dCB0aGUgdGVzdCBj
YXNlOg0KQWNjZXNzIHBhdHRlcm4sIGUuZy4gcGlwZWxpbmVkIGFjcm9zcyBtdWx0aXBsZSB0aHJl
YWRzIG9yIHJ1bi10by1jb21wbGV0aW9uPyBJZiBwb3NzaWJsZSwgbGluayB0byB0ZXN0IGNhc2Ug
c291cmNlIGNvZGU/DQpHZXQgYW5kIHB1dCBidXJzdCBzaXplcz8NCk1lbXBvb2wgY2FjaGUgc2l6
ZT8NCk1lbXBvb2wgZHJpdmVyPw0KDQpQUzogSSBhc3N1bWUgaXQgaXMgYWJvdXQgbWJ1ZiBtZW1w
b29sLiBPciBpcyBpdCBzb21lIG90aGVyIG9iamVjdCB0eXBlIGluIHRoZSBtZW1wb29sPw0KDQo+
IA0KPiBCUnMsDQo+IFdpc2FtIEphZGRvDQo+IA0KPiA+IC0tLS0tT3JpZ2luYWwgTWVzc2FnZS0t
LS0tDQo+ID4gRnJvbTogVGhvbWFzIE1vbmphbG9uIDx0aG9tYXNAbW9uamFsb24ubmV0Pg0KPiA+
IFNlbnQ6IFdlZG5lc2RheSwgSnVuZSAxMCwgMjAyNiAyOjA3IFBNDQo+ID4gVG86IE1vcnRlbiBC
csO4cnVwIDxtYkBzbWFydHNoYXJlc3lzdGVtcy5jb20+DQo+ID4gQ2M6IGRldkBkcGRrLm9yZzsg
QW5kcmV3IFJ5YmNoZW5rbyA8YW5kcmV3LnJ5YmNoZW5rb0Bva3RldGxhYnMucnU+DQo+ID4gU3Vi
amVjdDogUmU6IFtQQVRDSCB2OF0gbWVtcG9vbDogaW1wcm92ZSBjYWNoZSBiZWhhdmlvdXIgYW5k
DQo+IHBlcmZvcm1hbmNlDQo+ID4NCj4gPiAwNC8wNi8yMDI2IDEzOjQ4LCBNb3J0ZW4gQnLDuHJ1
cDoNCj4gPiA+IFRoaXMgcGF0Y2ggcmVmYWN0b3JzIHRoZSBtZW1wb29sIGNhY2hlIHRvIGVsaW1p
bmF0ZSBzb21lIHVuZXhwZWN0ZWQNCj4gPiA+IGJlaGF2aW91ciBhbmQgcmVkdWNlIHRoZSBtZW1w
b29sIGNhY2hlIG1pc3MgcmF0ZS4NCj4gPg0KPiA+IEFwcGxpZWQsIHRoYW5rcy4NCj4gPg0KPiA+
DQoNCg==
