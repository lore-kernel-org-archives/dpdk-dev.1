Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B4BC6C021A4
	for <dpdk-dev@archiver.kernel.org>; Fri, 14 Feb 2025 08:52:46 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id A1F614064A;
	Fri, 14 Feb 2025 09:52:45 +0100 (CET)
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com
 [185.176.79.56]) by mails.dpdk.org (Postfix) with ESMTP id F2CB240263
 for <dev@dpdk.org>; Fri, 14 Feb 2025 09:52:43 +0100 (CET)
Received: from mail.maildlp.com (unknown [172.18.186.231])
 by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4YvQhx420sz67bbH;
 Fri, 14 Feb 2025 16:49:37 +0800 (CST)
Received: from frapeml100007.china.huawei.com (unknown [7.182.85.133])
 by mail.maildlp.com (Postfix) with ESMTPS id 82BC814011F;
 Fri, 14 Feb 2025 16:52:43 +0800 (CST)
Received: from frapeml500007.china.huawei.com (7.182.85.172) by
 frapeml100007.china.huawei.com (7.182.85.133) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Fri, 14 Feb 2025 09:52:43 +0100
Received: from frapeml500007.china.huawei.com ([7.182.85.172]) by
 frapeml500007.china.huawei.com ([7.182.85.172]) with mapi id 15.01.2507.039;
 Fri, 14 Feb 2025 09:52:43 +0100
From: Konstantin Ananyev <konstantin.ananyev@huawei.com>
To: Stephen Hemminger <stephen@networkplumber.org>, "dev@dpdk.org"
 <dev@dpdk.org>
CC: Tyler Retzlaff <roretzla@linux.microsoft.com>,
 =?utf-8?B?TW9ydGVuIEJyw7hydXA=?= <mb@smartsharesystems.com>, Reshma Pattan
 <reshma.pattan@intel.com>
Subject: RE: [PATCH v7 2/7] latencystats: do not use floating point
Thread-Topic: [PATCH v7 2/7] latencystats: do not use floating point
Thread-Index: AQHbfl2AGUTGS77qZE2X99NhaCDOprNGfpaw
Date: Fri, 14 Feb 2025 08:52:43 +0000
Message-ID: <bd952f5a8c374b1d8ea5957095785df6@huawei.com>
References: <20240408195036.182545-1-stephen@networkplumber.org>
 <20250213212151.1693506-1-stephen@networkplumber.org>
 <20250213212151.1693506-3-stephen@networkplumber.org>
In-Reply-To: <20250213212151.1693506-3-stephen@networkplumber.org>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.195.247.231]
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

DQoNCj4gVGhlIGN5Y2xlIGNvdW50cyBkbyBub3QgbmVlZCB0byBiZSBzdG9yZWQgYXMgZmxvYXRp
bmcgcG9pbnQuDQo+IEluc3RlYWQga2VlcCB0cmFjayBvZiBsYXRlbmN5IGluIGN5Y2xlcywgYW5k
IGNvbnZlcnQgdG8NCj4gbmFub3NlY29uZHMgd2hlbiByZWFkLg0KPiANCj4gVXNlIHNjYWxlZCBt
YXRoIHdpdGggZXhwb25lbnRpYWwgV2VpZ2h0ZWQgTW92aW5nIEF2ZXJhZ2Ugd2VpZ2h0DQo+IG9m
IC4yNSB0byBhdm9pZCB1c2Ugb2YgZmxvYXRpbmcgcG9pbnQgZm9yIHRoYXQuDQo+IA0KPiBUaGUg
YXZlcmFnZSBsYXRlbmN5IHRvb2sgdG9vIGxvbmcgdG8gIndhcm0gdXAiLg0KPiBEbyB3aGF0IFJG
QyA2Mjk4IHN1Z2dlc3RzIGFuZCBpbml0aWFsaXplIG9uIGZpcnN0IHNhbXBsZS4NCj4gDQo+IFNp
Z25lZC1vZmYtYnk6IFN0ZXBoZW4gSGVtbWluZ2VyIDxzdGVwaGVuQG5ldHdvcmtwbHVtYmVyLm9y
Zz4NCj4gQWNrZWQtYnk6IFR5bGVyIFJldHpsYWZmIDxyb3JldHpsYUBsaW51eC5taWNyb3NvZnQu
Y29tPg0KPiBBY2tlZC1ieTogTW9ydGVuIEJyw7hydXAgPG1iQHNtYXJ0c2hhcmVzeXN0ZW1zLmNv
bT4NCj4gLS0tDQo+ICBsaWIvbGF0ZW5jeXN0YXRzL3J0ZV9sYXRlbmN5c3RhdHMuYyB8IDEyOCAr
KysrKysrKysrKysrKysrLS0tLS0tLS0tLS0tDQo+ICAxIGZpbGUgY2hhbmdlZCwgNzMgaW5zZXJ0
aW9ucygrKSwgNTUgZGVsZXRpb25zKC0pDQo+IA0KDQpBY2tlZC1ieTogS29uc3RhbnRpbiBBbmFu
eWV2IDxrb25zdGFudGluLmFuYW55ZXZAaHVhd2VpLmNvbT4NCiANCg0KPiAyLjQ3LjINCg0K
