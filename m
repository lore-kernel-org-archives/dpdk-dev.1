Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 355D7CD6E57
	for <dpdk-dev@archiver.kernel.org>; Tue,  2 Jun 2026 09:21:33 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 5C6B7402A9;
	Tue,  2 Jun 2026 11:21:32 +0200 (CEST)
Received: from dkmailrelay1.smartsharesystems.com
 (smartserver.smartsharesystems.com [77.243.40.215])
 by mails.dpdk.org (Postfix) with ESMTP id 6445640150
 for <dev@dpdk.org>; Tue,  2 Jun 2026 11:21:30 +0200 (CEST)
Received: from smartserver.smartsharesystems.com
 (smartserver.smartsharesys.local [192.168.4.10])
 by dkmailrelay1.smartsharesystems.com (Postfix) with ESMTP id 36D71208EE;
 Tue,  2 Jun 2026 11:21:30 +0200 (CEST)
Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="utf-8"
Content-Transfer-Encoding: base64
Subject: RE: [PATCH] ring: avoid extra store at move head
Date: Tue, 2 Jun 2026 11:21:27 +0200
Message-ID: <98CBD80474FA8B44BF855DF32C47DC35F658D4@smartserver.smartshare.dk>
X-MimeOLE: Produced By Microsoft Exchange V6.5
In-Reply-To: <580828b0214b4e1fb22e2f6d4079eadf@huawei.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: [PATCH] ring: avoid extra store at move head
Thread-Index: AQHc8fK5OiZjmmmV7UO2NjAsOtXDQbYqNc+AgAC22aCAABCrcA==
References: <20260601181509.71007-1-konstantin.ananyev@huawei.com>
 <20260601152313.1946d438@phoenix.local>
 <580828b0214b4e1fb22e2f6d4079eadf@huawei.com>
From: =?utf-8?B?TW9ydGVuIEJyw7hydXA=?= <mb@smartsharesystems.com>
To: "Konstantin Ananyev" <konstantin.ananyev@huawei.com>,
 "Stephen Hemminger" <stephen@networkplumber.org>
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

