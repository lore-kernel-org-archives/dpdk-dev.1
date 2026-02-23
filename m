Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D93C3EC1118
	for <dpdk-dev@archiver.kernel.org>; Mon, 23 Feb 2026 18:14:27 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 9ECA04025E;
	Mon, 23 Feb 2026 19:14:26 +0100 (CET)
Received: from dkmailrelay1.smartsharesystems.com
 (smartserver.smartsharesystems.com [77.243.40.215])
 by mails.dpdk.org (Postfix) with ESMTP id E5FC8400EF
 for <dev@dpdk.org>; Mon, 23 Feb 2026 19:14:24 +0100 (CET)
Received: from smartserver.smartsharesystems.com
 (smartserver.smartsharesys.local [192.168.4.10])
 by dkmailrelay1.smartsharesystems.com (Postfix) with ESMTP id A31E620770;
 Mon, 23 Feb 2026 19:14:24 +0100 (CET)
Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="UTF-8"
Content-Transfer-Encoding: base64
Subject: RE: [PATCH] mempool: introduce statistics reset function
Date: Mon, 23 Feb 2026 19:14:21 +0100
X-MimeOLE: Produced By Microsoft Exchange V6.5
Message-ID: <98CBD80474FA8B44BF855DF32C47DC35F6573F@smartserver.smartshare.dk>
In-Reply-To: <20260223092102.20446fa4@phoenix.local>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: [PATCH] mempool: introduce statistics reset function
Thread-Index: Adyk6M1TeTd/fpQsRJynz29Vf01kBQABxQvQ
References: <20260223102054.336350-1-mb@smartsharesystems.com>
 <20260223092102.20446fa4@phoenix.local>
