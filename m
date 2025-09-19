Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 42CCFCAC59A
	for <dpdk-dev@archiver.kernel.org>; Fri, 19 Sep 2025 07:57:22 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 3208640654;
	Fri, 19 Sep 2025 09:57:21 +0200 (CEST)
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
 by mails.dpdk.org (Postfix) with ESMTP id 05F61402B7
 for <dev@dpdk.org>; Fri, 19 Sep 2025 09:57:20 +0200 (CEST)
Received: from mail.maildlp.com (unknown [172.19.162.254])
 by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4cSl9Y72bnz13Mrg;
 Fri, 19 Sep 2025 15:53:05 +0800 (CST)
Received: from kwepemk100008.china.huawei.com (unknown [7.202.194.56])
 by mail.maildlp.com (Postfix) with ESMTPS id 1F23118048B;
 Fri, 19 Sep 2025 15:57:18 +0800 (CST)
Received: from kwepemn500008.china.huawei.com (7.202.194.149) by
 kwepemk100008.china.huawei.com (7.202.194.56) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Fri, 19 Sep 2025 15:57:17 +0800
Received: from kwepemn500008.china.huawei.com ([7.202.194.149]) by
 kwepemn500008.china.huawei.com ([7.202.194.149]) with mapi id 15.02.1544.011; 
 Fri, 19 Sep 2025 15:57:17 +0800
From: "wangfeifei (J)" <wangfeifei40@huawei.com>
To: Feifei Wang <wff_light@vip.163.com>, "dev@dpdk.org" <dev@dpdk.org>
CC: Stephen Hemminger <stephen@networkplumber.org>, Fengchengwen
 <fengchengwen@huawei.com>
Subject: =?gb2312?B?u9i4tDogW1YxMSAxMy8xOF0gbmV0L2hpbmljMzogYWRkIGRldiBvcHM=?=
Thread-Topic: [V11 13/18] net/hinic3: add dev ops
Thread-Index: AQHcJ7wuN794AWLy4UqpscF89UyVNbSYIEuw
Date: Fri, 19 Sep 2025 07:57:17 +0000
Message-ID: <d35c295d99aa46acb4c70ef7a1972e60@huawei.com>
References: <20250418090621.9638-1-wff_light@vip.163.com>
 <20250917101604.17045-1-wff_light@vip.163.com>
 <20250917101604.17045-14-wff_light@vip.163.com>
In-Reply-To: <20250917101604.17045-14-wff_light@vip.163.com>
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

DQo+ICsNCj4gKy8qKg0KPiArICogQ2xlYXIgdGhlIHJlZmVyZW5jZSB0byB0aGUgY29weSBtZW1v
cnkgcG9vbCB3aXRob3V0IGZyZWVpbmcgaXQuDQo+ICsgKg0KPiArICogQHBhcmFtW2luXSBuaWNf
ZGV2DQo+ICsgKiBQb2ludGVyIHRvIE5JQyBkZXZpY2Ugc3RydWN0dXJlLg0KPiArICovDQo+ICtz
dGF0aWMgdm9pZA0KPiAraGluaWMzX2NvcHlfbWVtcG9vbF91bmluaXQoc3RydWN0IGhpbmljM19u
aWNfZGV2ICpuaWNfZGV2KQ0KPiArew0KPiArCW5pY19kZXYtPmNweV9tcG9vbCA9IE5VTEw7DQo+
ICt9DQo+ICsNCj4gKy8qKg0KW0ZlaWZlaV0gSGmjrFN0ZXBoZW4uIA0KRm9yIGNweSBtYnVmLCB3
ZSBkbyBub3QgY2hhbmdlIHRoaXMgaW4gdGhpcyB2ZXJzaW9uLiBSZWFzb25zIGFyZSBhcyBmb2xs
b3dzOg0KDQpGb3IgSHVhd2VpIFNQeCBOSUMsIG9uZSBtdHUgcGt0IHNlZyBtYXggaXMgMzguDQox
LiBpbiBubyB0c28gY2FzZSwgd2UgY2FuIHVzZSAnbmJfbXR1X3NlZ19tYXggPSAzOCcgIHRvIHJl
c3RyaWN0IHVzZXIgbm90IHRvIHVzZSBtdWNoIG5iIHNlZ3MuIA0KMi4gaW4gdHNvIGNhc2UsIEh1
YXdlaSBTUHggTklDIGNhbiBzdXBwb3J0IDEyNyBzZWdzIHdpdGggZWFjaCBjb250aW51b3VzIDM4
IHNlZ3MgdG90YWxfbGVuZ3RoIG11c3QgYmUgbW9yZSB0aGFuIE1UVS4NCg0KVGh1cyB0aGVyZSB3
aWxsIGJlIGEgY2FzZSwgdXNlcnMgZ2l2ZSBkcml2ZXIgYSBtYnVmIGNoYWluIHdpdGggMTI3IHNl
Z3MsIGJ1dCBlYWNoIHNlZyBzaXplIGlzIHZlcnkgc21hbGwgKGZpcnN0IDM4IHNlZyBwa3QgbGVu
Z3RoIGlzIGxlc3MgdGhhbiBNVFUpLCBhbmQgaGUvc2hlIG9wZW4gdHNvIG9mZmxvYWQuDQpUaGVu
IGluIHRzbyBtb2RlLCBIdWF3ZWkgU1B4IE5JQyBzdGFydCBwcm9jZXNzaW5nIHBrdHMgd2hlbiB0
aGUgdG90YWxfbGVuZ3RoIHJlYWNoIE1UVSBsZW5ndGguDQoNCldoZW4gaXQgcHJvY2VzcyBmaXJz
dCBNVFUgcGFja2V0LCBpdCBmaW5kIGZpcnN0IDM4IHNlZyBwa3RzIGxlbmd0aCBpcyBsZXNzIHRo
YW4gTVRVLCB0byBtYWtlIHRoZSBwYWNrZXQgdG90YWwgbGVuZ3RoIGFjaGlldmUgTVRVIHNpemUs
IGFuIGV4dHJhIGNweSBtYnVmIGlzIG5lZWRlZCB0byByZXBsYWNlIHRoZSAzOHRoIG1idWYsDQpE
cml2ZXIgd2lsbCBjb250aW51ZSB0byBjb3B5IHN1YnNlcXVlbnQgc2VnIHBrdHMgdG8gdGhpcyBj
b3B5IG1idWYgdW50aWwgdG90YWwgbGVuZ3RoIG1vcmUgdGhhbiBNVFUgc2l6ZS4gDQo=
