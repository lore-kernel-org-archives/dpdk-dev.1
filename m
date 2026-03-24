Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5CBD2F532C6
	for <dpdk-dev@archiver.kernel.org>; Tue, 24 Mar 2026 01:19:40 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 5FCAD402D6;
	Tue, 24 Mar 2026 02:19:39 +0100 (CET)
Received: from canpmsgout08.his.huawei.com (canpmsgout08.his.huawei.com
 [113.46.200.223])
 by mails.dpdk.org (Postfix) with ESMTP id AC4DF4027C
 for <dev@dpdk.org>; Tue, 24 Mar 2026 02:19:37 +0100 (CET)
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
 c=relaxed/relaxed; q=dns/txt; h=From;
 bh=LplACXsJDcHEZ1W4OUM0apKoQF26Aw+hdFOvVJAm82I=;
 b=L6CNP+EA4x2ZAOX8zG6Ry48G5ovz9LixsuKRouui9U5uvVO1dWqOYNUMaC5BLHuFM7c8/8TI7
 X/UzTQHJLpkmU/31fu+HMBP7f6tErUg1UTiXHblCHrreaM3QATZUP5uHV+ICU0T02CD/Xu+PCnu
 5srY1w0yGyvLnlsa5dKobq0=
Received: from mail.maildlp.com (unknown [172.19.163.214])
 by canpmsgout08.his.huawei.com (SkyGuard) with ESMTPS id 4ffsVd3LLMzmV6d;
 Tue, 24 Mar 2026 09:13:29 +0800 (CST)
Received: from dggemv705-chm.china.huawei.com (unknown [10.3.19.32])
 by mail.maildlp.com (Postfix) with ESMTPS id A83554056C;
 Tue, 24 Mar 2026 09:19:35 +0800 (CST)
Received: from kwepemn200018.china.huawei.com (7.202.194.141) by
 dggemv705-chm.china.huawei.com (10.3.19.32) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Tue, 24 Mar 2026 09:19:35 +0800
Received: from kwepemn500008.china.huawei.com (7.202.194.149) by
 kwepemn200018.china.huawei.com (7.202.194.141) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Tue, 24 Mar 2026 09:19:35 +0800
Received: from kwepemn500008.china.huawei.com ([7.202.194.149]) by
 kwepemn500008.china.huawei.com ([7.202.194.149]) with mapi id 15.02.1544.011; 
 Tue, 24 Mar 2026 09:19:35 +0800
From: "wangfeifei (J)" <wangfeifei40@huawei.com>
To: Stephen Hemminger <stephen@networkplumber.org>, Feifei Wang
 <wff_light@vip.163.com>
CC: "dev@dpdk.org" <dev@dpdk.org>, zengweiliang zengweiliang
 <zengweiliang.zengweiliang@huawei.com>, "chenyi (CY)" <chenyi221@huawei.com>
Subject: =?gb2312?B?u9i4tDogW1BBVENIIHY3IDcvN10gbmV0L2hpbmljMzogdXNlIGRpZmZlcmVu?=
 =?gb2312?Q?t_callback_func_to_support_htn_fdir?=
Thread-Topic: [PATCH v7 7/7] net/hinic3: use different callback func to
 support htn fdir
Thread-Index: AQHcupvVBO9IzZRIck2qdqSUMoaEzbW8AV2AgADhwrA=
Date: Tue, 24 Mar 2026 01:19:34 +0000
Message-ID: <0f6f86ce936248d59f146bcb291bedb9@huawei.com>
References: <20260316134335.1640-1-wff_light@vip.163.com>
 <20260323080455.2699-1-wff_light@vip.163.com>
 <20260323080455.2699-8-wff_light@vip.163.com>
 <20260323125049.1ae8d1bb@phoenix.local>
