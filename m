Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 45572CCFA13
	for <dpdk-dev@archiver.kernel.org>; Mon, 10 Nov 2025 12:07:55 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id D50E24026D;
	Mon, 10 Nov 2025 13:07:53 +0100 (CET)
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com
 [185.176.79.56]) by mails.dpdk.org (Postfix) with ESMTP id 4F72D400D6
 for <dev@dpdk.org>; Mon, 10 Nov 2025 13:07:51 +0100 (CET)
Received: from mail.maildlp.com (unknown [172.18.186.231])
 by frasgout.his.huawei.com (SkyGuard) with ESMTPS id 4d4pMB2vyNzHnHLH;
 Mon, 10 Nov 2025 20:07:34 +0800 (CST)
Received: from dubpeml100002.china.huawei.com (unknown [7.214.144.156])
 by mail.maildlp.com (Postfix) with ESMTPS id 7CE611402FF;
 Mon, 10 Nov 2025 20:07:49 +0800 (CST)
Received: from dubpeml500001.china.huawei.com (7.214.147.241) by
 dubpeml100002.china.huawei.com (7.214.144.156) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.36; Mon, 10 Nov 2025 12:07:49 +0000
Received: from dubpeml500001.china.huawei.com ([7.214.147.241]) by
 dubpeml500001.china.huawei.com ([7.214.147.241]) with mapi id 15.02.1544.011; 
 Mon, 10 Nov 2025 12:07:49 +0000
From: Konstantin Ananyev <konstantin.ananyev@huawei.com>
To: Stephen Hemminger <stephen@networkplumber.org>, Rami Neiman
 <rami.neiman@solace.com>
CC: "dev@dpdk.org" <dev@dpdk.org>, Duane Pauls <Duane.Pauls@solace.com>,
 Anatoly Burakov <anatoly.burakov@intel.com>
Subject: =?utf-8?B?UkU6IFF1ZXN0aW9uOiBXaHkgZG9lc27igJl0IHJ0ZV9yaW5nIHVzZSBkb3Vi?=
 =?utf-8?Q?le-mapped_VMA_to_eliminate_wraparound_logic=3F?=
Thread-Topic: =?utf-8?B?UXVlc3Rpb246IFdoeSBkb2VzbuKAmXQgcnRlX3JpbmcgdXNlIGRvdWJsZS1t?=
 =?utf-8?Q?apped_VMA_to_eliminate_wraparound_logic=3F?=
Thread-Index: AQHcUAdEFyv3lBIccEmtmK06UZiWXLTpBiAAgAK295A=
Date: Mon, 10 Nov 2025 12:07:48 +0000
Message-ID: <30360617ea8e48589b6490eb5b6f7388@huawei.com>
References: <SA1PR01MB82954E1727004B247E462C269BC3A@SA1PR01MB8295.prod.exchangelabs.com>
 <20251108091408.584962e8@phoenix>
In-Reply-To: <20251108091408.584962e8@phoenix>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.81.192.108]
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
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

