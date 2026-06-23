Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AB24BCDB46F
	for <dpdk-dev@archiver.kernel.org>; Tue, 23 Jun 2026 12:05:06 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id E98524042F;
	Tue, 23 Jun 2026 14:05:05 +0200 (CEST)
Received: from dkmailrelay1.smartsharesystems.com
 (smartserver.smartsharesystems.com [77.243.40.215])
 by mails.dpdk.org (Postfix) with ESMTP id CB61F402EB
 for <dev@dpdk.org>; Tue, 23 Jun 2026 14:05:03 +0200 (CEST)
Received: from smartserver.smartsharesystems.com
 (smartserver.smartsharesys.local [192.168.4.10])
 by dkmailrelay1.smartsharesystems.com (Postfix) with ESMTP id 9B4C72024A;
 Tue, 23 Jun 2026 14:05:03 +0200 (CEST)
Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="utf-8"
Content-Transfer-Encoding: base64
Subject: RE: [PATCH v5] graph: add optional profiling stats
Date: Tue, 23 Jun 2026 14:04:58 +0200
Message-ID: <98CBD80474FA8B44BF855DF32C47DC35F6593A@smartserver.smartshare.dk>
X-MimeOLE: Produced By Microsoft Exchange V6.5
In-Reply-To: <CAHfVqdWKoDqb0uD_HrF8e=GqadThPhZj0vZnRYDW=KMPei0mXQ@mail.gmail.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: [PATCH v5] graph: add optional profiling stats
Thread-Index: Ad0C6wxEgT+4eYwsR0OAjZOEYgVz/gAHPWFg
References: <20260619202047.2809165-1-mb@smartsharesystems.com>
 <20260621184140.2878132-1-mb@smartsharesystems.com>
 <CALBAE1OCbZ9GB1oGYgR5hRtzjRmev2ZFOaSNndf02AZptihOcw@mail.gmail.com>
 <98CBD80474FA8B44BF855DF32C47DC35F65937@smartserver.smartshare.dk>
 <CALBAE1OZDXfH1FoVLJ=vXVqr=9hYPgqeCzN8h278wN8FbU+XaQ@mail.gmail.com>
 <CAHfVqdWKoDqb0uD_HrF8e=GqadThPhZj0vZnRYDW=KMPei0mXQ@mail.gmail.com>
From: =?utf-8?B?TW9ydGVuIEJyw7hydXA=?= <mb@smartsharesystems.com>
To: "saeed bishara" <saeed.bishara.os@gmail.com>
Cc: "Jerin Jacob" <jerinjacobk@gmail.com>, <dev@dpdk.org>,
 "Jerin Jacob" <jerinj@marvell.com>,
 "Kiran Kumar K" <kirankumark@marvell.com>,
 "Nithin Dabilpuram" <ndabilpuram@marvell.com>,
 "Zhirun Yan" <yanzhirun_163@163.com>
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

PiBGcm9tOiBzYWVlZCBiaXNoYXJhIFttYWlsdG86c2FlZWQuYmlzaGFyYS5vc0BnbWFpbC5jb21d
DQo+IFNlbnQ6IFR1ZXNkYXksIDIzIEp1bmUgMjAyNiAxMC4zNA0KPiANCj4gPiA+ID4gPiArICAg
ICAgICAgICAgICAgLyoqIEZhc3QgcGF0aCBhcmVhIGNhY2hlIGxpbmUgMy4gKi8NCj4gPiA+ID4g
PiArI2lmZGVmIFJURV9HUkFQSF9QUk9GSUxFDQo+ID4gPiA+ID4gKyAgICAgICAgICAgICAgIHN0
cnVjdCB7DQo+ID4gPiA+ID4gKyAgICAgICAgICAgICAgICAgICAgICAgdWludDY0X3QgY2FsbHM7
ICAgICAvKio8IENhbGxzDQo+IHByb2Nlc3NpbmcNCj4gPiA+ID4gcmVzcC4gMCBvciAxIG9iamVj
dHMuICovDQo+ID4gPiA+ID4gKyAgICAgICAgICAgICAgICAgICAgICAgdWludDY0X3QgY3ljbGVz
OyAgICAvKio8IEN5Y2xlcyBzcGVudA0KPiA+ID4gPiBwcm9jZXNzaW5nIHJlc3AuIDAgb3IgMSBv
YmplY3RzLiAqLw0KPiA+ID4gPiA+ICsgICAgICAgICAgICAgICB9IHVzYWdlX3N0YXRzWzJdOyAg
ICAgICAvKio8IFVzYWdlIHdoZW4gdGhpcw0KPiBub2RlDQo+ID4gPiA+IHByb2Nlc3NlZCAwIG9y
IDEgb2JqZWN0cy4gKi8NCj4gPiA+ID4gPiArICAgICAgICAgICAgICAgdWludDY0X3QgZnVsbF9i
dXJzdF9jYWxsczsgIC8qKjwgQ2FsbHMNCj4gcHJvY2Vzc2luZyBhDQo+ID4gPiA+IGZ1bGwgYnVy
c3Qgb2Ygb2JqZWN0cy4gKi8NCj4gPiA+ID4gPiArICAgICAgICAgICAgICAgdWludDY0X3QgZnVs
bF9idXJzdF9jeWNsZXM7IC8qKjwgQ3ljbGVzIHNwZW50DQo+ID4gPiA+IHByb2Nlc3NpbmcgYSBm
dWxsIGJ1cnN0IG9mIG9iamVjdHMuICovDQo+ID4gPiA+ID4gKyAgICAgICAgICAgICAgIHVpbnQ2
NF90IGhhbGZfYnVyc3RfY2FsbHM7ICAvKio8IENhbGxzDQo+IHByb2Nlc3NpbmcgYQ0KPiA+ID4g
PiBoYWxmIGJ1cnN0IG9mIG9iamVjdHMuICovDQo+ID4gPiA+ID4gKyAgICAgICAgICAgICAgIHVp
bnQ2NF90IGhhbGZfYnVyc3RfY3ljbGVzOyAvKio8IEN5Y2xlcyBzcGVudA0KPiA+ID4gPiBwcm9j
ZXNzaW5nIGEgaGFsZiBidXJzdCBvZiBvYmplY3RzLiAqLw0KPiA+ID4gPiA+ICsgICAgICAgICAg
ICAgICAvKiogRmFzdCBwYXRoIGFyZWEgY2FjaGUgbGluZSA0LiAqLw0KPiA+ID4gPiA+ICsjZW5k
aWYNCj4gPiA+ID4NCj4gPiA+ID4gSXMgaXQgYW4gQUJJIGJyZWFrYWdlPw0KPiBDYW4geW91IGNv
bnNpZGVyIG9uZSBhcnJheSBmb3IgYWxsIGNhc2VzPw0KDQpBY2suDQoNCj4gYWxzbywgaW5zdGVh
ZCBvZiBhZGRpbmcgY2FjaGVsaW5lIGZvciB0aGlzIHByb2ZpbGluZyBkYXRhLCBjYW4gd2UNCj4g
c2hhcmUgd2l0aCBsaW5lIDEgdGhhdCB1c2VkIHNvbGVseSBmb3IgeHN0YXRzPw0KDQpUaGlzIHBy
b2ZpbGluZyBkYXRhIGlzIDQgaW5kZXhlcyAqIDIgdmFsdWVzICogOC1ieXRlIGZpZWxkcywgc28g
b25lIGNhY2hlIGxpbmUgaW4gaXRzZWxmLg0KDQo=
