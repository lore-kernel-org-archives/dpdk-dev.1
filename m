Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2AF35C369AB
	for <dpdk-dev@archiver.kernel.org>; Sat, 19 Apr 2025 02:53:03 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id EE3C74028B;
	Sat, 19 Apr 2025 04:53:01 +0200 (CEST)
Received: from szxga04-in.huawei.com (szxga04-in.huawei.com [45.249.212.190])
 by mails.dpdk.org (Postfix) with ESMTP id 05A0B4027A
 for <dev@dpdk.org>; Sat, 19 Apr 2025 04:52:59 +0200 (CEST)
Received: from mail.maildlp.com (unknown [172.19.88.163])
 by szxga04-in.huawei.com (SkyGuard) with ESMTP id 4Zfbgs2tdFz2CcjP;
 Sat, 19 Apr 2025 10:49:29 +0800 (CST)
Received: from dggpemf200013.china.huawei.com (unknown [7.185.36.181])
 by mail.maildlp.com (Postfix) with ESMTPS id DB61418005F;
 Sat, 19 Apr 2025 10:52:56 +0800 (CST)
Received: from kwepemn500008.china.huawei.com (7.202.194.149) by
 dggpemf200013.china.huawei.com (7.185.36.181) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Sat, 19 Apr 2025 10:52:56 +0800
Received: from kwepemn500008.china.huawei.com ([7.202.194.149]) by
 kwepemn500008.china.huawei.com ([7.202.194.149]) with mapi id 15.02.1544.011; 
 Sat, 19 Apr 2025 10:52:56 +0800
From: "wangfeifei (J)" <wangfeifei40@huawei.com>
To: Stephen Hemminger <stephen@networkplumber.org>, Feifei Wang
 <wff_light@vip.163.com>
CC: "dev@dpdk.org" <dev@dpdk.org>, "chenyi (CY)" <chenyi221@huawei.com>,
 "Wangxin(kunpeng)" <wangxin679@h-partners.com>, zengweiliang zengweiliang
 <zengweiliang.zengweiliang@huawei.com>, "Dumin(Dumin,KunPeng)"
 <dumin3@huawei.com>
Subject: =?gb2312?B?u9i4tDogW1JGQyAxOC8xOF0gZHJpdmVycy9uZXQ6IGFkZCBoaW5pYzMgUE1E?=
 =?gb2312?Q?_build_and_doc_files?=
Thread-Topic: [RFC 18/18] drivers/net: add hinic3 PMD build and doc files
Thread-Index: AQHbsEFa8yws4BJKNE6gfwJpkWDcurOpJk4AgAEkqqA=
Date: Sat, 19 Apr 2025 02:52:56 +0000
Message-ID: <f5ef2df2fa8844c7acaac5ff1d41a826@huawei.com>
References: <20250418090621.9638-1-wff_light@vip.163.com>
 <20250418090621.9638-19-wff_light@vip.163.com>
 <20250418102230.1e4132a1@hermes.local>
In-Reply-To: <20250418102230.1e4132a1@hermes.local>
Accept-Language: en-US
Content-Language: zh-CN
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.48.40.191]
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

DQoNCi0tLS0t08q8/tStvP4tLS0tLQ0Kt6K8/sjLOiBTdGVwaGVuIEhlbW1pbmdlciA8c3RlcGhl
bkBuZXR3b3JrcGx1bWJlci5vcmc+IA0Kt6LLzcqxvOQ6IDIwMjXE6jTUwjE5yNUgMToyMw0KytW8
/sjLOiBGZWlmZWkgV2FuZyA8d2ZmX2xpZ2h0QHZpcC4xNjMuY29tPg0Ks63LzTogZGV2QGRwZGsu
b3JnOyBjaGVueWkgKENZKSA8Y2hlbnlpMjIxQGh1YXdlaS5jb20+OyBXYW5neGluKGt1bnBlbmcp
IDx3YW5neGluNjc5QGgtcGFydG5lcnMuY29tPjsgd2FuZ2ZlaWZlaSAoSikgPHdhbmdmZWlmZWk0
MEBodWF3ZWkuY29tPg0K1vfM4jogUmU6IFtSRkMgMTgvMThdIGRyaXZlcnMvbmV0OiBhZGQgaGlu
aWMzIFBNRCBidWlsZCBhbmQgZG9jIGZpbGVzDQoNCk9uIEZyaSwgMTggQXByIDIwMjUgMTc6MDY6
MDQgKzA4MDANCkZlaWZlaSBXYW5nIDx3ZmZfbGlnaHRAdmlwLjE2My5jb20+IHdyb3RlOg0KDQo+
ICtjZmxhZ3MgKz0gWw0KPiArICAgICctREhXX0NPTlZFUlRfRU5ESUFOJywNCj4gKyAgICAnLURf
X0hJTklDX0hVQVdFSV9TRUNVUkVDX18nLA0KPiArICAgICctZlBJQycsDQo+ICsgICAgJy1mc3Rh
Y2stcHJvdGVjdG9yLXN0cm9uZycsDQo+ICtdDQoNCldoYXQgaXMgdGhpcz8NClNob3VsZCBub3Qg
ZW5hYmxlIFBJQyBvciBzdGFjay1wcm90ZWN0b3IgYXQgdGhlIGRyaXZlciBsZXZlbC4NCkkgYXNz
dW1lIHRoZSBvdGhlciBzdHVmZiBpcyBodWF3ZWkgc3BlY2lmaWMgY29tcGlsZXIgZmxhZ3MuDQoN
CltGZWlmZWldIEdvdCBpdC4gV2Ugd2lsbCByZW1vdmUgdGhpcywgYW5kIHNob3VsZCBrZWVwIGl0
IHRoZSBzYW1lIGFzIGdlbmVyaWMgd2F5Lg0KDQo+ICtpZiBhcmNoX3N1YmRpciA9PSAnYXJtJyBh
bmQgZHBka19jb25mLmdldCgnUlRFX0FSQ0hfNjQnKQ0KPiArICAgIGNmbGFncyArPSBbJy1EX19B
Uk02NF9ORU9OX18nXQ0KPiArZWxzZQ0KPiArICAgIGNmbGFncyArPSBbJy1EX19YODZfNjRfU1NF
X18nXQ0KPiArZW5kaWYNCg0KDQpUaGlzIHNob3VsZCBhbHJlYWR5IGJlIGhhbmRsZWQgaW4gdGhl
IGV4aXN0aW5nIERQREsgbWVzb24gc3R1ZmYuDQpEb2luZyBpdCBhdCBhIHBlci1kcml2ZXIgbGV2
ZWwgc2VlbXMgd3JvbmcuDQpbRmVpZmVpXSBBZ3JlZSwgdGhlIG5leHQgdmVyc2lvbiB3ZSB3aWxs
IGZpeC4NCg==
