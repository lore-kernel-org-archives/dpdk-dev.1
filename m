Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D150606A320
	for <dpdk-dev@archiver.kernel.org>; Thu, 19 Nov 2026 19:27:40 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 2B9ED402DA;
	Thu, 19 Nov 2026 20:27:38 +0100 (CET)
Received: from dkmailrelay1.smartsharesystems.com
 (smartserver.smartsharesystems.com [77.243.40.215])
 by mails.dpdk.org (Postfix) with ESMTPS id 5C494400D7;
 Thu, 19 Nov 2026 20:27:36 +0100 (CET)
Received: from smartserver.smartsharesystems.com
 (smartserver.smartsharesys.local [192.168.4.10])
 by dkmailrelay1.smartsharesystems.com (Postfix) with ESMTP id C562320C50;
 Thu, 19 Nov 2026 20:27:35 +0100 (CET)
Content-class: urn:content-classes:message
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="utf-8"
Content-Transfer-Encoding: base64
Subject: RE: [PATCH v4 2/3] mempool: fix dump of unpopulated pool
X-MimeOLE: Produced By Microsoft Exchange V6.5
Date: Thu, 19 Nov 2026 20:27:33 +0100
Message-ID: <98CBD80474FA8B44BF855DF32C47DC35F65B17@smartserver.smartshare.dk>
In-Reply-To: <hJsCtzRYR1eG3PZiPV7p7Q@monjalon.net>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: [PATCH v4 2/3] mempool: fix dump of unpopulated pool
Thread-Index: Ad14NNlOvArgpGP8RhG/o/n998HIOQAJskbA
References: <20261109144054.3784583-1-rsanford2@gmail.com>
 <eexnNMGcSbWMwzjgikVLXw@monjalon.net>
 <98CBD80474FA8B44BF855DF32C47DC35F65B15@smartserver.smartshare.dk>
 <hJsCtzRYR1eG3PZiPV7p7Q@monjalon.net>
From: =?utf-8?B?TW9ydGVuIEJyw7hydXA=?= <mb@smartsharesystems.com>
To: "Thomas Monjalon" <thomas@monjalon.net>,
 "Robert Sanford" <rsanford@akamai.com>,
 "Robert Sanford" <rsanford2@gmail.com>
Cc: <dev@dpdk.org>, <andrew.rybchenko@oktetlabs.ru>, <olivier.matz@6wind.com>,
 <stable@dpdk.org>, "David Marchand" <david.marchand@redhat.com>
X-BeenThere: dev@dpdk.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: DPDK patches and discussions <dev.dpdk.org>
List-Archive: <http://mails.dpdk.org/archives/dev/>
List-Post: <mailto:dev@dpdk.org>
List-Help: <mailto:dev-request@dpdk.org?subject=help>
List-Subscribe: <https://mails.dpdk.org/listinfo/dev>,
 <mailto:dev-request@dpdk.org?subject=subscribe>
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

