Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4066ACDB470
	for <dpdk-dev@archiver.kernel.org>; Wed, 24 Jun 2026 07:59:47 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 8BFB140616;
	Wed, 24 Jun 2026 09:59:46 +0200 (CEST)
Received: from dkmailrelay1.smartsharesystems.com
 (smartserver.smartsharesystems.com [77.243.40.215])
 by mails.dpdk.org (Postfix) with ESMTP id 06D2C400EF
 for <dev@dpdk.org>; Wed, 24 Jun 2026 09:59:45 +0200 (CEST)
Received: from smartserver.smartsharesystems.com
 (smartserver.smartsharesys.local [192.168.4.10])
 by dkmailrelay1.smartsharesystems.com (Postfix) with ESMTP id 03BC12024A;
 Wed, 24 Jun 2026 09:59:44 +0200 (CEST)
Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="utf-8"
Content-Transfer-Encoding: base64
Subject: RE: [PATCH v5] graph: add optional profiling stats
Date: Wed, 24 Jun 2026 09:59:38 +0200
Message-ID: <98CBD80474FA8B44BF855DF32C47DC35F6593C@smartserver.smartshare.dk>
X-MimeOLE: Produced By Microsoft Exchange V6.5
In-Reply-To: <CAHfVqdXW_=8Gn_hy7zYSztAngy=Un2HJ4d+8Ds-EyaqpjM=WHQ@mail.gmail.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: [PATCH v5] graph: add optional profiling stats
Thread-Index: Ad0DGhkRy/DmafKGTnqJa6mthvw1DQAjTk7g
References: <20260619202047.2809165-1-mb@smartsharesystems.com>
 <20260621184140.2878132-1-mb@smartsharesystems.com>
 <CALBAE1OCbZ9GB1oGYgR5hRtzjRmev2ZFOaSNndf02AZptihOcw@mail.gmail.com>
 <98CBD80474FA8B44BF855DF32C47DC35F65937@smartserver.smartshare.dk>
 <CALBAE1OZDXfH1FoVLJ=vXVqr=9hYPgqeCzN8h278wN8FbU+XaQ@mail.gmail.com>
 <CAHfVqdWKoDqb0uD_HrF8e=GqadThPhZj0vZnRYDW=KMPei0mXQ@mail.gmail.com>
 <98CBD80474FA8B44BF855DF32C47DC35F6593A@smartserver.smartshare.dk>
 <CAHfVqdXW_=8Gn_hy7zYSztAngy=Un2HJ4d+8Ds-EyaqpjM=WHQ@mail.gmail.com>
From: =?utf-8?B?TW9ydGVuIEJyw7hydXA=?= <mb@smartsharesystems.com>
To: "saeed bishara" <saeed.bishara.os@gmail.com>,
 "Pavan Nikhilesh" <pbhagavatula@marvell.com>,
 "Stephen Hemminger" <stephen@networkplumber.org>,
 "Wathsala Vithanage" <wathsala.vithanage@arm.com>,
 "Bruce Richardson" <bruce.richardson@intel.com>, <thomas@monjalon.net>
Cc: "Jerin Jacob" <jerinjacobk@gmail.com>, <dev@dpdk.org>,
 "Jerin Jacob" <jerinj@marvell.com>,
 "Kiran Kumar K" <kirankumark@marvell.com>,
 "Nithin Dabilpuram" <ndabilpuram@marvell.com>,
 "Zhirun Yan" <yanzhirun_163@163.com>
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