From: =?UTF-8?B?TW9ydGVuIEJyw7hydXA=?= <mb@smartsharesystems.com>
To: "Stephen Hemminger" <stephen@networkplumber.org>
Cc: <dev@dpdk.org>,
	"Andrew Rybchenko" <andrew.rybchenko@oktetlabs.ru>
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
b3JnXQ0KPiBTZW50OiBNb25kYXksIDIzIEZlYnJ1YXJ5IDIwMjYgMTguMjENCj4gDQo+IE9uIE1v
biwgMjMgRmViIDIwMjYgMTA6MjA6NTQgKzAwMDANCj4gTW9ydGVuIEJyw7hydXAgPG1iQHNtYXJ0
c2hhcmVzeXN0ZW1zLmNvbT4gd3JvdGU6DQo+IA0KPiA+ICsJZnByaW50ZihmLCAiICAgIGF2ZyBv
YmpzL2J1bGsgcHV0PSUjTGYsIGdldD0lI0xmLA0KPiBnZXRfZmFpbD0lI0xmXG4iLA0KPiA+ICsJ
CQlzdW0ucHV0X2J1bGsgIT0gMCA/IChsb25nIGRvdWJsZSlzdW0ucHV0X29ianMgLw0KPiBzdW0u
cHV0X2J1bGsgOiAwLA0KPiA+ICsJCQlzdW0uZ2V0X3N1Y2Nlc3NfYnVsayAhPSAwID8NCj4gPiAr
CQkJKGxvbmcgZG91YmxlKXN1bS5nZXRfc3VjY2Vzc19vYmpzIC8NCj4gc3VtLmdldF9zdWNjZXNz
X2J1bGsgOiAwLA0KPiA+ICsJCQlzdW0uZ2V0X2ZhaWxfYnVsayAhPSAwID8NCj4gPiArCQkJKGxv
bmcgZG91YmxlKXN1bS5nZXRfZmFpbF9vYmpzIC8gc3VtLmdldF9mYWlsX2J1bGsgOg0KPiAwKTsN
Cj4gPiArCWZwcmludGYoZiwgIiAgICBhdmcgY29tbW9uX3Bvb2wgb2Jqcy9idWxrIHB1dD0lI0xm
LCBnZXQ9JSNMZlxuIiwNCj4gPiArCQkJc3VtLnB1dF9jb21tb25fcG9vbF9idWxrICE9IDAgPw0K
PiA+ICsJCQkobG9uZyBkb3VibGUpc3VtLnB1dF9jb21tb25fcG9vbF9vYmpzIC8NCj4gc3VtLnB1
dF9jb21tb25fcG9vbF9idWxrIDogMCwNCj4gPiArCQkJc3VtLmdldF9jb21tb25fcG9vbF9idWxr
ICE9IDAgPw0KPiA+ICsJCQkobG9uZyBkb3VibGUpc3VtLmdldF9jb21tb25fcG9vbF9vYmpzIC8N
Cj4gc3VtLmdldF9jb21tb25fcG9vbF9idWxrIDogMCk7DQo+ID4gKwlmcHJpbnRmKGYsICIgICAg
YXZnIGNhY2hlIG1pc3MgcmF0ZSBwdXRfb2Jqcz0lcyUjTGYsDQo+IGdldF9vYmpzPSVzJSNMZlxu
IiwNCj4gPiArCQkJc3VtLnB1dF9jb21tb25fcG9vbF9vYmpzICE9IDAgPyAiMS8iIDogIiIsDQo+
ID4gKwkJCXN1bS5wdXRfY29tbW9uX3Bvb2xfb2JqcyAhPSAwID8NCj4gPiArCQkJKGxvbmcgZG91
YmxlKXN1bS5wdXRfb2JqcyAvIHN1bS5wdXRfY29tbW9uX3Bvb2xfb2Jqcw0KPiA6IDAsDQo+ID4g
KwkJCXN1bS5nZXRfY29tbW9uX3Bvb2xfb2JqcyAhPSAwID8gIjEvIiA6ICIiLA0KPiA+ICsJCQlz
dW0uZ2V0X2NvbW1vbl9wb29sX29ianMgIT0gMCA/DQo+ID4gKwkJCShsb25nIGRvdWJsZSlzdW0u
Z2V0X3N1Y2Nlc3Nfb2JqcyAvDQo+IHN1bS5nZXRfY29tbW9uX3Bvb2xfb2JqcyA6IDApOw0KPiA+
ICsJZnByaW50ZihmLCAiICAgIGF2ZyBjYWNoZSBtaXNzIHJhdGUgcHV0X2J1bGs9JXMlI0xmLA0K
PiBnZXRfYnVsaz0lcyUjTGZcbiIsDQo+ID4gKwkJCXN1bS5wdXRfY29tbW9uX3Bvb2xfYnVsayAh
PSAwID8gIjEvIiA6ICIiLA0KPiA+ICsJCQlzdW0ucHV0X2NvbW1vbl9wb29sX2J1bGsgIT0gMCA/
DQo+ID4gKwkJCShsb25nIGRvdWJsZSlzdW0ucHV0X2J1bGsgLyBzdW0ucHV0X2NvbW1vbl9wb29s
X2J1bGsNCj4gOiAwLA0KPiA+ICsJCQlzdW0uZ2V0X2NvbW1vbl9wb29sX2J1bGsgIT0gMCA/ICIx
LyIgOiAiIiwNCj4gPiArCQkJc3VtLmdldF9jb21tb25fcG9vbF9idWxrICE9IDAgPw0KPiA+ICsJ
CQkobG9uZyBkb3VibGUpc3VtLmdldF9zdWNjZXNzX2J1bGsgLw0KPiBzdW0uZ2V0X2NvbW1vbl9w
b29sX2J1bGsgOiAwKTsNCj4gDQo+IFRoaXMgaXMgZ2V0dGluZyB2ZXJib3NlLCB3b3VsZCBsb29r
IGJldHRlciBhcyBmdW5jdGlvbiBvciBiZXR0ZXIgeWV0DQo+IHRhYmxlIGRyaXZlbi4NCg0KRHVt
cCBvdXRwdXRzIGFyZSBmb3JtYXR0ZWQgYXMgaGllcmFyY2h5LCBsaWtlIHRoaXMsIHNvIHRhYmxl
IGlzIGEgbm8tZ28uDQpPbmx5IHRoZSBsYXN0IHR3byBhcmUgc2ltaWxhciwgYW5kIGNvdWxkIHNo
YXJlIGEgbWFjcm8vZnVuY3Rpb24sIGJ1dCBJIHRoaW5rIGl0IHdvdWxkIG1ha2UgdGhlIGNvZGUg
bGVzcyByZWFkYWJsZS4NCg0K
