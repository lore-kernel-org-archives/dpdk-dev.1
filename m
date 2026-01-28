Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 12199D35699
	for <dpdk-dev@archiver.kernel.org>; Wed, 28 Jan 2026 09:49:59 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id E843040274;
	Wed, 28 Jan 2026 10:49:58 +0100 (CET)
Received: from dkmailrelay1.smartsharesystems.com
 (smartserver.smartsharesystems.com [77.243.40.215])
 by mails.dpdk.org (Postfix) with ESMTP id 643AE400D7
 for <dev@dpdk.org>; Wed, 28 Jan 2026 10:49:57 +0100 (CET)
Received: from smartserver.smartsharesystems.com
 (smartserver.smartsharesys.local [192.168.4.10])
 by dkmailrelay1.smartsharesystems.com (Postfix) with ESMTP id A307E20143;
 Wed, 28 Jan 2026 10:49:55 +0100 (CET)
Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="UTF-8"
Content-Transfer-Encoding: base64
Subject: RE: [PATCH v1 2/3] net/af_packet: RX/TX rte_memcpy, bulk free,
 prefetch
Date: Wed, 28 Jan 2026 10:49:54 +0100
Message-ID: <98CBD80474FA8B44BF855DF32C47DC35F656BF@smartserver.smartshare.dk>
X-MimeOLE: Produced By Microsoft Exchange V6.5
In-Reply-To: <CAFn2buBzhD=+5fG44xVyVYvLdunSxK7hTUAqi8+acPqoLf508w@mail.gmail.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: [PATCH v1 2/3] net/af_packet: RX/TX rte_memcpy, bulk free,
 prefetch
Thread-Index: AdyP9Lo+i+Y7EycqQRm5p+7lMFM/rAAQpVBg
References: <20260127181355.98437-1-scott.k.mitch1@gmail.com>
 <20260127181355.98437-3-scott.k.mitch1@gmail.com>
 <20260127105440.267abdec@phoenix.local>
 <CAFn2buBzhD=+5fG44xVyVYvLdunSxK7hTUAqi8+acPqoLf508w@mail.gmail.com>
From: =?UTF-8?B?TW9ydGVuIEJyw7hydXA=?= <mb@smartsharesystems.com>
To: "Scott Mitchell" <scott.k.mitch1@gmail.com>,
 "Stephen Hemminger" <stephen@networkplumber.org>
Cc: <dev@dpdk.org>
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

PiA+ID4gLSBSZXBsYWNlIG1lbWNweSgpIHdpdGggcnRlX21lbWNweSgpIGZvciBvcHRpbWl6ZWQg
Y29weSBvcGVyYXRpb25zDQo+ID4gVGhlcmUgaXMgbm8gZ29vZCByZWFzb24gdGhhdCBydGVfbWVt
Y3B5KCkgc2hvdWxkIGJlIGZhc3RlciB0aGFuDQo+IG1lbWNweSgpLg0KPiA+IFRoZXJlIHdlcmUg
c29tZSBjYXNlcyBvYnNlcnZlZCB3aXRoIHZpcnRpbyBidXQgbXkgaHVuY2ggaXMgdGhhdCB0aGlz
DQo+IGlzDQo+ID4gYmVjYXVzZSB0aGUgdHdvIHJvdXRpbmVzIGFyZSBtYWtpbmcgZGlmZmVyZW50
IGFsaWdubWVudCBhc3N1bXB0aW9ucy4NCj4gDQo+IGFjay4gSSB3aWxsIGRyb3AgcnRlX21lbWNw
eS4NCg0KVGhlIGNvbW11bml0eSBpcyBpbmNyZWFzaW5nbHkgc2tlcHRpY2FsIGFib3V0IHVzaW5n
IHJ0ZV9tZW1jcHkoKSBpbnN0ZWFkIG9mIG1lbWNweSgpLg0KSSdtIG5vdCBzdXJlIGFsbCBEUERL
IGRvY3VtZW50YXRpb24gaGFzIGJlZW4gdXBkYXRlZCB0byByZWZsZWN0IHRoaXMgY2hhbmdlLCBi
dXQgbWlnaHQgc3RpbGwgcmVjb21tZW5kIHJ0ZV9tZW1jcHkoKS4NCg0KU28sIHNpbXBseSByZXBs
YWNpbmcgbWVtY3B5KCkgd2l0aCBydGVfbWVtY3B5KCkgaXMgbm8gbG9uZ2VyIGFjY2VwdGFibGUu
DQpIb3dldmVyLCBpZiB5b3UgYmFjayB1cCB0aGUgcmVwbGFjZW1lbnQgd2l0aCBwZXJmb3JtYW5j
ZSBkYXRhLCBpdCBpcyBtb3JlIGxpa2VseSB0byBnZXQgYWNjZXB0ZWQuDQoNCj4gVW5kZXIgd2hh
dCBzY2VuYXJpb3MgaXMgcnRlX21lbWNweSBwcmVmZXJyZWQvYmVuZWZpY2lhbD8NCg0KSSB3aXNo
IHNvbWVvbmUgaGFkIGFuIGFuc3dlciB0byB0aGF0IHF1ZXN0aW9uIQ0KVGhlIGJlc3QgSSBjYW4g
Y29tZSB1cCB3aXRoIGlzOg0KV2hlbiB1c2luZyBhbiBhbmNpZW50IGNvbXBpbGVyIG9yIEMgbGli
cmFyeSwgd2hlcmUgbWVtY3B5KCkgaXNuJ3QgcHJvcGVybHkgb3B0aW1pemVkLg0KDQpXaXRoIG1v
ZGVybiBjb21waWxlcnMgY2F0Y2hpbmcgdXAsIHJ0ZV9tZW1jcHkoKSBpcyBiZWNvbWluZyBpbmNy
ZWFzaW5nbHkgb2Jzb2xldGUuDQoNCkhlcmUncyBzb21lIGJhY2tncm91bmQgaW5mb3JtYXRpb24g
YWJvdXQgcnRlX21lbWNweSgpIGZyb20gMjAxNzoNCmh0dHBzOi8vd3d3LmludGVsLmNvbS9jb250
ZW50L3d3dy91cy9lbi9kZXZlbG9wZXIvYXJ0aWNsZXMvdGVjaG5pY2FsL3BlcmZvcm1hbmNlLW9w
dGltaXphdGlvbi1vZi1tZW1jcHktaW4tZHBkay5odG1sDQoNCklJUkMsIHRoZSBjb25jZXB0IG9m
IGEgc3BlY2lhbGl6ZWQgbWVtY3B5KCkgb3JpZ2luYXRlcyBmcm9tIHNvbWUgdmlkZW8gc3RyZWFt
aW5nIG9yIGdhbWluZyBjb2RlLCB3aGVyZSBodWdlIG1lbW9yeSBhcmVhcyB3ZXJlIGJlaW5nIGNv
cGllZCBhcm91bmQuDQoNCg==
