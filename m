Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B62D0C021AA
	for <dpdk-dev@archiver.kernel.org>; Wed, 19 Feb 2025 10:18:49 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 80E384028B;
	Wed, 19 Feb 2025 11:18:48 +0100 (CET)
Received: from dkmailrelay1.smartsharesystems.com
 (smartserver.smartsharesystems.com [77.243.40.215])
 by mails.dpdk.org (Postfix) with ESMTP id 324114025A
 for <dev@dpdk.org>; Wed, 19 Feb 2025 11:18:47 +0100 (CET)
Received: from smartserver.smartsharesystems.com
 (smartserver.smartsharesys.local [192.168.4.10])
 by dkmailrelay1.smartsharesystems.com (Postfix) with ESMTP id 1BB7F21B51;
 Wed, 19 Feb 2025 11:18:46 +0100 (CET)
Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="UTF-8"
Content-Transfer-Encoding: base64
Subject: RE: [EXTERNAL] Re: [PATCH v6 7/8] app: reduce app dependencies
Date: Wed, 19 Feb 2025 11:18:46 +0100
X-MimeOLE: Produced By Microsoft Exchange V6.5
Message-ID: <98CBD80474FA8B44BF855DF32C47DC35E9FA4E@smartserver.smartshare.dk>
In-Reply-To: <CO6PR18MB44846826FEEA15C90FCFA837D8C52@CO6PR18MB4484.namprd18.prod.outlook.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: [EXTERNAL] Re: [PATCH v6 7/8] app: reduce app dependencies
Thread-Index: AQHbgqUIJtqemb75i0OJSSs1KGJaRrNORacggAAicUA=
References: <cover.1725462264.git.anatoly.burakov@intel.com>
 <cover.1739877265.git.anatoly.burakov@intel.com>
 <4fef69922f2220f57ea32cb4a31e015622590237.1739877266.git.anatoly.burakov@intel.com>
 <CAJFAV8xGGW9bTvBXKA9Q90etQv97sW29hVC=ptkGPY2EUVMEJw@mail.gmail.com>
 <CO6PR18MB44846826FEEA15C90FCFA837D8C52@CO6PR18MB4484.namprd18.prod.outlook.com>
From: =?UTF-8?B?TW9ydGVuIEJyw7hydXA=?= <mb@smartsharesystems.com>
To: "Akhil Goyal" <gakhil@marvell.com>,
 "David Marchand" <david.marchand@redhat.com>,
 "Anatoly Burakov" <anatoly.burakov@intel.com>, <bruce.richardson@intel.com>
Cc: <dev@dpdk.org>, "Reshma Pattan" <reshma.pattan@intel.com>,
 "Stephen Hemminger" <stephen@networkplumber.org>,
 "Sunil Kumar Kori" <skori@marvell.com>,
 "Rakesh Kudurumalla" <rkudurumalla@marvell.com>,
 "Brian Dooley" <brian.dooley@intel.com>,
 "Vladimir Medvedkin" <vladimir.medvedkin@intel.com>,
 "Konstantin Ananyev" <konstantin.v.ananyev@yandex.ru>
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

