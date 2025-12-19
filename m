Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 84B4ED767FF
	for <dpdk-dev@archiver.kernel.org>; Fri, 19 Dec 2025 13:06:39 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 5FC04402EE;
	Fri, 19 Dec 2025 14:06:38 +0100 (CET)
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com
 [185.176.79.56])
 by mails.dpdk.org (Postfix) with ESMTP id 9454D40150;
 Fri, 19 Dec 2025 14:06:36 +0100 (CET)
Received: from mail.maildlp.com (unknown [172.18.224.150])
 by frasgout.his.huawei.com (SkyGuard) with ESMTPS id 4dXnpg2XDCzJ46Ck;
 Fri, 19 Dec 2025 21:06:03 +0800 (CST)
Received: from dubpeml500004.china.huawei.com (unknown [7.214.147.1])
 by mail.maildlp.com (Postfix) with ESMTPS id 0142240539;
 Fri, 19 Dec 2025 21:06:36 +0800 (CST)
Received: from dubpeml500001.china.huawei.com (7.214.147.241) by
 dubpeml500004.china.huawei.com (7.214.147.1) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Fri, 19 Dec 2025 13:06:35 +0000
Received: from dubpeml500001.china.huawei.com ([7.214.147.241]) by
 dubpeml500001.china.huawei.com ([7.214.147.241]) with mapi id 15.02.1544.011; 
 Fri, 19 Dec 2025 13:06:35 +0000
From: Konstantin Ananyev <konstantin.ananyev@huawei.com>
To: Marat Khalili <marat.khalili@huawei.com>, "stephen@networkplumber.org"
 <stephen@networkplumber.org>, "jerinjacobk@gmail.com"
 <jerinjacobk@gmail.com>, "mb@smartsharesystems.com"
 <mb@smartsharesystems.com>, Jack Bond-Preston
 <jack.bond-preston@foss.arm.com>
CC: "dev@dpdk.org" <dev@dpdk.org>, "stable@dpdk.org" <stable@dpdk.org>
Subject: RE: [PATCH v3 1/6] eal: variable first arguments of RTE_SHIFT_VALxx
Thread-Topic: [PATCH v3 1/6] eal: variable first arguments of RTE_SHIFT_VALxx
Thread-Index: AQHcb39nrSZKOKtjmEeKWvw5j5nRdrUo8YBw
Date: Fri, 19 Dec 2025 13:06:35 +0000
Message-ID: <645dc8e37c2c4abc8b894362614d10ba@huawei.com>
References: <20251216182036.77869-1-marat.khalili@huawei.com>
 <20251217180141.60227-1-marat.khalili@huawei.com>
 <20251217180141.60227-2-marat.khalili@huawei.com>
In-Reply-To: <20251217180141.60227-2-marat.khalili@huawei.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.195.245.175]
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

