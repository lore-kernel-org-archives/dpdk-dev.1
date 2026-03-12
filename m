Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ADBD3FED2EF
	for <dpdk-dev@archiver.kernel.org>; Thu, 12 Mar 2026 08:33:07 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 72E8540430;
	Thu, 12 Mar 2026 09:33:06 +0100 (CET)
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com
 [185.176.79.56]) by mails.dpdk.org (Postfix) with ESMTP id 9601F402E0
 for <dev@dpdk.org>; Thu, 12 Mar 2026 09:33:05 +0100 (CET)
Received: from mail.maildlp.com (unknown [172.18.224.150])
 by frasgout.his.huawei.com (SkyGuard) with ESMTPS id 4fWgqC1GjNzHnHBZ;
 Thu, 12 Mar 2026 16:32:55 +0800 (CST)
Received: from dubpeml100001.china.huawei.com (unknown [7.214.144.137])
 by mail.maildlp.com (Postfix) with ESMTPS id 7BE664056B;
 Thu, 12 Mar 2026 16:33:04 +0800 (CST)
Received: from dubpeml500001.china.huawei.com (7.214.147.241) by
 dubpeml100001.china.huawei.com (7.214.144.137) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.36; Thu, 12 Mar 2026 08:33:04 +0000
Received: from dubpeml500001.china.huawei.com ([7.214.147.241]) by
 dubpeml500001.china.huawei.com ([7.214.147.241]) with mapi id 15.02.1544.011; 
 Thu, 12 Mar 2026 08:33:04 +0000
From: Konstantin Ananyev <konstantin.ananyev@huawei.com>
To: =?utf-8?B?TW9ydGVuIEJyw7hydXA=?= <mb@smartsharesystems.com>,
 "dev@dpdk.org" <dev@dpdk.org>, Bruce Richardson <bruce.richardson@intel.com>, 
 Konstantin Ananyev <konstantin.v.ananyev@yandex.ru>, Vipin Varghese
 <vipin.varghese@amd.com>, Stephen Hemminger <stephen@networkplumber.org>,
 Liangxing Wang <wangliangxing@hygon.cn>
CC: Thiyagarajan P <Thiyagarajan.P@amd.com>, Bala Murali Krishna
 <Bala.MuraliKrishna@amd.com>
Subject: RE: [PATCH v7] eal/x86: optimize memcpy of small sizes
Thread-Topic: [PATCH v7] eal/x86: optimize memcpy of small sizes
Thread-Index: AQHcollKgyTFc4bVEUCaHcF8rqa3m7WqsHNw
Date: Thu, 12 Mar 2026 08:33:03 +0000
Message-ID: <10af1da2058b4ceca83a1ec8894c8c5d@huawei.com>
References: <20251120114554.950287-1-mb@smartsharesystems.com>
 <20260220110824.235784-1-mb@smartsharesystems.com>
In-Reply-To: <20260220110824.235784-1-mb@smartsharesystems.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.81.211.31]
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

