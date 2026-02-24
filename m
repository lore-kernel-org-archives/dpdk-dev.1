Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9A81CEFB811
	for <dpdk-dev@archiver.kernel.org>; Tue, 24 Feb 2026 07:39:00 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 0A937402EF;
	Tue, 24 Feb 2026 08:38:55 +0100 (CET)
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
 by mails.dpdk.org (Postfix) with ESMTP id 474D6400D5
 for <dev@dpdk.org>; Tue, 24 Feb 2026 03:34:50 +0100 (CET)
X-SpamFilter-By: ArmorX SpamTrap 5.80 with qID 61O2YemtE2198380,
 This message is accepted by code: ctloc85258
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=realsil.com.cn;
 s=dkim; t=1771900480;
 bh=NnBBkbKmHYuDE8F/vLhnNvEJZdrJotnwqylbXc7lLPk=;
 h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
 Content-Type:Content-Transfer-Encoding:MIME-Version;
 b=i0WxLRFqE8NvdJ75KFkj2AgrTXOl0U6HUxemXkr6k/np6wMmNWdwPW76wzZL/Vejq
 PkqlgE8A0JVtPNHTDP9nk1ZpvxHNG9K4eVV9ouZRkAo0bNTAh+0e/Q6UolXMCeITfa
 D7Ejjhtk6rZf3OkPNBeWWaG+uEjdX3WBWxYeFXcEvRskmnvSXg+yZdp7jsQCV+3lnD
 3jwJYM85+L4nIO8POyf3buSPlplz7XN/tD6GlVeeYAM6HspmdsiKrFD/oLBzTAZeFZ
 K/5qHCEwjxSVOMThistvoDm0/yoQ9U7zcopFFCDrp4umyRS7Zy80Ps1vUnq8TQ+kbD
 EXaksoA/2DVUg==
Received: from RS-EX-MBS3.realsil.com.cn ([172.29.17.103])
 by rtits2.realtek.com.tw (8.15.2/3.21/5.94) with ESMTPS id 61O2YemtE2198380
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
 Tue, 24 Feb 2026 10:34:40 +0800
