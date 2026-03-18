Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B9BAB10775E6
	for <dpdk-dev@archiver.kernel.org>; Wed, 18 Mar 2026 16:16:59 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id D69864026F;
	Wed, 18 Mar 2026 17:16:58 +0100 (CET)
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com
 [185.176.79.56]) by mails.dpdk.org (Postfix) with ESMTP id 0436440150
 for <dev@dpdk.org>; Wed, 18 Mar 2026 17:16:55 +0100 (CET)
Received: from mail.maildlp.com (unknown [172.18.224.150])
 by frasgout.his.huawei.com (SkyGuard) with ESMTPS id 4fbYpg1YhmzJ46bM;
 Thu, 19 Mar 2026 00:15:55 +0800 (CST)
Received: from frapema500002.china.huawei.com (unknown [7.182.19.148])
 by mail.maildlp.com (Postfix) with ESMTPS id 380DD4056B;
 Thu, 19 Mar 2026 00:16:53 +0800 (CST)
Received: from frapema500003.china.huawei.com (7.182.19.114) by
 frapema500002.china.huawei.com (7.182.19.148) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Wed, 18 Mar 2026 17:16:53 +0100
Received: from frapema500003.china.huawei.com ([7.182.19.114]) by
 frapema500003.china.huawei.com ([7.182.19.114]) with mapi id 15.02.1544.011;
 Wed, 18 Mar 2026 17:16:52 +0100
From: Marat Khalili <marat.khalili@huawei.com>
To: Christophe Fontaine <cfontain@redhat.com>,
 =?utf-8?B?TW9ydGVuIEJyw7hydXA=?= <mb@smartsharesystems.com>
CC: "dev@dpdk.org" <dev@dpdk.org>, Konstantin Ananyev
 <konstantin.ananyev@huawei.com>, Wathsala Vithanage
 <wathsala.vithanage@arm.com>
Subject: RE: [PATCH] bpf/arm64: support packet data load instructions
Thread-Topic: [PATCH] bpf/arm64: support packet data load instructions
Thread-Index: AQHctXjoFxWXyTh3g0OC9SlGIQcTMrW0I+zwgAAX+/CAAAZ24IAABL0ggAAWnQCAABUq0A==
Date: Wed, 18 Mar 2026 16:16:52 +0000
Message-ID: <ea715be437174fa782f3ceb031debe0d@huawei.com>
References: <20260310122045.4057836-1-cfontain@redhat.com>
 <b10d0edcdaac4fd9a4f5a0261205670c@huawei.com>
 <98CBD80474FA8B44BF855DF32C47DC35F6579F@smartserver.smartshare.dk>
 <4942136acefe4fc3b5157191749fe3d5@huawei.com>
 <98CBD80474FA8B44BF855DF32C47DC35F657A0@smartserver.smartshare.dk>
 <CAHVr2NmXSAhKO6EGjh_DDvdaUShPTWH-Eb1y1VrriQBAVnay4w@mail.gmail.com>
In-Reply-To: <CAHVr2NmXSAhKO6EGjh_DDvdaUShPTWH-Eb1y1VrriQBAVnay4w@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.206.137.74]
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

