Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 82A09D2ECF7
	for <dpdk-dev@archiver.kernel.org>; Tue, 20 Jan 2026 11:37:00 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 5B84840268;
	Tue, 20 Jan 2026 12:36:59 +0100 (CET)
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com
 [185.176.79.56])
 by mails.dpdk.org (Postfix) with ESMTP id E31A44013F;
 Tue, 20 Jan 2026 12:36:57 +0100 (CET)
Received: from mail.maildlp.com (unknown [172.18.224.150])
 by frasgout.his.huawei.com (SkyGuard) with ESMTPS id 4dwQJc2NHCzJ468s;
 Tue, 20 Jan 2026 19:36:32 +0800 (CST)
Received: from frapema500003.china.huawei.com (unknown [7.182.19.114])
 by mail.maildlp.com (Postfix) with ESMTPS id B766940539;
 Tue, 20 Jan 2026 19:36:56 +0800 (CST)
Received: from frapema500003.china.huawei.com (7.182.19.114) by
 frapema500003.china.huawei.com (7.182.19.114) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Tue, 20 Jan 2026 12:36:56 +0100
Received: from frapema500003.china.huawei.com ([7.182.19.114]) by
 frapema500003.china.huawei.com ([7.182.19.114]) with mapi id 15.02.1544.011;
 Tue, 20 Jan 2026 12:36:56 +0100
From: Marat Khalili <marat.khalili@huawei.com>
To: Stephen Hemminger <stephen@networkplumber.org>
CC: "dev@dpdk.org" <dev@dpdk.org>, "stable@dpdk.org" <stable@dpdk.org>,
 =?utf-8?B?TW9ydGVuIEJyw7hydXA=?= <mb@smartsharesystems.com>, Bruce Richardson
 <bruce.richardson@intel.com>
Subject: RE: [PATCH 6/6] test: fix trace_autotest_with_traces parallel
 execution
Thread-Topic: [PATCH 6/6] test: fix trace_autotest_with_traces parallel
 execution
Thread-Index: AQHciLbjlzF26T4aQUe+95X2I1GmorVZeG5wgACnDICAAMAIQA==
Date: Tue, 20 Jan 2026 11:36:56 +0000
Message-ID: <37f13d5dc0714ce29cae6beee2dcdb03@huawei.com>
References: <20260118201223.323024-1-stephen@networkplumber.org>
 <20260118201223.323024-7-stephen@networkplumber.org>
 <e895dd4222bd487f84d80241028cf951@huawei.com>
 <20260119160759.1f4b325a@phoenix.local>
In-Reply-To: <20260119160759.1f4b325a@phoenix.local>
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