Received: from RS-EX-MBS3.realsil.com.cn (172.29.17.103) by
 RS-EX-MBS3.realsil.com.cn (172.29.17.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.39; Tue, 24 Feb 2026 10:34:40 +0800
Received: from RS-EX-MBS3.realsil.com.cn ([172.29.17.103]) by
 RS-EX-MBS3.realsil.com.cn ([172.29.17.103]) with mapi id 15.02.1748.039; Tue,
 24 Feb 2026 10:34:40 +0800
From: =?utf-8?B?6K645L+K5Lyf?= <javen_xu@realsil.com.cn>
To: Thomas Monjalon <thomas@monjalon.net>, "dev@dpdk.org" <dev@dpdk.org>
CC: "byron.marohn@intel.com" <byron.marohn@intel.com>, "david.hunt@intel.com"
 <david.hunt@intel.com>, "lee.daly@intel.com" <lee.daly@intel.com>,
 "xuanziyang2@huawei.com" <xuanziyang2@huawei.com>,
 "kyo.liu@nebula-matrix.com" <kyo.liu@nebula-matrix.com>
Subject: RE: [PATCH] maintainers: prune unreachable contacts
Thread-Topic: [PATCH] maintainers: prune unreachable contacts
Thread-Index: AQHcpTO/zW9J1hvPiUe6TNtyglI9frWRHwpw
Date: Tue, 24 Feb 2026 02:34:39 +0000
Message-ID: <067c453863ff4b9e9e3ba90f4dfe5222@realsil.com.cn>
References: <202602240217.61O2Ha8G22926752@rtits1.realtek.com.tw>
In-Reply-To: <202602240217.61O2Ha8G22926752@rtits1.realtek.com.tw>
Accept-Language: zh-CN, en-US
Content-Language: en-US
x-originating-ip: [172.29.17.210]
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-Mailman-Approved-At: Tue, 24 Feb 2026 08:38:52 +0100
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

Pi0tLS0tT3JpZ2luYWwgTWVzc2FnZS0tLS0tDQo+RnJvbTogVGhvbWFzIE1vbmphbG9uIDx0aG9t
YXNAbW9uamFsb24ubmV0Pg0KPlNlbnQ6IDIwMjblubQy5pyIMjDml6UgMjI6NTMNCj5UbzogZGV2
QGRwZGsub3JnDQo+Q2M6IGJ5cm9uLm1hcm9obkBpbnRlbC5jb207IGRhdmlkLmh1bnRAaW50ZWwu
Y29tOyBsZWUuZGFseUBpbnRlbC5jb207DQo+eHVhbnppeWFuZzJAaHVhd2VpLmNvbTsga3lvLmxp
dUBuZWJ1bGEtbWF0cml4LmNvbTsgSmF2ZW4gWHUNCj48amF2ZW5feHVAcmVhbHNpbC5jb20uY24+
DQo+U3ViamVjdDogW1BBVENIXSBtYWludGFpbmVyczogcHJ1bmUgdW5yZWFjaGFibGUgY29udGFj
dHMNCj4NCj4NCj5FeHRlcm5hbCBtYWlsIDogVGhpcyBlbWFpbCBvcmlnaW5hdGVkIGZyb20gb3V0
c2lkZSB0aGUgb3JnYW5pemF0aW9uLiBEbyBub3QNCj5yZXBseSwgY2xpY2sgbGlua3MsIG9yIG9w
ZW4gYXR0YWNobWVudHMgdW5sZXNzIHlvdSByZWNvZ25pemUgdGhlIHNlbmRlciBhbmQNCj5rbm93
IHRoZSBjb250ZW50IGlzIHNhZmUuDQo+DQo+DQo+DQo+U29tZSBlbWFpbCBhZGRyZXNzZXMgYXJl
IG5vdCByZXNwb25kaW5nIHRvICJSQ1BUIFRPIi4NCj5Ecm9wIHRoZXNlIG1haW50YWluZXJzIGFz
IHdlIGNhbm5vdCByZWFjaCB0aGVtLg0KPg0KPkNjOiBieXJvbi5tYXJvaG5AaW50ZWwuY29tDQo+
Q2M6IGRhdmlkLmh1bnRAaW50ZWwuY29tDQo+Q2M6IGxlZS5kYWx5QGludGVsLmNvbQ0KPkNjOiB4
dWFueml5YW5nMkBodWF3ZWkuY29tDQo+Q2M6IGt5by5saXVAbmVidWxhLW1hdHJpeC5jb20NCj5D
YzogamF2ZW5feHVAcmVhbHNpbC5jb20uY24NCj4NCj5TaWduZWQtb2ZmLWJ5OiBUaG9tYXMgTW9u
amFsb24gPHRob21hc0Btb25qYWxvbi5uZXQ+DQo+DQo+LS0tDQo+DQo+VGhpcyBwYXRjaCBzaG91
bGQgY29uZmlybSB0aGUgZW1haWwgYm91bmNlcy4NCj5JZiB0aGlzIGlzIGEgbWlzdGFrZSwgcGxl
YXNlIHJlcGx5Lg0KPi0tLQ0KPiBNQUlOVEFJTkVSUyB8IDcgLS0tLS0tLQ0KPiAxIGZpbGUgY2hh
bmdlZCwgNyBkZWxldGlvbnMoLSkNCj4NCj5kaWZmIC0tZ2l0IGEvTUFJTlRBSU5FUlMgYi9NQUlO
VEFJTkVSUw0KPmluZGV4IGI3YTFlMjhjNWEuLjJmYWYyOGY1MjIgMTAwNjQ0DQo+LS0tIGEvTUFJ
TlRBSU5FUlMNCj4rKysgYi9NQUlOVEFJTkVSUw0KPkBAIC03NzQsNyArNzc0LDYgQEAgRjogZG9j
L2d1aWRlcy9uaWNzL2huczMucnN0DQo+IEY6IGRvYy9ndWlkZXMvbmljcy9mZWF0dXJlcy9obnMz
LmluaQ0KPg0KPiBIdWF3ZWkgaGluaWMNCj4tTTogWml5YW5nIFh1YW4gPHh1YW56aXlhbmcyQGh1
YXdlaS5jb20+DQo+IE06IFhpYW95dW4gV2FuZyA8Y2xvdWQud2FuZ3hpYW95dW5AaHVhd2VpLmNv
bT4NCj4gRjogZHJpdmVycy9uZXQvaGluaWMvDQo+IEY6IGRvYy9ndWlkZXMvbmljcy9oaW5pYy5y
c3QNCj5AQCAtMTAyMSw3ICsxMDIwLDYgQEAgRjogZG9jL2d1aWRlcy9uaWNzL2ZlYXR1cmVzL3Ju
cC5pbmkNCj4NCj4gTmVidWxhbWF0cml4IG5ibA0KPiBNOiBEaW1vbiBaaGFvIDxkaW1vbi56aGFv
QG5lYnVsYS1tYXRyaXguY29tPg0KPi1NOiBLeW8gTGl1IDxreW8ubGl1QG5lYnVsYS1tYXRyaXgu
Y29tPg0KPiBNOiBMZW9uIFl1IDxsZW9uLnl1QG5lYnVsYS1tYXRyaXguY29tPg0KPiBNOiBTYW0g
Q2hlbiA8c2FtLmNoZW5AbmVidWxhLW1hdHJpeC5jb20+DQo+IEY6IGRyaXZlcnMvbmV0L25ibC8N
Cj5AQCAtMTAzMiw3ICsxMDMwLDYgQEAgUmVhbHRlayByODE2OQ0KPiBNOiBIb3dhcmQgV2FuZyA8
aG93YXJkX3dhbmdAcmVhbHNpbC5jb20uY24+DQo+IE06IENodW5oYW8gTGluIDxoYXVAcmVhbHRl
ay5jb20+DQo+IE06IFhpbmcgV2FuZyA8eGluZ193YW5nQHJlYWxzaWwuY29tLmNuPg0KPi1NOiBK
YXZlbiBYdSA8amF2ZW5feHVAcmVhbHNpbC5jb20uY24+DQoNCkhpLCBUaG9tYXMNCg0KUGxlYXNl
IGtlZXAgbWUgaW4gdGhlIE1BSU5UQUlORVJTIGZpbGUuIE15IGVtYWlsIGFkZHJlc3MgPGphdmVu
X3h1QHJlYWxzaWwuY29tLmNuPiBpcyB2YWxpZCBhbmQgd29ya2luZyBwcm9wZXJseS4gDQpUaGUg
cHJldmlvdXMgIlJDUFQgVE8iIGVycm9yIHdhcyBjYXVzZWQgYnkgb3VyIGNvbXBhbnkncyBmaXJl
d2FsbCBibG9ja2luZyB0aGUgaW5jb21pbmcgZW1haWxzLg0KSSBoYXZlIGFkanVzdGVkIHRoZSBm
aXJld2FsbCBzZXR0aW5ncyBhbmQgdW5ibG9ja2VkIHRoZSB0cmFmZmljLiBTb3JyeSBmb3IgdGhl
IGluY29udmVuaWVuY2UuDQoNClRoYW5rcywNCkphdmVuIFh1DQo=
