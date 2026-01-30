Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2626FE6BF11
	for <dpdk-dev@archiver.kernel.org>; Fri, 30 Jan 2026 14:03:09 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 06FC3402C6;
	Fri, 30 Jan 2026 15:03:08 +0100 (CET)
Received: from dkmailrelay1.smartsharesystems.com
 (smartserver.smartsharesystems.com [77.243.40.215])
 by mails.dpdk.org (Postfix) with ESMTP id CC9D3402AF
 for <dev@dpdk.org>; Fri, 30 Jan 2026 15:03:05 +0100 (CET)
Received: from smartserver.smartsharesystems.com
 (smartserver.smartsharesys.local [192.168.4.10])
 by dkmailrelay1.smartsharesystems.com (Postfix) with ESMTP id 023B5206EC;
 Fri, 30 Jan 2026 15:03:05 +0100 (CET)
Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="UTF-8"
Content-Transfer-Encoding: base64
Subject: RE: [PATCH 2/2] [RFC] net: introduce fast ethernet address comparison
 function
Date: Fri, 30 Jan 2026 15:03:03 +0100
X-MimeOLE: Produced By Microsoft Exchange V6.5
Message-ID: <98CBD80474FA8B44BF855DF32C47DC35F656D6@smartserver.smartshare.dk>
In-Reply-To: <20260130104617.535413-2-mb@smartsharesystems.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: [PATCH 2/2] [RFC] net: introduce fast ethernet address
 comparison function
Thread-Index: AdyR1bCVGuB5kNAwSuK/jmwdjktG/AAGxTmQ
References: <20260130104617.535413-1-mb@smartsharesystems.com>
 <20260130104617.535413-2-mb@smartsharesystems.com>
From: =?UTF-8?B?TW9ydGVuIEJyw7hydXA=?= <mb@smartsharesystems.com>
To: "Bruce Richardson" <bruce.richardson@intel.com>,
	<dev@dpdk.org>
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

