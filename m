Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0DE5CC7EE2A
	for <dpdk-dev@archiver.kernel.org>; Fri, 27 Jun 2025 17:49:48 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 1422F4026D;
	Fri, 27 Jun 2025 19:49:47 +0200 (CEST)
Received: from dkmailrelay1.smartsharesystems.com
 (smartserver.smartsharesystems.com [77.243.40.215])
 by mails.dpdk.org (Postfix) with ESMTP id 1906C400EF
 for <dev@dpdk.org>; Fri, 27 Jun 2025 19:49:45 +0200 (CEST)
Received: from smartserver.smartsharesystems.com
 (smartserver.smartsharesys.local [192.168.4.10])
 by dkmailrelay1.smartsharesystems.com (Postfix) with ESMTP id CD1C020625;
 Fri, 27 Jun 2025 19:49:44 +0200 (CEST)
Subject: RE: [PATCH v3 2/3] eal: handle sysconf(_SC_PAGESIZE) negative return
 value
MIME-Version: 1.0
Content-Type: text/plain;
	charset="UTF-8"
Content-Transfer-Encoding: base64
Date: Fri, 27 Jun 2025 19:49:42 +0200
Content-class: urn:content-classes:message
Message-ID: <98CBD80474FA8B44BF855DF32C47DC35E9FD53@smartserver.smartshare.dk>
X-MimeOLE: Produced By Microsoft Exchange V6.5
In-Reply-To: <6180155.ReJHH8Nr61@thomas>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: [PATCH v3 2/3] eal: handle sysconf(_SC_PAGESIZE) negative return
 value
Thread-Index: AdvnidqJbs/TVaDVSmSSpegATKID9AAAVkMQ
References: <20250610131348.248800-1-mb@smartsharesystems.com>
 <17086222.mzqWEpnEhh@thomas>
 <98CBD80474FA8B44BF855DF32C47DC35E9FD51@smartserver.smartshare.dk>
 <6180155.ReJHH8Nr61@thomas>
From: =?UTF-8?B?TW9ydGVuIEJyw7hydXA=?= <mb@smartsharesystems.com>
To: "Thomas Monjalon" <thomas@monjalon.net>
Cc: "Tyler Retzlaff" <roretzla@linux.microsoft.com>,
 "Anatoly Burakov" <anatoly.burakov@intel.com>,
 "Bruce Richardson" <bruce.richardson@intel.com>,
 "Maxime Coquelin" <maxime.coquelin@redhat.com>,
 "Chenbo Xia" <chenbox@nvidia.com>,
 "Tomasz Duszynski" <tduszynski@marvell.com>,
 "Stephen Hemminger" <stephen@networkplumber.org>, <dev@dpdk.org>
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

PiBGcm9tOiBUaG9tYXMgTW9uamFsb24gW21haWx0bzp0aG9tYXNAbW9uamFsb24ubmV0XQ0KPiBT
ZW50OiBGcmlkYXksIDI3IEp1bmUgMjAyNSAxOS4zNQ0KPiANCj4gMjcvMDYvMjAyNSAxODozOCwg
TW9ydGVuIEJyw7hydXA6DQo+ID4gPiBGcm9tOiBUaG9tYXMgTW9uamFsb24gW21haWx0bzp0aG9t
YXNAbW9uamFsb24ubmV0XQ0KPiA+ID4gU2VudDogRnJpZGF5LCAyNyBKdW5lIDIwMjUgMTcuNTgN
Cj4gPiA+DQo+ID4gPiAyNC8wNi8yMDI1IDEwOjAzLCBNb3J0ZW4gQnLDuHJ1cDoNCj4gPiA+ID4g
KwkJaWYgKChzc2l6ZV90KXBhZ2Vfc2l6ZSA8IDApDQo+ID4gPiA+ICsJCQlydGVfcGFuaWMoInN5
c2NvbmYoX1NDX1BBR0VTSVpFKSBmYWlsZWQ6ICVzIiwNCj4gPiA+ID4gKwkJCQkJZXJybm8gPT0g
MCA/ICJJbmRldGVybWluYXRlIiA6DQo+ID4gPiBzdHJlcnJvcihlcnJubykpOw0KPiA+ID4NCj4g
PiA+IFdlIGRvbid0IHdhbnQgbW9yZSBydGVfcGFuaWMoKS4NCj4gPiA+IFlvdSBjb3VsZCBsb2cg
dGhlIHByb2JsZW0gYW5kIHJldHVybiAwIGhlcmUuDQo+ID4gPiBJdCB3aWxsIGJlIGEgcHJvYmxl
bSBsYXRlciwgYnV0IGl0IG1heSBhbGxvdyB0aGUgYXBwbGljYXRpb24gdG8NCj4gY2xlYW51cA0K
PiA+ID4gaW5zdGVhZCBvZiBhYnJ1cHRpbmcgY3Jhc2hpbmcuDQo+ID4NCj4gPiBEaXNhZ3JlZS4N
Cj4gPiBUaGF0IHdvdWxkIGJlIGxpa2VseSB0byBjYXVzZSBjcmFzaCB3aXRoIGRpdmlzaW9uIGJ5
IHplcm8gbGF0ZXIuDQo+ID4gQmV0dGVyIHRvIGZhaWwgZWFybHkuDQo+IA0KPiBXaGljaCBkaXZp
c2lvbiBieSB6ZXJvPw0KDQpGdW5jdGlvbnMgZGl2aWRpbmcgYnkgcGFnZSBzaXplLiBFLmcuOg0K
aHR0cHM6Ly9lbGl4aXIuYm9vdGxpbi5jb20vZHBkay92MjUuMDMvc291cmNlL2xpYi9lYWwvY29t
bW9uL2VhbF9jb21tb25fbWVtb3J5LmMjTDMxMw0KDQo+IA0KPiBJIGRvbid0IHRoaW5rIGEgbGli
cmFyeSBzaG91bGQgdGFrZSB0aGlzIGRlY2lzaW9uIG9uIGJlaGFsZiBvZiB0aGUgYXBwLg0KDQpJ
IGV4cGVjdCBsb3RzIG9mIHRoaW5ncyB0byBicmVhayBpZiBzeXNjb25mKF9TQ19QQUdFU0laRSkg
ZmFpbHMsIHNvIHRoZSBwdXJwb3NlIG9mIHRoaXMgcGF0Y2ggaXMgdG8gY2VudHJhbGl6ZSBlcnJv
ciBoYW5kbGluZyBoZXJlLCBhbmQgb25seSBjb250aW51ZS9yZXR1cm4gd2l0aCBub24tZmFpbGlu
ZyB2YWx1ZXMuDQoNCk90aGVyd2lzZSwgZXZlcnl3aGVyZSB1c2luZyBydGVfbWVtX3BhZ2Vfc2l6
ZSgpIG9yIHN5c2NvbmYoX1NDX1BBR0VTSVpFKSBzaG91bGQgaW1wbGVtZW50IGVycm9yIGhhbmRs
aW5nIChvciBpZ25vcmUgZXJyb3JzKS4NClRoYXQncyBhIGxvdCBvZiBwbGFjZXMsIHNvIEknbSBu
b3QgZ29pbmcgdG8gcHJvdmlkZSBhIHBhdGNoIGRvaW5nIHRoYXQuDQoNCg==
