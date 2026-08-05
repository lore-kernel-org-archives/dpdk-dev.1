Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 33A96C55174
	for <dpdk-dev@archiver.kernel.org>; Wed,  5 Aug 2026 05:45:58 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 2020D40144;
	Wed,  5 Aug 2026 07:45:57 +0200 (CEST)
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com
 [185.176.79.56]) by mails.dpdk.org (Postfix) with ESMTP id 448A44003C
 for <dev@dpdk.org>; Wed,  5 Aug 2026 07:45:55 +0200 (CEST)
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
 c=relaxed/relaxed; q=dns/txt; h=From;
 bh=iWpW7Sk/OvZ+AsLWpHsTJbcgQcG+IBKq2OBGjEstyY4=;
 b=oZhdmBBLf0vpPrsbbz/Qzce3R4pgC/rj961dW9CGTfJUOHi0Vccd3GomBu5ClJ+5vyGVyhMex
 IcLKNiNPdfQOfBr2wrbZ1Pu4xOe1LowyeMFR/OvpHvyxoPPhqRMjuIN3xRNTk3K91R9MNBbhh55
 EzjRv7jQNmtv9zXxYtk+rnU=
Received: from mail.maildlp.com (unknown [172.18.224.83])
 by frasgout.his.huawei.com (SkyGuard) with ESMTPS id 4hFKBC5XJPzJ468v;
 Wed,  5 Aug 2026 13:45:07 +0800 (CST)
Received: from dubpeml500005.china.huawei.com (unknown [7.214.145.207])
 by mail.maildlp.com (Postfix) with ESMTPS id 49D2E40569;
 Wed,  5 Aug 2026 13:45:52 +0800 (CST)
Received: from dubpemt100001.china.huawei.com (7.214.147.107) by
 dubpeml500005.china.huawei.com (7.214.145.207) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Wed, 5 Aug 2026 06:45:51 +0100
Received: from dubpeml100001.china.huawei.com (7.214.144.137) by
 dubpemt100001.china.huawei.com (7.214.147.107) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Wed, 5 Aug 2026 06:45:51 +0100
Received: from dubpeml100001.china.huawei.com ([7.214.144.137]) by
 dubpeml100001.china.huawei.com ([7.214.144.137]) with mapi id 15.02.1544.036; 
 Wed, 5 Aug 2026 06:45:51 +0100
From: Konstantin Ananyev <konstantin.ananyev@huawei.com>
To: =?utf-8?B?TW9ydGVuIEJyw7hydXA=?= <mb@smartsharesystems.com>, "Stephen
 Hemminger" <stephen@networkplumber.org>
CC: "dev@dpdk.org" <dev@dpdk.org>, Bruce Richardson
 <bruce.richardson@intel.com>
Subject: RE: [PATCH] eal/x86: optimize memcpy of small 64-byte blocks
Thread-Topic: [PATCH] eal/x86: optimize memcpy of small 64-byte blocks
Thread-Index: AQHdJB42oNL4gJj070KJtRurBEIGmLaN+WoAgAAJXwCAAOt0oA==
Date: Wed, 5 Aug 2026 05:45:51 +0000
Message-ID: <6f474724bc22441a8a4f516f3398ca76@huawei.com>
References: <20260804143305.1344327-1-mb@smartsharesystems.com>
 <20260804085210.74763eb5@phoenix.local>
 <98CBD80474FA8B44BF855DF32C47DC35F659B8@smartserver.smartshare.dk>
In-Reply-To: <98CBD80474FA8B44BF855DF32C47DC35F659B8@smartserver.smartshare.dk>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.126.173.34]
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

DQoNCj4gPiBGcm9tOiBTdGVwaGVuIEhlbW1pbmdlciBbbWFpbHRvOnN0ZXBoZW5AbmV0d29ya3Bs
dW1iZXIub3JnXQ0KPiA+IFNlbnQ6IFR1ZXNkYXksIDQgQXVndXN0IDIwMjYgMTcuNTINCj4gPg0K
PiA+IE9uIFR1ZSwgIDQgQXVnIDIwMjYgMTQ6MzM6MDQgKzAwMDANCj4gPiBNb3J0ZW4gQnLDuHJ1
cCA8bWJAc21hcnRzaGFyZXN5c3RlbXMuY29tPiB3cm90ZToNCj4gPg0KPiA+ID4gKwkvKiBDb21t
b24gd2F5IGZvciBzbWFsbCBjb3B5IHNpemUgb2YgNjQtYnl0ZSBibG9ja3MuIFVubGlrZWx5LCBz
bw0KPiA+IGNvbnN0YW50IHNpemUgb25seSAqLw0KPiA+ID4gKwlpZiAoX19ydGVfY29uc3RhbnQo
bikgJiYgKG4gJiA2MykgPT0gMCAmJiBuIDw9DQo+ID4gUlRFX01FTUNQWV9CTE9DS182NF9NQVgp
IHsNCj4gPiA+ICsJCXZvaWQgKnJldCA9IGRzdDsNCj4gPiA+ICsNCj4gPg0KPiA+IE1heWJlIGp1
c3QgbGV0IGNvbXBpbGVyIGRlY2lkZSwgaXQgd2lsbCBnZW5lcmF0ZSB2ZWN0b3IgaW5zdHJ1Y3Rp
b25zIGluDQo+ID4gbW9zdCBjYXNlcy4NCj4gPg0KPiA+IAlpZiAoX19ydGVfY29uc3RhbnQobikp
DQo+ID4gCQlyZXR1cm4gbWVtcGNweShkc3QsIHNyYywgbik7DQo+IA0KPiBNYXliZSBpbiBtb3N0
LCBidXQgbm90IGluIGFsbDoNCj4gaHR0cHM6Ly9nb2Rib2x0Lm9yZy96L0t2ZEtxVDVyWQ0KDQpX
aXRoICctbWF2eCcgb3IgJy1tYXZ4NTEyZicgaXQgbG9va3MgbGlrZSBpdCBkb2VzIGZvciB5b3Vy
IHNhbXBsZSBjb2RlLg0KDQoNCg==