PiA+IEluIENsYXNzaWMgQlBGLCBuZWdhdGl2ZSAiayIgaGFzIHNwZWNpYWwgbWVhbmluZyBmb3Ig
Ym90aCBCUEZfQUJTIGFuZCBCUEZfSU5ELg0KPiA+IFNvIHdlIHNob3VsZCBjb25zaWRlciBpdCBp
bnZhbGlkIGZvciBib3RoIGNhc2VzLg0KPiA+DQo+ID4gVGhhdCBwcmV2ZW50cyBhcHBsaWNhdGlv
bnMgZnJvbSB1c2luZyBpdCB0aGUgd2F5IHlvdSBkZXNjcmliZS4NCj4gPiBBbmQgaXQgd2lsbCBh
bGxvdyB1cyB0byBhZGQgQlBGIGxpYnJhcnkgc3VwcG9ydCBmb3IgTGludXgtY29tcGF0aWJsZSBz
cGVjaWFsIG1lYW5pbmdzIGxhdGVyLCB3aXRob3V0DQo+IGJyZWFraW5nIHRoZSBBQkkuDQo+ID4N
Cj4gDQo+IEFyZW4ndCB0aGVzZSBpbnZhbGlkIG9mZnNldHMgYWxyZWFkeSB0YWtlbiBjYXJlIGR1
cmluZyB0aGUgc3ludGF4DQo+IGNoZWNrIHdoZW4gd2UgdmFsaWRhdGUgdGhlIEJQRiBwcm9ncmFt
ID8NCj4gaW4gYnBmX3ZhbGlkYXRlLmMgKzE0OTk6DQo+ICAgICAgICAgLyogbG9hZCBhYnNvbHV0
ZSBpbnN0cnVjdGlvbnMgKi8NCj4gICAgICAgICBbKEJQRl9MRCB8IEJQRl9BQlMgfCBCUEZfQild
ID0gew0KPiAgICAgICAgICAgICAgICAgLm1hc2sgPSB7LiBkcmVnID0gWkVST19SRUcsIC5zcmVn
ID0gWkVST19SRUd9LA0KPiAgICAgICAgICAgICAgICAgLm9mZiA9IHsgLm1pbiA9IDAsIC5tYXgg
PSAwfSwNCj4gICAgICAgICAgICAgICAgIC5pbW0gPSB7IC5taW4gPSAwLCAubWF4ID0gSU5UMzJf
TUFYfSwNCj4gICAgICAgICAgICAgICAgIC5ldmFsID0gZXZhbF9sZF9tYnVmLA0KPiAgICAgICAg
IH0sDQo+IA0KPiBJSVVDLCBhcyBfX3J0ZV9icGZfdmFsaWRhdGUgZmFpbHMgd2hlbiB3ZSBjYWwg
cnRlX2JwZl9sb2FkICggaW4NCj4gYnBmX2xvYWQuYyArMTEzKSwgd2UgY2FuJ3QgZXZlbiBpbnRl
cnByZXQgdGhlIGNCUEYgcHJvZ3JhbS4NCg0KR29vZCBwb2ludCwgd2UgY2FuIHByb2JhYmx5IGNv
bnNpZGVyIEJQRl9BQlMgY2FzZSBjb3ZlcmVkIGJ5IHRoaXMuDQoNCkZvciBCUEZfSU5EIGhvd2V2
ZXIgaXQgZG9lcyBub3Qgc2VlbSB0byBleGNsdWRlIGFueSB2YWx1ZXMsIGFuZCBldmVuIGlmIGl0
IGRpZA0Kd2UgZG9uJ3Qga25vdyB3aGF0J3MgaW4gdGhlIHJlZ2lzdGVyLiBTcGVha2luZyBvZiB3
aGljaCwgSSBqdXN0IG5vdGljZWQgdGhhdA0Kd2UncmUgdHJ1bmNhdGluZyBpdC4NCg0KSSBzdWdn
ZXN0IHRoZSBmb2xsb3dpbmcgbG9naWMgaW4gcHNldWRvLWNvZGU6DQoNCnN0YXRpYyB2b2lkIA0K
ZW1pdF9sZF9tYnVmKHN0cnVjdCBhNjRfaml0X2N0eCAqY3R4LCB1aW50MzJfdCBvcCwgdWludDhf
dCB0bXAxLCB1aW50OF90IHRtcDIsIA0KCXVpbnQ4X3Qgc3JjLCBpbnQzMl90IGltbSkNCnsNCgkv
LyAuLi4NCg0KCS8qIHIxID0gb2ZmOiBmb3IgQUJTIHVzZSBpbW0sIGZvciBJTkQgdXNlIHNyYyAr
IGltbSAqLw0KCWlmIChtb2RlID09IEJQRl9BQlMpIHsNCgkJYXNzZXJ0IGltbSA+PSAwLCAidmVy
aWZpZWQgYnkgdmVyaWZpZXIiDQoJCWVtaXQgTU9WIFcxLCAjPGltbT4NCgl9IGVsc2Ugew0KCQkv
KiBhZGQgc2lnbmVkIGltbSB0byB0aGUgc291cmNlIHJlZ2lzdGVyICovDQoJCWVtaXQocykgWDEg
PSBzcmMgKyAjPGltbT4NCgkJLyogdmVyaWZ5IGR5bmFtaWNhbGx5IHRoYXQgb2Zmc2V0IGlzIHdp
dGhpbiB0aGUgZG9tYWluIG9mIF9fcnRlX3BrdG1idWZfcmVhZCAqLw0KCQllbWl0KHMpIGp1bXBf
dG9fZXBpbG9ndWUgaWYgWDEgPHMgMCB8fCBYMSA+IElOVDMyX01BWA0KCX0NCg0KCS8vIC4uLg0K
fQ0K