DQoNCj4gDQo+IFRoZSBpbXBsZW1lbnRhdGlvbiBmb3IgY29weWluZyB1cCB0byA2NCBieXRlcyBk
b2VzIG5vdCBkZXBlbmQgb24gYWRkcmVzcw0KPiBhbGlnbm1lbnQgd2l0aCB0aGUgc2l6ZSBvZiB0
aGUgQ1BVJ3MgdmVjdG9yIHJlZ2lzdGVycy4gTm9uZXRoZWxlc3MsIHRoZQ0KPiBleGFjdCBzYW1l
IGNvZGUgZm9yIGNvcHlpbmcgdXAgdG8gNjQgYnl0ZXMgd2FzIHByZXNlbnQgaW4gYm90aCB0aGUg
YWxpZ25lZA0KPiBjb3B5IGZ1bmN0aW9uIGFuZCBhbGwgdGhlIENQVSB2ZWN0b3IgcmVnaXN0ZXIg
c2l6ZSBzcGVjaWZpYyB2YXJpYW50cyBvZg0KPiB0aGUgdW5hbGlnbmVkIGNvcHkgZnVuY3Rpb25z
Lg0KPiBXaXRoIHRoaXMgcGF0Y2gsIHRoZSBpbXBsZW1lbnRhdGlvbiBmb3IgY29weWluZyB1cCB0
byA2NCBieXRlcyB3YXMNCj4gY29uc29saWRhdGVkIGludG8gb25lIGluc3RhbmNlLCBsb2NhdGVk
IGluIHRoZSBjb21tb24gY29weSBmdW5jdGlvbiwNCj4gYmVmb3JlIGNoZWNraW5nIGFsaWdubWVu
dCByZXF1aXJlbWVudHMuDQo+IFRoaXMgcHJvdmlkZXMgdGhyZWUgYmVuZWZpdHM6DQo+IDEuIE5v
IGNvcHktcGFzdGUgaW4gdGhlIHNvdXJjZSBjb2RlLg0KPiAyLiBBIHBlcmZvcm1hbmNlIGdhaW4g
Zm9yIGNvcHlpbmcgdXAgdG8gNjQgYnl0ZXMsIGJlY2F1c2UgdGhlDQo+IGFkZHJlc3MgYWxpZ25t
ZW50IGNoZWNrIGlzIGF2b2lkZWQgaW4gdGhpcyBjYXNlLg0KPiAzLiBSZWR1Y2VkIGluc3RydWN0
aW9uIG1lbW9yeSBmb290cHJpbnQsIGJlY2F1c2UgdGhlIGNvbXBpbGVyIG9ubHkNCj4gZ2VuZXJh
dGVzIG9uZSBpbnN0YW5jZSBvZiB0aGUgZnVuY3Rpb24gZm9yIGNvcHlpbmcgdXAgdG8gNjQgYnl0
ZXMsIGluc3RlYWQNCj4gb2YgdHdvIGluc3RhbmNlcyAob25lIGluIHRoZSB1bmFsaWduZWQgY29w
eSBmdW5jdGlvbiwgYW5kIG9uZSBpbiB0aGUNCj4gYWxpZ25lZCBjb3B5IGZ1bmN0aW9uKS4NCj4g
DQo+IEZ1cnRoZXJtb3JlLCB0aGUgZnVuY3Rpb24gZm9yIGNvcHlpbmcgbGVzcyB0aGFuIDE2IGJ5
dGVzIHdhcyByZXBsYWNlZCB3aXRoDQo+IGEgc21hcnRlciBpbXBsZW1lbnRhdGlvbiB1c2luZyBm
ZXdlciBicmFuY2hlcyBhbmQgcG90ZW50aWFsbHkgZmV3ZXINCj4gbG9hZC9zdG9yZSBvcGVyYXRp
b25zLg0KPiBUaGlzIGZ1bmN0aW9uIHdhcyBhbHNvIGV4dGVuZGVkIHRvIGhhbmRsZSBjb3B5aW5n
IG9mIHVwIHRvIDE2IGJ5dGVzLA0KPiBpbnN0ZWFkIG9mIHVwIHRvIDE1IGJ5dGVzLg0KPiBUaGlz
IHNtYWxsIGV4dGVuc2lvbiByZWR1Y2VzIHRoZSBjb2RlIHBhdGgsIGFuZCB0aHVzIGltcHJvdmVz
IHRoZQ0KPiBwZXJmb3JtYW5jZSwgZm9yIGNvcHlpbmcgdHdvIHBvaW50ZXJzIG9uIDY0LWJpdCBh
cmNoaXRlY3R1cmVzIGFuZCBmb3VyDQo+IHBvaW50ZXJzIG9uIDMyLWJpdCBhcmNoaXRlY3R1cmVz
Lg0KPiANCj4gQWxzbywgX19ydGVfcmVzdHJpY3Qgd2FzIGFkZGVkIHRvIHNvdXJjZSBhbmQgZGVz
dGluYXRpb24gYWRkcmVzc2VzLg0KPiANCj4gQW5kIGZpbmFsbHksIHRoZSBtaXNzaW5nIGltcGxl
bWVudGF0aW9uIG9mIHJ0ZV9tb3Y0OCgpIHdhcyBhZGRlZC4NCj4gDQo+IFJlZ2FyZGluZyBwZXJm
b3JtYW5jZSwgdGhlIG1lbWNweSBwZXJmb3JtYW5jZSB0ZXN0IHNob3dlZCBjYWNoZS10by1jYWNo
ZQ0KPiBjb3B5aW5nIG9mIHVwIHRvIDMyIGJ5dGVzIG5vdyB0YWtlcyAyIGN5Y2xlcywgdmVyc3Vz
IGNhLiA2LjUgY3ljbGVzIGJlZm9yZQ0KPiB0aGlzIHBhdGNoLg0KPiBDb3B5aW5nIDY0IGJ5dGVz
IG5vdyB0YWtlcyA0IGN5Y2xlcywgdmVyc3VzIDcgY3ljbGVzIGJlZm9yZS4NCj4gDQo+IFNpZ25l
ZC1vZmYtYnk6IE1vcnRlbiBCcsO4cnVwIDxtYkBzbWFydHNoYXJlc3lzdGVtcy5jb20+DQo+IC0t
LQ0KDQpBY2tlZC1ieTogS29uc3RhbnRpbiBBbmFueWV2IDxrb25zdGFudGluLmFuYW55ZXZAaHVh
d2VpLmNvbT4NCg0KPiAtLQ0KPiAyLjQzLjANCg0K