PiBGcm9tOiBNb3J0ZW4gQnLDuHJ1cCBbbWFpbHRvOm1iQHNtYXJ0c2hhcmVzeXN0ZW1zLmNvbV0N
Cj4gU2VudDogRnJpZGF5LCAzMCBKYW51YXJ5IDIwMjYgMTEuNDYNCj4gDQo+IEFkZGVkIGEgZmFz
dCBldGhlcm5ldCBhZGRyZXNzIGNvbXBhcmlzb24gZnVuY3Rpb24gZm9yIDY0LWJpdCBDUFUNCj4g
YXJjaGl0ZWN0dXJlcyB3aXRob3V0IHN0cmljdCBhbGlnbm1lbnQgcmVxdWlyZW1lbnRzLCBsb2Fk
aW5nIHRoZQ0KPiBldGhlcm5ldA0KPiBhZGRyZXNzZXMgYXMgNjQtYml0IHdvcmRzIGFuZCBjb21w
YXJpbmcgdGhlIHJlbGV2YW50IDYgYnl0ZXMuDQoNClNvbWUgcXVpY2sgdGVzdGluZyBpbiBhIHJl
YWwgYXBwbGljYXRpb24gc2hvd3MgdGhpcyBpcyB+MiBjeWNsZXMgZmFzdGVyIHRoYW4gdGhlIHN0
YW5kYXJkIHJ0ZV9pc19zYW1lX2V0aGVyX2FkZHIoKSBpbXBsZW1lbnRhdGlvbiAod2l0aG91dCB0
aGUgcGF0Y2ggMS8yIGNoYW5nZXMpLg0KDQo+IA0KPiBTaWduZWQtb2ZmLWJ5OiBNb3J0ZW4gQnLD
uHJ1cCA8bWJAc21hcnRzaGFyZXN5c3RlbXMuY29tPg0KPiAtLS0NCj4gIGxpYi9uZXQvcnRlX2V0
aGVyLmggfCA0NiArKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysN
Cj4gIDEgZmlsZSBjaGFuZ2VkLCA0NiBpbnNlcnRpb25zKCspDQo+IA0KPiBkaWZmIC0tZ2l0IGEv
bGliL25ldC9ydGVfZXRoZXIuaCBiL2xpYi9uZXQvcnRlX2V0aGVyLmgNCj4gaW5kZXggNTU1MmQz
YzFmNi4uMWI2NDBkODFjMiAxMDA2NDQNCj4gLS0tIGEvbGliL25ldC9ydGVfZXRoZXIuaA0KPiAr
KysgYi9saWIvbmV0L3J0ZV9ldGhlci5oDQo+IEBAIC0xMTQsNiArMTE0LDUyIEBAIHN0YXRpYyBp
bmxpbmUgaW50IHJ0ZV9pc19zYW1lX2V0aGVyX2FkZHIoY29uc3QNCj4gc3RydWN0IHJ0ZV9ldGhl
cl9hZGRyICplYTEsDQo+ICAjZW5kaWYNCj4gIH0NCj4gDQo+ICsvKioNCj4gKyAqIEB3YXJuaW5n
DQo+ICsgKiBAYiBFWFBFUklNRU5UQUw6IHRoaXMgQVBJIG1heSBjaGFuZ2UsIG9yIGJlIHJlbW92
ZWQsIHdpdGhvdXQgcHJpb3INCj4gbm90aWNlDQo+ICsgKg0KPiArICogQ2hlY2sgaWYgdHdvIEV0
aGVybmV0IGFkZHJlc3NlcyBhcmUgdGhlIHNhbWUsIHBlcmZvcm1hbmNlDQo+IG9wdGltaXplZC4N
Cj4gKyAqDQo+ICsgKiBAd2FybmluZw0KPiArICogSW50ZW50aW9uYWwgYnVmZmVyIG92ZXJydW46
DQo+ICsgKiBUaGUgRXRoZXJuZXQgYWRkcmVzc2VzIGFyZSBsb2FkZWQgYXMgNjQtYml0IGludGVn
ZXJzLCBpLmUuDQo+ICsgKiB0d28gYnl0ZXMgcGFzdCB0aGUgbWVtb3J5IGhvbGRpbmcgdGhlIEV0
aGVybmV0IGFkZHJlc3NlcyBhcmUNCj4gbG9hZGVkLg0KPiArICogVGhlIGNhbGxlciBtdXN0IGVu
c3VyZSB0aGF0IHRoaXMgZG9lcyBub3QgY2F1c2UgcHJvYmxlbXMuDQo+ICsgKiBJZiBhbiBFdGhl
cm5ldCBhZGRyZXNzICdlYScgaXMgYSBmaWVsZCBpbiBhIHN0cnVjdHVyZSAnUycsIGl0IGNhbg0K
PiBiZSB2ZXJpZmllZCBhcyBmb2xsb3dzOg0KPiArICogXGNvZGV7LmN9DQo+ICsgKiAgIHN0YXRp
Y19hc3NlcnQoc2l6ZW9mKHN0cnVjdCBTKSA+PSBvZmZzZXRvZihzdHJ1Y3QgUywgZWEpICsNCj4g
c2l6ZW9mKHVpbnQ2NF90KSk7DQo+ICsgKiBcZW5kY29kZQ0KPiArICoNCj4gKyAqIEBwYXJhbSBl
YTENCj4gKyAqICAgQSBwb2ludGVyIHRvIHRoZSBmaXJzdCBldGhlcl9hZGRyIHN0cnVjdHVyZSBj
b250YWluaW5nIHRoZQ0KPiBFdGhlcm5ldCBhZGRyZXNzLg0KPiArICogQHBhcmFtIGVhMg0KPiAr
ICogICBBIHBvaW50ZXIgdG8gdGhlIHNlY29uZCBldGhlcl9hZGRyIHN0cnVjdHVyZSBjb250YWlu
aW5nIHRoZQ0KPiBFdGhlcm5ldCBhZGRyZXNzLg0KPiArICoNCj4gKyAqIEByZXR1cm4NCj4gKyAq
ICAgLSB0cnVlIGlmIHRoZSBnaXZlbiB0d28gRXRoZXJuZXQgYWRkcmVzc2VzIGFyZSB0aGUgc2Ft
ZTsNCj4gKyAqICAgLSBmYWxzZSBvdGhlcndpc2UuDQo+ICsgKi8NCj4gK19fcnRlX2V4cGVyaW1l
bnRhbA0KPiArX19ydGVfcHVyZQ0KPiArc3RhdGljIGlubGluZSBib29sDQo+ICtydGVfaXNfc2Ft
ZV9ldGhlcl9hZGRyX2Zhc3QoY29uc3Qgc3RydWN0IHJ0ZV9ldGhlcl9hZGRyICplYTEsDQo+ICsJ
CWNvbnN0IHN0cnVjdCBydGVfZXRoZXJfYWRkciAqZWEyKQ0KPiArew0KPiArI2lmIGRlZmluZWQo
UlRFX0FSQ0hfNjQpICYmICFkZWZpbmVkKFJURV9BUkNIX1NUUklDVF9BTElHTikNCj4gKwljb25z
dCB1bmFsaWduZWRfdWludDY0X3QgKiBjb25zdCBhMSA9IChjb25zdCB1bmFsaWduZWRfdWludDY0
X3QNCj4gKillYTE7DQo+ICsJY29uc3QgdW5hbGlnbmVkX3VpbnQ2NF90ICogY29uc3QgYTIgPSAo
Y29uc3QgdW5hbGlnbmVkX3VpbnQ2NF90DQo+ICopZWEyOw0KPiArI2lmIFJURV9CWVRFX09SREVS
ID09IFJURV9CSUdfRU5ESUFODQo+ICsJcmV0dXJuICgqYTEgXiAqYTIpID4+IDE2ID09IDA7DQo+
ICsjZWxpZiBSVEVfQllURV9PUkRFUiA9PSBSVEVfTElUVExFX0VORElBTg0KPiArCXJldHVybiAo
KmExIF4gKmEyKSA8PCAxNiA9PSAwOw0KPiArI2Vsc2UNCj4gKyNlcnJvciAiVW5rbm93biBieXRl
IG9yZGVyLiINCj4gKyNlbmRpZiAvKiBSVEVfQllURV9PUkRFUiAqLw0KPiArI2Vsc2UNCj4gKwly
ZXR1cm4gcnRlX2lzX3NhbWVfZXRoZXJfYWRkcihlYTEsIGVhMik7DQo+ICsjZW5kaWYNCj4gK30N
Cj4gKw0KPiAgLyoqDQo+ICAgKiBDaGVjayBpZiBhbiBFdGhlcm5ldCBhZGRyZXNzIGlzIGZpbGxl
ZCB3aXRoIHplcm9zLg0KPiAgICoNCj4gLS0NCj4gMi40My4wDQoNCg==
