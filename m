Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7A138CD5BC0
	for <dpdk-dev@archiver.kernel.org>; Mon, 25 May 2026 03:30:48 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 523334021E;
	Mon, 25 May 2026 05:30:47 +0200 (CEST)
Received: from canpmsgout04.his.huawei.com (canpmsgout04.his.huawei.com
 [113.46.200.219])
 by mails.dpdk.org (Postfix) with ESMTP id F22C240041
 for <dev@dpdk.org>; Mon, 25 May 2026 05:30:44 +0200 (CEST)
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
 c=relaxed/relaxed; q=dns/txt; h=From;
 bh=KozGuAuQqu3Hwkqviqa4SCLX31FrFiz2b38aXLyflzc=;
 b=Bh8sCWwpdDhJshKEvkv0dWpXLKXU7sN0yvR43y2WoxdITZlz3f1eE/qUJzBITK6x01Hp93Gez
 uAvxE5VKDsI7CgWPR0TSNKXm8AnQaDzx4bPY5+YA2oR/Cn344KiTuyuuYMeP2mzrrf4lSJMpQuP
 hUhxagufkyH9+d59+5Ci2bQ=
Received: from mail.maildlp.com (unknown [172.19.163.104])
 by canpmsgout04.his.huawei.com (SkyGuard) with ESMTPS id 4gP1RM46LZz1prKP;
 Mon, 25 May 2026 11:22:55 +0800 (CST)
Received: from dggemv706-chm.china.huawei.com (unknown [10.3.19.33])
 by mail.maildlp.com (Postfix) with ESMTPS id 604A54056A;
 Mon, 25 May 2026 11:30:42 +0800 (CST)
Received: from kwepemn500016.china.huawei.com (7.202.194.157) by
 dggemv706-chm.china.huawei.com (10.3.19.33) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Mon, 25 May 2026 11:30:41 +0800
Received: from kwepemn500008.china.huawei.com (7.202.194.149) by
 kwepemn500016.china.huawei.com (7.202.194.157) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Mon, 25 May 2026 11:30:41 +0800
Received: from kwepemn500008.china.huawei.com ([7.202.194.149]) by
 kwepemn500008.china.huawei.com ([7.202.194.149]) with mapi id 15.02.1544.011; 
 Mon, 25 May 2026 11:30:41 +0800
From: "wangfeifei (J)" <wangfeifei40@huawei.com>
To: Stephen Hemminger <stephen@networkplumber.org>, Feifei Wang
 <wff_light@vip.163.com>
CC: "dev@dpdk.org" <dev@dpdk.org>, "chenyi (CY)" <chenyi221@huawei.com>,
 huangbingkang <huangbingkang4@huawei.com>, zengweiliang zengweiliang
 <zengweiliang.zengweiliang@huawei.com>, "Wangxin(kunpeng)"
 <wangxin679@h-partners.com>
Subject: =?gb2312?B?u9i4tDogW1YxIDEvMV0gbmV0L2hpbmljMzogQWRkIFZYTEFOIFRTTyBmdW5j?=
 =?gb2312?Q?tion?=
Thread-Topic: [V1 1/1] net/hinic3: Add VXLAN TSO function
Thread-Index: AQHc6CYepukgzSA1kEGtR0SB8CZK6bYWfieAgAeKYjA=
Date: Mon, 25 May 2026 03:30:41 +0000
Message-ID: <ae1fc770e3044836b749d1e2765b4d30@huawei.com>
References: <20260520065817.931-1-wff_light@vip.163.com>
 <20260520065817.931-2-wff_light@vip.163.com>
 <20260520080649.67af0f2c@phoenix.local>
In-Reply-To: <20260520080649.67af0f2c@phoenix.local>
Accept-Language: en-US
Content-Language: zh-CN
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [100.105.34.252]
Content-Type: text/plain; charset="gb2312"
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

