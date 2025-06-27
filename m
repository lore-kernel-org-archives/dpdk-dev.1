Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 38D46C7EE2A
	for <dpdk-dev@archiver.kernel.org>; Fri, 27 Jun 2025 16:38:58 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id A7C4040A84;
	Fri, 27 Jun 2025 18:38:56 +0200 (CEST)
Received: from dkmailrelay1.smartsharesystems.com
 (smartserver.smartsharesystems.com [77.243.40.215])
 by mails.dpdk.org (Postfix) with ESMTP id B1C67406A2
 for <dev@dpdk.org>; Fri, 27 Jun 2025 18:38:55 +0200 (CEST)
Received: from smartserver.smartsharesystems.com
 (smartserver.smartsharesys.local [192.168.4.10])
 by dkmailrelay1.smartsharesystems.com (Postfix) with ESMTP id 87F7620625;
 Fri, 27 Jun 2025 18:38:55 +0200 (CEST)
Subject: RE: [PATCH v3 2/3] eal: handle sysconf(_SC_PAGESIZE) negative return
 value
MIME-Version: 1.0
Content-Type: text/plain;
	charset="UTF-8"
Content-Transfer-Encoding: base64
Date: Fri, 27 Jun 2025 18:38:53 +0200
Content-class: urn:content-classes:message
Message-ID: <98CBD80474FA8B44BF855DF32C47DC35E9FD51@smartserver.smartshare.dk>
X-MimeOLE: Produced By Microsoft Exchange V6.5
In-Reply-To: <17086222.mzqWEpnEhh@thomas>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: [PATCH v3 2/3] eal: handle sysconf(_SC_PAGESIZE) negative return
 value
Thread-Index: AdvnfEpZnt8nHqL7Rxu9K7o0n3XmnAABQk+Q
References: <20250610131348.248800-1-mb@smartsharesystems.com>
 <20250624080333.127618-1-mb@smartsharesystems.com>
 <20250624080333.127618-3-mb@smartsharesystems.com>
 <17086222.mzqWEpnEhh@thomas>
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
ZW50OiBGcmlkYXksIDI3IEp1bmUgMjAyNSAxNy41OA0KPiANCj4gMjQvMDYvMjAyNSAxMDowMywg
TW9ydGVuIEJyw7hydXA6DQo+ID4gKwkJaWYgKChzc2l6ZV90KXBhZ2Vfc2l6ZSA8IDApDQo+ID4g
KwkJCXJ0ZV9wYW5pYygic3lzY29uZihfU0NfUEFHRVNJWkUpIGZhaWxlZDogJXMiLA0KPiA+ICsJ
CQkJCWVycm5vID09IDAgPyAiSW5kZXRlcm1pbmF0ZSIgOg0KPiBzdHJlcnJvcihlcnJubykpOw0K
PiANCj4gV2UgZG9uJ3Qgd2FudCBtb3JlIHJ0ZV9wYW5pYygpLg0KPiBZb3UgY291bGQgbG9nIHRo
ZSBwcm9ibGVtIGFuZCByZXR1cm4gMCBoZXJlLg0KPiBJdCB3aWxsIGJlIGEgcHJvYmxlbSBsYXRl
ciwgYnV0IGl0IG1heSBhbGxvdyB0aGUgYXBwbGljYXRpb24gdG8gY2xlYW51cA0KPiBpbnN0ZWFk
IG9mIGFicnVwdGluZyBjcmFzaGluZy4NCg0KRGlzYWdyZWUuDQpUaGF0IHdvdWxkIGJlIGxpa2Vs
eSB0byBjYXVzZSBjcmFzaCB3aXRoIGRpdmlzaW9uIGJ5IHplcm8gbGF0ZXIuDQpCZXR0ZXIgdG8g
ZmFpbCBlYXJseS4NCg0K
