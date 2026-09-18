Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E49C2C982DA
	for <dpdk-dev@archiver.kernel.org>; Fri, 18 Sep 2026 09:42:12 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 1B0F64027C;
	Fri, 18 Sep 2026 11:42:12 +0200 (CEST)
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com
 [185.176.79.56]) by mails.dpdk.org (Postfix) with ESMTP id 41B0440276
 for <dev@dpdk.org>; Fri, 18 Sep 2026 11:42:10 +0200 (CEST)
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
 c=relaxed/relaxed; q=dns/txt; h=From;
 bh=exmqSt9Q8qJqSk6qTmOF48pnpWD4XWlAaXphulhCdlk=;
 b=d15qCrZHNSRlwt8XTmXjDNoZLSLZ7fuO7BntQIx6GUI3MVrtwMt0KYw3Z+q6YQ7A5p+o9pNew
 N8CUNsfNRImgz3AxCVU7H6nrDYXYyaXYEZLbNU2xyUQ3echYa6ToOh+WmKf1tcMtyG9uC5cNagI
 iUpjbRGHGV4pjQnYZGtMgLw=
Received: from mail.maildlp.com (unknown [172.18.224.83])
 by frasgout.his.huawei.com (SkyGuard) with ESMTPS id 4hmSLF6wD4zJ46ZD;
 Fri, 18 Sep 2026 17:41:09 +0800 (CST)
Received: from dubpeml500001.china.huawei.com (unknown [7.214.147.241])
 by mail.maildlp.com (Postfix) with ESMTPS id 989D940569;
 Fri, 18 Sep 2026 17:42:07 +0800 (CST)
Received: from dubpeml500001.china.huawei.com (7.214.147.241) by
 dubpeml500001.china.huawei.com (7.214.147.241) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46; Fri, 18 Sep 2026 10:42:07 +0100
Received: from dubpeml500001.china.huawei.com ([7.214.147.241]) by
 dubpeml500001.china.huawei.com ([7.214.147.241]) with mapi id 15.02.2562.046; 
 Fri, 18 Sep 2026 10:42:06 +0100
From: Konstantin Ananyev <konstantin.ananyev@huawei.com>
To: =?utf-8?B?TW9ydGVuIEJyw7hydXA=?= <mb@smartsharesystems.com>,
 "dev@dpdk.org" <dev@dpdk.org>, Andrew Rybchenko
 <andrew.rybchenko@oktetlabs.ru>, Bruce Richardson
 <bruce.richardson@intel.com>, Stephen Hemminger <stephen@networkplumber.org>
Subject: RE: [PATCH 4/6] mempool: various cleanups
Thread-Topic: [PATCH 4/6] mempool: various cleanups
Thread-Index: AQHdQRBNllaje0j+706LjLKCT0oEw7bUIUpw
Date: Fri, 18 Sep 2026 09:42:06 +0000
Message-ID: <3c0a5ad4043f4191abc0fbe37258b3c0@huawei.com>
References: <20260910103613.808038-1-mb@smartsharesystems.com>
 <20260910103613.808038-5-mb@smartsharesystems.com>
In-Reply-To: <20260910103613.808038-5-mb@smartsharesystems.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.48.158.134]
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

