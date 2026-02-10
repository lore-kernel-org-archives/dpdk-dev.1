Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0CE04EA3F2A
	for <dpdk-dev@archiver.kernel.org>; Tue, 10 Feb 2026 09:18:27 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 46F8E400D7;
	Tue, 10 Feb 2026 10:18:26 +0100 (CET)
Received: from dkmailrelay1.smartsharesystems.com
 (smartserver.smartsharesystems.com [77.243.40.215])
 by mails.dpdk.org (Postfix) with ESMTP id 1BB3C400D7
 for <dev@dpdk.org>; Tue, 10 Feb 2026 10:18:24 +0100 (CET)
Received: from smartserver.smartsharesystems.com
 (smartserver.smartsharesys.local [192.168.4.10])
 by dkmailrelay1.smartsharesystems.com (Postfix) with ESMTP id F3CEE208FB;
 Tue, 10 Feb 2026 10:18:23 +0100 (CET)
Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="UTF-8"
Content-Transfer-Encoding: base64
Subject: RE: [PATCH v5 00/10] net/rtap: add io_uring based TAP driver
Date: Tue, 10 Feb 2026 10:18:21 +0100
X-MimeOLE: Produced By Microsoft Exchange V6.5
Message-ID: <98CBD80474FA8B44BF855DF32C47DC35F656F8@smartserver.smartshare.dk>
In-Reply-To: <20260209184045.132774-1-stephen@networkplumber.org>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: [PATCH v5 00/10] net/rtap: add io_uring based TAP driver
Thread-Index: AdyZ85+I+NqzCjgeSW6rpuNkLdkRGwAeGNPA
References: <20241210212757.83490-1-stephen@networkplumber.org>
 <20260209184045.132774-1-stephen@networkplumber.org>
From: =?UTF-8?B?TW9ydGVuIEJyw7hydXA=?= <mb@smartsharesystems.com>
To: "Stephen Hemminger" <stephen@networkplumber.org>,
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

PiBUaGlzIHNlcmllcyBhZGRzIG5ldF9ydGFwLCBhbiBleHBlcmltZW50YWwgcG9sbCBtb2RlIGRy
aXZlciB0aGF0IHVzZXMNCj4gTGludXggaW9fdXJpbmcgZm9yIGFzeW5jaHJvbm91cyBwYWNrZXQg
SS9PIHdpdGgga2VybmVsIFRBUCBpbnRlcmZhY2VzLg0KPiANCj4gTGlrZSBuZXRfdGFwLCBuZXRf
cnRhcCBjcmVhdGVzIGEga2VybmVsIG5ldHdvcmsgaW50ZXJmYWNlIHZpc2libGUgdG8NCj4gc3Rh
bmRhcmQgdG9vbHMgKGlwLCBldGh0b29sKSBhbmQgdGhlIExpbnV4IFRDUC9JUCBzdGFjay4gIEZy
b20gRFBESw0KPiBpdCBpcyBhbiBvcmRpbmFyeSBldGhkZXYuDQoNClJvYmluIEphcnJ5IHJlY2Vu
dGx5IGFkZGVkIE5ldHdvcmsgTmFtZXNwYWNlIHN1cHBvcnQgdG8gdGhlIFRBUCBkcml2ZXIgWzFd
Lg0KRG9lcyB0aGUgcnRhcCBkcml2ZXIgc3VwcG9ydCBOZXR3b3JrIE5hbWVzcGFjZXM/DQoNClsx
XTogaHR0cHM6Ly9pbmJveC5kcGRrLm9yZy9kZXYvMjAyNTEwMzAxNzU1MzcuMjE5NjQxLTctcmph
cnJ5QHJlZGhhdC5jb20vDQoNCj4gUmVxdWlyZW1lbnRzOg0KPiAgIC0gS2VybmVsIGhlYWRlcnMg
d2l0aCBJT1JJTkdfQVNZTkNfQ0FOQ0VMX0FMTCAodXBzdHJlYW0gc2luY2UgNS4xOSkNCg0KVGhl
IERQREsgMjUuMTEgbWluaW11bSByZXF1aXJlbWVudCBbMl0gaXMgS2VybmVsIDUuNC4NClNpbmNl
IHRoaXMgZHJpdmVyIHJlcXVpcmVzIGEgaGlnaGVyIHZlcnNpb24sIGl0IHNob3VsZCBiZSBwcm9t
aW5lbnRseSBtZW50aW9uZWQgaW4gcmVsZXZhbnQgZG9jdW1lbnRhdGlvbi4NCg0KSW4gRGVjZW1i
ZXIgMjAyNiwgc2hvcnRseSBhZnRlciB0aGUgcmVsZWFzZSBvZiBEUERLIDI2LjExLCB0aGUgb2xk
ZXN0IHN1cHBvcnRlZCBLZXJuZWwgTFRTIHZlcnNpb24gd2lsbCBiZSA2LjEuIEZvciBub3csIGl0
IGlzIDUuMTAuDQoNClsyXTogaHR0cHM6Ly9kb2MuZHBkay5vcmcvZ3VpZGVzLTI1LjExL2xpbnV4
X2dzZy9zeXNfcmVxcy5odG1sI3N5c3RlbS1zb2Z0d2FyZQ0KDQo+ICAgLSBsaWJ1cmluZyA+PSAy
LjANCj4gDQo+IEtub3duIHdvcmtpbmcgZGlzdHJpYnV0aW9uczogRGViaWFuIDEyKywgVWJ1bnR1
IDI0LjA0KywNCj4gRmVkb3JhIDM3KywgU0xFUyAxNSBTUDYrIC8gb3BlblNVU0UgVHVtYmxld2Vl
ZC4NCj4gUkhFTCA5IGlzIG5vdCBzdXBwb3J0ZWQgKGlvX3VyaW5nIGlzIGRpc2FibGVkIGJ5IGRl
ZmF1bHQpLg0KDQo=