PiBOb3Qgc3VyZSwgd2hhdCB3b3VsZCBpdCBsb29rIGxpa2UuDQoNClRoZXJlIGlzIG11bHRpcGxl
IHdheXMsIGhvdyBhYm91dCB0aGUgb25lIGJlbG93Lg0KDQo+IEhhdmluZyBzcGVjaWFsIGNhc2Ug
YXJncyBmb3IgdGVzdCBsb29rcyBsaWtlIGEga2x1ZGdlIGFueXdheS4NCg0KMTAwJSBhZ3JlZSwg
YnV0IGl0J3Mgbm90IGxpa2Ugd2UgY2FuIGVhc2lseSBmaXggaXQgcmlnaHQgbm93Lg0KDQoNCmRp
ZmYgLS1naXQgYS9hcHAvdGVzdC9zdWl0ZXMvbWVzb24uYnVpbGQgYi9hcHAvdGVzdC9zdWl0ZXMv
bWVzb24uYnVpbGQNCmluZGV4IDRjODE1ZWEwOTcuLjg0ZGE1ZTZkMGUgMTAwNjQ0DQotLS0gYS9h
cHAvdGVzdC9zdWl0ZXMvbWVzb24uYnVpbGQNCisrKyBiL2FwcC90ZXN0L3N1aXRlcy9tZXNvbi5i
dWlsZA0KQEAgLTk5LDIyICs5OSwyMCBAQCBmb3JlYWNoIHN1aXRlOnRlc3Rfc3VpdGVzDQogICAg
ICAgICAgICAgICAgIHRlc3RfYXJncyArPSBbJy1kJywgZHBka19kcml2ZXJzX2J1aWxkX2Rpcl0N
CiAgICAgICAgICAgICBlbmRpZg0KIA0KKyAgICAgICAgICAgIGlmIHRlc3RfbmFtZS5lbmRzd2l0
aCgnX3dpdGhfdHJhY2VzJykNCisgICAgICAgICAgICAgICAgaWYgaXNfd2luZG93cw0KKyAgICAg
ICAgICAgICAgICAgICAgY29udGludWUNCisgICAgICAgICAgICAgICAgZW5kaWYNCisgICAgICAg
ICAgICAgICAgdGVzdF9hcmdzICs9IFsnLS10cmFjZT0uKiddDQorICAgICAgICAgICAgICAgIHRl
c3RfYXJncyArPSBbJy0tdHJhY2UtZGlyPUAwQCcuZm9ybWF0KG1lc29uLmN1cnJlbnRfYnVpbGRf
ZGlyKCkpXQ0KKyAgICAgICAgICAgIGVuZGlmDQorDQogICAgICAgICAgICAgdGVzdCh0ZXN0X25h
bWUsIGRwZGtfdGVzdCwNCiAgICAgICAgICAgICAgICAgYXJncyA6IHRlc3RfYXJncywNCiAgICAg
ICAgICAgICAgICAgZW52OiBbJ0RQREtfVEVTVD0nICsgdGVzdF9uYW1lXSwNCiAgICAgICAgICAg
ICAgICAgdGltZW91dCA6IHRpbWVvdXRfc2Vjb25kc19mYXN0LA0KICAgICAgICAgICAgICAgICBp
c19wYXJhbGxlbCA6IGZhbHNlLA0KICAgICAgICAgICAgICAgICBzdWl0ZSA6ICdmYXN0LXRlc3Rz
JykNCi0gICAgICAgICAgICBpZiBub3QgaXNfd2luZG93cyBhbmQgdGVzdF9uYW1lID09ICd0cmFj
ZV9hdXRvdGVzdCcNCi0gICAgICAgICAgICAgICAgdGVzdF9hcmdzICs9IFsnLS10cmFjZT0uKidd
DQotICAgICAgICAgICAgICAgIHRlc3RfYXJncyArPSBbJy0tdHJhY2UtZGlyPUAwQCcuZm9ybWF0
KG1lc29uLmN1cnJlbnRfYnVpbGRfZGlyKCkpXQ0KLSAgICAgICAgICAgICAgICB0ZXN0KHRlc3Rf
bmFtZSArICdfd2l0aF90cmFjZXMnLCBkcGRrX3Rlc3QsDQotICAgICAgICAgICAgICAgICAgICBh
cmdzIDogdGVzdF9hcmdzLA0KLSAgICAgICAgICAgICAgICAgICAgZW52OiBbJ0RQREtfVEVTVD0n
ICsgdGVzdF9uYW1lXSwNCi0gICAgICAgICAgICAgICAgICAgIHRpbWVvdXQgOiB0aW1lb3V0X3Nl
Y29uZHNfZmFzdCwNCi0gICAgICAgICAgICAgICAgICAgIGlzX3BhcmFsbGVsIDogZmFsc2UsDQot
ICAgICAgICAgICAgICAgICAgICBzdWl0ZSA6ICdmYXN0LXRlc3RzJykNCi0gICAgICAgICAgICBl
bmRpZg0KICAgICAgICAgZW5kZm9yZWFjaA0KICAgICBlbmRpZg0KIGVuZGZvcmVhY2gNCmRpZmYg
LS1naXQgYS9hcHAvdGVzdC90ZXN0X3RyYWNlLmMgYi9hcHAvdGVzdC90ZXN0X3RyYWNlLmMNCmlu
ZGV4IDk3ZGM2OWY2OGMuLjQ1MWQ4N2JkMTYgMTAwNjQ0DQotLS0gYS9hcHAvdGVzdC90ZXN0X3Ry
YWNlLmMNCisrKyBiL2FwcC90ZXN0L3Rlc3RfdHJhY2UuYw0KQEAgLTI1NSwzICsyNTUsNCBAQCB0
ZXN0X3RyYWNlKHZvaWQpDQogI2VuZGlmIC8qICFSVEVfRVhFQ19FTlZfV0lORE9XUyAqLw0KIA0K
IFJFR0lTVEVSX0ZBU1RfVEVTVCh0cmFjZV9hdXRvdGVzdCwgTk9IVUdFX09LLCBBU0FOX09LLCB0
ZXN0X3RyYWNlKTsNCitSRUdJU1RFUl9GQVNUX1RFU1QodHJhY2VfYXV0b3Rlc3Rfd2l0aF90cmFj
ZXMsIE5PSFVHRV9PSywgQVNBTl9PSywgdGVzdF90cmFjZSk7DQo=