DQoNCj4gUmVtb3ZlZCBhdWRpdCBjYWxsIGZyb20gZHVtcCBmdW5jdGlvbiwgd2hlcmUgaXQgZG9l
c24ndCBiZWxvbmcuDQo+IA0KPiBBZGRlZCBtYWxsb2MvZGVhbGxvYyBhdHRyaWJ1dGUgdG8gcHJp
dmF0ZSBjYWNoZSBhbGxvYy9mcmVlIGZ1bmN0aW9ucy4NCj4gDQo+IEltcHJvdmVkIGNoZWNrcyBp
biBtZW1wb29sIG9wcyByZWdpc3RyYXRpb24gZnVuY3Rpb24uDQo+IA0KPiBJbXByb3ZlZCBjYWNo
ZSBhdWRpdCBjaGVja3MuDQo+IA0KPiBBZGRlZCBkZXRhaWxlZCBkZXNjcmlwdGlvbiB0byBkZWZp
bml0aW9uIG9mIG1lbXBvb2wgbmFtZSBsZW5ndGguDQo+IA0KPiBVcGRhdGVkIHNvbWUgY29tbWVu
dHMsIGFuZCBtb3ZlZCBhcm91bmQgc29tZSBtaXNwbGFjZWQgY29tbWVudHMuDQo+IA0KPiBTaWdu
ZWQtb2ZmLWJ5OiBNb3J0ZW4gQnLDuHJ1cCA8bWJAc21hcnRzaGFyZXN5c3RlbXMuY29tPg0KPiAt
LS0NCg0KLi4uLg0KDQo+IGRpZmYgLS1naXQgYS9saWIvbWVtcG9vbC9ydGVfbWVtcG9vbF9vcHMu
Yw0KPiBiL2xpYi9tZW1wb29sL3J0ZV9tZW1wb29sX29wcy5jDQo+IGluZGV4IDA2NmJlYzM2ZmMu
LjZkOTljN2EyNWMgMTAwNjQ0DQo+IC0tLSBhL2xpYi9tZW1wb29sL3J0ZV9tZW1wb29sX29wcy5j
DQo+ICsrKyBiL2xpYi9tZW1wb29sL3J0ZV9tZW1wb29sX29wcy5jDQo+IEBAIC0yNyw3ICsyNyw3
IEBAIGludA0KPiAgcnRlX21lbXBvb2xfcmVnaXN0ZXJfb3BzKGNvbnN0IHN0cnVjdCBydGVfbWVt
cG9vbF9vcHMgKmgpDQo+ICB7DQo+ICAJc3RydWN0IHJ0ZV9tZW1wb29sX29wcyAqb3BzOw0KPiAt
CWludDE2X3Qgb3BzX2luZGV4Ow0KPiArCXVuc2lnbmVkIGludCBvcHNfaW5kZXg7DQo+IA0KPiAg
CXJ0ZV9zcGlubG9ja19sb2NrKCZydGVfbWVtcG9vbF9vcHNfdGFibGUuc2wpOw0KPiANCj4gQEAg
LTQ3LDEyICs0NywyMiBAQCBydGVfbWVtcG9vbF9yZWdpc3Rlcl9vcHMoY29uc3Qgc3RydWN0DQo+
IHJ0ZV9tZW1wb29sX29wcyAqaCkNCj4gIAkJcmV0dXJuIC1FSU5WQUw7DQo+ICAJfQ0KPiANCj4g
LQlpZiAoc3RybGVuKGgtPm5hbWUpID49IHNpemVvZihvcHMtPm5hbWUpIC0gMSkgew0KPiArCWlm
IChzdHJubGVuKGgtPm5hbWUsIHNpemVvZihoLT5uYW1lKSkgPiBzaXplb2Yob3BzLT5uYW1lKSAt
IDEpIHsNCj4gIAkJcnRlX3NwaW5sb2NrX3VubG9jaygmcnRlX21lbXBvb2xfb3BzX3RhYmxlLnNs
KTsNCj4gLQkJUlRFX01FTVBPT0xfTE9HKERFQlVHLCAiJXMoKTogbWVtcG9vbF9vcHMgPCVzPjog
bmFtZQ0KPiB0b28gbG9uZyIsDQo+IC0JCQkJX19mdW5jX18sIGgtPm5hbWUpOw0KPiAtCQlydGVf
ZXJybm8gPSBFRVhJU1Q7DQo+IC0JCXJldHVybiAtRUVYSVNUOw0KPiArCQljaGFyIG5hbWVbc2l6
ZW9mKGgtPm5hbWUpICsgMV07DQo+ICsJCXN0cmxjcHkobmFtZSwgaC0+bmFtZSwgc2l6ZW9mKG5h
bWUpKTsNCg0KQ3VyaW91cywgd2h5IGRvIHlvdSBuZWVkIHRvIGNvcHk/DQpXaHkgY2FuJ3QgdC0+
bmFtZSBiZSB1c2VkIGRpcmVjdGx5IHdpdGhpaW4gdGhlIExPRygpPw0KDQo+ICsJCVJURV9NRU1Q
T09MX0xPRyhFUlIsICIlcygpOiBtZW1wb29sX29wcyA8JXM+OiBuYW1lIHRvbw0KPiBsb25nIiwN
Cj4gKwkJCQlfX2Z1bmNfXywgbmFtZSk7DQo+ICsJCXJldHVybiAtRU5BTUVUT09MT05HOw0KPiAr
CX0NCj4gKw0KPiArCWZvciAob3BzX2luZGV4ID0gMDsgb3BzX2luZGV4IDwgcnRlX21lbXBvb2xf
b3BzX3RhYmxlLm51bV9vcHM7DQo+IG9wc19pbmRleCsrKSB7DQo+ICsJCWlmICghc3RyY21wKGgt
Pm5hbWUsDQo+IHJ0ZV9tZW1wb29sX29wc190YWJsZS5vcHNbb3BzX2luZGV4XS5uYW1lKSkgew0K
PiArCQkJcnRlX3NwaW5sb2NrX3VubG9jaygmcnRlX21lbXBvb2xfb3BzX3RhYmxlLnNsKTsNCj4g
KwkJCVJURV9NRU1QT09MX0xPRyhFUlIsICIlcygpOiBtZW1wb29sX29wcyA8JXM+Og0KPiBuYW1l
IGV4aXN0cyIsDQo+ICsJCQkJCV9fZnVuY19fLCBoLT5uYW1lKTsNCj4gKwkJCXJldHVybiAtRUVY
SVNUOw0KPiArCQl9DQo+ICAJfQ0KPiANCj4gIAlvcHNfaW5kZXggPSBydGVfbWVtcG9vbF9vcHNf
dGFibGUubnVtX29wcysrOw0KPiBAQCAtNzAsNiArODAsOCBAQCBydGVfbWVtcG9vbF9yZWdpc3Rl
cl9vcHMoY29uc3Qgc3RydWN0IHJ0ZV9tZW1wb29sX29wcw0KPiAqaCkNCj4gDQo+ICAJcnRlX3Nw
aW5sb2NrX3VubG9jaygmcnRlX21lbXBvb2xfb3BzX3RhYmxlLnNsKTsNCj4gDQo+ICsJUlRFX01F
TVBPT0xfTE9HKERFQlVHLCAiUmVnaXN0ZXJlZCBtZW1wb29sIG9wcyA8JXM+IGF0IGluZGV4DQo+
ICV1Iiwgb3BzLT5uYW1lLCBvcHNfaW5kZXgpOw0KPiArDQo+ICAJcmV0dXJuIG9wc19pbmRleDsN
Cj4gIH0NCj4gDQo+IEBAIC0xODUsOCArMTk3LDEyIEBAIHJ0ZV9tZW1wb29sX3NldF9vcHNfYnlu
YW1lKHN0cnVjdCBydGVfbWVtcG9vbA0KPiAqbXAsIGNvbnN0IGNoYXIgKm5hbWUsDQo+ICAJCX0N
Cj4gIAl9DQo+IA0KPiAtCWlmIChvcHMgPT0gTlVMTCkNCj4gKwlpZiAob3BzID09IE5VTEwpIHsN
Cj4gKwkJUlRFX01FTVBPT0xfTE9HKERFQlVHLA0KPiArCQkJCSJDYW5ub3Qgc2V0IHVua25vd24g
bWVtcG9vbCBvcHMgPCVzPiwgb2YgJXUNCj4gb3BzIHJlZ2lzdGVyZWQiLA0KPiArCQkJCW5hbWUs
IGkpOw0KPiAgCQlyZXR1cm4gLUVJTlZBTDsNCj4gKwl9DQo+IA0KPiAgCW1wLT5vcHNfaW5kZXgg
PSBpOw0KPiAgCW1wLT5wb29sX2NvbmZpZyA9IHBvb2xfY29uZmlnOw0KPiAtLQ0KPiAyLjQzLjAN
Cg0K