PiBGcm9tOiBBa2hpbCBHb3lhbCBbbWFpbHRvOmdha2hpbEBtYXJ2ZWxsLmNvbV0NCj4gU2VudDog
V2VkbmVzZGF5LCAxOSBGZWJydWFyeSAyMDI1IDA5LjE2DQo+IA0KPiBIaSBEYXZpZCwNCj4gPiBI
ZWxsbywNCj4gPg0KPiA+IENjOiBBa2hpbC4NCj4gPg0KPiA+IE9uIFR1ZSwgRmViIDE4LCAyMDI1
IGF0IDEyOjE24oCvUE0gQW5hdG9seSBCdXJha292DQo+ID4gPGFuYXRvbHkuYnVyYWtvdkBpbnRl
bC5jb20+IHdyb3RlOg0KPiA+ID4gZGlmZiAtLWdpdCBhL2FwcC90ZXN0LWNyeXB0by1wZXJmL21l
c29uLmJ1aWxkIGIvYXBwL3Rlc3QtY3J5cHRvLQ0KPiA+IHBlcmYvbWVzb24uYnVpbGQNCj4gPiA+
IGluZGV4IGZiNDhkOWVjMjkuLmYwNTY0MzFiZjQgMTAwNjQ0DQo+ID4gPiAtLS0gYS9hcHAvdGVz
dC1jcnlwdG8tcGVyZi9tZXNvbi5idWlsZA0KPiA+ID4gKysrIGIvYXBwL3Rlc3QtY3J5cHRvLXBl
cmYvbWVzb24uYnVpbGQNCj4gPiA+IEBAIC0xOSw3ICsxOSw3IEBAIHNvdXJjZXMgPSBmaWxlcygN
Cj4gPiA+ICAgICAgICAgICdjcGVyZl90ZXN0X3ZlcmlmeS5jJywNCj4gPiA+ICAgICAgICAgICdt
YWluLmMnLA0KPiA+ID4gICkNCj4gPiA+IC1kZXBzICs9IFsnY3J5cHRvZGV2JywgJ25ldCcsICdz
ZWN1cml0eSddDQo+ID4gPiArZGVwcyArPSBbJ2NyeXB0b2RldiddDQo+ID4gPiAgb3B0aW9uYWxf
ZGVwcyArPSAnY3J5cHRvX3NjaGVkdWxlcicNCj4gPiA+DQo+ID4gPiAgY2ZsYWdzICs9IG5vX3d2
bGFfY2ZsYWcNCj4gPg0KPiA+IC0gVGhpcyBhcHAgZG9lcyBzZWVtIHRvIHJlbHkgb24gbGliL25l
dC4NCj4gPg0KPiA+IFs5ODkvMTI2Nl0gQ29tcGlsaW5nIEMgb2JqZWN0DQo+ID4gYXBwL2RwZGst
dGVzdC1jcnlwdG8tcGVyZi5wL3Rlc3QtY3J5cHRvLXBlcmZfY3BlcmZfb3BzLmMubw0KPiA+IEZB
SUxFRDogYXBwL2RwZGstdGVzdC1jcnlwdG8tcGVyZi5wL3Rlc3QtY3J5cHRvLXBlcmZfY3BlcmZf
b3BzLmMubw0KPiA+IGNjYWNoZSBhYXJjaDY0LWxpbnV4LWdudS1nY2MgLUlhcHAvZHBkay10ZXN0
LWNyeXB0by1wZXJmLnAgLUlhcHANCj4gPiAtSS4uL2FwcCAtSWxpYi9jcnlwdG9kZXYgLUkuLi9s
aWIvY3J5cHRvZGV2IC1JbGliL21idWYgLUkuLi9saWIvbWJ1Zg0KPiA+IC1JbGliL21lbXBvb2wg
LUkuLi9saWIvbWVtcG9vbCAtSWxpYi9yaW5nIC1JLi4vbGliL3JpbmcgLUkuIC1JLi4NCj4gPiAt
SWNvbmZpZyAtSS4uL2NvbmZpZyAtSWxpYi9lYWwvaW5jbHVkZSAtSS4uL2xpYi9lYWwvaW5jbHVk
ZQ0KPiA+IC1JbGliL2VhbC9saW51eC9pbmNsdWRlIC1JLi4vbGliL2VhbC9saW51eC9pbmNsdWRl
DQo+ID4gLUlsaWIvZWFsL2FybS9pbmNsdWRlIC1JLi4vbGliL2VhbC9hcm0vaW5jbHVkZSAtSS4u
L2tlcm5lbC9saW51eA0KPiA+IC1JbGliL2VhbC9jb21tb24gLUkuLi9saWIvZWFsL2NvbW1vbiAt
SWxpYi9lYWwgLUkuLi9saWIvZWFsDQo+ID4gLUlsaWIva3ZhcmdzIC1JLi4vbGliL2t2YXJncyAt
SWxpYi9sb2cgLUkuLi9saWIvbG9nIC1JbGliL21ldHJpY3MNCj4gPiAtSS4uL2xpYi9tZXRyaWNz
IC1JbGliL3RlbGVtZXRyeSAtSS4uL2xpYi90ZWxlbWV0cnkgLUlsaWIvcmN1DQo+ID4gLUkuLi9s
aWIvcmN1IC1mZGlhZ25vc3RpY3MtY29sb3I9YWx3YXlzIC1waXBlIC1EX0ZJTEVfT0ZGU0VUX0JJ
VFM9NjQNCj4gPiAtV2FsbCAtV2ludmFsaWQtcGNoIC1XZXh0cmEgLVdlcnJvciAtc3RkPWMxMSAt
TzMgLWluY2x1ZGUNCj4gcnRlX2NvbmZpZy5oDQo+ID4gLVd2bGEgLVdjYXN0LXF1YWwgLVdkZXBy
ZWNhdGVkIC1XZm9ybWF0IC1XZm9ybWF0LW5vbmxpdGVyYWwNCj4gPiAtV2Zvcm1hdC1zZWN1cml0
eSAtV21pc3NpbmctZGVjbGFyYXRpb25zIC1XbWlzc2luZy1wcm90b3R5cGVzDQo+ID4gLVduZXN0
ZWQtZXh0ZXJucyAtV29sZC1zdHlsZS1kZWZpbml0aW9uIC1XcG9pbnRlci1hcml0aCAtV3NpZ24t
DQo+IGNvbXBhcmUNCj4gPiAtV3N0cmljdC1wcm90b3R5cGVzIC1XdW5kZWYgLVd3cml0ZS1zdHJp
bmdzIC1Xbm8tcGFja2VkLW5vdC1hbGlnbmVkDQo+ID4gLVduby1taXNzaW5nLWZpZWxkLWluaXRp
YWxpemVycyAtRF9HTlVfU09VUkNFIC1tY3B1PWNvcnRleC1hNzINCj4gPiAtREFMTE9XX0VYUEVS
SU1FTlRBTF9BUEkgLVduby12bGEgLU1EIC1NUQ0KPiA+IGFwcC9kcGRrLXRlc3QtY3J5cHRvLXBl
cmYucC90ZXN0LWNyeXB0by1wZXJmX2NwZXJmX29wcy5jLm8gLU1GDQo+ID4gYXBwL2RwZGstdGVz
dC1jcnlwdG8tcGVyZi5wL3Rlc3QtY3J5cHRvLXBlcmZfY3BlcmZfb3BzLmMuby5kIC1vDQo+ID4g
YXBwL2RwZGstdGVzdC1jcnlwdG8tcGVyZi5wL3Rlc3QtY3J5cHRvLXBlcmZfY3BlcmZfb3BzLmMu
byAtYw0KPiA+IC4uL2FwcC90ZXN0LWNyeXB0by1wZXJmL2NwZXJmX29wcy5jDQo+ID4gLi4vYXBw
L3Rlc3QtY3J5cHRvLXBlcmYvY3BlcmZfb3BzLmM6NjoxMDogZmF0YWwgZXJyb3I6IHJ0ZV9ldGhl
ci5oOg0KPiBObw0KPiA+IHN1Y2ggZmlsZSBvciBkaXJlY3RvcnkNCj4gPiAgICAgNiB8ICNpbmNs
dWRlIDxydGVfZXRoZXIuaD4NCj4gPiAgICAgICB8ICAgICAgICAgIF5+fn5+fn5+fn5+fn4NCj4g
PiBjb21waWxhdGlvbiB0ZXJtaW5hdGVkLg0KPiA+IG5pbmphOiBidWlsZCBzdG9wcGVkOiBzdWJj
b21tYW5kIGZhaWxlZC4NCj4gPg0KPiA+DQo+ID4gLSBCdHcsIHJ0ZV9zZWN1cml0eS5oIGlzIGlu
Y2x1ZGVkIGluIGFwcC90ZXN0LWNyeXB0by0NCj4gcGVyZi9jcGVyZl9vcHMuYy4NCj4gPiBIb3dl
dmVyLCBnaXZlbiB0aGVyZSBpcyBhICNpZmRlZiwgSSBzdXNwZWN0IHRoZSBpbnRlbnRpb24gd2Fz
IHRvIGhhdmUNCj4gPiBsaWIvc2VjdXJpdHkgYXMgYW4gb3B0aW9uYWwgZGVwLg0KPiANCj4gWWVz
IGl0IHdhcyBpbml0aWFsbHkgbWVhbnQgdG8gYmUgb3B0aW9uYWwgd2hlbiBydGVfc2VjdXJpdHkg
d2FzDQo+IGV4cGVyaW1lbnRhbC4NCj4gQnV0IG5vdywgaXQgaXMga2luZCBvZiBtYW5kYXRvcnkg
bGlicmFyeS4gSSBhbSBub3Qgc3VyZSBpZiBpdCB3aWxsDQo+IGNvbXBpbGUgd2l0aG91dCBydGVf
c2VjdXJpdHkuDQo+IFdlIGNhbiByZW1vdmUgdGhlIGlmZGVmcyBvdmVyIHJ0ZV9zZWN1cml0eSBh
bmQNCj4gd2Ugc2hvdWxkIG5vdCByZW1vdmUgc2VjdXJpdHkgZGVwZW5kZW5jeSBmcm9tIGNyeXB0
by1wZXJmLg0KPiANCj4gLUFraGlsDQoNCk5vdCBzdXJlIHdoYXQgeW91IG1lYW4gaGVyZSwgYnV0
Og0KVGhlICJzZWN1cml0eSIgbGlicmFyeSBpcyBvcHRpb25hbCwgbm90IGFsd2F5cyBlbmFibGVk
LCB3aGVuIGJ1aWxkaW5nIERQREsuDQpSZWY6IC9zb3VyY2UvbGliL21lc29uLmJ1aWxkDQoNCk5v
dCBhbGwgYXBwbGljYXRpb25zIHVzZSB0aGUgc2VjdXJpdHkgbGlicmFyeSAob3Igc3R1ZmYgdGhh
dCBkZXBlbmRzIG9uIGl0KSwgc28gZG9uJ3QgbWFrZSBpdCBtYW5kYXRvcnkhDQoNCi1Nb3J0ZW4N
Cg0K
