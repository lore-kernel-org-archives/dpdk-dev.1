Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8BA36C02194
	for <dpdk-dev@archiver.kernel.org>; Fri,  7 Feb 2025 14:30:04 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id BAC3242DC1;
	Fri,  7 Feb 2025 15:30:03 +0100 (CET)
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com
 [185.176.79.56])
 by mails.dpdk.org (Postfix) with ESMTP id F136B410E3;
 Fri,  7 Feb 2025 15:30:01 +0100 (CET)
Received: from mail.maildlp.com (unknown [172.18.186.231])
 by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4YqGYm1Yh9z6HJZN;
 Fri,  7 Feb 2025 22:29:00 +0800 (CST)
Received: from frapeml100008.china.huawei.com (unknown [7.182.85.131])
 by mail.maildlp.com (Postfix) with ESMTPS id 8073F140A30;
 Fri,  7 Feb 2025 22:30:01 +0800 (CST)
Received: from frapeml500007.china.huawei.com (7.182.85.172) by
 frapeml100008.china.huawei.com (7.182.85.131) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Fri, 7 Feb 2025 15:30:01 +0100
Received: from frapeml500007.china.huawei.com ([7.182.85.172]) by
 frapeml500007.china.huawei.com ([7.182.85.172]) with mapi id 15.01.2507.039;
 Fri, 7 Feb 2025 15:30:01 +0100
From: Konstantin Ananyev <konstantin.ananyev@huawei.com>
To: Ariel Otilibili <ariel.otilibili@6wind.com>, "dev@dpdk.org" <dev@dpdk.org>
CC: "stable@dpdk.org" <stable@dpdk.org>, Thomas Monjalon
 <thomas@monjalon.net>, David Marchand <david.marchand@redhat.com>, "Andrew
 Rybchenko" <andrew.rybchenko@oktetlabs.ru>, =?utf-8?B?TW9ydGVuIEJyw7hydXA=?=
 <mb@smartsharesystems.com>
Subject: RE: [PATCH v2 1/2] mempool: fix rte_errno in rte_mempool_create_empty
Thread-Topic: [PATCH v2 1/2] mempool: fix rte_errno in rte_mempool_create_empty
Thread-Index: AQHbazX9Duu185KQMESOwf2/FhG20LM8Arqg
Date: Fri, 7 Feb 2025 14:30:01 +0000
Message-ID: <05499f1b84b6459caa413b6f17fc5e8c@huawei.com>
References: <20250119174643.2162110-1-ariel.otilibili@6wind.com>
 <20250120122156.2480524-1-ariel.otilibili@6wind.com>
 <20250120122156.2480524-2-ariel.otilibili@6wind.com>
In-Reply-To: <20250120122156.2480524-2-ariel.otilibili@6wind.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.48.146.145]
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

DQo+IA0KPiBXaGVuIHJldHVybmluZyBmcm9tIHJ0ZV9tZW1wb29sX3NldF9vcHNfYnluYW1lKCks
IHJ0ZV9lcnJubyBpcyBub3Qgc2V0DQo+IGZvciBlcnJvciBleGl0cy4NCj4gDQo+IFRoZSBBUEkg
cmVxdWlyZXMgcnRlX2Vycm5vIHRvIGJlIHNldCBpbiB0aGF0IGNhc2UuDQo+IA0KPiBCdWd6aWxs
YSBJRDogMTU1OQ0KPiBGaXhlczogYzJjNmIyZjQxMzA1ICgibWVtcG9vbDogZml4IGRlZmF1bHQg
b3BzIGZvciBhbiBlbXB0eSBtZW1wb29sIikNCj4gTGluazogaHR0cHM6Ly9kb2MuZHBkay5vcmcv
YXBpL3J0ZV9fbWVtcG9vbF84aC5odG1sI2E4MmUzMDFlZTMzZWQ3YTI2M2NlYjQ1ODI2NTVkYzNl
YQ0KPiBTaWduZWQtb2ZmLWJ5OiBBcmllbCBPdGlsaWJpbGkgPGFyaWVsLm90aWxpYmlsaUA2d2lu
ZC5jb20+DQo+IC0tLQ0KPiAgbGliL21lbXBvb2wvcnRlX21lbXBvb2wuYyB8IDQgKysrLQ0KPiAg
MSBmaWxlIGNoYW5nZWQsIDMgaW5zZXJ0aW9ucygrKSwgMSBkZWxldGlvbigtKQ0KPiANCj4gZGlm
ZiAtLWdpdCBhL2xpYi9tZW1wb29sL3J0ZV9tZW1wb29sLmMgYi9saWIvbWVtcG9vbC9ydGVfbWVt
cG9vbC5jDQo+IGluZGV4IGQ4ZTM5ZTVjMjA3Mi4uMWU0ZjI0NzgzYzBiIDEwMDY0NA0KPiAtLS0g
YS9saWIvbWVtcG9vbC9ydGVfbWVtcG9vbC5jDQo+ICsrKyBiL2xpYi9tZW1wb29sL3J0ZV9tZW1w
b29sLmMNCj4gQEAgLTkyOCw4ICs5MjgsMTAgQEAgcnRlX21lbXBvb2xfY3JlYXRlX2VtcHR5KGNv
bnN0IGNoYXIgKm5hbWUsIHVuc2lnbmVkIG4sIHVuc2lnbmVkIGVsdF9zaXplLA0KPiAgCWVsc2UN
Cj4gIAkJcmV0ID0gcnRlX21lbXBvb2xfc2V0X29wc19ieW5hbWUobXAsICJyaW5nX21wX21jIiwg
TlVMTCk7DQo+IA0KPiAtCWlmIChyZXQpDQo+ICsJaWYgKHJldCkgew0KPiArCQlydGVfZXJybm8g
PSAtcmV0Ow0KPiAgCQlnb3RvIGV4aXRfdW5sb2NrOw0KPiArCX0NCj4gDQo+ICAJLyoNCj4gIAkg
KiBsb2NhbF9jYWNoZSBwb2ludGVyIGlzIHNldCBldmVuIGlmIGNhY2hlX3NpemUgaXMgemVyby4N
Cj4gLS0NCg0KQWNrZWQtYnk6IEtvbnN0YW50aW4gQW5hbnlldiA8a29uc3RhbnRpbi5hbmFueWV2
QGh1YXdlaS5jb20+IA0KDQo+IDIuMzAuMg0KDQo=