DQoNCj4gLS0tLS3Tyrz+1K28/i0tLS0tDQo+ILeivP7IyzogU3RlcGhlbiBIZW1taW5nZXIgPHN0
ZXBoZW5AbmV0d29ya3BsdW1iZXIub3JnPg0KPiC3osvNyrG85DogMjAyNsTqNdTCMjDI1SAyMzow
Nw0KPiDK1bz+yMs6IEZlaWZlaSBXYW5nIDx3ZmZfbGlnaHRAdmlwLjE2My5jb20+DQo+ILOty806
IGRldkBkcGRrLm9yZzsgd2FuZ2ZlaWZlaSAoSikgPHdhbmdmZWlmZWk0MEBodWF3ZWkuY29tPg0K
PiDW98ziOiBSZTogW1YxIDEvMV0gbmV0L2hpbmljMzogQWRkIFZYTEFOIFRTTyBmdW5jdGlvbg0K
PiANCj4gT24gV2VkLCAyMCBNYXkgMjAyNiAxNDo1ODoxNSArMDgwMA0KPiBGZWlmZWkgV2FuZyA8
d2ZmX2xpZ2h0QHZpcC4xNjMuY29tPiB3cm90ZToNCj4gDQo+ID4gVGhlIFJURV9FVEhfVFhfT0ZG
TE9BRF9WWExBTl9UTkxfVFNPIGZsYWcgaXMgYWRkZWQgdG8gc3VwcG9ydCB0aGUNCj4gPiBWWExB
TiBUU08gZnVuY3Rpb24NCj4gPg0KPiA+IFNpZ25lZC1vZmYtYnk6IEZlaWZlaSBXYW5nIDx3YW5n
ZmVpZmVpNDBAaHVhd2VpLmNvbT4NCj4gPiAtLS0NCj4gDQo+IFlvdSBuZWVkIHRvIGRvIG1vcmUg
dGhhbiBqdXN0IGFkdmVydGlzZSB0aGUgY2FwYWJpbGl0eSB0byBnZXQgdGhlIGRyaXZlciB0bw0K
PiBhY3R1YWxseSB3b3JrIHJpZ2h0Lg0KPiANCj4gQUkgZXhwbGFuYXRpb246DQo+IA0KPiBFcnJv
cjogVlhMQU4gVFNPIGlzIGFkdmVydGlzZWQgdW5jb25kaXRpb25hbGx5IGJ1dCB0aGUgdW5kZXJs
eWluZyBoYXJkd2FyZQ0KPiBmZWF0dXJlIGlzIG5vdC4gVGhlIHBhdGNoIGFkZHMgUlRFX0VUSF9U
WF9PRkZMT0FEX1ZYTEFOX1ROTF9UU08gdG8gdGhlDQo+IHVuY29uZGl0aW9uYWwgdHhfb2ZmbG9h
ZF9jYXBhIGFzc2lnbm1lbnQgaW4gaGluaWMzX2Rldl9pbmZvc19nZXQoKSwgYnV0IHRoZSBUeA0K
PiBwYXRoIGluIGRyaXZlcnMvbmV0L2hpbmljMy9oaW5pYzNfdHguYzozMDYtMzEzIHJlamVjdHMg
ZXZlcnkgVlhMQU4gdHVubmVsIG1idWYNCj4gd2hlbiB0aGUgaGFyZHdhcmUgZG9lcyBub3QgaGF2
ZSBOSUNfRl9WWExBTl9PRkZMT0FEOg0KW0ZlaWZlaV0gVGhhbmtzIGZvciB5b3VyIHJldmlld2lu
Zy4gQWJvdmUgY29tbWVudCBpcyB2YWx1YWJsZSwgd2UgaWdub3JlIHRoaXMuDQpJbiB0aGUgbmV4
dCB2ZXJzaW9uLCB3ZSB3aWxsIGNoYW5nZSBhcyBiZWxvdzoNCg0KaWYgKEhJTklDM19TVVBQT1JU
X1ZYTEFOX09GRkxPQUQobmljX2RldikpDQoJaW5mby0+dHhfb2ZmbG9hZF9jYXBhIHw9IFJURV9F
VEhfVFhfT0ZGTE9BRF9WWExBTl9UTkxfVFNPDQo=
