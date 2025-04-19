Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8C6D8C369AB
	for <dpdk-dev@archiver.kernel.org>; Sat, 19 Apr 2025 02:45:05 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 515294028B;
	Sat, 19 Apr 2025 04:45:04 +0200 (CEST)
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
 by mails.dpdk.org (Postfix) with ESMTP id 8AA154027A
 for <dev@dpdk.org>; Sat, 19 Apr 2025 04:45:02 +0200 (CEST)
Received: from mail.maildlp.com (unknown [172.19.162.254])
 by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4ZfbY63yt3zQwR7;
 Sat, 19 Apr 2025 10:43:38 +0800 (CST)
Received: from dggemv712-chm.china.huawei.com (unknown [10.1.198.32])
 by mail.maildlp.com (Postfix) with ESMTPS id 6CCBB18047E;
 Sat, 19 Apr 2025 10:45:00 +0800 (CST)
Received: from kwepemn200007.china.huawei.com (7.202.194.130) by
 dggemv712-chm.china.huawei.com (10.1.198.32) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Sat, 19 Apr 2025 10:45:00 +0800
Received: from kwepemn500008.china.huawei.com (7.202.194.149) by
 kwepemn200007.china.huawei.com (7.202.194.130) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Sat, 19 Apr 2025 10:44:59 +0800
Received: from kwepemn500008.china.huawei.com ([7.202.194.149]) by
 kwepemn500008.china.huawei.com ([7.202.194.149]) with mapi id 15.02.1544.011; 
 Sat, 19 Apr 2025 10:44:59 +0800
From: "wangfeifei (J)" <wangfeifei40@huawei.com>
To: Stephen Hemminger <stephen@networkplumber.org>, Feifei Wang
 <wff_light@vip.163.com>
CC: "dev@dpdk.org" <dev@dpdk.org>
Subject: =?gb2312?B?u9i4tDogW1JGQyAwMC8xOF0gYWRkIGhpbmljMyBQTUQgZHJpdmVy?=
Thread-Topic: [RFC 00/18] add hinic3 PMD driver
Thread-Index: AQHbsEFdKM8u4uunWkekFJQ+/7jQv7OpNfSAgAETcaA=
Date: Sat, 19 Apr 2025 02:44:59 +0000
Message-ID: <2560aa847b1f48aa9e3e335f7c15780e@huawei.com>
References: <20250418090621.9638-1-wff_light@vip.163.com>
 <20250418111831.09717389@hermes.local>
In-Reply-To: <20250418111831.09717389@hermes.local>
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
bkBuZXR3b3JrcGx1bWJlci5vcmc+IA0Kt6LLzcqxvOQ6IDIwMjXE6jTUwjE5yNUgMjoxOQ0KytW8
/sjLOiBGZWlmZWkgV2FuZyA8d2ZmX2xpZ2h0QHZpcC4xNjMuY29tPg0Ks63LzTogZGV2QGRwZGsu
b3JnDQrW98ziOiBSZTogW1JGQyAwMC8xOF0gYWRkIGhpbmljMyBQTUQgZHJpdmVyDQoNCk9uIEZy
aSwgMTggQXByIDIwMjUgMTc6MDU6NDYgKzA4MDANCkZlaWZlaSBXYW5nIDx3ZmZfbGlnaHRAdmlw
LjE2My5jb20+IHdyb3RlOg0KDQo+ICoqKiBCTFVSQiBIRVJFICoqKg0KPiBUaGUgaGluaWMzIFBN
RCAoKipsaWJydGVfbmV0X2hpbmljMyoqKSBwcm92aWRlcyBwb2xsIG1vZGUgZHJpdmVyIA0KPiBz
dXBwb3J0IGZvciAyNUdicHMvMTAwR2Jwcy8yMDBHYnBzIEh1YXdlaSBTUHggc2VyaWVzIE5ldHdv
cmsgQWRhcHRlcnMuDQoNCg0KWW91IGFyZSBzdXBwb3NlZCB0byByZW1vdmUgdGhlICIqKiogQkxV
UkIgSEVSRSAqKioiIHdoZW4gZWRpdGluZyB0aGUgY29tbWl0IG1lc3NhZ2UuDQpbRmVpZmVpXSBT
b3JyeSwgV2UgaWdub3JlIHRoaXMsIHRoZSBuZXh0IHZlcnNpb24gd2lsbCBmaXggaXQuDQo=
