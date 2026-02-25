Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5163BFD3774
	for <dpdk-dev@archiver.kernel.org>; Wed, 25 Feb 2026 17:18:08 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 65F104027F;
	Wed, 25 Feb 2026 18:18:07 +0100 (CET)
Received: from dkmailrelay1.smartsharesystems.com
 (smartserver.smartsharesystems.com [77.243.40.215])
 by mails.dpdk.org (Postfix) with ESMTP id 449C1402C5;
 Wed, 25 Feb 2026 18:18:05 +0100 (CET)
Received: from smartserver.smartsharesystems.com
 (smartserver.smartsharesys.local [192.168.4.10])
 by dkmailrelay1.smartsharesystems.com (Postfix) with ESMTP id 1013E20770;
 Wed, 25 Feb 2026 18:18:05 +0100 (CET)
Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="UTF-8"
Content-Transfer-Encoding: base64
Subject: RE: [PATCH v3] mbuf: fix packet copy
Date: Wed, 25 Feb 2026 18:17:59 +0100
X-MimeOLE: Produced By Microsoft Exchange V6.5
Message-ID: <98CBD80474FA8B44BF855DF32C47DC35F6574F@smartserver.smartshare.dk>
In-Reply-To: <6e46bb34-4195-4629-a861-77e881005d91@redhat.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: [PATCH v3] mbuf: fix packet copy
Thread-Index: Adymb5z02RkivA7fQrK4Qu9vUQercAACHZ3g
References: <20251119120403.907511-1-mb@smartsharesystems.com>
 <20260120072414.465240-1-mb@smartsharesystems.com>
 <9659693.EvYhyI6sBW@thomas> <6e46bb34-4195-4629-a861-77e881005d91@redhat.com>
From: =?UTF-8?B?TW9ydGVuIEJyw7hydXA=?= <mb@smartsharesystems.com>
To: "Kevin Traynor" <ktraynor@redhat.com>,
 "Thomas Monjalon" <thomas@monjalon.net>
Cc: "Stephen Hemminger" <stephen@networkplumber.org>, <dev@dpdk.org>,
 <stable@dpdk.org>, "Konstantin Ananyev" <konstantin.ananyev@huawei.com>
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

PiBGcm9tOiBLZXZpbiBUcmF5bm9yIFttYWlsdG86a3RyYXlub3JAcmVkaGF0LmNvbV0NCj4gU2Vu
dDogV2VkbmVzZGF5LCAyNSBGZWJydWFyeSAyMDI2IDE2LjU5DQo+IA0KPiBPbiAxMC8wMi8yMDI2
IDE3OjIxLCBUaG9tYXMgTW9uamFsb24gd3JvdGU6DQo+ID4gMjAvMDEvMjAyNiAwODoyNCwgTW9y
dGVuIEJyw7hydXA6DQo+ID4+IG1idWY6IGZpeCBwYWNrZXQgY29weQ0KPiA+Pg0KPiA+PiBSZXF1
ZXN0cyBmb3IgY29weWluZyB0aGUgYXQgdGhlIGVuZCBvZiBhIHBhY2tldCBpbmNvcnJlY3RseSBy
ZXR1cm5lZA0KPiBOVUxMLA0KPiA+PiBhcyBpZiBjb3B5aW5nIHBhc3QgdGhlIGVuZCBvZiBhIHBh
Y2tldC4NCj4gPj4NCj4gPj4gV2hlbiBhbGxvY2F0aW5nIHRoZSBtYnVmIGZvciB0aGUgY29weSBm
cm9tIGEgbWVtcG9vbCB1c2luZyBwaW5uZWQNCj4gZXh0ZXJuYWwNCj4gPj4gYnVmZmVycywgdGhl
IGV4dGVybmFsIGZsYWcgaW4gdGhpcyBtYnVmIHdhcyBub3QgcHJlc2VydmVkLg0KPiA+Pg0KPiA+
PiBGaXhlczogYzNhOTBjMzgxZGFhICgibWJ1ZjogYWRkIGEgY29weSByb3V0aW5lIikNCj4gPj4N
Cj4gPj4gU2lnbmVkLW9mZi1ieTogTW9ydGVuIEJyw7hydXAgPG1iQHNtYXJ0c2hhcmVzeXN0ZW1z
LmNvbT4NCj4gPj4gQWNrZWQtYnk6IEtvbnN0YW50aW4gQW5hbnlldiA8a29uc3RhbnRpbi5hbmFu
eWV2QGh1YXdlaS5jb20+DQo+ID4NCj4gPiBBcHBsaWVkLCB0aGFua3MuDQo+ID4NCj4gPg0KPiA+
DQo+IEhpIEFsbC4gSSBzZWUgdGhpcyBpcyBub3QgbWFya2VkIGZvciBzdGFibGUgcmVsZWFzZS4g
SXMgaXQgZGVsaWJlcmF0ZQ0KPiBiZWNhdXNlIG9mIHRoZSBmbGFncyBjaGFuZ2VzID8NCg0KSUlS
QywgdGhlIGNvbnNlbnN1cyB3YXMgdGhhdCB1c2luZyBwaW5uZWQgZXh0ZXJuYWwgYnVmZmVycyBp
cyBjb25zaWRlcmVkIGV4b3RpYywgc28gdGhlIGJ1ZyBpcyB1bmxpa2VseSB0byBvY2N1ciBpbiBy
ZWFsIGFwcGxpY2F0aW9ucy4gQW5kIGlmIGl0IGRpZCBoYXBwZW4sIHdlIHdvdWxkIGhhdmUgaGVh
cmQgYWJvdXQgaXQuDQoNCkJ1dCwgc2luY2UgeW91IGFzaywgd2UgcmVhbGx5IHNob3VsZCBoYXZl
IGxlZnQgdGhhdCBkZWNpc2lvbiB0byB0aGUgc3RhYmxlIHRyZWUgbWFpbnRhaW5lcnMuDQoNCi1N
b3J0ZW4NCg0K
