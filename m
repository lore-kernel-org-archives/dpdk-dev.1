Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BFB9ACCFA0D
	for <dpdk-dev@archiver.kernel.org>; Wed,  5 Nov 2025 15:34:49 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 12990406B8;
	Wed,  5 Nov 2025 16:34:49 +0100 (CET)
Received: from dkmailrelay1.smartsharesystems.com
 (smartserver.smartsharesystems.com [77.243.40.215])
 by mails.dpdk.org (Postfix) with ESMTP id 6F56E4021F
 for <dev@dpdk.org>; Wed,  5 Nov 2025 16:34:48 +0100 (CET)
Received: from smartserver.smartsharesystems.com
 (smartserver.smartsharesys.local [192.168.4.10])
 by dkmailrelay1.smartsharesystems.com (Postfix) with ESMTP id 3A6A72079A;
 Wed,  5 Nov 2025 16:34:48 +0100 (CET)
Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="UTF-8"
Content-Transfer-Encoding: base64
Subject: RE: [PATCH] net/mlx5: store rxq MTU at allocation time
Date: Wed, 5 Nov 2025 16:34:44 +0100
Message-ID: <98CBD80474FA8B44BF855DF32C47DC35F65534@smartserver.smartshare.dk>
X-MimeOLE: Produced By Microsoft Exchange V6.5
In-Reply-To: <2962335.1SvkZsmPdQ@thomas>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: [PATCH] net/mlx5: store rxq MTU at allocation time
Thread-Index: AdxOZ/oa5QHT6VKDQ3eaBE+ocw+XUwAAbTxA
References: <20251028095240.35281-1-a.schollmeyer@syseleven.de>
 <2962335.1SvkZsmPdQ@thomas>
From: =?UTF-8?B?TW9ydGVuIEJyw7hydXA=?= <mb@smartsharesystems.com>
To: "Thomas Monjalon" <thomas@monjalon.net>,
 "Adrian Schollmeyer" <a.schollmeyer@syseleven.de>
Cc: <dev@dpdk.org>, "Michael Rossberg" <michael.rossberg@tu-ilmenau.de>,
 "Erez Ferber" <erezf@nvidia.com>,
 "Dariusz Sosnowski" <dsosnowski@nvidia.com>
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

VGhvbWFzLA0KDQpUaGVyZSdzIGEgdjI6DQpodHRwczovL3BhdGNod29yay5kcGRrLm9yZy9wcm9q
ZWN0L2RwZGsvcGF0Y2gvMjAyNTEwMzAwOTEzMTMuNTUxNTItMS1hLnNjaG9sbG1leWVyQHN5c2Vs
ZXZlbi5kZS8NCg0KDQpWZW5saWcgaGlsc2VuIC8gS2luZCByZWdhcmRzLA0KLU1vcnRlbiBCcsO4
cnVwDQoNCg0KPiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBUaG9tYXMgTW9u
amFsb24gW21haWx0bzp0aG9tYXNAbW9uamFsb24ubmV0XQ0KPiBTZW50OiBXZWRuZXNkYXksIDUg
Tm92ZW1iZXIgMjAyNSAxNi4yMg0KPiBUbzogQWRyaWFuIFNjaG9sbG1leWVyDQo+IENjOiBkZXZA
ZHBkay5vcmc7IE1pY2hhZWwgUm9zc2Jlcmc7IEVyZXogRmVyYmVyOyBEYXJpdXN6IFNvc25vd3Nr
aQ0KPiBTdWJqZWN0OiBSZTogW1BBVENIXSBuZXQvbWx4NTogc3RvcmUgcnhxIE1UVSBhdCBhbGxv
Y2F0aW9uIHRpbWUNCj4gDQo+IEhlbGxvLA0KPiANCj4gSSBkb24ndCBmaW5kIHRoaXMgcGF0Y2gg
aW4gcGF0Y2h3b3JrLg0KPiBQbGVhc2UgY291bGQgeW91IHRyeSBzZW5kaW5nIGl0IGFnYWluPw0K
PiBQbGVhc2UgdXNlIC0tY2MtY21kIGRldnRvb2xzL2dldC1tYWludGFpbmVyLnNoDQo+IHRvIG1h
a2Ugc3VyZSB0aGUgbWFpbnRhaW5lcnMgYXJlIGluIENjLg0KPiANCj4gVGhhbmtzDQo+IA0KPiAN
Cj4gMjgvMTAvMjAyNSAxMDo1MiwgYS5zY2hvbGxtZXllckBzeXNlbGV2ZW4uZGU6DQo+ID4gRnJv
bTogQWRyaWFuIFNjaG9sbG1leWVyIDxhLnNjaG9sbG1leWVyQHN5c2VsZXZlbi5kZT4NCj4gPg0K
PiA+IEZvciBzaGFyZWQgUnggcXVldWVzLCBlcXVhbCBNVFUgZm9yIGFsbCBwb3J0cyBzaGFyaW5n
IHF1ZXVlcyBpcw0KPiBlbmZvcmNlZA0KPiA+IHVzaW5nIG1seDVfc2hhcmVkX3J4cV9tYXRjaCgp
IHRvIG1ha2Ugc3VyZSwgdGhlIG1lbW9yeSBhbGxvY2F0ZWQgaW4NCj4gdGhlDQo+ID4gUnggYnVm
ZmVyIGlzIGxhcmdlIGVub3VnaC4gVGhlIGNoZWNrIHVzZXMgdGhlIE1UVSBhcyByZXBvcnRlZCBi
eSB0aGUNCj4gPiBwb3J0cycgcHJpdmF0ZSBkZXZfZGF0YSBzdHJ1Y3RzLCB3aGljaCBjb250YWlu
IHRoZSBNVFUgY3VycmVudGx5IHNldA0KPiBmb3INCj4gPiB0aGUgZGV2aWNlLiBJbiBjYXNlIG9u
ZSBwb3J0J3MgTVRVIGlzIGFsdGVyZWQgYWZ0ZXIgUnggcXVldWVzIGFyZQ0KPiA+IGFsbG9jYXRl
ZCBhbmQgdGhlbiBhIHNlY29uZCBwb3J0IGpvaW5zIHRoZSBzaGFyZWQgUnggcXVldWUgd2l0aCB0
aGUNCj4gb2xkLA0KPiA+IHlldCBjb3JyZWN0IE1UVSwgdGhlIGNoZWNrIGZhaWxzIGRlc3BpdGUg
dGhlIGZhY3QgdGhhdCB0aGUgUnggYnVmZmVyDQo+ID4gc2l6ZSBpcyBjb3JyZWN0IGZvciBib3Ro
IHBvcnRzLg0KPiA+DQo+ID4gVGhpcyBwYXRjaCBhZGRzIGEgbmV3IGVudHJ5IHRvIHRoZSBSeCBx
dWV1ZSBjb250cm9sIHN0cnVjdHVyZSB0aGF0DQo+ID4gY2FwdHVyZXMgdGhlIE1UVSBhdCB0aGUg
dGltZSB0aGUgUnggYnVmZmVyIHdhcyBhbGxvY2F0ZWQsIHNpbmNlIHRoaXMNCj4gaXMNCj4gPiB0
aGUgcmVsZXZhbnQgaW5mb3JtYXRpb24gdGhhdCBuZWVkcyB0byBiZSBjaGVja2VkIHdoZW4gYSBw
b3J0IGpvaW5zIGENCj4gPiBzaGFyZWQgUnggcXVldWUuDQo+ID4NCj4gPiBGaXhlczogMDljMjU1
NTMwM2JlDQo+IA0KPiANCj4gDQoNCg==
