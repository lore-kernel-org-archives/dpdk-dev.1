Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BCF7B606A323
	for <dpdk-dev@archiver.kernel.org>; Fri, 13 Nov 2026 18:07:13 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 1E714402A4;
	Fri, 13 Nov 2026 19:07:12 +0100 (CET)
Received: from dkmailrelay1.smartsharesystems.com
 (smartserver.smartsharesystems.com [77.243.40.215])
 by mails.dpdk.org (Postfix) with ESMTPS id A3AD54003C;
 Fri, 13 Nov 2026 19:07:10 +0100 (CET)
Received: from smartserver.smartsharesystems.com
 (smartserver.smartsharesys.local [192.168.4.10])
 by dkmailrelay1.smartsharesystems.com (Postfix) with ESMTP id 44CCE20972;
 Fri, 13 Nov 2026 19:07:10 +0100 (CET)
Content-class: urn:content-classes:message
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="utf-8"
Subject: RE: [PATCH] bitops: fix integer overflow in align64pow2
Content-Transfer-Encoding: base64
X-MimeOLE: Produced By Microsoft Exchange V6.5
Date: Fri, 13 Nov 2026 19:07:09 +0100
Message-ID: <98CBD80474FA8B44BF855DF32C47DC35F65B0C@smartserver.smartshare.dk>
In-Reply-To: <20261113141307.4727-1-ms.bulatov7@gmail.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: [PATCH] bitops: fix integer overflow in align64pow2
Thread-Index: Ad1zeUOAG5Ej/EYnRmi6+gToBXNRwQAH0hNw
References: <20261113141307.4727-1-ms.bulatov7@gmail.com>
From: =?utf-8?B?TW9ydGVuIEJyw7hydXA=?= <mb@smartsharesystems.com>
To: "Bulatov Mark" <ms.bulatov7@gmail.com>,
 "Jack Bond-Preston" <jack.bond-preston@foss.arm.com>,
 "Ferruh Yigit" <ferruh.yigit@amd.com>,
 "Tyler Retzlaff" <roretzla@linux.microsoft.com>,
 "Bruce Richardson" <bruce.richardson@intel.com>
Cc: <dev@dpdk.org>, <stable@dpdk.org>, "Alexey Simakov" <bigalex934@gmail.com>
X-BeenThere: dev@dpdk.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: DPDK patches and discussions <dev.dpdk.org>
List-Archive: <http://mails.dpdk.org/archives/dev/>
List-Post: <mailto:dev@dpdk.org>
List-Help: <mailto:dev-request@dpdk.org?subject=help>
List-Subscribe: <https://mails.dpdk.org/listinfo/dev>,
 <mailto:dev-request@dpdk.org?subject=subscribe>
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

PiBJZiB0aGUgZnVuY3Rpb24gcnRlX2NvbWJpbmU2NG1zMWIoKSByZXR1cm5zIHRoZSBtYXhpbXVt
IHBvc3NpYmxlDQo+IHVpbnQ2NF90DQo+IHZhbHVlLCBpdCB3aWxsIHJlc3VsdCBpbiBhbiBvdmVy
Zmxvdy4NCj4gDQo+IFRvIGF2b2lkIHRoaXMsIGFkZCBhIGNoZWNrLg0KPiANCj4gRm91bmQgYnkg
TGludXggVmVyaWZpY2F0aW9uIENlbnRlciAobGludXh0ZXN0aW5nLm9yZykgd2l0aCBTVkFDRS4N
Cj4gDQo+IEZpeGVzOiA3MjUzZTNkMmE1ICgiYml0b3BzOiBtb3ZlIGJpdCBjb3VudCBmdW5jdGlv
bnMiKQ0KPiBDYzogc3RhYmxlQGRwZGsub3JnDQo+IA0KPiBTaWduZWQtb2ZmLWJ5OiBBbGV4ZXkg
U2ltYWtvdiA8YmlnYWxleDkzNEBnbWFpbC5jb20+DQo+IFNpZ25lZC1vZmYtYnk6IE1hcmsgQnVs
YXRvdiA8bXMuYnVsYXRvdjdAZ21haWwuY29tPg0KPiAtLS0NCj4gIGxpYi9lYWwvaW5jbHVkZS9y
dGVfYml0b3BzLmggfCAzICsrKw0KPiAgMSBmaWxlIGNoYW5nZWQsIDMgaW5zZXJ0aW9ucygrKQ0K
PiANCj4gZGlmZiAtLWdpdCBhL2xpYi9lYWwvaW5jbHVkZS9ydGVfYml0b3BzLmgNCj4gYi9saWIv
ZWFsL2luY2x1ZGUvcnRlX2JpdG9wcy5oDQo+IGluZGV4IDQ1MjU1YjY4YWEuLmQyZWQwYzNjNjEg
MTAwNjQ0DQo+IC0tLSBhL2xpYi9lYWwvaW5jbHVkZS9ydGVfYml0b3BzLmgNCj4gKysrIGIvbGli
L2VhbC9pbmNsdWRlL3J0ZV9iaXRvcHMuaA0KPiBAQCAtMTMwNyw2ICsxMzA3LDkgQEAgcnRlX2Fs
aWduNjRwb3cyKHVpbnQ2NF90IHYpDQo+ICAJdi0tOw0KPiAgCXYgPSBydGVfY29tYmluZTY0bXMx
Yih2KTsNCj4gDQo+ICsJaWYgKHYgPT0gVUlOVDY0X01BWCkNCj4gKwkJdi0tOw0KPiArDQo+ICAJ
cmV0dXJuIHYgKyAxOw0KPiAgfQ0KDQpOQUsuDQoNClRoZSBvdmVyZmxvdyBidWcgaXMgcHJlc2Vu
dCwgYWxzbyBpbiBydGVfYWxpZ24zMnBvdzIoKS4NCg0KQnV0IHRoZSBmaXggaXMgd3Jvbmc7IGl0
IGRvZXMgbm90IHJldHVybiBhIHBvd2VyLW9mLXR3byB2YWx1ZS4NCg0KVGhlcmUgaXMgbm8gc29s
dXRpb24gdG8gZml4IHRoaXMgb3ZlcmZsb3cuDQpUaGUgb25seSBwb3NzaWJsZSBmaXggaXMgdG8g
c3BlY2lmeSBpbiB0aGUgZnVuY3Rpb24gZG9jdW1lbnRhdGlvbiB0aGF0IHRoZSBwYXJhbWV0ZXIg
bXVzdCBub3QgZXhjZWVkIDEgPDwgNjMgKDB4ODAwMDAwMDAwMDAwMDAwMCkuDQoNCi1Nb3J0ZW4N
Cg0K
