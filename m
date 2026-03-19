Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C2F87109022C
	for <dpdk-dev@archiver.kernel.org>; Thu, 19 Mar 2026 14:21:36 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 033DD402BD;
	Thu, 19 Mar 2026 15:21:36 +0100 (CET)
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com
 [185.176.79.56])
 by mails.dpdk.org (Postfix) with ESMTP id 5471F4025D;
 Thu, 19 Mar 2026 15:21:34 +0100 (CET)
Received: from mail.maildlp.com (unknown [172.18.224.107])
 by frasgout.his.huawei.com (SkyGuard) with ESMTPS id 4fc7C56QcXzJ46Zt;
 Thu, 19 Mar 2026 22:20:33 +0800 (CST)
Received: from frapema500004.china.huawei.com (unknown [7.182.19.21])
 by mail.maildlp.com (Postfix) with ESMTPS id 668D740584;
 Thu, 19 Mar 2026 22:21:33 +0800 (CST)
Received: from frapema500003.china.huawei.com (7.182.19.114) by
 frapema500004.china.huawei.com (7.182.19.21) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Thu, 19 Mar 2026 15:21:33 +0100
Received: from frapema500003.china.huawei.com ([7.182.19.114]) by
 frapema500003.china.huawei.com ([7.182.19.114]) with mapi id 15.02.1544.011;
 Thu, 19 Mar 2026 15:21:33 +0100
From: Marat Khalili <marat.khalili@huawei.com>
To: =?utf-8?B?TW9ydGVuIEJyw7hydXA=?= <mb@smartsharesystems.com>,
 "dev@dpdk.org" <dev@dpdk.org>
CC: Stephen Hemminger <stephen@networkplumber.org>, Christophe Fontaine
 <cfontain@redhat.com>, Konstantin Ananyev <konstantin.v.ananyev@yandex.ru>,
 Wathsala Vithanage <wathsala.vithanage@arm.com>, "stable@dpdk.org"
 <stable@dpdk.org>
Subject: RE: [PATCH v2] mbuf: fix read packet data
Thread-Topic: [PATCH v2] mbuf: fix read packet data
Thread-Index: AQHct54EgHZAG2nipE+i7GOZrCGhprW12CGA
Date: Thu, 19 Mar 2026 14:21:33 +0000
Message-ID: <da1693e3aef3481583356e9e7393a8fa@huawei.com>
References: <20260319084048.652493-1-mb@smartsharesystems.com>
 <20260319124329.729034-1-mb@smartsharesystems.com>
In-Reply-To: <20260319124329.729034-1-mb@smartsharesystems.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.206.138.16]
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

QWNrZWQtYnk6IE1hcmF0IEtoYWxpbGkgPG1hcmF0LmtoYWxpbGlAaHVhd2VpLmNvbT4NClRlc3Rl
ZC1ieTogTWFyYXQgS2hhbGlsaSA8bWFyYXQua2hhbGlsaUBodWF3ZWkuY29tPg0KDQpHb29kIGlk
ZWEgdG8gY2xhcmlmeSBjaGVjayB0ZXh0cyBpbiB0aGUgdGVzdC4NCg0KPiBkaWZmIC0tZ2l0IGEv
YXBwL3Rlc3QvdGVzdF9tYnVmLmMgYi9hcHAvdGVzdC90ZXN0X21idWYuYw0KPiBpbmRleCBhNDFk
MmQwZjk3Li5kYjIzMjU5NzQ1IDEwMDY0NA0KPiAtLS0gYS9hcHAvdGVzdC90ZXN0X21idWYuYw0K
PiArKysgYi9hcHAvdGVzdC90ZXN0X21idWYuYw0KPiBAQCAtMjAzNywxMyArMjAzNywxMyBAQCB0
ZXN0X3BrdG1idWZfcmVhZF9mcm9tX29mZnNldChzdHJ1Y3QgcnRlX21lbXBvb2wgKnBrdG1idWZf
cG9vbCkNCj4gIAkvKiByZWFkIGxlbmd0aCBncmVhdGVyIHRoYW4gbWJ1ZiBkYXRhX2xlbiAqLw0K
PiAgCWlmIChydGVfcGt0bWJ1Zl9yZWFkKG0sIGhkcl9sZW4sIHJ0ZV9wa3RtYnVmX2RhdGFfbGVu
KG0pICsgMSwNCj4gIAkJCQlOVUxMKSAhPSBOVUxMKQ0KPiAtCQlHT1RPX0ZBSUwoIiVzOiBSZXF1
ZXN0ZWQgbGVuIGlzIGxhcmdlciB0aGFuIG1idWYgZGF0YSBsZW4hXG4iLA0KPiArCQlHT1RPX0ZB
SUwoIiVzOiBSZXF1ZXN0ZWQgb2Zmc2V0ICsgbGVuIGlzIGxhcmdlciB0aGFuIG1idWYgZGF0YSBs
ZW4hXG4iLA0KPiAgCQkJCV9fZnVuY19fKTsNCg0KQW5vdGhlciBzdHJhbmdlIGNoZWNrIHRiaCwg
dGhlcmUgaXMgbm90aGluZyB3cm9uZyB3aXRoIHJlYWRpbmcgYmV5b25kIG1idWYgZGF0YQ0KbGVu
Z3RoLiBUaGlzIG9ubHkgZmFpbHMgYmVjYXVzZSB3ZSBhcmUgcmVhZGluZyBiZXlvbmQgcGFja2V0
IGxlbmd0aCwgd2hpY2ggaXMNCnRlc3RlZCBpbW1lZGlhdGVseSBhZnRlci4gSSdkIHZvdGUgdG8g
ZGVsZXRlIGl0LCBhbHRob3VnaCBpdCBoYXMgbm90aGluZyB0byBkbw0Kd2l0aCB0aGUgcGF0Y2gu
IFRoaXMgaXMganVzdCBhIGdlbmVyYWwgY29tbWVudCwgbm90IGFuIGlzc3VlLg0KDQo+IA0KPiAg
CS8qIHJlYWQgbGVuZ3RoIGdyZWF0ZXIgdGhhbiBtYnVmIHBrdF9sZW4gKi8NCj4gIAlpZiAocnRl
X3BrdG1idWZfcmVhZChtLCBoZHJfbGVuLCBydGVfcGt0bWJ1Zl9wa3RfbGVuKG0pICsgMSwNCj4g
IAkJCQlOVUxMKSAhPSBOVUxMKQ0KPiAtCQlHT1RPX0ZBSUwoIiVzOiBSZXF1ZXN0ZWQgbGVuIGlz
IGxhcmdlciB0aGFuIG1idWYgcGt0IGxlbiFcbiIsDQo+ICsJCUdPVE9fRkFJTCgiJXM6IFJlcXVl
c3RlZCBvZmZzZXQgKyBsZW4gaXMgbGFyZ2VyIHRoYW4gbWJ1ZiBwa3QgbGVuIVxuIiwNCj4gIAkJ
CQlfX2Z1bmNfXyk7DQo+IA0KPiAgCS8qIHJlYWQgZGF0YSBvZiB6ZXJvIGxlbiBmcm9tIHZhbGlk
IG9mZnNldCAqLw0KDQo=
