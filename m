Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2C8DBE98E0F
	for <dpdk-dev@archiver.kernel.org>; Mon, 23 Feb 2026 09:39:08 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id EE7614025E;
	Mon, 23 Feb 2026 10:39:06 +0100 (CET)
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com
 [185.176.79.56]) by mails.dpdk.org (Postfix) with ESMTP id 6D0A1400EF
 for <dev@dpdk.org>; Mon, 23 Feb 2026 10:39:05 +0100 (CET)
Received: from mail.maildlp.com (unknown [172.18.224.107])
 by frasgout.his.huawei.com (SkyGuard) with ESMTPS id 4fKG4z6XGnzJ46Bv
 for <dev@dpdk.org>; Mon, 23 Feb 2026 17:38:43 +0800 (CST)
Received: from dubpeml100002.china.huawei.com (unknown [7.214.144.156])
 by mail.maildlp.com (Postfix) with ESMTPS id A19A540571
 for <dev@dpdk.org>; Mon, 23 Feb 2026 17:39:03 +0800 (CST)
Received: from dubpeml500001.china.huawei.com (7.214.147.241) by
 dubpeml100002.china.huawei.com (7.214.144.156) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.36; Mon, 23 Feb 2026 09:39:03 +0000
Received: from dubpeml500001.china.huawei.com ([7.214.147.241]) by
 dubpeml500001.china.huawei.com ([7.214.147.241]) with mapi id 15.02.1544.011; 
 Mon, 23 Feb 2026 09:39:03 +0000
From: Konstantin Ananyev <konstantin.ananyev@huawei.com>
To: Harsh raj Singh <singhharshraj215@gmail.com>
CC: "dev@dpdk.org" <dev@dpdk.org>
Subject: RE: [PATCH v2] examples/l2fwd_acl: add ACL-based L2 forwarding example
Thread-Topic: [PATCH v2] examples/l2fwd_acl: add ACL-based L2 forwarding
 example
Thread-Index: AQHcpJoy6v8gNuKQHku1Udn2C3f3frWP9o0ggAAJigCAAAUmIA==
Date: Mon, 23 Feb 2026 09:39:03 +0000
Message-ID: <88880ecbc9944f39b23654b5ac2f27fb@huawei.com>
References: <CAN33txFiMRpKpdEat+P+tqQmn4POTY3XafJRxnkjj6BAY6sAnw@mail.gmail.com>
 <8dd2059525774ff0b4af2258caa64891@huawei.com>
 <CAN33txFwhtZR4A8MfoHOMYmuVTTCxjDo6feRVfP1BFA40rmiZA@mail.gmail.com>
In-Reply-To: <CAN33txFwhtZR4A8MfoHOMYmuVTTCxjDo6feRVfP1BFA40rmiZA@mail.gmail.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.45.150.25]
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

DQoNCj5UaGFua3MgZm9yIHRoZSByZXZpZXcuDQo+VGhlIGludGVudGlvbiBvZiB0aGlzIGV4YW1w
bGUgaXMgbm90IHRvIHJlcGxhY2UgdGhlIGV4aXN0aW5nIGwzZndkIEFDTCBtb2RlLCBidXQgdG8g
cHJvdmlkZSBhIG1pbmltYWwgYW5kIGVhc2llciBzdGFydGluZyBwb2ludCBmb3IgPnVzZXJzIHdo
byB3YW50IHRvIHVuZGVyc3RhbmQgaG93IHRvIHVzZSB0aGUgRFBESyBBQ0wgbGlicmFyeSBpbiBp
c29sYXRpb24uDQoNCkZvciB0aGF0IHRoaW5nLCBJIHRoaW5rICB3ZSBkbyBoYXZlIGFuIEFDTCBV
VDogYXBwL3Rlc3QvKmFjbCoNCg0KPlRoZSBsM2Z3ZCBhcHBsaWNhdGlvbiBpcyBxdWl0ZSBsYXJn
ZSBhbmQgaW5jbHVkZXMgZnVsbCBMMyBmb3J3YXJkaW5nIGxvZ2ljLCByb3V0aW5nIHRhYmxlcywg
bXVsdGlwbGUgbG9va3VwIHBhdGhzLCBhbmQgdmFyaW91cyA+Y29uZmlndXJhdGlvbiBvcHRpb25z
LiBCZWNhdXNlIG9mIHRoYXQsIGl0IGNhbiBiZSBkaWZmaWN1bHQgZm9yIG5ldyB1c2VycyB0byBp
ZGVudGlmeSB0aGUgc3BlY2lmaWMgc3RlcHMgcmVxdWlyZWQgdG8NCj5kZWZpbmUgQUNMIGZpZWxk
cywgY3JlYXRlIGFuZCBidWlsZCBhbiBBQ0wgY29udGV4dCwgaW5zZXJ0IHJ1bGVzLCBhbmQgcGVy
Zm9ybSBjbGFzc2lmaWNhdGlvbiBvbiBwYWNrZXRzLg0KPlRoaXMgZXhhbXBsZSBmb2N1c2VzIG9u
bHkgb24gZGVtb25zdHJhdGluZyBBQ0wgdXNhZ2UgaW4gYSBzbWFsbCwgc2VsZi1jb250YWluZWQg
cHJvZ3JhbSwgd2l0aG91dCByb3V0aW5nIG9yIGNvbXBsZXggZm9yd2FyZGluZyA+bG9naWMuIFRo
ZSBnb2FsIGlzIHRvIG1ha2UgaXQgZWFzaWVyIGZvciBiZWdpbm5lcnMgdG8gbGVhcm4gaG93IEFD
TCBjbGFzc2lmaWNhdGlvbiB3b3JrcyBiZWZvcmUgaW50ZWdyYXRpbmcgaXQgaW50byBsYXJnZXIg
YXBwbGljYXRpb25zLg0KPklmIHRoZSBtYWludGFpbmVycyBmZWVsIHRoYXQgdGhpcyB1c2UgY2Fz
ZSBpcyBhbHJlYWR5IHN1ZmZpY2llbnRseSBjb3ZlcmVkIGJ5IGV4aXN0aW5nIGV4YW1wbGVzLCBJ
4oCZbSBoYXBweSB0byBhZGp1c3Qgb3IgaW1wcm92ZSB0aGUgcGF0Y2ggPmFjY29yZGluZ2x5Lg0K
DQpJIGRvbid0IHRoaW5rIHRoZXJlIGlzIGEgbmVlZCB0byBpbnRyb2R1Y2UgYSBuZXcgc2FtcGxl
IGFwcCBqdXN0IGZvciB0aGF0Lg0KRmVlbCBmcmVlIHRvIHN1Ym1pdCBhIHBhdGNoIHRoYXQgaW1w
cm92ZXMgbDNmd2QgZG9jcyBhbmQvb3IgY29tbWVudHMgdG8gbWFrZQ0KSXQgZWFzaWVyIGZvciBu
ZXdjb21lcnMgdG8gdW5kZXJzdGFuZCBpdC4NCg0KT24gYSBzbGlnaHRseSBkaWZmZXJlbnQgc3Vi
amVjdDoNCndoZW4geW91IHJlcGx5aW5nIHRvIHBhdGNoJ3MgY29tbWVudHMgLSBkb24ndCBmb3Jn
ZXQgdG8gaGl0ICdyZXBseSBhbGwnIGJ1dHRvbiwNCmFuZCBwbGVhc2UgdXNlIHBsYWluLXRleHQg
Zm9ybWF0Lg0KDQpUaGFua3MNCktvbnN0YW50aW4NCg0KIA0KDQo=
