Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 899FECA0EE4
	for <dpdk-dev@archiver.kernel.org>; Thu, 14 Aug 2025 13:28:08 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id C8E77410E4;
	Thu, 14 Aug 2025 15:28:07 +0200 (CEST)
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com
 [185.176.79.56]) by mails.dpdk.org (Postfix) with ESMTP id 436C0402CA
 for <dev@dpdk.org>; Thu, 14 Aug 2025 15:28:06 +0200 (CEST)
Received: from mail.maildlp.com (unknown [172.18.186.216])
 by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4c2mC14RX9z6JB9S;
 Thu, 14 Aug 2025 21:23:09 +0800 (CST)
Received: from frapeml100002.china.huawei.com (unknown [7.182.85.26])
 by mail.maildlp.com (Postfix) with ESMTPS id 1DEBE1402EA;
 Thu, 14 Aug 2025 21:28:05 +0800 (CST)
Received: from frapeml500002.china.huawei.com (7.182.85.205) by
 frapeml100002.china.huawei.com (7.182.85.26) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Thu, 14 Aug 2025 15:28:04 +0200
Received: from frapeml500002.china.huawei.com ([7.182.85.205]) by
 frapeml500002.china.huawei.com ([7.182.85.205]) with mapi id 15.01.2507.039;
 Thu, 14 Aug 2025 15:28:04 +0200
From: Marat Khalili <marat.khalili@huawei.com>
To: Francois <devel.fx.lebail@orange.fr>, "dev@dpdk.org" <dev@dpdk.org>
Subject: RE: Warnings in headers when building libpcap with dpdk and clang
Thread-Topic: Warnings in headers when building libpcap with dpdk and clang
Thread-Index: AQHcDRqLxlJo7Y/37EamrK0BYDl1M7RiHq8g
Date: Thu, 14 Aug 2025 13:28:04 +0000
Message-ID: <145abf7b6da64c229fc99ab580973eb5@huawei.com>
References: <be3d5abb-84cd-44de-b7c3-286536f7f994@orange.fr>
In-Reply-To: <be3d5abb-84cd-44de-b7c3-286536f7f994@orange.fr>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.206.137.70]
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

PiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBGcmFuY29pcyA8ZGV2ZWwuZngu
bGViYWlsQG9yYW5nZS5mcj4NCj4gU2VudDogVGh1cnNkYXkgMTQgQXVndXN0IDIwMjUgMTM6NTQN
Cj4gVG86IGRldkBkcGRrLm9yZw0KPiBTdWJqZWN0OiBXYXJuaW5ncyBpbiBoZWFkZXJzIHdoZW4g
YnVpbGRpbmcgbGlicGNhcCB3aXRoIGRwZGsgYW5kIGNsYW5nDQo+IA0KPiBIZWxsbywNCj4gDQo+
IEkgbm90aWNlIG1hbnkgd2FybmluZ3MuIFRvIHJlcHJvZHVjZToNCj4gDQo+IE9uIERlYmlhbiBi
b29rd29ybS4NCj4gDQo+IHN1ZG8gYXB0IGluc3RhbGwgZHBkay1kZXYNCj4gDQo+IGdpdCBjbG9u
ZSBodHRwczovL2dpdC50Y3BkdW1wLm9yZy9saWJwY2FwDQo+IA0KPiAjIGJ1aWxkIHdpdGggY2xh
bmcNCj4gDQo+ICQgLi9hdXRvZ2VuLnNoDQo+IA0KPiAkIC4vY29uZmlndXJlIENDPWNsYW5nLTE2
IC0td2l0aC1kcGRrDQo+IA0KPiAkIG1ha2UNCj4gDQo+IFdhcm5pbmcgbGluZXM6DQo+IC91c3Iv
aW5jbHVkZS9kcGRrL3J0ZV9yaW5nX2VsZW1fcHZ0Lmg6MTM6MzY6IHdhcm5pbmc6ICdHQ0NfVkVS
U0lPTicgaXMgbm90IGRlZmluZWQsIGV2YWx1YXRlcyB0byAwIFstDQo+IFd1bmRlZl0NCg0KPiBX
aGF0IGRvIHlvdSB0aGluaz8NCg0KRm9yIHRoZSBmaXJzdCB3YXJuaW5nIHRoZXJlIHdhcyBhIGNv
bW1pdCAzY2IzNGZiMGIwICJidWlsZDogc2V0IHRvb2xjaGFpbiBtYWNyb3MgZnJvbSBwcmVkZWZp
bmVkIG1hY3JvcyIgZGF0ZWQgMjAyNC0wMS0wMiB0aGF0IHdhcyBmaXhpbmcgc2ltaWxhciBpc3N1
ZS4gSXQgaXMgcG9zc2libGUgdGhhdCBkb2N1bWVudGF0aW9uIGlzc3VlcyB3ZXJlIGZpeGVkIHNp
bmNlIGJvb2t3b3JtLXNoaXBwZWQgdmVyc2lvbiAyMi4xMSBhcyB3ZWxsLiBEZXBlbmRpbmcgb24g
eW91ciBnb2FscyB5b3UgbWF5IHRyeSBuZXdlciBEUERLIHZlcnNpb24sIGNvbXBpbGluZyBsaWJw
Y2FwIHdpdGggZ2NjIGFuZC9vciBmZXdlciB3YXJuaW5ncyBvciBqdXN0IGlnbm9yaW5nIHRoZXNl
IHdhcm5pbmdzLg0K
