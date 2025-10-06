Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8D290CCA470
	for <dpdk-dev@archiver.kernel.org>; Mon,  6 Oct 2025 18:26:10 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id BCB37402E2;
	Mon,  6 Oct 2025 20:26:09 +0200 (CEST)
Received: from dkmailrelay1.smartsharesystems.com
 (smartserver.smartsharesystems.com [77.243.40.215])
 by mails.dpdk.org (Postfix) with ESMTP id 9B8AD402D1
 for <dev@dpdk.org>; Mon,  6 Oct 2025 20:26:08 +0200 (CEST)
Received: from smartserver.smartsharesystems.com
 (smartserver.smartsharesys.local [192.168.4.10])
 by dkmailrelay1.smartsharesystems.com (Postfix) with ESMTP id 59663202CC;
 Mon,  6 Oct 2025 20:26:08 +0200 (CEST)
Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="UTF-8"
Content-Transfer-Encoding: base64
Subject: RE: [PATCH] mbuf: optimize segment prefree
Date: Mon, 6 Oct 2025 20:26:07 +0200
Message-ID: <98CBD80474FA8B44BF855DF32C47DC35F654A4@smartserver.smartshare.dk>
In-Reply-To: <9428c18d-fec7-4400-a4f3-b2614b7fb058@arm.com>
X-MimeOLE: Produced By Microsoft Exchange V6.5
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: [PATCH] mbuf: optimize segment prefree
Thread-Index: Adw26RcZ5J7PxMnfSeqap9LT4lkILAABCgZQ
References: <20250827213535.21602-1-mb@smartsharesystems.com>
 <20250827161726.24cebd9c@hermes.local>
 <9428c18d-fec7-4400-a4f3-b2614b7fb058@arm.com>
From: =?UTF-8?B?TW9ydGVuIEJyw7hydXA=?= <mb@smartsharesystems.com>
To: "Wathsala Vithanage" <wathsala.vithanage@arm.com>,
 <stephen@networkplumber.org>
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

PiBGcm9tOiBXYXRoc2FsYSBWaXRoYW5hZ2UgW21haWx0bzp3YXRoc2FsYS52aXRoYW5hZ2VAYXJt
LmNvbV0NCj4gU2VudDogTW9uZGF5LCA2IE9jdG9iZXIgMjAyNSAxOS40Ng0KPiANCj4gT24gOC8y
Ny8yNSAxODoxNywgU3RlcGhlbiBIZW1taW5nZXIgd3JvdGU6DQo+ID4gT24gV2VkLCAyNyBBdWcg
MjAyNSAyMTozNTozNCArMDAwMA0KPiA+IE1vcnRlbiBCcsO4cnVwIDxtYkBzbWFydHNoYXJlc3lz
dGVtcy5jb20+IHdyb3RlOg0KPiA+DQo+ID4+DQo+ID4+ICsvKiBHQ0Mgb25seSBvcHRpbWl6ZXMg
c2luZ2xlLWJpdCBNU0IgdGVzdHMgdGhpcyB3YXksIHNvIGRvIGl0IGJ5DQo+IGhhbmQgd2l0aCBt
dWx0aS1iaXQuICovDQo+ID4+ICsjaWYgZGVmaW5lZChSVEVfVE9PTENIQUlOX0dDQykgJiYgZGVm
aW5lZChSVEVfQVJDSF9YODYpDQo+ID4+ICsjdW5kZWYgUlRFX01CVUZfRElSRUNUDQo+ID4+ICsj
ZGVmaW5lIFJURV9NQlVGX0RJUkVDVChtYikgXA0KPiA+PiArCSghKCgoY29uc3QgdWludDhfdCAq
KShtYikpW29mZnNldG9mKHN0cnVjdCBydGVfbWJ1Ziwgb2xfZmxhZ3MpICsNCj4gN10gJiBcDQo+
ID4+ICsJKHVpbnQ4X3QpKChSVEVfTUJVRl9GX0lORElSRUNUIHwgUlRFX01CVUZfRl9FWFRFUk5B
TCkgPj4gNTYpKSkNCj4gPj4gKyNlbmRpZg0KPiA+IENvbXBsZXggZW5vdWdoIGV4cHJlc3Npb24g
dGhhdCBJIHdvdWxkIHByZWZlciB0aGlzIGJlIGFuIGlubGluZQ0KPiBmdW5jdGlvbg0KPiA+IHdp
dGggc29tZSBtb3JlIHRlbXBvcmFyeSB2YXJpYWJsZXMgYW5kIG1vcmUgY29tbWVudHMuDQo+ID4g
TGlrZSB0aGUgbWFnaWMgNyBmb3IgbWFzaz8/DQo+IA0KPiArMQ0KDQpTbywgaW5zdGVhZCBvZiBv
dmVycmlkaW5nIHRoZSBtYWNybyBkZWZpbml0aW9uIGluIHRoZSBHQ0MgZXhjZXB0aW9uIGNhc2Us
IHlvdSBwcmVmZXIgc29tZXRoaW5nIGxpa2U6DQojaWYgZGVmaW5lZChSVEVfVE9PTENIQUlOX0dD
QykgJiYgZGVmaW5lZChSVEVfQVJDSF9YODYpDQpzdGF0aWMgX19ydGVfYWx3YXlzX2lubGluZQ0K
UlRFX01CVUZfRElSRUNUKGNvbnN0IHN0cnVjdCBydGVfbWJ1ZiAqIGNvbnN0IG1iKQ0Key4uLn0N
CiNlbHNlDQojZGVmaW5lIFJURV9NQlVGX0RJUkVDVChtYikgXA0KCSghKChtYiktPm9sX2ZsYWdz
ICYgKFJURV9NQlVGX0ZfSU5ESVJFQ1QgfCBSVEVfTUJVRl9GX0VYVEVSTkFMKSkpDQojZW5kaWYN
Cg0Kd2hpY2ggd291bGQgZ2l2ZSB1cyBhIGZ1bmN0aW9uIHdpdGggYSBtYWNyby1saWtlICh1cHBl
ciBjYXNlKSBuYW1lLg0KDQpIb3cgYWJvdXQgSSBqdXN0IGFkZCBhIG1vcmUgZGV0YWlsZWQgZGVz
Y3JpcHRpb24gdG8gdGhpcyBtYWNybz8NCkFmdGVyIGFsbCwgZm9ybWFsbHksIGl0J3MgYW4gZXhj
ZXB0aW9uIHRvIHRoZSBzaW1wbGUgZGVmYXVsdCBtYWNyby4NCg0K
