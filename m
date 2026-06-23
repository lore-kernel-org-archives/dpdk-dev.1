Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7C20BCDB46F
	for <dpdk-dev@archiver.kernel.org>; Tue, 23 Jun 2026 10:30:04 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 427FC402A2;
	Tue, 23 Jun 2026 12:30:03 +0200 (CEST)
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com
 [185.176.79.56]) by mails.dpdk.org (Postfix) with ESMTP id 30C4D40269
 for <dev@dpdk.org>; Tue, 23 Jun 2026 12:30:01 +0200 (CEST)
Received: from mail.maildlp.com (unknown [172.18.224.107])
 by frasgout.his.huawei.com (SkyGuard) with ESMTPS id 4gl1X43bT2zJ46d6;
 Tue, 23 Jun 2026 18:29:24 +0800 (CST)
Received: from frapema500002.china.huawei.com (unknown [7.182.19.148])
 by mail.maildlp.com (Postfix) with ESMTPS id 50B4340584;
 Tue, 23 Jun 2026 18:29:59 +0800 (CST)
Received: from frapema500003.china.huawei.com (7.182.19.114) by
 frapema500002.china.huawei.com (7.182.19.148) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Tue, 23 Jun 2026 12:29:59 +0200
Received: from frapema500003.china.huawei.com ([7.182.19.114]) by
 frapema500003.china.huawei.com ([7.182.19.114]) with mapi id 15.02.1544.011;
 Tue, 23 Jun 2026 12:29:59 +0200
From: Marat Khalili <marat.khalili@huawei.com>
To: Thomas Monjalon <thomas@monjalon.net>
CC: Konstantin Ananyev <konstantin.ananyev@huawei.com>, "dev@dpdk.org"
 <dev@dpdk.org>
Subject: RE: [PATCH v3 05/25] bpf/validate: introduce debugging interface
Thread-Topic: [PATCH v3 05/25] bpf/validate: introduce debugging interface
Thread-Index: AQHc+lkWXE6IMRotik+EWsdt3Z9C1LZL3RYAgAAiGhA=
Date: Tue, 23 Jun 2026 10:29:58 +0000
Message-ID: <84ce7f7669404239864c61819267d9b6@huawei.com>
References: <20260519093131.52022-1-marat.khalili@huawei.com>
 <20260612104743.6465-1-marat.khalili@huawei.com>
 <20260612104743.6465-6-marat.khalili@huawei.com>
 <3BbIFKkFSyOqZrm3k570og@monjalon.net>
In-Reply-To: <3BbIFKkFSyOqZrm3k570og@monjalon.net>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.206.137.78]
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

PiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBUaG9tYXMgTW9uamFsb24gPHRo
b21hc0Btb25qYWxvbi5uZXQ+DQo+IFNlbnQ6IFR1ZXNkYXkgMjMgSnVuZSAyMDI2IDExOjE5DQo+
IFRvOiBNYXJhdCBLaGFsaWxpIDxtYXJhdC5raGFsaWxpQGh1YXdlaS5jb20+DQo+IENjOiBLb25z
dGFudGluIEFuYW55ZXYgPGtvbnN0YW50aW4uYW5hbnlldkBodWF3ZWkuY29tPjsgZGV2QGRwZGsu
b3JnDQo+IFN1YmplY3Q6IFJlOiBbUEFUQ0ggdjMgMDUvMjVdIGJwZi92YWxpZGF0ZTogaW50cm9k
dWNlIGRlYnVnZ2luZyBpbnRlcmZhY2UNCj4gDQo+IDEyLzA2LzIwMjYgMTI6NDcsIE1hcmF0IEto
YWxpbGk6DQo+ID4gKyNpZm5kZWYgTElTVF9GT1JFQUNIX1NBRkUNCj4gPiArLyogV2UgbmVlZCB0
aGlzIG1hY3JvIHdoaWNoIG5laXRoZXIgTGludXggbm9yIEVBTCBmb3IgTGludXggaW5jbHVkZSB5
ZXQuICovDQo+ID4gKyNkZWZpbmUgICAgICAgIExJU1RfRk9SRUFDSF9TQUZFKHZhciwgaGVhZCwg
ZmllbGQsIHR2YXIpICAgICAgICAgICAgICAgICAgICAgICBcDQo+ID4gKyAgICAgICBmb3IgKCh2
YXIpID0gTElTVF9GSVJTVCgoaGVhZCkpOyAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
XA0KPiA+ICsgICAgICAgICAgICh2YXIpICYmICgodHZhcikgPSBMSVNUX05FWFQoKHZhciksIGZp
ZWxkKSwgMSk7ICAgICAgICAgICAgIFwNCj4gPiArICAgICAgICAgICAodmFyKSA9ICh0dmFyKSkN
Cj4gPiArI2Vsc2UNCj4gPiArI2lmZGVmIFJURV9FWEVDX0VOVl9MSU5VWA0KPiA+ICsjZXJyb3Ig
IkRvbid0IG5lZWQgTElTVF9GT1JFQUNIX1NBRkUgaW4gdGhpcyB2ZXJzaW9uIG9mIERQREsgYW55
bW9yZSwgcmVtb3ZlIGl0LiINCj4gPiArI2VuZGlmDQo+ID4gKyNlbmRpZg0KPiANCj4gSXQgZmFp
bHMgb24gQWxwaW5lIExpbnV4Lg0KPiBXaHkgYWRkaW5nIHRoaXMgI2Vycm9yPw0KPiANCg0KVGhp
cyBpcyBpbnRlcmVzdGluZy4gTXkgbWVudGFsIG1vZGVsIHdhcyB0aGF0IExpbnV4IGlzIG5ldmVy
IGdvaW5nIHRvIGhhdmUNCkxJU1RfRk9SRUFDSF9TQUZFLCBidXQgRFBESyB3aWxsIGV2ZW50dWFs
bHkgZ2FpbiBpdHMgb3duIHBvbHlmaWxsLiBJIHdhcw0KYWN0dWFsbHkgZXhwZWN0aW5nIGl0IHRv
IGhhcHBlbiBiZWZvcmUgbXkgcGF0Y2ggaXMgcHVibGlzaGVkLCBzbyB0aGlzIHdhcyBhDQpyZW1p
bmRlciB0byByZW1vdmUgbXkgb3duIGRlZmluaXRpb24gc2luY2UgaXQgY2xlYXJseSBiZWxvbmdz
IHRvIHNvbWUgY29tbW9uDQpsaWJyYXJ5LiBUdXJucyBvdXQgSSB3YXMgd3Jvbmcgb24gYm90aCBh
Y2NvdW50czogdGhlcmUgYXJlIExpbnV4ZXMgdGhhdCBkZWZpbmUNCkxJU1RfRk9SRUFDSF9TQUZF
LCBhbmQgSSBtYW5hZ2VkIHRvIHN1Ym1pdCBmYXN0ZXIuIEFwYXJ0IGZyb20gdGhlc2UNCm9yZ2Fu
aXphdGlvbmFsIGlzc3VlcyB0aGUgd2hvbGUgZWxzZSBicmFuY2ggY2FuIGJlIHNhZmVseSByZW1v
dmVkLiBEbyB5b3Ugd2FudA0KbWUgdG8gc3VibWl0IGFuIHVwZGF0ZWQgdmVyc2lvbj8NCg==
