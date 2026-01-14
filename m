Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2B649D31A1C
	for <dpdk-dev@archiver.kernel.org>; Wed, 14 Jan 2026 07:52:33 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 297794042F;
	Wed, 14 Jan 2026 08:52:32 +0100 (CET)
Received: from dkmailrelay1.smartsharesystems.com
 (smartserver.smartsharesystems.com [77.243.40.215])
 by mails.dpdk.org (Postfix) with ESMTP id D57CB40289
 for <dev@dpdk.org>; Wed, 14 Jan 2026 08:52:30 +0100 (CET)
Received: from smartserver.smartsharesystems.com
 (smartserver.smartsharesys.local [192.168.4.10])
 by dkmailrelay1.smartsharesystems.com (Postfix) with ESMTP id 112BA229AD;
 Wed, 14 Jan 2026 08:52:30 +0100 (CET)
Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="UTF-8"
Content-Transfer-Encoding: base64
Subject: RE: [PATCH v2 0/2] cnxk: add HALO support for CN20K mempool
Date: Wed, 14 Jan 2026 08:52:28 +0100
Message-ID: <98CBD80474FA8B44BF855DF32C47DC35F65659@smartserver.smartshare.dk>
X-MimeOLE: Produced By Microsoft Exchange V6.5
In-Reply-To: <20260113220448.56f44b5e@phoenix.local>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: [PATCH v2 0/2] cnxk: add HALO support for CN20K mempool
Thread-Index: AdyFG7fwgqbZ75/jTpSjNPENjkh2PQADOpWA
References: <20251204065203.1866809-2-nkishor@marvell.com>
 <20251205055140.2395369-1-nkishor@marvell.com>
 <20260113220448.56f44b5e@phoenix.local>
From: =?UTF-8?B?TW9ydGVuIEJyw7hydXA=?= <mb@smartsharesystems.com>
To: "Stephen Hemminger" <stephen@networkplumber.org>,
 "Nawal Kishor" <nkishor@marvell.com>
Cc: <dev@dpdk.org>,
	<jerinj@marvell.com>,
	<asekhar@marvell.com>
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

PiAqKldhcm5pbmc6IE5vbi1wb3J0YWJsZSBmb3JtYXQgc3BlY2lmaWVyKioNCj4gDQo+IEluIGBy
b2NfbnBhX2RlYnVnLmNgLCBmdW5jdGlvbiBgbnBhX2hhbG9fZHVtcCgpYDoNCj4gYGBgYw0KPiBu
cGFfZHVtcCgiVzk6IHRocmVzaCBcdFx0JWx1XG5XOTogZmNfbXNoX2RzdCBcdFx0JWQiLA0KPiAg
ICAgICAgICAodW5zaWduZWQgbG9uZyloYWxvLT50aHJlc2gsIGhhbG8tPmZjX21zaF9kc3QpOw0K
PiBgYGANCj4gDQo+IFRoZSBBR0VOVFMubWQgc3BlY2lmaWVzOg0KPiA+IEZvcmJpZGRlbjogYCVs
bGRgLCBgJWxsdWAsIGAlbGx4YCDihpIgUHJlZmVycmVkOiBgJVBSSWQ2NGAsIGAlUFJJdTY0YCwN
Cj4gYCVQUkl4NjRgDQo+IA0KPiBXaGlsZSBgJWx1YCB3aXRoIGFuIGV4cGxpY2l0IGNhc3QgaXMg
dGVjaG5pY2FsbHkgZGlmZmVyZW50LCBmb3INCj4gY29uc2lzdGVuY3kgd2l0aCB0aGUgcmVzdCBv
ZiB0aGUgZmlsZSAod2hpY2ggdXNlcyBgJSJQUkl4NjQiYA0KPiBwYXR0ZXJucyksIHRoaXMgc2hv
dWxkIHVzZToNCj4gYGBgYw0KPiBucGFfZHVtcCgiVzk6IHRocmVzaCBcdFx0JSIgUFJJdTY0ICJc
blc5OiBmY19tc2hfZHN0IFx0XHQlZCIsDQo+ICAgICAgICAgICh1aW50NjRfdCloYWxvLT50aHJl
c2gsIGhhbG8tPmZjX21zaF9kc3QpOw0KPiBgYGANCg0KSSdtIG5vdCBzdXJlIEkgYWdyZWUgd2l0
aCB0aGlzLCBiZWNhdXNlIHRoZSBBSSBzdWdnZXN0ZWQgZml4IGNhc3RzIGhhbG8tPnRocmVzaCB0
byA2NCBiaXQgb24gMzIgYml0IGFyY2hpdGVjdHVyZXMgKHdoaWNoIHRoZXJlIGlzIG5vIG5lZWQg
Zm9yKS4NCg0K
