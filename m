Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1955AC79F99
	for <dpdk-dev@archiver.kernel.org>; Sun,  6 Sep 2026 20:14:17 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 1542D402DA;
	Sun,  6 Sep 2026 22:14:17 +0200 (CEST)
Received: from dkmailrelay1.smartsharesystems.com
 (smartserver.smartsharesystems.com [77.243.40.215])
 by mails.dpdk.org (Postfix) with ESMTP id C3A7E402DA
 for <dev@dpdk.org>; Sun,  6 Sep 2026 22:14:14 +0200 (CEST)
Received: from smartserver.smartsharesystems.com
 (smartserver.smartsharesys.local [192.168.4.10])
 by dkmailrelay1.smartsharesystems.com (Postfix) with ESMTP id 230EF205C8;
 Sun,  6 Sep 2026 22:14:12 +0200 (CEST)
Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="utf-8"
Content-Transfer-Encoding: base64
Subject: RE: [PATCH v2 0/5] eal: RTE_PTR_ADD qualifiers and real unaligned
 types
X-MimeOLE: Produced By Microsoft Exchange V6.5
Date: Sun, 6 Sep 2026 22:14:10 +0200
Message-ID: <98CBD80474FA8B44BF855DF32C47DC35F65A36@smartserver.smartshare.dk>
In-Reply-To: <20260906171142.3503868-1-stephen@networkplumber.org>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: [PATCH v2 0/5] eal: RTE_PTR_ADD qualifiers and real unaligned
 types
Thread-Index: Ad0+ItHfQucoWS2VS4qiODUUuYti7gAGDhVg
References: <20260904220953.3105930-1-stephen@networkplumber.org>
 <20260906171142.3503868-1-stephen@networkplumber.org>
From: =?utf-8?B?TW9ydGVuIEJyw7hydXA=?= <mb@smartsharesystems.com>
To: "Stephen Hemminger" <stephen@networkplumber.org>, <dev@dpdk.org>,
 "Konstantin Ananyev" <konstantin.v.ananyev@yandex.ru>,
 "Wathsala Vithanage" <wathsala.vithanage@arm.com>
Cc: "Bruce Richardson" <bruce.richardson@intel.com>
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

