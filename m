Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 699B6CD3436
	for <dpdk-dev@archiver.kernel.org>; Fri,  8 May 2026 10:16:06 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 6EE7D40608;
	Fri,  8 May 2026 12:16:05 +0200 (CEST)
Received: from dkmailrelay1.smartsharesystems.com
 (smartserver.smartsharesystems.com [77.243.40.215])
 by mails.dpdk.org (Postfix) with ESMTP id 2604C4013F
 for <dev@dpdk.org>; Fri,  8 May 2026 12:16:04 +0200 (CEST)
Received: from smartserver.smartsharesystems.com
 (smartserver.smartsharesys.local [192.168.4.10])
 by dkmailrelay1.smartsharesystems.com (Postfix) with ESMTP id E1F61208C9;
 Fri,  8 May 2026 12:16:03 +0200 (CEST)
Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="utf-8"
Content-Transfer-Encoding: base64
Subject: RE: [PATCH v1 1/1] net/iavf: fix large VF IRQ mapping
Date: Fri, 8 May 2026 12:16:01 +0200
Message-ID: <98CBD80474FA8B44BF855DF32C47DC35F65861@smartserver.smartshare.dk>
X-MimeOLE: Produced By Microsoft Exchange V6.5
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: [PATCH v1 1/1] net/iavf: fix large VF IRQ mapping
Thread-Index: Adzd+L094xOO1SQwT+Ke5gtFPOExKQAz86pQAAJGP+A=
References: <c50ef6c3d4ecaa7902d325d5e8a7fd4c92c8eeb6.1778076415.git.anatoly.burakov@intel.com>
 <CAJFAV8yNKxSXjmjQ0sM21-6hZDTVrGT9cpZ6aQU_FNTepTP4nw@mail.gmail.com>
 <3b9ba191-f086-4264-8382-653c06772e17@intel.com> 
From: =?utf-8?B?TW9ydGVuIEJyw7hydXA=?= <mb@smartsharesystems.com>
To: "Burakov, Anatoly" <anatoly.burakov@intel.com>,
 "Vladimir Medvedkin" <vladimir.medvedkin@intel.com>,
 "Bruce Richardson" <bruce.richardson@intel.com>
Cc: <dev@dpdk.org>, "David Marchand" <david.marchand@redhat.com>,
 <stephen@networkplumber.org>
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

