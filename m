Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C323FC021B8
	for <dpdk-dev@archiver.kernel.org>; Tue,  4 Mar 2025 10:08:56 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 6834340156;
	Tue,  4 Mar 2025 11:08:55 +0100 (CET)
Received: from dkmailrelay1.smartsharesystems.com
 (smartserver.smartsharesystems.com [77.243.40.215])
 by mails.dpdk.org (Postfix) with ESMTP id 2D51340041
 for <dev@dpdk.org>; Tue,  4 Mar 2025 11:08:54 +0100 (CET)
Received: from smartserver.smartsharesystems.com
 (smartserver.smartsharesys.local [192.168.4.10])
 by dkmailrelay1.smartsharesystems.com (Postfix) with ESMTP id DB70F2056C;
 Tue,  4 Mar 2025 11:08:53 +0100 (CET)
Content-class: urn:content-classes:message
Subject: RE: [PATCH v4 0/4] Introduce Topology NUMA grouping for lcores
MIME-Version: 1.0
Content-Type: text/plain;
	charset="UTF-8"
Content-Transfer-Encoding: base64
Date: Tue, 4 Mar 2025 11:08:53 +0100
X-MimeOLE: Produced By Microsoft Exchange V6.5
Message-ID: <98CBD80474FA8B44BF855DF32C47DC35E9FABA@smartserver.smartshare.dk>
In-Reply-To: <PH7PR12MB8596C47BD103ADF3C275C10E82C92@PH7PR12MB8596.namprd12.prod.outlook.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: [PATCH v4 0/4] Introduce Topology NUMA grouping for lcores
Thread-Index: AQHbL22WzCqF9Lj5SUqurJMDjBRIs7NFKZjQgABbpICAAAxrAIAcRJQAgAGjigA=
References: <20241105102849.1947-1-vipin.varghese@amd.com>
 <PH7PR12MB85960CB35BB467CEBBC2CA2F82FF2@PH7PR12MB8596.namprd12.prod.outlook.com>
 <2097299.UkFFEUeh36@thomas>
 <98CBD80474FA8B44BF855DF32C47DC35E9FA33@smartserver.smartshare.dk>
 <PH7PR12MB8596C47BD103ADF3C275C10E82C92@PH7PR12MB8596.namprd12.prod.outlook.com>
From: =?UTF-8?B?TW9ydGVuIEJyw7hydXA=?= <mb@smartsharesystems.com>
To: "Varghese, Vipin" <Vipin.Varghese@amd.com>,
 "Thomas Monjalon" <thomas@monjalon.net>
Cc: <dev@dpdk.org>, <roretzla@linux.microsoft.com>,
 <bruce.richardson@intel.com>, <john.mcnamara@intel.com>,
 <dmitry.kozliuk@gmail.com>, <ajit.khaparde@broadcom.com>,
 "Song, Keesang" <Keesang.Song@amd.com>, <pbhagavatula@marvell.com>,
 <jerinj@marvell.com>, <ruifeng.wang@arm.com>,
 <mattias.ronnblom@ericsson.com>, <anatoly.burakov@intel.com>,
 <stephen@networkplumber.org>, "Yigit, Ferruh" <Ferruh.Yigit@amd.com>,
 <honnappa.nagarahalli@arm.com>, <wathsala.vithanage@arm.com>,
 <konstantin.ananyev@huawei.com>
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