DQoNCj4gPiBIaSBhbGwsDQo+ID4gSSBoYXZlIGEgZGVzaWduIHF1ZXN0aW9uIHJlZ2FyZGluZyBy
dGVfcmluZyB0aGF0IEkgZGlkbuKAmXQgZmluZCBhIGhpc3RvcmljYWwgcmF0aW9uYWxlDQo+IGZv
ciBpbiB0aGUgYXJjaGl2ZXMuDQo+ID4gTW9zdCBtb2Rlcm4gaGlnaC1wZXJmIHJpbmcgYnVmZmVy
cyAoZS5nLiBzb21lIE5JQyBkcml2ZXJzLCBzb21lIERCIHF1ZXVlDQo+IGltcGxlbWVudGF0aW9u
cywgZXRjLikgZWxpbWluYXRlIHdyYXAtYXJvdW5kIGJyYW5jaGVzIGJ5IHRha2luZyB0aGUgcmlu
Z+KAmXMgZWxlbWVudA0KPiBhcnJheSBhbmQgbWFwcGluZyB0d28gY29uc2VjdXRpdmUgVkEgcmFu
Z2VzIHRvIHRoZSBzYW1lIHBoeXNpY2FsIGJhY2tpbmcgcGFnZXMuDQo+ID4gaS5lLiB5b3UgYWxs
b2NhdGUgTiBlbGVtZW50cywgY29tbWl0IGVub3VnaCBwYWdlcyB0byBjb3ZlciBOLCB0aGVuIGNh
bGwgbW1hcCAob3INCj4gZXF1aXZhbGVudCkgYWdhaW4gaW1tZWRpYXRlbHkgZm9sbG93aW5nIGl0
LCBwb2ludGluZyB0byB0aGUgc2FtZSBwaHlzaWNhbCBwYWdlcy4gU28NCj4gZnJvbSB0aGUgQ1BV
4oCZcyBQT1YgdGhlIGVsZW1lbnQgYXJyYXkgaXMgbG9naWNhbGx5IFswIC4uIE4qMikgYnV0IHBo
eXNpY2FsbHkgaXTigJlzIHRoZQ0KPiBzYW1lIGJhY2tpbmcuIFRoZXJlZm9yZSBhIGJhdGNoIHJl
YWQvd3JpdGUgY2FuIGFsd2F5cyBiZSBkb25lIGFzIGEgc2luZ2xlDQo+IGNvbnRpZ3VvdXMgbWVt
Y3B5L0NMRC9TVE9TIHdpdGhvdXQgY29uZGl0aW9uYWxzLCBldmVuIGlmIChoZWFkK2J1bGspIGV4
Y2VlZHMgTi4NCj4gPiBQc2V1ZG8gaWxsdXN0cmF0aW9uOg0KPiA+DQo+ID4gW3BoeXMgYnVmZmVy
IG9mIE4gc2xvdHNdDQo+ID4gVkE6IFswIC4uIE4pIC0+IHBoeXMNCj4gPiBWQTogW04gLi4gMk4p
IC0+IHNhbWUgcGh5cw0KPiA+DQo+ID4NCj4gPiBGb3IgbXVsdGktZWxlbWVudCBlbnF1ZXVlL2Rl
cXVldWUgaXQgZWxpbWluYXRlcyB0aGUg4oCcaWYgd3JhcCDihpIgc3BsaXTigJ0gY2FzZQ0KPiBl
bnRpcmVseSDigJQgeW91IGNhbiBhbHdheXMgbWVtY3B5IGluIG9uZSBjb250aWd1b3VzIG9wLg0K
PiA+IFF1ZXN0aW9uOg0KPiA+IElzIHRoZXJlIGFuIGV4cGxpY2l0IHJlYXNvbiBEUERLIGRvZXNu
4oCZdCB1c2UgdGhpcyB0ZWNobmlxdWUgZm9yIHJ0ZV9yaW5nPw0KPiA+IGUuZy4NCj4gDQo+IE1h
bmlwdWxhdGluZyBwcm9jZXNzIG1hcHBpbmcgaW4gdXNlciBzcGFjZSBpcyBvZnRlbiBub24tcG9y
dGFibGUsIGl0IGlzIHBvc3NpYmxlIG9uDQo+IExpbnV4IHRvIHVzZSBtbWFwDQo+IHRvIGRvIHRo
aXMgYnV0IHdvdWxkIHJlcXVpcmUgZGVlcCBjaGFuZ2VzIHRvIHRoZSBBUEkuDQoNClRCSCwgSSBk
aWRuJ3QgZXZlbiBjb25zaWRlciBzdWNoIG9wcG9ydHVuaXR5Li4uLg0KQnV0IHllcywgSSBTdGVw
aGVuIGFscmVhZHkgcG9pbnRlZCwgb25lIHBvdGVudGlhbCBwcm9ibGVtOg0KRFBESyBtZW1vcnkg
YWxsb2NhdGlvbiBmcmFtZXdvcmsgKHJ0ZV9tYWxsb2MpDQpkb2Vzbid0IHN1cHBvcnQgc3VjaCBk
b3VibGUgbWFwcGluZ3MgZm9yIG5vdy4NCldvdWxkIGl0IGJlIGEgZ29vZCB0aGluZyB0byBhZGQg
b3Igbm90IC0gSSBzdXBwb3NlIGl0IGRlcGVuZHMgb24gd2hhdA0KcGVyZm9ybWFuY2UgYm9vc3Qg
d2Ugd2lsbCBnZXQgaW4gcmV0dXJuIGFuZCB3aGF0IHdvdWxkIGJlIGEgcmVxdWlyZWQgY29kZS1j
aGFuZ2VzIGNvbXBsZXhpdHkuDQpLb25zdGFudGluDQoNCg0K