DQoNCj4gTWFjcm9zIFJURV9TSElGVF9WQUwzMiBhbmQgUlRFX1NISUZUX1ZBTDY0IHdlcmUgaW1w
bGVtZW50ZWQgYnkgYXBwbHlpbmcNCj4gVUlOVDMyX0Mgb3IgVUlOVDY0X0MgY29ycmVzcG9uZGlu
Z2x5IHRvIGl0cyBmaXJzdCBhcmd1bWVudC4gQXMgYQ0KPiBjb25zZXF1ZW5jZSBmaXJzdCBhcmd1
bWVudCBoYWQgdG8gYmUgYSBjb25zdGFudC4gUmVwbGFjZSBVSU5UMzJfQyBhbmQNCj4gVUlOVDY0
X0Mgd2l0aCBjYXN0cyB0byB1aW50MzJfdCBhbmQgdWludDY0X3QgdG8gYWxsb3cgdGhlc2UgYXJn
dW1lbnRzIGJlDQo+IHZhcmlhYmxlLiBGb3IgY29uc3RhbnRzIHRoZSByZXN1bHQgc2hvdWxkIGJl
IHRoZSBzYW1lLg0KPiANCj4gKFllcywgdGVjaG5pY2FsbHkgVUlOVDY0X0MgcHJvbW90ZXMgdG8g
dWludF9sZWFzdDY0X3QsIG5vdCB1aW50NjRfdCwgYnV0DQo+IEkgdGhpbmsgbW9zdCB1c2VycyBv
ZiBSVEVfU0hJRlRfVkFMNjQgZXhwZWN0IHRoZSByZXN1bHQgdG8gYmUgdWludDY0X3QuKQ0KPiAN
Cj4gU2lnbmVkLW9mZi1ieTogTWFyYXQgS2hhbGlsaSA8bWFyYXQua2hhbGlsaUBodWF3ZWkuY29t
Pg0KPiBSZXZpZXdlZC1ieTogTW9ydGVuIEJyw7hydXAgPG1iQHNtYXJ0c2hhcmVzeXN0ZW1zLmNv
bT4NCj4gLS0tDQo+ICBsaWIvZWFsL2luY2x1ZGUvcnRlX2JpdG9wcy5oIHwgNCArKy0tDQo+ICAx
IGZpbGUgY2hhbmdlZCwgMiBpbnNlcnRpb25zKCspLCAyIGRlbGV0aW9ucygtKQ0KPiANCj4gZGlm
ZiAtLWdpdCBhL2xpYi9lYWwvaW5jbHVkZS9ydGVfYml0b3BzLmggYi9saWIvZWFsL2luY2x1ZGUv
cnRlX2JpdG9wcy5oDQo+IGluZGV4IDJkMWI5ZDI4MWMuLmFhNmFjNzNhYmIgMTAwNjQ0DQo+IC0t
LSBhL2xpYi9lYWwvaW5jbHVkZS9ydGVfYml0b3BzLmgNCj4gKysrIGIvbGliL2VhbC9pbmNsdWRl
L3J0ZV9iaXRvcHMuaA0KPiBAQCAtNTEsNyArNTEsNyBAQCBleHRlcm4gIkMiIHsNCj4gICAqIEBw
YXJhbSBucg0KPiAgICogICBUaGUgc2hpZnQgbnVtYmVyIGluIHJhbmdlIG9mIDAgdG8gKDMyIC0g
d2lkdGggb2YgdmFsKS4NCj4gICAqLw0KPiAtI2RlZmluZSBSVEVfU0hJRlRfVkFMMzIodmFsLCBu
cikgKFVJTlQzMl9DKHZhbCkgPDwgKG5yKSkNCj4gKyNkZWZpbmUgUlRFX1NISUZUX1ZBTDMyKHZh
bCwgbnIpICgodWludDMyX3QpKHZhbCkgPDwgKG5yKSkNCj4gDQo+ICAvKioNCj4gICAqIEdldCB0
aGUgdWludDY0X3Qgc2hpZnRlZCB2YWx1ZS4NCj4gQEAgLTYxLDcgKzYxLDcgQEAgZXh0ZXJuICJD
IiB7DQo+ICAgKiBAcGFyYW0gbnINCj4gICAqICAgVGhlIHNoaWZ0IG51bWJlciBpbiByYW5nZSBv
ZiAwIHRvICg2NCAtIHdpZHRoIG9mIHZhbCkuDQo+ICAgKi8NCj4gLSNkZWZpbmUgUlRFX1NISUZU
X1ZBTDY0KHZhbCwgbnIpIChVSU5UNjRfQyh2YWwpIDw8IChucikpDQo+ICsjZGVmaW5lIFJURV9T
SElGVF9WQUw2NCh2YWwsIG5yKSAoKHVpbnQ2NF90KSh2YWwpIDw8IChucikpDQo+IA0KPiAgLyoq
DQo+ICAgKiBHZW5lcmF0ZSBhIGNvbnRpZ3VvdXMgMzItYml0IG1hc2sNCj4gLS0NCg0KQWNrZWQt
Ynk6IEtvbnN0YW50aW4gQW5hbnlldiA8a29uc3RhbnRpbi5hbmFueWV2QGh1YXdlaS5jb20+DQoN
Cj4gMi40My4wDQoNCg==