PiBGcm9tOiBNb3J0ZW4gQnLDuHJ1cA0KPiBTZW50OiBGcmlkYXksIDggTWF5IDIwMjYgMTEuMTYN
Cj4gDQo+ID4gRnJvbTogQnVyYWtvdiwgQW5hdG9seSBbbWFpbHRvOmFuYXRvbHkuYnVyYWtvdkBp
bnRlbC5jb21dDQo+ID4gU2VudDogVGh1cnNkYXksIDcgTWF5IDIwMjYgMTAuMDkNCj4gPg0KPiA+
IE9uIDUvNi8yMDI2IDU6NTggUE0sIERhdmlkIE1hcmNoYW5kIHdyb3RlOg0KPiA+ID4gT24gV2Vk
LCA2IE1heSAyMDI2IGF0IDE2OjA3LCBBbmF0b2x5IEJ1cmFrb3YNCj4gPiA8YW5hdG9seS5idXJh
a292QGludGVsLmNvbT4gd3JvdGU6DQo+ID4gPj4NCj4gPiA+DQo+ID4gPiAtIGFsbCB0aG9zZSB2
aXJ0Y2hubCBsaXN0IHN0cnVjdCBoYXZlIHRoZSBzYW1lIGVsZW1zWzFdIGlzc3VlLg0KPiA+ID4g
S2VybmVsIHNpZGUgZGlkIHNvbWUgY2xlYW51cHMgc29tZSB0aW1lIGFnbywgbWF5YmUgdGltZSBm
b3IgRFBESyB0bw0KPiA+IGRvDQo+ID4gPiB0aGUgc2FtZS4uLj8NCj4gPiA+DQo+ID4NCj4gPiBZ
ZXMsIGl0IGlzIGluZGVlZCB0aW1lIHRvIGRvIHRoZSBzYW1lLCBidXQgbm90IGFzIHBhcnQgb2Yg
dGhpcw0KPiA+IHBhdGNoc2V0LA0KPiA+IGFuZCBub3QgYmVmb3JlIHRoZSBiYXNlIGRyaXZlciBj
b2RlIGlzIHVwZGF0ZWQgdG8gZG8gdGhlIHNhbWUuIFRoZXJlDQo+IGlzDQo+ID4gc29tZSBiYWNr
Z3JvdW5kIHdvcmsgaGFwcGVuaW5nIG9uIHRoYXQgZnJvbnQgYWxyZWFkeSwgYnV0IHRoZXJlIGFy
ZSBhDQo+ID4gbG90IG9mIGRlcGVuZGVuY2llcyBhbmQgbW92aW5nIHBhcnRzLCBzbyB3ZSBjYW4n
dCBqdXN0IGNoYW5nZSB0aGlzDQo+ID4gd2lsbHkNCj4gPiBuaWxseS4NCj4gDQo+IElzIHRoZXJl
IGEgdGltZWxpbmUgZm9yIHRoaXMgZml4Pw0KPiANCj4gV2l0aCB0aGUgcGVyZm9ybWFuY2UgaW1w
cm92ZWQgcnRlX21lbWNweSgpIHBhdGNoIFsxXSwgb25lIG9mIHRoZSBDSQ0KPiBjb21waWxlcnMg
Y29tcGxhaW5zIGFib3V0IGJ1ZmZlciBvdmVyZmxvd3Mgd2hlbiB3cml0aW5nIGJleW9uZCB0aGVz
ZQ0KPiB1bmRlcnNpemUgYXJyYXlzIFsyXS4NCj4gQW5kIEknZCBsaWtlIHRvIHNlZSB0aGUgcGVy
Zm9ybWFuY2UgaW1wcm92ZWQgcnRlX21lbWNweSgpIG1lcmdlZCBpbg0KPiAyNi4wNy4NCg0KV2l0
aCB2MTAgb2YgdGhlIHJ0ZV9tZW1jcHkoKSBwYXRjaCBbM10sIEkgaGF2ZSByZXZlcnRlZCB0aGUg
cmVtb3ZhbCBvZiB0aGUgd29ya2Fyb3VuZCB0aGF0IGlnbm9yZXMgc3RyaW5nb3Atb3ZlcmZsb3cg
d2FybmluZ3MgaW4gcnRlX21lbWNweSgpLCBzbyB0aGUgcGF0Y2ggZG9lc24ndCBkZXBlbmQgb24g
Zml4aW5nIHRoZSBkcml2ZXJzLg0KDQpQbGVhc2UgdGFrZSBub3RlIHRvIHJlbW92ZSB0aGUgd29y
a2Fyb3VuZCBmcm9tIHJ0ZV9tZW1jcHkoKSB3aGVuIHRoZSBmbGV4IGFycmF5IGlzc3VlIGluIHRo
ZSBkcml2ZXJzIC0gdXNpbmcgZWxlbXNbMV0gaW5zdGVhZCBvZiBlbGVtc1tdIC0gaGFzIGJlZW4g
Zml4ZWQuDQpOb3QgaWdub3JpbmcgYnVmZmVyIG92ZXJmbG93cyBpbiBydGVfbWVtY3B5KCkgbWln
aHQgaGVscCByZXZlYWwgYnVncyBlbHNld2hlcmUuDQoNCkFsdGVybmF0aXZlbHksIG1vdmUgdGhl
IHdvcmthcm91bmQgZnJvbSBydGVfbWVtY3B5LmggdG8gdGhlIGRyaXZlciBjb2RlIHJlcXVpcmlu
ZyB0aGUgd29ya2Fyb3VuZC4NCg0KPiANCj4gWzFdOg0KPiBodHRwczovL3BhdGNod29yay5kcGRr
Lm9yZy9wcm9qZWN0L2RwZGsvcGF0Y2gvMjAyNjA0MjkxMDM1NDguMjIwMzU0LTEtDQo+IG1iQHNt
YXJ0c2hhcmVzeXN0ZW1zLmNvbS8NCj4gWzJdOg0KPiBodHRwczovL2dpdGh1Yi5jb20vb3Zzcm9i
b3QvZHBkay9hY3Rpb25zL3J1bnMvMjUxMDQ0Mzg1NTIvam9iLzc0OTY4MjE4NA0KPiAyMA0KDQpb
M106IGh0dHBzOi8vcGF0Y2h3b3JrLmRwZGsub3JnL3Byb2plY3QvZHBkay9wYXRjaC8yMDI2MDUw
ODA5NTgyNy41MzU4Ny0xLW1iQHNtYXJ0c2hhcmVzeXN0ZW1zLmNvbS8NCg0KPiANCj4gLU1vcnRl
bg0KDQo=
