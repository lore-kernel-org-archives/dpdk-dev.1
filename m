Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B4D08C982D7
	for <dpdk-dev@archiver.kernel.org>; Fri, 18 Sep 2026 09:48:36 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id C39274027C;
	Fri, 18 Sep 2026 11:48:35 +0200 (CEST)
Received: from dkmailrelay1.smartsharesystems.com
 (smartserver.smartsharesystems.com [77.243.40.215])
 by mails.dpdk.org (Postfix) with ESMTP id A748F40276
 for <dev@dpdk.org>; Fri, 18 Sep 2026 11:48:33 +0200 (CEST)
Received: from smartserver.smartsharesystems.com
 (smartserver.smartsharesys.local [192.168.4.10])
 by dkmailrelay1.smartsharesystems.com (Postfix) with ESMTP id 50C80205CD;
 Fri, 18 Sep 2026 11:48:32 +0200 (CEST)
Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="utf-8"
Content-Transfer-Encoding: base64
Subject: RE: [PATCH 4/6] mempool: various cleanups
X-MimeOLE: Produced By Microsoft Exchange V6.5
Date: Fri, 18 Sep 2026 11:48:31 +0200
Message-ID: <98CBD80474FA8B44BF855DF32C47DC35F65A53@smartserver.smartshare.dk>
In-Reply-To: <3c0a5ad4043f4191abc0fbe37258b3c0@huawei.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: [PATCH 4/6] mempool: various cleanups
Thread-Index: AQHdQRBNllaje0j+706LjLKCT0oEw7bUIUpwgAAA2MA=
References: <20260910103613.808038-1-mb@smartsharesystems.com>
 <20260910103613.808038-5-mb@smartsharesystems.com>
 <3c0a5ad4043f4191abc0fbe37258b3c0@huawei.com>
From: =?utf-8?B?TW9ydGVuIEJyw7hydXA=?= <mb@smartsharesystems.com>
To: "Konstantin Ananyev" <konstantin.ananyev@huawei.com>, <dev@dpdk.org>,
 "Andrew Rybchenko" <andrew.rybchenko@oktetlabs.ru>,
 "Bruce Richardson" <bruce.richardson@intel.com>,
 "Stephen Hemminger" <stephen@networkplumber.org>
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

