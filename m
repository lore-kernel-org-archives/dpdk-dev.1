Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 980F2CD98F2
	for <dpdk-dev@archiver.kernel.org>; Fri, 19 Jun 2026 20:11:11 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 4974E4028F;
	Fri, 19 Jun 2026 22:11:10 +0200 (CEST)
Received: from dkmailrelay1.smartsharesystems.com
 (smartserver.smartsharesystems.com [77.243.40.215])
 by mails.dpdk.org (Postfix) with ESMTP id 9262940289
 for <dev@dpdk.org>; Fri, 19 Jun 2026 22:11:08 +0200 (CEST)
Received: from smartserver.smartsharesystems.com
 (smartserver.smartsharesys.local [192.168.4.10])
 by dkmailrelay1.smartsharesystems.com (Postfix) with ESMTP id 4A8BF201E4;
 Fri, 19 Jun 2026 22:11:08 +0200 (CEST)
Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="utf-8"
Content-Transfer-Encoding: base64
Subject: RE: [PATCH v1 0/5] prefix lcore role enum values
Date: Fri, 19 Jun 2026 22:11:02 +0200
Message-ID: <98CBD80474FA8B44BF855DF32C47DC35F6592C@smartserver.smartshare.dk>
X-MimeOLE: Produced By Microsoft Exchange V6.5
In-Reply-To: <20260619083934.510bd2d4@phoenix.local>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: [PATCH v1 0/5] prefix lcore role enum values
Thread-Index: Ad0AAdiFb9ET7PU0SiOiJDk9j9K5KgAJY7Nw
References: <20260617102834.2343356-1-lihuisong@huawei.com><98CBD80474FA8B44BF855DF32C47DC35F65917@smartserver.smartshare.dk><20260618190339.2fc76616@phoenix.local><ApV03BBBSN-iQgiffDgXRg@monjalon.net><98CBD80474FA8B44BF855DF32C47DC35F65929@smartserver.smartshare.dk>
 <20260619083934.510bd2d4@phoenix.local>
From: =?utf-8?B?TW9ydGVuIEJyw7hydXA=?= <mb@smartsharesystems.com>
To: "Stephen Hemminger" <stephen@networkplumber.org>
Cc: "Thomas Monjalon" <thomas@monjalon.net>,
 "Huisong Li" <lihuisong@huawei.com>, <andrew.rybchenko@oktetlabs.ru>,
 <dev@dpdk.org>, <zhanjie9@hisilicon.com>
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

PiBGcm9tOiBTdGVwaGVuIEhlbW1pbmdlciBbbWFpbHRvOnN0ZXBoZW5AbmV0d29ya3BsdW1iZXIu
b3JnXQ0KPiBTZW50OiBGcmlkYXksIDE5IEp1bmUgMjAyNiAxNy40MA0KPiANCj4gT24gRnJpLCAx
OSBKdW4gMjAyNiAwOTo1NDo1MSArMDIwMA0KPiBNb3J0ZW4gQnLDuHJ1cCA8bWJAc21hcnRzaGFy
ZXN5c3RlbXMuY29tPiB3cm90ZToNCj4gDQo+ID4gPiA+IFRoZSBwcm9ibGVtIHdpdGggdGhpcyBw
YXRjaCBpdCBjYXVzZXMgYnVpbGQgZmFpbHVyZXMgbm93IHdpdGggYWJpDQo+ID4gPiBkaWZmLg0K
PiA+ID4NCj4gPiA+IEl0IGlzIHByb2JhYmx5IGEgYnVnIG9mIGFuIG9sZCB2ZXJzaW9uIG9mIGFi
aWRpZmYuDQo+ID4gPiBJIHJlY29tbWVuZCB1cGRhdGluZy4NCj4gPg0KPiA+IFdpdGggdGhlICNk
ZWZpbmUncyB0aGUgQUJJIGhhcyBub3QgY2hhbmdlZC4gSXQncyBwcm9iYWJseSB0b28NCj4gaW5k
aXJlY3QgZm9yIGFiaWRpZmYgdG8gdW5kZXJzdGFuZC4NCj4gPiBJZiB3ZSBhYnNvbHV0ZWx5IHdh
bnQgdG8gcGxlYXNlIGFiaWRpZmYsIHdlIGNvdWxkIGtlZXAgdGhlIGV4aXN0aW5nDQo+IGVudW1z
IGFuZCAjZGVmaW5lIFJURV9MQ09SRV9ST0xFX1JURSBST0xFX1JURSBmb3Igbm93Lg0KPiA+IEJ1
dCBJJ20gaW4gZmF2b3Igb2Ygd2hhdCB3YXMgZG9uZSBhbHJlYWR5Lg0KPiANCj4gVGhlIGJ1aWxk
IGZhaWx1cmVzIG9uIGdpdGh1Yiwgbm90IGluIG15IGxvY2FsIGJ1aWxkcy4NCj4gaHR0cHM6Ly9n
aXRodWIuY29tL292c3JvYm90L2RwZGsvYWN0aW9ucy9ydW5zLzI3Nzg5ODg5MTcyL2pvYi84MjIz
NTk2NTANCj4gOTANCj4gDQo+IEl0IG1ha2VzIGxvb2tpbmcgYXQgcGF0Y2h3b3JrIGRhc2hib2Fy
ZCBkaWZmaWN1bHQsIGFsbCBwYXRjaGVzIHNob3cgdXANCj4gd2l0aCByZWQgbWFyaw0KDQpTbyBt
YXliZSB3ZSBjYW4gY2hvb3NlIHRoZSBwYXRoIG9mIHBsZWFzaW5nIGFiaWRpZmYuLi4NCktlZXAg
dGhlIGV4aXN0aW5nIGVudW1zLCBhbmQgI2RlZmluZSB0aGUgbmV3IFJURV9MQ09SRV8gcHJlZml4
ZWQgdmFyaWFudHMsIGFuZCB1c2UgdGhvc2UgaW4gdGhlIGNvZGUuDQoNCkxhdGVyLCB3aXRoIGFu
IEFCSSBicmVha2luZyByZWxlYXNlLCB3ZSBjYW4gc3dhcC4NCk9yIG1heWJlIHdlIGp1c3Qgd2Fp
dCB1bnRpbCBhbiBBQkkgYnJlYWtpbmcgcmVsZWFzZSB0byBmaXggdGhpcy4NCg0K