K1RPOiBSSU5HIG1haW50YWluZXJzDQorQ0M6IEJydWNlLCB5b3UgbWlnaHQgYmUgYWJsZSB0byBy
ZWNhbGwgc29tZXRoaW5nDQoNCj4gRnJvbTogU3RlcGhlbiBIZW1taW5nZXIgW21haWx0bzpzdGVw
aGVuQG5ldHdvcmtwbHVtYmVyLm9yZ10NCj4gU2VudDogU3VuZGF5LCA2IFNlcHRlbWJlciAyMDI2
IDE5LjEwDQo+IA0KPiBUaGlzIHNlcmllcyBzdGFydGVkIHdpdGggU2NvdHQgTWl0Y2hlbGwncyBw
YXRjaCB0byBwcmVzZXJ2ZSBwb2ludGVyDQo+IHF1YWxpZmljYXRpb25zIGFjcm9zcyBSVEVfUFRS
X0FERCBhbmQgUlRFX1BUUl9TVUIuIFJldmlld2luZyBpdA0KPiB0dXJuZWQgdXAgdHdvIGZ1cnRo
ZXIgcHJvYmxlbXMuDQo+IA0KPiBUaGUgZmlyc3QgaXMgdGhhdCB1bmFsaWduZWRfdWludE5OX3Qg
b25seSBoYWQgYWxpZ25tZW50IDEgb24gYXJtdjgNCj4gYWFyY2gzMiwgdGhlIG9uZSB0YXJnZXQg
c2V0dGluZyBSVEVfQVJDSF9TVFJJQ1RfQUxJR04uIEV2ZXJ5d2hlcmUNCj4gZWxzZSB0aGV5IHdl
cmUgb3JkaW5hcnkgYWxpZ25lZCB0eXBlcywgc28gY29kZSB1c2luZyB0aGVtIHRvIHJlYWQNCj4g
b3Igd3JpdGUgYXQgYXJiaXRyYXJ5IG9mZnNldHMgd2FzIHN0aWxsIHVuZGVmaW5lZCBiZWhhdmlv
dXIgYW5kIHdhcw0KPiByZXBvcnRlZCBieSBVQlNBTi4gR2l2aW5nIHRoZW0gYWxpZ25tZW50IDEg
b24gYWxsIGFyY2hpdGVjdHVyZXMNCj4gZml4ZXMgdGhhdCwgYW5kIG9uY2UgbWx4NSBubyBsb25n
ZXIgbmVlZHMgaXRzIHN0cmljdCBhbGlnbm1lbnQNCj4gcGF0aCwgUlRFX0FSQ0hfU1RSSUNUX0FM
SUdOIGhhcyBubyB1c2VycyBsZWZ0IGFuZCBpcyByZW1vdmVkLg0KPiANCj4gVGhlIHNlY29uZCBp
cyB0aGUgamhhc2ggdGVzdCwgd2hpY2ggZGVjbGFyZWQgaXRzIGtleSBhcyBhIGJ5dGUNCj4gYXJy
YXkgYW5kIGNhc3QgaXQgdG8gdW5hbGlnbmVkX3VpbnQzMl90ICogdG8gcGFzcyB0byBhIGZ1bmN0
aW9uDQo+IHRha2luZyBjb25zdCB1aW50MzJfdCAqLiBUaGF0IGlzIGZpeGVkIGZpcnN0IGluIHRo
ZSBzZXJpZXMgc28gdGhlDQo+IGFsaWdubWVudCBjaGFuZ2UgZG9lcyBub3QgaW50cm9kdWNlIGEg
bmV3IGNsYW5nIHdhcm5pbmcuDQo+IA0KPiBPbmx5IHBhdGNoIDEgc2hvdWxkIGdvIHRvIHN0YWJs
ZS4NCj4gDQo+IE5vdGUgZm9yIHJldmlld2VyczogdW5hbGlnbmVkX3VpbnROTl90IGlzIGluIGFu
IGluc3RhbGxlZCBoZWFkZXIsDQo+IHNvIGFwcGxpY2F0aW9ucyBlbWJlZGRpbmcgb25lIG9mIHRo
ZXNlIHR5cGVzIGluIGEgc3RydWN0dXJlIHdpbGwNCj4gc2VlIGl0cyBsYXlvdXQgY2hhbmdlLiBU
aGF0IGlzIGNhbGxlZCBvdXQgaW4gdGhlIHJlbGVhc2Ugbm90ZXMuDQo+IA0KPiBUaGUgdHlwZXMg
YXJlIGFsc28gdXNlZCBpbiB0aGUgaGFzaCBrZXkgY29tcGFyZSBwYXRoDQo+IChydGVfY3Vja29v
X2hhc2guYywgcnRlX2NtcF9nZW5lcmljLmgpIGFuZCBmb3IgOCBieXRlIHJpbmcgZWxlbWVudHMN
Cj4gKHJ0ZV9yaW5nX2VsZW1fcHZ0LmgpLiBTY2FsYXIgY29kZSBnZW5lcmF0aW9uIGlzIHVuY2hh
bmdlZCBvbiB4ODYsDQo+IGJ1dCB0aGUgY29tcGlsZXIgY2FuIG5vIGxvbmdlciBhc3N1bWUgYWxp
Z25tZW50IHdoZW4gY29tYmluaW5nDQo+IGFkamFjZW50IGFjY2Vzc2VzLCBzbyBoYXNoIGFuZCBy
aW5nIHBlcmYgcmVzdWx0cyB3b3VsZCBiZSB3ZWxjb21lLA0KPiBwYXJ0aWN1bGFybHkgb24gYXJt
Lg0KDQpJcyB0aGVyZSBhIHJlYWwgcmVhc29uIHdoeSByaW5ncyBzdXBwb3J0IHVuYWxpZ25lZCBv
YmplY3RzPw0KT3Igd2FzIHRoZSAidW5hbGlnbmVkIiBqdXN0IHNsYXBwZWQgb24gZHVlIHRvIHNv
bWUgb2xkIGhhYml0LCBsaWtlIHBhY2tpbmcgc3RydWN0cz8NCg0KSWYgdGhlcmUncyBubyBnb29k
IHJlYXNvbiwgbGV0J3MgY29udmVyZ2UgdG93YXJkcyBub3JtYWwgYWxpZ25tZW50IGluIHRoZSBy
aW5nIGxpYnJhcnkuDQoNCi1Nb3J0ZW4NCg0K