PiA+IFJlbW92ZWQgYXVkaXQgY2FsbCBmcm9tIGR1bXAgZnVuY3Rpb24sIHdoZXJlIGl0IGRvZXNu
J3QgYmVsb25nLg0KPiA+DQo+ID4gQWRkZWQgbWFsbG9jL2RlYWxsb2MgYXR0cmlidXRlIHRvIHBy
aXZhdGUgY2FjaGUgYWxsb2MvZnJlZSBmdW5jdGlvbnMuDQo+ID4NCj4gPiBJbXByb3ZlZCBjaGVj
a3MgaW4gbWVtcG9vbCBvcHMgcmVnaXN0cmF0aW9uIGZ1bmN0aW9uLg0KPiA+DQo+ID4gSW1wcm92
ZWQgY2FjaGUgYXVkaXQgY2hlY2tzLg0KPiA+DQo+ID4gQWRkZWQgZGV0YWlsZWQgZGVzY3JpcHRp
b24gdG8gZGVmaW5pdGlvbiBvZiBtZW1wb29sIG5hbWUgbGVuZ3RoLg0KPiA+DQo+ID4gVXBkYXRl
ZCBzb21lIGNvbW1lbnRzLCBhbmQgbW92ZWQgYXJvdW5kIHNvbWUgbWlzcGxhY2VkIGNvbW1lbnRz
Lg0KPiA+DQo+ID4gU2lnbmVkLW9mZi1ieTogTW9ydGVuIEJyw7hydXAgPG1iQHNtYXJ0c2hhcmVz
eXN0ZW1zLmNvbT4NCj4gPiAtLS0NCj4gDQo+IC4uLi4NCj4gDQo+ID4gZGlmZiAtLWdpdCBhL2xp
Yi9tZW1wb29sL3J0ZV9tZW1wb29sX29wcy5jDQo+ID4gYi9saWIvbWVtcG9vbC9ydGVfbWVtcG9v
bF9vcHMuYw0KPiA+IGluZGV4IDA2NmJlYzM2ZmMuLjZkOTljN2EyNWMgMTAwNjQ0DQo+ID4gLS0t
IGEvbGliL21lbXBvb2wvcnRlX21lbXBvb2xfb3BzLmMNCj4gPiArKysgYi9saWIvbWVtcG9vbC9y
dGVfbWVtcG9vbF9vcHMuYw0KPiA+IEBAIC0yNyw3ICsyNyw3IEBAIGludA0KPiA+ICBydGVfbWVt
cG9vbF9yZWdpc3Rlcl9vcHMoY29uc3Qgc3RydWN0IHJ0ZV9tZW1wb29sX29wcyAqaCkNCj4gPiAg
ew0KPiA+ICAJc3RydWN0IHJ0ZV9tZW1wb29sX29wcyAqb3BzOw0KPiA+IC0JaW50MTZfdCBvcHNf
aW5kZXg7DQo+ID4gKwl1bnNpZ25lZCBpbnQgb3BzX2luZGV4Ow0KPiA+DQo+ID4gIAlydGVfc3Bp
bmxvY2tfbG9jaygmcnRlX21lbXBvb2xfb3BzX3RhYmxlLnNsKTsNCj4gPg0KPiA+IEBAIC00Nywx
MiArNDcsMjIgQEAgcnRlX21lbXBvb2xfcmVnaXN0ZXJfb3BzKGNvbnN0IHN0cnVjdA0KPiA+IHJ0
ZV9tZW1wb29sX29wcyAqaCkNCj4gPiAgCQlyZXR1cm4gLUVJTlZBTDsNCj4gPiAgCX0NCj4gPg0K
PiA+IC0JaWYgKHN0cmxlbihoLT5uYW1lKSA+PSBzaXplb2Yob3BzLT5uYW1lKSAtIDEpIHsNCj4g
PiArCWlmIChzdHJubGVuKGgtPm5hbWUsIHNpemVvZihoLT5uYW1lKSkgPiBzaXplb2Yob3BzLT5u
YW1lKSAtIDEpIHsNCj4gPiAgCQlydGVfc3BpbmxvY2tfdW5sb2NrKCZydGVfbWVtcG9vbF9vcHNf
dGFibGUuc2wpOw0KPiA+IC0JCVJURV9NRU1QT09MX0xPRyhERUJVRywgIiVzKCk6IG1lbXBvb2xf
b3BzIDwlcz46IG5hbWUNCj4gPiB0b28gbG9uZyIsDQo+ID4gLQkJCQlfX2Z1bmNfXywgaC0+bmFt
ZSk7DQo+ID4gLQkJcnRlX2Vycm5vID0gRUVYSVNUOw0KPiA+IC0JCXJldHVybiAtRUVYSVNUOw0K
PiA+ICsJCWNoYXIgbmFtZVtzaXplb2YoaC0+bmFtZSkgKyAxXTsNCj4gPiArCQlzdHJsY3B5KG5h
bWUsIGgtPm5hbWUsIHNpemVvZihuYW1lKSk7DQo+IA0KPiBDdXJpb3VzLCB3aHkgZG8geW91IG5l
ZWQgdG8gY29weT8NCj4gV2h5IGNhbid0IHQtPm5hbWUgYmUgdXNlZCBkaXJlY3RseSB3aXRoaWlu
IHRoZSBMT0coKT8NCg0KSWYgdGhlIG5hbWUgdXNlcyB0aGUgZW50aXJlIGgtPm5hbWUgYXJyYXks
IGl0IGlzIG5vdCBOVUwtdGVybWluYXRlZCwgc28gSSBjb3B5IGl0IHRvIGFkZCB0aGUgTlVMIGNo
YXJhY3Rlci4NCk5vdGUgdGhlIGxvY2FsIHZhcmlhYmxlIEkgY29weSBpdCB0byBoYXMgcm9vbSBm
b3IgKzEgY2hhcmFjdGVyLCBhbmQgc3RybGNweSgpIHByb3ZpZGVzIE5VTCB0ZXJtaW5hdGlvbi4N
Cg0KPiANCj4gPiArCQlSVEVfTUVNUE9PTF9MT0coRVJSLCAiJXMoKTogbWVtcG9vbF9vcHMgPCVz
PjogbmFtZSB0b28NCj4gPiBsb25nIiwNCj4gPiArCQkJCV9fZnVuY19fLCBuYW1lKTsNCj4gPiAr
CQlyZXR1cm4gLUVOQU1FVE9PTE9ORzsNCj4gPiArCX0NCj4gPiArDQo+ID4gKwlmb3IgKG9wc19p
bmRleCA9IDA7IG9wc19pbmRleCA8IHJ0ZV9tZW1wb29sX29wc190YWJsZS5udW1fb3BzOw0KPiA+
IG9wc19pbmRleCsrKSB7DQo+ID4gKwkJaWYgKCFzdHJjbXAoaC0+bmFtZSwNCj4gPiBydGVfbWVt
cG9vbF9vcHNfdGFibGUub3BzW29wc19pbmRleF0ubmFtZSkpIHsNCj4gPiArCQkJcnRlX3NwaW5s
b2NrX3VubG9jaygmcnRlX21lbXBvb2xfb3BzX3RhYmxlLnNsKTsNCj4gPiArCQkJUlRFX01FTVBP
T0xfTE9HKEVSUiwgIiVzKCk6IG1lbXBvb2xfb3BzIDwlcz46DQo+ID4gbmFtZSBleGlzdHMiLA0K
PiA+ICsJCQkJCV9fZnVuY19fLCBoLT5uYW1lKTsNCj4gPiArCQkJcmV0dXJuIC1FRVhJU1Q7DQo+
ID4gKwkJfQ0KPiA+ICAJfQ0KPiA+DQo+ID4gIAlvcHNfaW5kZXggPSBydGVfbWVtcG9vbF9vcHNf
dGFibGUubnVtX29wcysrOw0KPiA+IEBAIC03MCw2ICs4MCw4IEBAIHJ0ZV9tZW1wb29sX3JlZ2lz
dGVyX29wcyhjb25zdCBzdHJ1Y3QNCj4gcnRlX21lbXBvb2xfb3BzDQo+ID4gKmgpDQo+ID4NCj4g
PiAgCXJ0ZV9zcGlubG9ja191bmxvY2soJnJ0ZV9tZW1wb29sX29wc190YWJsZS5zbCk7DQo+ID4N
Cj4gPiArCVJURV9NRU1QT09MX0xPRyhERUJVRywgIlJlZ2lzdGVyZWQgbWVtcG9vbCBvcHMgPCVz
PiBhdCBpbmRleA0KPiA+ICV1Iiwgb3BzLT5uYW1lLCBvcHNfaW5kZXgpOw0KPiA+ICsNCj4gPiAg
CXJldHVybiBvcHNfaW5kZXg7DQo+ID4gIH0NCj4gPg0KPiA+IEBAIC0xODUsOCArMTk3LDEyIEBA
IHJ0ZV9tZW1wb29sX3NldF9vcHNfYnluYW1lKHN0cnVjdCBydGVfbWVtcG9vbA0KPiA+ICptcCwg
Y29uc3QgY2hhciAqbmFtZSwNCj4gPiAgCQl9DQo+ID4gIAl9DQo+ID4NCj4gPiAtCWlmIChvcHMg
PT0gTlVMTCkNCj4gPiArCWlmIChvcHMgPT0gTlVMTCkgew0KPiA+ICsJCVJURV9NRU1QT09MX0xP
RyhERUJVRywNCj4gPiArCQkJCSJDYW5ub3Qgc2V0IHVua25vd24gbWVtcG9vbCBvcHMgPCVzPiwg
b2YgJXUNCj4gPiBvcHMgcmVnaXN0ZXJlZCIsDQo+ID4gKwkJCQluYW1lLCBpKTsNCj4gPiAgCQly
ZXR1cm4gLUVJTlZBTDsNCj4gPiArCX0NCj4gPg0KPiA+ICAJbXAtPm9wc19pbmRleCA9IGk7DQo+
ID4gIAltcC0+cG9vbF9jb25maWcgPSBwb29sX2NvbmZpZzsNCj4gPiAtLQ0KPiA+IDIuNDMuMA0K
DQo=
