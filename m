Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 767E9CCF9FE
	for <dpdk-dev@archiver.kernel.org>; Fri, 31 Oct 2025 14:29:13 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 7AFBF40650;
	Fri, 31 Oct 2025 15:29:12 +0100 (CET)
Received: from dkmailrelay1.smartsharesystems.com
 (smartserver.smartsharesystems.com [77.243.40.215])
 by mails.dpdk.org (Postfix) with ESMTP id 95C5A40150
 for <dev@dpdk.org>; Fri, 31 Oct 2025 15:29:10 +0100 (CET)
Received: from smartserver.smartsharesystems.com
 (smartserver.smartsharesys.local [192.168.4.10])
 by dkmailrelay1.smartsharesystems.com (Postfix) with ESMTP id 76E7D206E7;
 Fri, 31 Oct 2025 15:29:10 +0100 (CET)
Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="UTF-8"
Content-Transfer-Encoding: base64
Subject: RE: [PATCH] mbuf: dump Tx offload metadata
Date: Fri, 31 Oct 2025 15:29:06 +0100
Message-ID: <98CBD80474FA8B44BF855DF32C47DC35F65524@smartserver.smartshare.dk>
X-MimeOLE: Produced By Microsoft Exchange V6.5
In-Reply-To: <CAJFAV8xfDUuAt_aC0rzi6pJ+7YXWfEBejx3MJB6Szi28+bZU5g@mail.gmail.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: [PATCH] mbuf: dump Tx offload metadata
Thread-Index: AdxKb9JnRAyCUMQVQG68kO85ptC+swAAEYTQ
References: <20251031131159.1199221-1-david.marchand@redhat.com>
 <98CBD80474FA8B44BF855DF32C47DC35F65523@smartserver.smartshare.dk>
 <CAJFAV8xfDUuAt_aC0rzi6pJ+7YXWfEBejx3MJB6Szi28+bZU5g@mail.gmail.com>
From: =?UTF-8?B?TW9ydGVuIEJyw7hydXA=?= <mb@smartsharesystems.com>
To: "David Marchand" <david.marchand@redhat.com>
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

PiBGcm9tOiBEYXZpZCBNYXJjaGFuZCBbbWFpbHRvOmRhdmlkLm1hcmNoYW5kQHJlZGhhdC5jb21d
DQo+IFNlbnQ6IEZyaWRheSwgMzEgT2N0b2JlciAyMDI1IDE1LjA4DQo+IA0KPiBPbiBGcmksIDMx
IE9jdCAyMDI1IGF0IDE0OjI4LCBNb3J0ZW4gQnLDuHJ1cCA8bWJAc21hcnRzaGFyZXN5c3RlbXMu
Y29tPg0KPiB3cm90ZToNCj4gPiBQcmludGluZyBvZiBvdXRlcl9sMl9sZW4gYW5kIG91dGVyX2wz
X2xlbiBjb3VsZCBiZSBvbWl0dGVkIGlmIG5vdA0KPiBwcmVzZW50LCBsaWtlIHRoZSBWTEFOIElE
cywgZS5nLjoNCj4gPg0KPiA+IGZwcmludGYoZiwgIiAgIik7DQo+ID4gaWYgKG0tPm91dGVyX2wy
X2xlbiAhPSAwKQ0KPiA+ICAgICAgICAgZnByaW50ZihmLCAib3V0ZXJfbDJfbGVuPSV1LCAiLCBt
LT5vdXRlcl9sMl9sZW4pOw0KPiA+IGlmIChtLT5vdXRlcl9sM19sZW4gIT0gMCkNCj4gPiAgICAg
ICAgIGZwcmludGYoZiwgIm91dGVyX2wzX2xlbj0ldSwgIiwgbS0+b3V0ZXJfbDNfbGVuKTsNCj4g
PiBmcHJpbnRmKGYsICJsMl9sZW49JXUsIGwzX2xlbj0ldSwgbDRfbGVuPSV1LCB0c29fc2Vnc3o9
JXVcbiIsDQo+ID4gICAgICAgICBtLT5sMl9sZW4sIG0tPmwzX2xlbiwgbS0+bDRfbGVuLCBtLT50
c29fc2Vnc3opOw0KPiANCj4gTW0sIHdoeSBzcGVjaWZpY2FsbHkgdGhvc2UgdHdvIG9ubHk/DQo+
IElmIHRoZSBpbnRlbnRpb24gaXMgdG8gbWFrZSB0aGlzIGRlYnVnIG91dHB1dCBzaG9ydGVyLCBJ
IHdvdWxkIGFwcGx5DQo+IHRoZSBzYW1lIHRvIGFsbCB0aG9zZSBmaWVsZHMsIGFuZCBvbWl0IHRo
ZSB3aG9sZSAobmV3KSBsaW5lIGlmIG5vDQo+IGZpZWxkIGlzIHNldC4NCg0KVGhlIGludGVudGlv
biBpcyBub3QgZG8gbWFrZSB0aGUgb3V0cHV0IHNob3J0ZXIsIGJ1dCB0byByZWR1Y2UgdGhlIGFt
b3VudCBvZiAibm9pc2UiICh1c2VsZXNzIGRhdGEpIGluIHRoZSBvdXRwdXQuDQpNeSBzdWdnZXN0
aW9uIG9taXRzIG5vaXNlIGZvciBub24tdHVubmVsZWQgcGFja2V0cy4NCg0KTWF5YmUgdHNvX3Nl
Z3N6IGNvdWxkIGJlIGNvbmRpdGlvbmFsIG9uIG5vbi16ZXJvIHRvby4NCg0KSXQgZGVwZW5kcyBv
biB3aGF0IHRoZSB1c2VyL2RldmVsb3BlciBpcyBkZWJ1Z2dpbmcsIHdoZXRoZXIgbDIvbDMvbDRf
bGVuIGFyZSBjb25zaWRlcmVkIG5vaXNlLiBJIGRvbid0IG9iamVjdCB0byBtYWtpbmcgdGhlbSBj
b25kaXRpb25hbCB0b28sIGlmIHlvdSBwcmVmZXIuDQoNCkFueXdheSwgSSBqdXN0IHJlYWxpemVk
IHRoYXQgdGhlIHR4X29mZmxvYWQgZmllbGQgaXMgbm90IGNsZWFyZWQgb24gUlgsIHNvIHRoZSBk
aXNjdXNzZWQgemVyby1jaGVjayBpcyB1c2VsZXNzIChjaGVja2luZyB1bmluaXRpYWxpemVkIGRh
dGEpIHdoZW4gZHVtcGluZyBhbiBtYnVmIGF0IGFuIGVhcmx5IHN0YWdlIGluIHRoZSBhcHBsaWNh
dGlvbidzIHBhY2tldCBwcm9jZXNzaW5nIHBpcGVsaW5lLg0KSSBoYXZlIGFuIGlkZWEgdG8gZ2V0
IGFyb3VuZCB0aGlzLi4uIFRoZSBUWCBmbGFncyBpbiBvbF9mbGFncyBhcmUgY2xlYXJlZCBhdCBS
WCwgc28gd2UgY2FuIGNvbnNpZGVyIHR4X29mZmxvYWQgdW5pbml0aWFsaXplZCB1bnRpbCBvbmUg
b2YgdGhlIFRYIGZsYWdzIGluIG9sX2ZsYWdzIGhhcyBiZWVuIHNldC4NCg0K
