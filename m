Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 499FFC3600B
	for <dpdk-dev@archiver.kernel.org>; Thu, 27 Mar 2025 10:39:14 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 164E9406B7;
	Thu, 27 Mar 2025 11:39:13 +0100 (CET)
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com
 [185.176.79.56])
 by mails.dpdk.org (Postfix) with ESMTP id C087D40687;
 Thu, 27 Mar 2025 11:39:10 +0100 (CET)
Received: from mail.maildlp.com (unknown [172.18.186.216])
 by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4ZNg6c5SC3z6K99b;
 Thu, 27 Mar 2025 18:35:52 +0800 (CST)
Received: from frapeml100008.china.huawei.com (unknown [7.182.85.131])
 by mail.maildlp.com (Postfix) with ESMTPS id DEAF614025A;
 Thu, 27 Mar 2025 18:39:09 +0800 (CST)
Received: from frapeml500007.china.huawei.com (7.182.85.172) by
 frapeml100008.china.huawei.com (7.182.85.131) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Thu, 27 Mar 2025 11:39:09 +0100
Received: from frapeml500007.china.huawei.com ([7.182.85.172]) by
 frapeml500007.china.huawei.com ([7.182.85.172]) with mapi id 15.01.2507.039;
 Thu, 27 Mar 2025 11:39:09 +0100
From: Konstantin Ananyev <konstantin.ananyev@huawei.com>
To: David Marchand <david.marchand@redhat.com>, Bruce Richardson
 <bruce.richardson@intel.com>
CC: "dev@dpdk.org" <dev@dpdk.org>, "bluca@debian.org" <bluca@debian.org>,
 "stable@dpdk.org" <stable@dpdk.org>, Konstantin Ananyev
 <konstantin.v.ananyev@yandex.ru>, David Christensen <drc@linux.ibm.com>,
 Wathsala Vithanage <wathsala.vithanage@arm.com>
Subject: RE: [PATCH] acl: fix build with GCC 15 on aarch64
Thread-Topic: [PATCH] acl: fix build with GCC 15 on aarch64
Thread-Index: AQHbnjt5qhsCVMI9iE2kqI1U+hvMxLOGnsEAgAAcUgCAABEakA==
Date: Thu, 27 Mar 2025 10:39:09 +0000
Message-ID: <243684416b27483b89f1c5e5ffcc249c@huawei.com>
References: <20250326103928.1189243-1-david.marchand@redhat.com>
 <Z-USgmK7lRZsjcIn@bricha3-mobl1.ger.corp.intel.com>
 <CAJFAV8xLbR_UD3=i_fR3aLzuciuWbbkkV8DgiXYm6Y1C7RXQug@mail.gmail.com>
In-Reply-To: <CAJFAV8xLbR_UD3=i_fR3aLzuciuWbbkkV8DgiXYm6Y1C7RXQug@mail.gmail.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.126.172.251]
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

DQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogRGF2aWQgTWFyY2hhbmQg
PGRhdmlkLm1hcmNoYW5kQHJlZGhhdC5jb20+DQo+IFNlbnQ6IFRodXJzZGF5LCBNYXJjaCAyNywg
MjAyNSAxMDozNyBBTQ0KPiBUbzogQnJ1Y2UgUmljaGFyZHNvbiA8YnJ1Y2UucmljaGFyZHNvbkBp
bnRlbC5jb20+DQo+IENjOiBkZXZAZHBkay5vcmc7IGJsdWNhQGRlYmlhbi5vcmc7IHN0YWJsZUBk
cGRrLm9yZzsgS29uc3RhbnRpbiBBbmFueWV2IDxrb25zdGFudGluLnYuYW5hbnlldkB5YW5kZXgu
cnU+OyBEYXZpZCBDaHJpc3RlbnNlbg0KPiA8ZHJjQGxpbnV4LmlibS5jb20+OyBXYXRoc2FsYSBW
aXRoYW5hZ2UgPHdhdGhzYWxhLnZpdGhhbmFnZUBhcm0uY29tPg0KPiBTdWJqZWN0OiBSZTogW1BB
VENIXSBhY2w6IGZpeCBidWlsZCB3aXRoIEdDQyAxNSBvbiBhYXJjaDY0DQo+IA0KPiBPbiBUaHUs
IE1hciAyNywgMjAyNSBhdCA5OjU14oCvQU0gQnJ1Y2UgUmljaGFyZHNvbg0KPiA8YnJ1Y2Uucmlj
aGFyZHNvbkBpbnRlbC5jb20+IHdyb3RlOg0KPiA+DQo+ID4gT24gV2VkLCBNYXIgMjYsIDIwMjUg
YXQgMTE6Mzk6MjhBTSArMDEwMCwgRGF2aWQgTWFyY2hhbmQgd3JvdGU6DQo+ID4gPiBDYXVnaHQg
aW4gT0JTIGZvciBGZWRvcmEgUmF3aGlkZSBvbiBhYXJjaDY0Og0KPiA+ID4NCj4gPiA+IFsgIDE5
OHNdIEluIGZpbGUgaW5jbHVkZWQgZnJvbSAuLi9saWIvYWNsL2FjbF9ydW5fbmVvbi5oOjcsDQo+
ID4gPiBbICAxOThzXSAgICAgICAgICAgICAgICAgIGZyb20gLi4vbGliL2FjbC9hY2xfcnVuX25l
b24uYzo1Og0KPiA+ID4gWyAgMTk4c10gSW4gZnVuY3Rpb24g4oCYYWxsb2NfY29tcGxldGlvbuKA
mSwNCj4gPiA+IFsgIDE5OHNdICAgICBpbmxpbmVkIGZyb20g4oCYYWNsX3N0YXJ0X25leHRfdHJp
ZeKAmSBhdA0KPiA+ID4gICAgICAgLi4vbGliL2FjbC9hY2xfcnVuLmg6MTQwOjI0LA0KPiA+ID4g
WyAgMTk4c10gICAgIGlubGluZWQgZnJvbSDigJhzZWFyY2hfbmVvbl80LmlzcmHigJkgYXQNCj4g
PiA+ICAgICAgIC4uL2xpYi9hY2wvYWNsX3J1bl9uZW9uLmg6MjM5OjIwOg0KPiA+ID4gWyAgMTk4
c10gLi4vbGliL2FjbC9hY2xfcnVuLmg6OTM6MjU6IGVycm9yOiDigJhjbXBsdOKAmSBtYXkgYmUg
dXNlZA0KPiA+ID4gICAgICAgdW5pbml0aWFsaXplZCBbLVdlcnJvcj1tYXliZS11bmluaXRpYWxp
emVkXQ0KPiA+ID4gWyAgMTk4c10gICAgOTMgfCAgICAgICAgICAgICAgICAgaWYgKHBbbl0uY291
bnQgPT0gMCkgew0KPiA+ID4gWyAgMTk4c10gICAgICAgfCAgICAgICAgICAgICAgICAgICAgIH5+
fn5efn5+fn4NCj4gPiA+IFsgIDE5OHNdIC4uL2xpYi9hY2wvYWNsX3J1bl9uZW9uLmg6IEluIGZ1
bmN0aW9uIOKAmHNlYXJjaF9uZW9uXzQuaXNyYeKAmToNCj4gPiA+IFsgIDE5OHNdIC4uL2xpYi9h
Y2wvYWNsX3J1bl9uZW9uLmg6MjMwOjI3OiBub3RlOiDigJhjbXBsdOKAmSBkZWNsYXJlZCBoZXJl
DQo+ID4gPiBbICAxOThzXSAgIDIzMCB8ICAgICAgICAgc3RydWN0IGNvbXBsZXRpb24gY21wbHRb
NF07DQo+ID4gPiBbICAxOThzXSAgICAgICB8ICAgICAgICAgICAgICAgICAgICAgICAgICAgXn5+
fn4NCj4gPiA+DQo+ID4gPiBUaGUgY29kZSB3YXMgcmVzZXR0aW5nIHNlcXVlbnRpYWxseSBjbXBs
W10uY291bnQgYXQgdGhlIGV4YWN0IGluZGV4IHRoYXQNCj4gPiA+IGxhdGVyIGNhbGwgdG8gYWxs
b2NfY29tcGxldGlvbiB1c2VzLg0KPiA+ID4gV2hpbGUgdGhpcyBjb2RlIHNlZW1zIGNvcnJlY3Qs
IEdDQyAxNSBkb2VzIG5vdCB1bmRlcnN0YW5kIHRoaXMgKHByb2JhYmx5DQo+ID4gPiB3aGVuIGFw
cGx5aW5nIHNvbWUgb3B0aW1pc2F0aW9ucykuDQo+ID4gPg0KPiA+ID4gSW5zdGVhZCwgcmVzZXQg
Y21wbFtdLmNvdW50IGFsbCBhdCBvbmNlIGluIGFjbF9zZXRfZmxvdywgYW5kIGNsZWFudXAgdGhl
DQo+ID4gPiB2YXJpb3VzIHZlY3Rvcml6ZWQgaW1wbGVtZW50YXRpb25zIGFjY29yZGluZ2x5Lg0K
PiA+ID4NCj4gPiA+IEJ1Z3ppbGxhIElEOiAxNjc4DQo+ID4gPiBDYzogc3RhYmxlQGRwZGsub3Jn
DQo+ID4gPg0KPiA+ID4gU2lnbmVkLW9mZi1ieTogRGF2aWQgTWFyY2hhbmQgPGRhdmlkLm1hcmNo
YW5kQHJlZGhhdC5jb20+DQo+ID4gPiAtLS0NCj4gPiA+ICBsaWIvYWNsL2FjbF9ydW4uaCAgICAg
ICAgIHwgNSArKysrKw0KPiA+ID4gIGxpYi9hY2wvYWNsX3J1bl9hbHRpdmVjLmggfCA4ICsrLS0t
LS0tDQo+ID4gPiAgbGliL2FjbC9hY2xfcnVuX2F2eDIuaCAgICB8IDQgKy0tLQ0KPiA+ID4gIGxp
Yi9hY2wvYWNsX3J1bl9uZW9uLmggICAgfCA4ICsrLS0tLS0tDQo+ID4gPiAgbGliL2FjbC9hY2xf
cnVuX3NjYWxhci5jICB8IDQgKy0tLQ0KPiA+ID4gIGxpYi9hY2wvYWNsX3J1bl9zc2UuaCAgICAg
fCA4ICsrLS0tLS0tDQo+ID4gPiAgNiBmaWxlcyBjaGFuZ2VkLCAxMyBpbnNlcnRpb25zKCspLCAy
NCBkZWxldGlvbnMoLSkNCj4gPiA+DQo+ID4gPiBkaWZmIC0tZ2l0IGEvbGliL2FjbC9hY2xfcnVu
LmggYi9saWIvYWNsL2FjbF9ydW4uaA0KPiA+ID4gaW5kZXggN2YwOTI0MTNjZC4uOWZkM2U2MDAy
MSAxMDA2NDQNCj4gPiA+IC0tLSBhL2xpYi9hY2wvYWNsX3J1bi5oDQo+ID4gPiArKysgYi9saWIv
YWNsL2FjbF9ydW4uaA0KPiA+ID4gQEAgLTE3Niw2ICsxNzYsOCBAQCBhY2xfc2V0X2Zsb3coc3Ry
dWN0IGFjbF9mbG93X2RhdGEgKmZsb3dzLCBzdHJ1Y3QgY29tcGxldGlvbiAqY21wbHQsDQo+ID4g
PiAgICAgICB1aW50MzJfdCBjbXBsdF9zaXplLCBjb25zdCB1aW50OF90ICoqZGF0YSwgdWludDMy
X3QgKnJlc3VsdHMsDQo+ID4gPiAgICAgICB1aW50MzJfdCBkYXRhX251bSwgdWludDMyX3QgY2F0
ZWdvcmllcywgY29uc3QgdWludDY0X3QgKnRyYW5zKQ0KPiA+ID4gIHsNCj4gPiA+ICsgICAgIHVu
c2lnbmVkIGludCBpOw0KPiA+ID4gKw0KPiA+ID4gICAgICAgZmxvd3MtPm51bV9wYWNrZXRzID0g
MDsNCj4gPiA+ICAgICAgIGZsb3dzLT5zdGFydGVkID0gMDsNCj4gPiA+ICAgICAgIGZsb3dzLT50
cmllID0gMDsNCj4gPiA+IEBAIC0xODcsNiArMTg5LDkgQEAgYWNsX3NldF9mbG93KHN0cnVjdCBh
Y2xfZmxvd19kYXRhICpmbG93cywgc3RydWN0IGNvbXBsZXRpb24gKmNtcGx0LA0KPiA+ID4gICAg
ICAgZmxvd3MtPmRhdGEgPSBkYXRhOw0KPiA+ID4gICAgICAgZmxvd3MtPnJlc3VsdHMgPSByZXN1
bHRzOw0KPiA+ID4gICAgICAgZmxvd3MtPnRyYW5zID0gdHJhbnM7DQo+ID4gPiArDQo+ID4gPiAr
ICAgICBmb3IgKGkgPSAwOyBpIDwgY21wbHRfc2l6ZTsgaSsrKQ0KPiA+ID4gKyAgICAgICAgICAg
ICBjbXBsdFtpXS5jb3VudCA9IDA7DQo+ID4gPiAgfQ0KPiA+DQo+ID4gTWlub3Igbml0LCBidXQg
c2luY2Ugd2UgYXJlIHVzaW5nIGMxMSBzdGFuZGFyZCwgaXMgaXQgbm90IGJldHRlciB0byBkZWNs
YXJlDQo+ID4gImkiIGluc2lkZSB0aGUgImZvciIgc3RhdGVtZW50LiBLZWVwcyBkaWZmcyBzaW1w
bGVyIGZvciBhZGRpbmcvcmVtb3ZpbmcNCj4gPiBjb2RlLCBJIHRoaW5rLg0KPiANCj4gSSBzdGls
bCBoYXZlIHRoaXMgKGJhZCkgaGFiaXQgYnV0IHllcywgaXQgbG9va3MgbmljZXIgd2l0aCBkZWNs
YXJpbmcNCj4gaW4gZm9yKCkgaXRzZWxmLg0KDQpNeSB2b3RlIHdvdWxkIGJlIHRvIGtlZXAgaXQg
aW4gYW4gb2xkIGZhc2hpb25lZCB3YXkuDQpOb3RoaW5nIGlzIHdyb25nIGluIGRlZmluaW5nIHZh
cmlhYmxlIHRvIHVzZSBhdCB0aGUgc3RhcnQgb2YgdGhlIGZ1bmN0aW9uIDopIA0KIA0KDQo=