PiBGcm9tOiBWYXJnaGVzZSwgVmlwaW4gW21haWx0bzpWaXBpbi5WYXJnaGVzZUBhbWQuY29tXQ0K
PiBTZW50OiBNb25kYXksIDMgTWFyY2ggMjAyNSAxMC4wNg0KPiANCj4gW1B1YmxpY10NCj4gDQo+
IEhpIE1vcnRlbiwNCj4gDQo+IHNuaXBwZWQNCj4gDQo+ID4NCj4gPiA+IEZyb206IFRob21hcyBN
b25qYWxvbiBbbWFpbHRvOnRob21hc0Btb25qYWxvbi5uZXRdDQo+ID4gPiBTZW50OiBUaHVyc2Rh
eSwgMTMgRmVicnVhcnkgMjAyNSAwOS4zNA0KPiA+ID4NCj4gPiA+IDEzLzAyLzIwMjUgMDQ6MDks
IFZhcmdoZXNlLCBWaXBpbjoNCj4gPiA+ID4gW0FNRCBPZmZpY2lhbCBVc2UgT25seSAtIEFNRCBJ
bnRlcm5hbCBEaXN0cmlidXRpb24gT25seV0NCj4gPiA+ID4NCj4gPiA+ID4gQWRkaW5nIFRob21h
cyBhbmQgQWppdCB0byB0aGUgbG9vcC4NCj4gPiA+ID4NCj4gPiA+ID4gSGkgQWppdCwgd2UgaGF2
ZSBiZWVuIHVzaW5nIHRoZSBwYXRjaCBzZXJpZXMgZm9yIGlkZW50aWZ5aW5nIHRoZQ0KPiA+ID4g
dG9wb2xvZ3kgYW5kIGdldHRpbmcgbDMgY2FjaGUgaWQgZm9yIHBvcHVsYXRpbmcgdGhlIHN0ZWVy
aW5nIHRhZw0KPiBmb3INCj4gPiA+IERldmljZSBTcGVjaWZpYyBNb2RlbCAmIE1TSS14IGRyaXZl
biBhZi14ZHAgZm9yIHRoZSBleHBlcmltZW50YWwNCj4gU1RBRw0KPiA+ID4gZmlybXdhcmUgb24g
VGhvci4NCj4gPg0KPiA+IEV4Y2VsbGVudC4gQSByZWFsIGxpZmUgZXhhbXBsZSB1c2UgY2FzZSBo
ZWxwcyB0aGUgcmV2aWV3IHByb2Nlc3MgYQ0KPiBsb3QhDQo+IA0KPiBTdGVlcmluZyB0YWcgaXMg
b25lIG9mIHRoZSBleGFtcGxlcyBvciB1c2VzLCBhcyBzaGFyZWQgaW4gdGhlIGN1cnJlbnQNCj4g
cGF0Y2ggc2VyaWVzICB3ZSBtYWtlIHVzZSBvZiB0aGVzZSBmb3Igb3RoZXIgZXhhbXBsZXMgdG9v
Lg0KPiBFdmVudGRldiwgcGt0LWRpc3RyaWJ1dG9yIGFuZCBncmFwaCBub2RlcyBhcmUgYWxzbyBp
biB3b3JrcyB0byBleHBsb2l0DQo+IEwyfEwzIGNhY2hlIGxvY2FsIGNvaGVyZW5jeSB0b28uDQo+
IA0KPiA+DQo+ID4gPiA+DQo+ID4gPiA+IEhlbmNlIGN1cnJlbnQgdXNlIG9mIHRvcG9sb2d5IGxp
YnJhcnkgaGVscHMgaW4gMS4gd29ya2xvYWQNCj4gcGxhY2VtZW50DQo+ID4gPiA+IGluIHNhbWUg
Q2FjaGUgb3IgSU8gZG9tYWluIDIuIHBvcHVsYXRpbmcgaWQgZm9yIE1TSXggb3IgRGV2aWNlDQo+
ID4gPiA+IHNwZWNpZmljIG1vZGVsIGZvciBzdGVlcmluZyB0YWdzLg0KPiA+ID4gPg0KPiA+ID4g
PiBUaG9tYXMgYW5kIEFqaXRoIGNhbiB3ZSBnZXQgc29tZSBoZWxwIHRvIGdldCB0aGlzIG1haW5s
aW5lIHRvbz8NCj4gPiA+DQo+ID4gPiBZZXMsIHNvcnJ5IHRoZSByZXZpZXcgZGlzY3Vzc2lvbnMg
ZGlkIG5vdCBzdGFydC4NCj4gPiA+IEl0IGhhcyBiZWVuIGZvcmdvdHRlbi4NCj4gPg0KPiA+IEkg
dGhpbmsgdGhlIHRvcG9sb2d5L2RvbWFpbiBBUEkgaW4gdGhlIEVBTCBzaG91bGQgYmUgY28tZGVz
aWduZWQgd2l0aA0KPiB0aGUgc3RlZXJpbmcNCj4gPiB0YWcgQVBJIGluIHRoZSBldGhkZXYgbGli
cmFyeSwgc28gdGhlIGRlc2lnbiBjYW4gYmUNCj4gcmV2aWV3ZWQvZGlzY3Vzc2VkIGluIGl0cyBl
bnRpcmV0eS4NCj4gDQo+IEFzIHNoYXJlZCBpbiB0aGUgZGlzY3Vzc2lvbiwgd2UgaGF2ZSBiZWVu
IGV4cGxvcmluZyBzaW1wbGlmaWVkIGFwcHJvYWNoDQo+IGZvciBzdGVlcmluZyB0YWdzLCBuYW1l
bHkNCj4gDQo+IDEuIHBjaS1kZXYgYXJncyAoY3J1ZGUgd2F5KQ0KPiAyLiBmbG93IGFwaSBmb3Ig
UlggKGV4cGVyaW1lbnRhbCB3YXkpDQo+IA0KPiBCYXNlZCBvbiB0aGUgcGxhdGZvcm0gKGluIGNh
c2Ugb2YgQU1EIEVQWUMsIHRoZXNlIGFyZSB0cmFuc2xhdGVkIHRvIGBMMw0KPiBpZCArIDFgKQ0K
PiANCj4gV2UgZG8gYWdyZWUgcnRlX2V0aGRldiBsaWJyYXJ5IGNhbiB1c2UgdG9wb2xvZ3kgQVBJ
LiBDdXJyZW50IHRvcG9sb2d5DQo+IEFQSSBhcmUgZGVzaWduZWQgdG8gYmUgbWFkZSBpbmRlcGVu
ZGVudCBmcm9tIHN0ZWVyaW5nIHRhZ3MsIGFzIG90aGVyDQo+IGV4YW1wbGVzIGRvIG1ha2UgdXNl
IG9mIHRoZSBzYW1lLg0KPiANCj4gPg0KPiA+IFRvIGhlbHAgdGhlIHJldmlldyBkaXNjdXNzaW9u
LCBwbGVhc2UgY29uc2lkZXIgZGVzY3JpYmluZyB0aGUNCj4gZm9sbG93aW5nOg0KPiA+IFdoaWNo
IEFQSXMgYXJlIGZvciBzbG93IHBhdGgsIGFuZCB3aGljaCBhcmUgZm9yIGZhc3QgcGF0aD8NCj4g
PiBXaGljaCBBUElzIGFyZSAibXVzdCBoYXZlIiwgaS5lLiBjb3JlIHRvIG1ha2luZyBpdCB3b3Jr
IGF0IGFsbCwgYW5kDQo+IHdoaWNoIEFQSXMgYXJlDQo+ID4gIm5pY2UgdG8gaGF2ZSIsIGkuZS4g
c3VwcG9ydCBBUElzIHRvIGVhc2UgdXNlIG9mIHRoZSBuZXcgZmVhdHVyZXM/DQo+IA0KPiBZZXMs
IHdpbGwgdHJ5IHRvIGRvIHRoZSBzYW1lIGluIHVwZGF0ZWQgdmVyc2lvbi4gRm9yIFNsb3cgYW5k
IEZhc3QgcGF0aA0KPiBBUEkgSSBtaWdodCBuZWVkIHNvbWUgaGVscCwgYXMgSSB3YXMgdW5kZXIg
dGhlIGltcHJlc3Npb24gY3VycmVudA0KPiBiZWhhdmlvciBpcyBzYW1lIHJ0ZV9sY29yZSAoaW52
b2tlZCBhdCBzZXR1cCBhbmQgYmVmb3JlIHJlbW90ZSBsYXVuY2gpLg0KPiBCdXQgd2lsbCBjaGVj
ayBhZ2Fpbi4NCg0KUHJvYmFibHkgdGhleSBhcmUgYWxsIHVzZWQgZm9yIGNvbmZpZ3VyYXRpb24g
b25seSwgYW5kIHRodXMgYWxsIHNsb3cgcGF0aDsgYnV0IGlmIHRoZXJlIGFyZSBhbnkgZmFzdCBw
YXRoIEFQSXMsIHRoZXkgc2hvdWxkIGJlIGhpZ2hsaWdodGVkIGFzIHN1Y2guDQoNCj4gDQo+ID4N
Cj4gPiBJIGhhdmVuJ3QgbG9va2VkIGF0IHRoZSBod2xvYyBsaWJyYXJ5J3MgQVBJOyBidXQgSSBn
dWVzcyB0aGVzZSBuZXcNCj4gRUFMIGZ1bmN0aW9ucyBhcmUNCj4gPiBjbG9zZWx5IHJlbGF0ZWQu
IElzIGl0IGEgdGhpbiB3cmFwcGVyIGFyb3VuZCB0aGUgaHdsb2MgbGlicmFyeSwgb3IgaXMNCj4g
aXQgdmVyeSBkaWZmZXJlbnQ/DQo+IFRoaXMgaXMgdmVyeSB0aGluIHdyYXBwZXIgb24gdG9wIG9m
IGh3bG9jIGxpYnJhcnkgb25seS4gQnV0IHdpdGggRFBESw0KPiBSVEVfTUFYX0xDT1JFICYgUlRF
X05VTUEgYm91bmRhcnkgY2hlY2sgYW5kIHBvcHVsYXRpb24uDQoNCk9LLiBUaGUgaHdsb2MgbGli
cmFyeSBpcyBwb3J0YWJsZSBhY3Jvc3MgTGludXgsIEJTRCBhbmQgV2luZG93cywgd2hpY2ggaXMg
Z3JlYXQhDQoNClBsZWFzZSBhbHNvIGRlc2NyaWJlIHRoZSBiZW5lZml0cyBvZiB1c2luZyB0aGlz
IERQREsgbGlicmFyeSwgY29tcGFyZWQgdG8gZGlyZWN0bHkgdXNpbmcgdGhlIGh3bG9jIGxpYnJh
cnkuDQoNCg==