In-Reply-To: <20260323125049.1ae8d1bb@phoenix.local>
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
ZXBoZW5AbmV0d29ya3BsdW1iZXIub3JnPg0KPiC3osvNyrG85DogMjAyNsTqM9TCMjTI1SAzOjUx
DQo+IMrVvP7IyzogRmVpZmVpIFdhbmcgPHdmZl9saWdodEB2aXAuMTYzLmNvbT4NCj4gs63LzTog
ZGV2QGRwZGsub3JnOyB3YW5nZmVpZmVpIChKKSA8d2FuZ2ZlaWZlaTQwQGh1YXdlaS5jb20+DQo+
INb3zOI6IFJlOiBbUEFUQ0ggdjcgNy83XSBuZXQvaGluaWMzOiB1c2UgZGlmZmVyZW50IGNhbGxi
YWNrIGZ1bmMgdG8gc3VwcG9ydCBodG4NCj4gZmRpcg0KPiANCj4gT24gTW9uLCAyMyBNYXIgMjAy
NiAxNjowNDo1MCArMDgwMA0KPiBGZWlmZWkgV2FuZyA8d2ZmX2xpZ2h0QHZpcC4xNjMuY29tPiB3
cm90ZToNCj4gDQo+ID4NCj4gPiArCWlmIChuaWNfZGV2LT5mZWF0dXJlX2NhcCAmIE5JQ19GX0hU
Tl9DTURRKSB7DQo+ID4gKwkJcnNzX3R5cGUuaXB2Nl9leHQgPSAocnNzX2hmICYgUlRFX0VUSF9S
U1NfSVBWNl9FWCkgPyAxIDogMDsNCj4gPiArCQlyc3NfdHlwZS50Y3BfaXB2Nl9leHQgPSAocnNz
X2hmICYgUlRFX0VUSF9SU1NfSVBWNl9UQ1BfRVgpID8gMSA6IDA7DQo+ID4gKwl9IGVsc2Ugew0K
PiA+ICsJCXJzc190eXBlLmlwdjZfZXh0ID0gMDsNCj4gPiArCQlyc3NfdHlwZS5pcHY2X2V4dCA9
IDA7DQo+ID4gKwl9DQo+ID4gKw0KPiANCj4gT3ZlcmFsbCBBSSByZXZpZXcgaXMgZ29vZCwgYnV0
Og0KPiANCj4gT25lIGlzc3VlIHJlbWFpbnMgZnJvbSBWNjoNCj4gUGF0Y2ggNy83OiBuZXQvaGlu
aWMzOiB1c2UgZGlmZmVyZW50IGNhbGxiYWNrIGZ1bmMgdG8gc3VwcG9ydCBodG4gZmRpciBUaGUN
Cj4gY29weS1wYXN0ZSBidWcgaW4gaGluaWMzX2luaXRfcnNzX3R5cGUoKSBpcyBzdGlsbCBwcmVz
ZW50Lg0KPiBUaGUgaGluaWMzX3Jzc19oYXNoX3VwZGF0ZSgpIGluc3RhbmNlIHdhcyBmaXhlZCBi
dXQNCj4gaGluaWMzX2luaXRfcnNzX3R5cGUoKSBzdGlsbCBoYXM6DQo+IA0KPiByc3NfdHlwZS5p
cHY2X2V4dCA9IDA7DQo+IHJzc190eXBlLmlwdjZfZXh0ID0gMDsNCj4gDQo+IFRoZSBzZWNvbmQg
bGluZSBzaG91bGQgYmUgcnNzX3R5cGUudGNwX2lwdjZfZXh0ID0gMC4NCj4gVGhpcyB3YXMgcmVw
b3J0ZWQgaW4gYm90aCB0aGUgVjIgYW5kIFY2IHJldmlld3MuDQpbRmVpZmVpXSBTb3JyeSB0byBp
Z25vcmUgdGhpcywgd2Ugd2lsbCBmaXggdGhpcyBpbiB0aGUgbmV4dCB2ZXJzaW9uLg0K