PiBGcm9tOiBUaG9tYXMgTW9uamFsb24gW21haWx0bzp0aG9tYXNAbW9uamFsb24ubmV0XQ0KPiBT
ZW50OiBUaHVyc2RheSwgMTkgTm92ZW1iZXIgMjAyNiAwNi40Nw0KPiANCj4gMTkvMTEvMjAyNiAx
NToxOCwgTW9ydGVuIEJyw7hydXA6DQo+ID4gPiBGcm9tOiBUaG9tYXMgTW9uamFsb24gW21haWx0
bzp0aG9tYXNAbW9uamFsb24ubmV0XQ0KPiA+ID4gU2VudDogVGh1cnNkYXksIDE5IE5vdmVtYmVy
IDIwMjYgMDYuMDgNCj4gPiA+DQo+ID4gPiAxMi8xMS8yMDI2IDE2OjQzLCBSb2JlcnQgU2FuZm9y
ZDoNCj4gPiA+ID4gKyogKipBZGRlZCBmdW5jdGlvbiB0byBjaGVjayBpZiBhIG1lbXBvb2wgaXMg
Y3JlYXRlZC4qKg0KPiA+ID4gPiArDQo+ID4gPiA+ICsgIEFkZGVkIHRoZSBgYHJ0ZV9tZW1wb29s
X2lzX2NyZWF0ZWQoKWBgIGZ1bmN0aW9uDQo+ID4gPiA+ICsgIHRvIGNoZWNrIHdoZXRoZXIgdGhl
IHN0b3JlIG9mIGEgbWVtcG9vbCBoYXMgYmVlbiBjcmVhdGVkLg0KPiA+ID4gPiArICBgYHJ0ZV9t
ZW1wb29sX3dhbGsoKWBgIGNhbGxiYWNrcyBjYW4gdXNlIGl0IHRvIHNraXAgbWVtcG9vbHMNCj4g
PiA+ID4gKyAgdGhhdCBhcmUgbm90IHBvcHVsYXRlZCB5ZXQgYmVmb3JlIHF1ZXJ5aW5nIHRoZSBt
ZW1wb29sIGRyaXZlci4NCj4gPiA+DQo+ID4gPiBJZiB1c2FnZSBpcyBpbnRlcm5hbCwgd2h5IGV4
cG9zaW5nIHRoaXMgZnVuY3Rpb24gcHVibGljbHk/DQo+ID4NCj4gPiBJdCBpcyBhbHNvIGZvciBw
dWJsaWMgdXNlOg0KPiA+IElmIGFuIGFwcGxpY2F0aW9uIHdhbGtzIHRoZSBsaXN0IG9mIG1lbXBv
b2xzIHVzaW5nIHRoZSBwdWJsaWMNCj4gZnVuY3Rpb24gcnRlX21lbXBvb2xfd2FsaygpLCB3ZSBu
ZWVkIGEgcHVibGljIGZ1bmN0aW9uIGZvciB0aGUNCj4gYXBwbGljYXRpb24ncyBjYWxsYmFjayB0
byBkZXRlcm1pbmUgaWYgdGhlIG1lbXBvb2wgaXMgY3JlYXRlZCAoaS5lLg0KPiBkcml2ZXIgY2Fs
bGJhY2tzIGFyZSBpbml0aWFsaXplZCkuIElmIHRoZSBtZW1wb29sIGlzIG5vdCBjcmVhdGVkLA0K
PiBhY2Nlc3NpbmcgdGhlIG1lbXBvb2wgZHJpdmVyIGlzIG5vdyBhbGxvd2VkLg0KPiA+DQo+ID4g
Pg0KPiA+ID4gWy4uLl0NCj4gPiA+ID4gK2Jvb2wgcnRlX21lbXBvb2xfaXNfY3JlYXRlZChjb25z
dCBzdHJ1Y3QgcnRlX21lbXBvb2wgKm1wKTsNCj4gPiA+DQo+ID4gPiBBbnkgbmV3IEFQSSBtdXN0
IGVudGVyIGluIGFuIGV4cGVyaW1lbnRhbCBmaXJzdC4NCj4gPiA+IEJ1dCBoZXJlIHdlIG1heSBu
b3QgbmVlZCB0byBleHBvc2UgaXQgYXMgYW4gQVBJPw0KPiA+DQo+ID4gSWYgaXQgaXMgbWFya2Vk
IGFzIGV4cGVyaW1lbnRhbCwgaXQgY2Fubm90IGJlIHVzZWQgaW50ZXJuYWxseSwgYW5kDQo+IGl0
cyBpbnRlcm5hbCB1c2VyIHdvdWxkIG5lZWQgdG8gaW1wbGVtZW50IHNpbWlsYXIgZnVuY3Rpb25h
bGl0eS4NCj4gPiBBbmQgc2luY2UgaXQgaXMgYSBzaW1wbGUgZnVuY3Rpb24sIHdlIGRlY2lkZWQg
dG8gc2tpcCB0aGUNCj4gZXhwZXJpbWVudGFsIHN0YWdlLg0KPiA+IFRoZSBhbHRlcm5hdGl2ZSB3
YXMgbWFraW5nIGl0IGlubGluZTsgYnV0IGl0IGlzIG5vdCBhIGZhc3QgcGF0aA0KPiBmdW5jdGlv
biwgSSBwcmVmZXJyZWQgbm90IHRvLg0KPiANCj4gT2ggSSBmb3Jnb3QgdGhpcyBjb25zdHJhaW50
Lg0KPiANCj4gUGxlYXNlIGFkZCB0aGlzIGV4cGxhbmF0aW9uIGluIHRoZSBjb21taXQgbG9nLg0K
PiANCj4gQnkgdGhlIHdheSBJIGFzc3VtZSBpdCBpcyB0b28gbGF0ZSB0byBhZGQgc3VjaCBhIGZ1
bmN0aW9uIGluIDI2LjExLA0KPiBhbmQgaXQgaXMgbm90IGEgcmVjZW50IHJlZ3Jlc3Npb24sIHNv
IGl0IGNhbiB3YWl0IGEgbGl0dGxlLCByaWdodD8NCg0KQWdyZWUuDQoNCi1Nb3J0ZW4NCg==