PiA+IFRoZW4gaGFkIENsYXVkZSBjb21wYXJlIHJlc3VsdHM6DQo+ID4NCj4gPiBLZXkgbWV0cmlj
ICh0d28gcGh5c2ljYWwgY29yZXMgbGVnYWN5IE1QL01DIGJ1bGsgbj0xMjgpOg0KPiA+ICAgbWFp
bjogICAgICAgIDUuMzgwIGN5Y2xlcy9lbGVtDQo+ID4gICBzeW5jLWJvb2w6ICAgNS4zNzcgY3lj
bGVzL2VsZW0gICgtMC4wNyUpDQo+ID4gICBhdm9pZC1zdG9yZTogNS44OTIgY3ljbGVzL2VsZW0g
ICgrOS41MiUpICDihpAgcmVncmVzc2VzDQo+ID4NCj4gPg0KPiA+IExvb2tpbmcgYXQgdGhlIGRp
c3Nhc3NlbWJseSBvZiByaW5nX2VucXVldWVfYnVsazoNCj4gPg0KPiA+IFRoZSBpbm5lciBsb29w
IG9mIG1haW4gYW5kIHN5bmMtYm9vbCB2ZXJzaW9ucyBpczoNCj4gPiBtb3YgICAgMHg4MCglcmRp
KSwlcjExZCAgICAgICAgICAgIDsgbG9hZCBkLT5oZWFkIHZpYSBkaXNwbGFjZW1lbnQNCj4gPiBt
b3YgICAgMHgxMDQoJXJkaSksJWVieCAgICAgICAgICAgICA7IGxvYWQgcy0+dGFpbA0KPiA+IGFk
ZCAgICAlZWN4LCVlYngNCj4gPiBzdWIgICAgJXIxMWQsJWVieA0KPiA+IGNtcCAgICAlZWJ4LCVy
MTJkDQo+ID4gamFlICAgIFtleGl0XQ0KPiA+IGxlYSAgICAoJXI4LCVyMTEsMSksJXIxM2QgICAg
ICAgICAgIDsgbmV3X2hlYWQgPSBvbGRfaGVhZCArIG4NCj4gPiBtb3YgICAgJXIxMWQsJWVheCAg
ICAgICAgICAgICAgICAgICA7IGV4cGVjdGVkIOKGkiBlYXgNCj4gPiBsb2NrIGNtcHhjaGcgJXIx
M2QsMHg4MCglcmRpKSAgICAgICA7IOKGkCBkaXNwbGFjZW1lbnQgYWRkcmVzc2luZw0KPiA+IGpu
ZSAgICBbcmV0cnldICAgICAgICAgICAgICAgICAgICAgIDsg4oaQIGRpcmVjdCBqbmUsIGVheCBw
cmVzZXJ2ZWQNCj4gPg0KPiA+IFVzaW5nIGF0b21pY19jb21wYXJlX2V4Y2hhbmdlIGFuZCB5b3Vy
IHBhdGNoOg0KPiA+IG1vdiAgICAweDM4KCVyZGkpLCVyMTBkDQo+ID4gbW92ICAgIDB4ODAoJXJk
aSksJWVheCAgICAgICAgICAgICAgOyBsb2FkIGQtPmhlYWQgZGlyZWN0bHkgaW50byAlZWF4DQo+
ID4gbGVhICAgIDB4ODAoJXJkaSksJXJjeCAgICAgICAgICAgICAgIDsg4oaQIE1BVEVSSUFMSVpF
ICZkLT5oZWFkIGludG8NCj4gJXJjeA0KPiA+IGxlYSAgICAtMHgxKCVyOCksJXIxMmQNCj4gPiBt
b3YgICAgMHgxMDQoJXJkaSksJXIxMWQNCj4gPiBhZGQgICAgJXIxMGQsJXIxMWQNCj4gPiBzdWIg
ICAgJWVheCwlcjExZA0KPiA+IGNtcCAgICAlcjExZCwlcjEyZA0KPiA+IGphZSAgICBbZXhpdF0N
Cj4gPiBsZWEgICAgKCVyOCwlcmF4LDEpLCVyMTNkICAgICAgICAgICA7IG5ld19oZWFkDQo+ID4g
bG9jayBjbXB4Y2hnICVyMTNkLCglcmN4KSAgICAgICAgICAgOyDihpAgSU5ESVJFQ1QgYWRkcmVz
c2luZyB2aWEgJXJjeA0KPiA+IG1vdiAgICAlZWF4LCVlYnggICAgICAgICAgICAgICAgICAgIDsg
4oaQIEVYVFJBOiBzYXZlIHBvc3QtQ0FTICVlYXggdG8NCj4gJWVieA0KPiA+IGpuZSAgICBbcmV0
cnldDQo+ID4NCj4gPiBCb3R0b20gbGluZTogZ29vZCBpZGVhIGJ1dCBzdGlsbCBmaWdodGluZyB3
aXRoIEdjYyBvcHRpbWl6ZXIgaGVyZS4NCj4gDQo+IFRoYW5rcyBmb3IgdHJ5aW5nLg0KPiBPbiBt
eSBib3ggKEFNRCBFUFlDIDk1MzQpIHdpdGggc2FtZSB0ZXN0LCB0aGVyZSBpcyBubyBtdWNoIGRp
ZmZlcmVuY2UNCj4gYmV0d2VlbiBhbGwgb2YgdGhlbToNCj4gdXNlLXN5bmMtYm9vbDogICAgICAg
ICAgICAgICAgICAgICAyLjIyNzMNCj4gdXNlLWMxMS1jdXJyZW50LXZlcnNpb246ICAgMi4yNDIy
DQo+IHVzZS1jMTEtcGF0Y2hlZDogICAgICAgICAgICAgICAgMi4yNDMxDQo+IEFueXdheSwgLTEw
JSBvbiBzb21lIGJveGVzIC0gdGhhdCdzIHByb2JhYmx5IGdvb2QgZW5vdWdoIHJlYXNvbiB0byBr
ZWVwDQo+IHNwZWNpZmljIHZlcnNpb24NCj4gZm9yICBfX3J0ZV9yaW5nX2hlYWR0YWlsX21vdmVf
aGVhZF9tdCgpLg0KPiBNeSBhc2sgd291bGQgYmUgdG8gaGF2ZSBzb21lIHNwZWNpYWwgbWFjcm8g
Zm9yIGl0LCBzbyB1c2VycyBjYW4NCj4gZW5hYmxlL2Rpc2FibGUgaXQgdmlhICdtZXNvbiBzZXR1
cCcgYXQgd2lsbC4NCg0KVGhpcyBzZWVtcyB2ZXJ5IGV4b3RpYyBhcyBhIG1lc29uIGNvbW1hbmQg
bGluZSBvcHRpb24uDQpFaXRoZXIgcHV0IGl0IGluIHJ0ZV9jb25maWcuaCwgb3IgbWFrZSBpdCBD
UFUgc3BlY2lmaWMuDQoNCg==
