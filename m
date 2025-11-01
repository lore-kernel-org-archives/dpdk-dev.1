Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EDD95CCF9F8
	for <dpdk-dev@archiver.kernel.org>; Sat,  1 Nov 2025 07:47:17 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id AD8F7402DE;
	Sat,  1 Nov 2025 08:47:16 +0100 (CET)
Received: from dkmailrelay1.smartsharesystems.com
 (smartserver.smartsharesystems.com [77.243.40.215])
 by mails.dpdk.org (Postfix) with ESMTP id D2E5A402D1;
 Sat,  1 Nov 2025 08:47:14 +0100 (CET)
Received: from smartserver.smartsharesystems.com
 (smartserver.smartsharesys.local [192.168.4.10])
 by dkmailrelay1.smartsharesystems.com (Postfix) with ESMTP id 98DD420467;
 Sat,  1 Nov 2025 08:47:14 +0100 (CET)
Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="UTF-8"
Content-Transfer-Encoding: base64
Subject: RE: Disable SPDK testing again?
Date: Sat, 1 Nov 2025 08:47:11 +0100
Message-ID: <98CBD80474FA8B44BF855DF32C47DC35F65526@smartserver.smartshare.dk>
X-MimeOLE: Produced By Microsoft Exchange V6.5
In-Reply-To: <CAJvnSUD8pJJeXYQ1adxC0d5mUT9Zm7jODoufrDjePN+7gy3MAA@mail.gmail.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: Disable SPDK testing again?
Thread-Index: AdxKeQEZQz6MlEeiRnaOIBWluCokbAAik1kA
References: <CAJFAV8yS3-_RMn-Ln7umJFt+wWVH7Fj7yFnmmjgUnpD1=VX9yA@mail.gmail.com>
 <98CBD80474FA8B44BF855DF32C47DC35F6551F@smartserver.smartshare.dk>
 <CAJFAV8yn0n2B32W1WUaZSKs1N3DbBPCGZxrT-ats4x0mo0Py-A@mail.gmail.com>
 <98CBD80474FA8B44BF855DF32C47DC35F65520@smartserver.smartshare.dk>
 <CAJvnSUD8pJJeXYQ1adxC0d5mUT9Zm7jODoufrDjePN+7gy3MAA@mail.gmail.com>
From: =?UTF-8?B?TW9ydGVuIEJyw7hydXA=?= <mb@smartsharesystems.com>
To: "Patrick Robb" <probb@iol.unh.edu>
Cc: "David Marchand" <david.marchand@redhat.com>, <bruce.richardson@intel.com>,
 "Aaron Conole" <aconole@redhat.com>, "dpdk-techboard" <techboard@dpdk.org>,
 <ci@dpdk.org>, "dev" <dev@dpdk.org>
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

PiBGcm9tOiBQYXRyaWNrIFJvYmIgW21haWx0bzpwcm9iYkBpb2wudW5oLmVkdV0gDQo+IFNlbnQ6
IEZyaWRheSwgMzEgT2N0b2JlciAyMDI1IDE2LjEzDQo+IA0KPiBPbiBGcmksIE9jdCAzMSwgMjAy
NSBhdCA2OjAy4oCvQU0gTW9ydGVuIEJyw7hydXAgPG1iQHNtYXJ0c2hhcmVzeXN0ZW1zLmNvbT4g
d3JvdGU6DQo+IA0KPj4gSWYgd2UgZGlzYWJsZSBTUERLIHRlc3RpbmcgZHVlIHRvIHRoaXMgU1BE
SyBidWcsIGhvdyB3aWxsIHdlIG5vdGljZSB3aGVuIHRoZXkgZml4IGl0LCBzbyB3ZSBjYW4gZW5h
YmxlIFNQREsgdGVzdGluZyBhZ2Fpbj8NCj4NCj4+IE9uZSBvcHRpb27CoGlzIEkgY2FuIGRpc2Fi
bGUgU1BESyB0ZXN0aW5nIGZvciB0aGUgInBlci1wYXRjaCIgdGVzdGluZywgYnV0IGxlYXZlIGl0
IGVuYWJsZWQgZm9yIHRoZSBwZXJpb2RpYyAob25jZSBwZXIgNDggaG91cnMpIHJ1bnMgb24gRFBE
SyBtYWluLiBUaGF0IHdheSBwYXRjaCBzdWJtaXR0ZXJzIGFyZW4ndCBsZWZ0IHdvbmRlcmluZyBp
ZiB0aGVpciBwYXRjaCBoYXMgYnJva2VuIFNQREssIGJ1dCB3ZSB3aWxsIGJlIGFibGUgdG8gY2hl
Y2sgaW4gbGF0ZXIgb24gdGhlIERQREsgbWFpbiBwZXJpb2RpYyBidWlsZHMgdG8gc2VlIGlmIHRo
ZSBTUERLIHNpZGUgaXMgZml4ZWQsIGF0IHdoaWNoIHBvaW50IHdlIGNhbiByZS1lbmFibGUgU1BE
SyBmb3IgcGVyLXBhdGNoIHRlc3RpbmcuDQoNClllcywgcGxlYXNlIGRvLg0KDQo=
