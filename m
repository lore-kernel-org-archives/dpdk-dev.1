Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D7B20CCF9FA
	for <dpdk-dev@archiver.kernel.org>; Thu, 30 Oct 2025 07:57:53 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id D14CD402E2;
	Thu, 30 Oct 2025 08:57:52 +0100 (CET)
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com
 [185.176.79.56]) by mails.dpdk.org (Postfix) with ESMTP id 8B0524027A
 for <dev@dpdk.org>; Thu, 30 Oct 2025 08:57:51 +0100 (CET)
Received: from mail.maildlp.com (unknown [172.18.186.216])
 by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4cxxJ03KLFz6L4rx;
 Thu, 30 Oct 2025 15:56:00 +0800 (CST)
Received: from dubpeml500001.china.huawei.com (unknown [7.214.147.241])
 by mail.maildlp.com (Postfix) with ESMTPS id 370801402F9;
 Thu, 30 Oct 2025 15:57:49 +0800 (CST)
Received: from dubpeml500001.china.huawei.com (7.214.147.241) by
 dubpeml500001.china.huawei.com (7.214.147.241) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Thu, 30 Oct 2025 07:57:48 +0000
Received: from dubpeml500001.china.huawei.com ([7.214.147.241]) by
 dubpeml500001.china.huawei.com ([7.214.147.241]) with mapi id 15.02.1544.011; 
 Thu, 30 Oct 2025 07:57:48 +0000
From: Konstantin Ananyev <konstantin.ananyev@huawei.com>
To: Stephen Hemminger <stephen@networkplumber.org>, "dev@dpdk.org"
 <dev@dpdk.org>
CC: =?utf-8?B?TW9ydGVuIEJyw7hydXA=?= <mb@smartsharesystems.com>, "Cristian
 Dumitrescu" <cristian.dumitrescu@intel.com>, Tyler Retzlaff
 <roretzla@linux.microsoft.com>
Subject: RE: [PATCH v2] bitmap: change return value of rte_bitmap_free
Thread-Topic: [PATCH v2] bitmap: change return value of rte_bitmap_free
Thread-Index: AQHcSOOKaR/jDSvDMUehduMQf6tENLTaUj8A
Date: Thu, 30 Oct 2025 07:57:48 +0000
Message-ID: <cc6a7dece31f4769b6ad0c1038d35434@huawei.com>
References: <20251028204432.880074-1-stephen@networkplumber.org>
 <20251029145055.990899-1-stephen@networkplumber.org>
In-Reply-To: <20251029145055.990899-1-stephen@networkplumber.org>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.48.147.110]
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

DQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogU3RlcGhlbiBIZW1taW5n
ZXIgPHN0ZXBoZW5AbmV0d29ya3BsdW1iZXIub3JnPg0KPiBTZW50OiBXZWRuZXNkYXksIE9jdG9i
ZXIgMjksIDIwMjUgMjo1MSBQTQ0KPiBUbzogZGV2QGRwZGsub3JnDQo+IENjOiBTdGVwaGVuIEhl
bW1pbmdlciA8c3RlcGhlbkBuZXR3b3JrcGx1bWJlci5vcmc+OyBNb3J0ZW4gQnLDuHJ1cA0KPiA8
bWJAc21hcnRzaGFyZXN5c3RlbXMuY29tPjsgQ3Jpc3RpYW4gRHVtaXRyZXNjdQ0KPiA8Y3Jpc3Rp
YW4uZHVtaXRyZXNjdUBpbnRlbC5jb20+OyBUeWxlciBSZXR6bGFmZiA8cm9yZXR6bGFAbGludXgu
bWljcm9zb2Z0LmNvbT4NCj4gU3ViamVjdDogW1BBVENIIHYyXSBiaXRtYXA6IGNoYW5nZSByZXR1
cm4gdmFsdWUgb2YgcnRlX2JpdG1hcF9mcmVlDQo+IA0KPiBObyBleGlzdGluZyBjb2RlIGlzIGNo
ZWNraW5nIHRoZSByZXR1cm4gdmFsdWUgb2YgcnRlX2JpdG1hcF9mcmVlDQo+IGFuZCBvdGhlciBm
dW5jdGlvbnMgbGlrZSBydGVfZnJlZSBkbyBub3QgcmV0dXJuIGFuIGludC4NCj4gQ2hhbmdlIGl0
IHRvIGp1c3QgYSBzdHViIHZvaWQgZnVuY3Rpb24uDQo+IA0KPiBUaGlzIHdhcyBtb3RpdmF0ZWQg
YnkgQ292ZXJpdHkgd2FybmluZ3MgYWJvdXQgdW5jaGVja2VkIHJldHVybg0KPiB2YWx1ZS4NCj4g
DQo+IFNpZ25lZC1vZmYtYnk6IFN0ZXBoZW4gSGVtbWluZ2VyIDxzdGVwaGVuQG5ldHdvcmtwbHVt
YmVyLm9yZz4NCj4gUmV2aWV3ZWQtYnk6IE1vcnRlbiBCcsO4cnVwIDxtYkBzbWFydHNoYXJlc3lz
dGVtcy5jb20+DQo+IC0tLQ0KPiAgZG9jL2d1aWRlcy9yZWxfbm90ZXMvcmVsZWFzZV8yNV8xMS5y
c3QgfCAgMyArKysNCj4gIGxpYi9lYWwvaW5jbHVkZS9ydGVfYml0bWFwLmggICAgICAgICAgIHwg
MTMgKysrKy0tLS0tLS0tLQ0KPiAgMiBmaWxlcyBjaGFuZ2VkLCA3IGluc2VydGlvbnMoKyksIDkg
ZGVsZXRpb25zKC0pDQo+IA0KPiBkaWZmIC0tZ2l0IGEvZG9jL2d1aWRlcy9yZWxfbm90ZXMvcmVs
ZWFzZV8yNV8xMS5yc3QNCj4gYi9kb2MvZ3VpZGVzL3JlbF9ub3Rlcy9yZWxlYXNlXzI1XzExLnJz
dA0KPiBpbmRleCBjNWJhMzM1Y2ZjLi40YjhlMDg0MjA0IDEwMDY0NA0KPiAtLS0gYS9kb2MvZ3Vp
ZGVzL3JlbF9ub3Rlcy9yZWxlYXNlXzI1XzExLnJzdA0KPiArKysgYi9kb2MvZ3VpZGVzL3JlbF9u
b3Rlcy9yZWxlYXNlXzI1XzExLnJzdA0KPiBAQCAtMjIwLDYgKzIyMCw5IEBAIEFQSSBDaGFuZ2Vz
DQo+ICAgIFRoZSBsaW5rIHR5cGUgd2FzIHByZXZpb3VzbHkgaGFyZGNvZGVkIHRvIHRoZSBFdGhl
cm5ldCBsaW5rIHR5cGUgaW4gdGhlIEFQSS4NCj4gICAgVGhpcyBhcmd1bWVudCBpcyBhZGRlZCB0
byBgYHJ0ZV9wY2FwbmdfYWRkX2ludGVyZmFjZWBgLg0KPiANCj4gKyogYml0bWFwOiBDaGFuZ2Vk
IHRoZSByZXR1cm4gdHlwZSBvZiBgYHJ0ZV9iaXRtYXBfZnJlZSgpYGAgdG8gdm9pZA0KPiArICBm
b3IgY29uc2lzdGVuY3kgd2l0aCBvdGhlciBmcmVlIGZ1bmN0aW9ucy4NCj4gKw0KPiANCj4gIEFC
SSBDaGFuZ2VzDQo+ICAtLS0tLS0tLS0tLQ0KPiBkaWZmIC0tZ2l0IGEvbGliL2VhbC9pbmNsdWRl
L3J0ZV9iaXRtYXAuaCBiL2xpYi9lYWwvaW5jbHVkZS9ydGVfYml0bWFwLmgNCj4gaW5kZXggYWJi
MTAyZjFkMy4uZWJlNmM0NDk5OCAxMDA2NDQNCj4gLS0tIGEvbGliL2VhbC9pbmNsdWRlL3J0ZV9i
aXRtYXAuaA0KPiArKysgYi9saWIvZWFsL2luY2x1ZGUvcnRlX2JpdG1hcC5oDQo+IEBAIC0yODIs
MjAgKzI4MiwxNSBAQCBydGVfYml0bWFwX2luaXRfd2l0aF9hbGxfc2V0KHVpbnQzMl90IG5fYml0
cywgdWludDhfdA0KPiAqbWVtLCB1aW50MzJfdCBtZW1fc2l6ZSkNCj4gIC8qKg0KPiAgICogQml0
bWFwIGZyZWUNCj4gICAqDQo+ICsgKiBUaGlzIGZ1bmN0aW9uIGRvZXMgbm90aGluZyBpbiBjdXJy
ZW50IGltcGxlbWVudGF0aW9uLg0KPiArICoNCj4gICAqIEBwYXJhbSBibXANCj4gICAqICAgSGFu
ZGxlIHRvIGJpdG1hcCBpbnN0YW5jZQ0KPiAtICogQHJldHVybg0KPiAtICogICAwIHVwb24gc3Vj
Y2VzcywgZXJyb3IgY29kZSBvdGhlcndpc2UNCj4gICAqLw0KPiAtc3RhdGljIGlubGluZSBpbnQN
Cj4gK3N0YXRpYyBpbmxpbmUgdm9pZA0KPiAgcnRlX2JpdG1hcF9mcmVlKHN0cnVjdCBydGVfYml0
bWFwICpibXApDQo+ICB7DQo+IC0JLyogQ2hlY2sgaW5wdXQgYXJndW1lbnRzICovDQo+IC0JaWYg
KGJtcCA9PSBOVUxMKSB7DQo+IC0JCXJldHVybiAtMTsNCj4gLQl9DQo+IC0NCj4gLQlyZXR1cm4g
MDsNCj4gKwlSVEVfU0VUX1VTRUQoYm1wKTsNCj4gIH0NCj4gDQo+ICAvKioNCj4gLS0NCkFja2Vk
LWJ5OiBLb25zdGFudGluIEFuYW55ZXYgPGtvbnN0YW50aW4uYW5hbnlldkBodWF3ZWkuY29tPg0K
PiAyLjUxLjANCg0K