K1BhdmFuIE5pa2hpbGVzaCwgK1N0ZXBoZW4gSGVtbWluZ2VyLCArV2F0aHNhbGEgVml0aGFuYWdl
LCArQnJ1Y2UgUmljaGFyZHNvbiwgK1Rob21hcyBNb25qYWxvbg0KDQo+IEZyb206IHNhZWVkIGJp
c2hhcmEgW21haWx0bzpzYWVlZC5iaXNoYXJhLm9zQGdtYWlsLmNvbV0NCj4gU2VudDogVHVlc2Rh
eSwgMjMgSnVuZSAyMDI2IDE2LjExDQo+IA0KPiA+ID4gYWxzbywgaW5zdGVhZCBvZiBhZGRpbmcg
Y2FjaGVsaW5lIGZvciB0aGlzIHByb2ZpbGluZyBkYXRhLCBjYW4gd2UNCj4gPiA+IHNoYXJlIHdp
dGggbGluZSAxIHRoYXQgdXNlZCBzb2xlbHkgZm9yIHhzdGF0cz8NCj4gPg0KPiA+IFRoaXMgcHJv
ZmlsaW5nIGRhdGEgaXMgNCBpbmRleGVzICogMiB2YWx1ZXMgKiA4LWJ5dGUgZmllbGRzLCBzbyBv
bmUNCj4gY2FjaGUgbGluZSBpbiBpdHNlbGYuDQo+IG1ha2Ugc2Vuc2UuDQo+IGJ0dywgdGhlIGRl
ZmF1bHQgdmFsdWUgb2YgUlRFX0dSQVBIX0JVUlNUX1NJWkUgaXMgMjU2LCBJIHN1c3BlY3QgdGhh
dA0KPiByZWFsIGFwcGxpY2F0aW9ucyB3aWxsIGVuZm9yY2Ugc21hbGxlciBidXJzdCB3aGVuIHB1
bGxpbmcgZnJvbSBpbnB1dA0KPiBkZXZpY2VzIChlLmcuIDMyKS4gRG8geW91IGV4cGVjdCBzdWNo
IGNhc2VzIHRvIGNoYW5nZQ0KPiBSVEVfR1JBUEhfQlVSU1RfU0laRT8NCg0KRXhjZWxsZW50IHF1
ZXN0aW9uISBJIGRvbid0IGtub3cuDQpUaGV5IHNob3VsZC4gRS5nLiBhbiBhcHBsaWNhdGlvbiBv
cHRpbWl6ZWQgZm9yIGxhdGVuY3kgc2hvdWxkIGNlcnRhaW5seSBub3QgcHJvY2VzcyBidXJzdHMg
b2YgMjU2IG9iamVjdHMuDQoNCklNTywgdGhlIHJvb3QgcHJvYmxlbSBpcyB0aGUgbGFjayBvZiBh
IHVuaWZpZWQgYnVyc3Qgc2l6ZSBhY3Jvc3MgRFBESywgd2hpY2ggY2F1c2VzIGV2ZXJ5IGxpYnJh
cnkgdG8gYmUgZGVzaWduZWQgd2l0aCBpdHMgb3duIG9wdGltYWwgYnVyc3Qgc2l6ZS4NCkUuZy4g
dGhlIE1idWYgbGlicmFyeSB1c2VzIDY0IChmb3IgcnRlX3BrdG1idWZfZnJlZV9idWxrKCkpLCBh
bmQgdGhlIEdyYXBoIGxpYnJhcnkgdXNlcyAyNTYuDQoNClRoZXJlIGhhcyBiZWVuIGFuIGF0dGVt
cHQgYXQgaW50cm9kdWNpbmcgYSB1bmlmaWVkIGJ1cnN0IHNpemUgWzFdIGZvciBEUERLLCBidXQg
aXQgbWV0IGEgbG90IG9mIHJlc2lzdGFuY2UsIHNvIGl0IHN0aWxsIG5lZWRzIHRvIGJlIHJlZmlu
ZWQgYmVmb3JlIHdlIGNhbiByZWFjaCBhIGNvbmNsdXNpb24uDQpUaGUgZHJpdmVycyBzdXBwb3Nl
ZGx5IGNhbiByZXBvcnQgYW4gIm9wdGltYWwiIGJ1cnN0IHNpemUgYXQgcnVuLXRpbWUsIHdoaWNo
IHRoZSBhcHBsaWNhdGlvbiBjYW4gdGhlbiB1c2UuIEJ1dCB0aGUgYXBwbGljYXRpb24gaXMgdW5h
YmxlIHRvIGNvbmZpZ3VyZSBpdHMgaW50ZXJuYWwgYnVyc3Qgc2l6ZXMgaWYgb25lIGRyaXZlciBy
ZXBvcnRzIDY0IGFuZCBhbm90aGVyIHJlcG9ydHMgMzIuDQpJJ20gc3Ryb25nbHkgaW4gZmF2b3Ig
b2YgYSBidWlsZCB0aW1lIGNvbnN0YW50LCB1c2VkIGFjcm9zcyBEUERLLiBUaGUgZGVmYXVsdCB2
YWx1ZSBzaG91bGQgd29yayByZWFzb25hYmx5IHdlbGwgYWNyb3NzIGRyaXZlcnMgYW5kIGxpYnJh
cmllcy4NCkFuZCBpZiBhbiBhcHBsaWNhdGlvbiB3YW50cyB0byBvcHRpbWl6ZSBmb3IgcGVyZm9y
bWFuY2UgKGVpdGhlciB0aHJvdWdocHV0IG9yIGxhdGVuY3kpLCB0aGUgZGV2ZWxvcGVyIHNob3Vs
ZCBleHBlcmltZW50IHRvIGZpbmQgdGhlIG9wdGltYWwgdmFsdWUuDQpGdXJ0aGVybW9yZSwgZGVz
aWduaW5nIGZvciBhIGJ1aWxkIHRpbWUgY29uc3RhbnQgbWF4IGJ1cnN0IHNpemUgdGhyb3VnaG91
dCBEUERLIG1pZ2h0IHByb3ZpZGUgcGVyZm9ybWFuY2UgYmVuZWZpdHMgaW4gaXRzZWxmLCBhcyB0
aGUgY29tcGlsZXIgY2FuIG9wdGltaXplIGZvciB0aGlzLg0KDQpbMV06IGh0dHBzOi8vaW5ib3gu
ZHBkay5vcmcvZGV2L0tkT3lnTTk2UWI2ZDZBREsxLUFjbkFAbW9uamFsb24ubmV0Lw0KDQpOb3cs
IGJhY2sgdG8geW91ciBxdWVzdGlvbi4uLg0KQXMgYSB3b3JrYXJvdW5kLCBJIGNhbiBzYW1wbGUg
R3JhcGggbm9kZSBwZXJmb3JtYW5jZSBkYXRhIGZvciAzMiBvYmplY3RzLCBpbnN0ZWFkIG9mIHNh
bXBsaW5nIGZvciBSVEVfR1JBUEhfQlVSU1RfU0laRSAvIDIuDQoNCg==
