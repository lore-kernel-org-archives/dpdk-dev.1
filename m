Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EB846C2D0CD
	for <dpdk-dev@archiver.kernel.org>; Sat, 17 May 2025 12:59:23 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id BC75F4067B;
	Sat, 17 May 2025 14:59:22 +0200 (CEST)
Received: from dkmailrelay1.smartsharesystems.com
 (smartserver.smartsharesystems.com [77.243.40.215])
 by mails.dpdk.org (Postfix) with ESMTP id 02A1A40678
 for <dev@dpdk.org>; Sat, 17 May 2025 14:59:21 +0200 (CEST)
Received: from smartserver.smartsharesystems.com
 (smartserver.smartsharesys.local [192.168.4.10])
 by dkmailrelay1.smartsharesystems.com (Postfix) with ESMTP id B36212064C;
 Sat, 17 May 2025 14:59:21 +0200 (CEST)
Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="UTF-8"
Content-Transfer-Encoding: base64
Subject: RE: [PATCH v5 1/2] lib/fib: remove warning about implicit 64-bit
 conversion
X-MimeOLE: Produced By Microsoft Exchange V6.5
Date: Sat, 17 May 2025 14:59:17 +0200
Message-ID: <98CBD80474FA8B44BF855DF32C47DC35E9FC5E@smartserver.smartshare.dk>
In-Reply-To: <CAOaVG15FDQTGgtA6VkqGMR1A=DwXvTYGGGcxDrNQrtqjxZxxhg@mail.gmail.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: [PATCH v5 1/2] lib/fib: remove warning about implicit 64-bit
 conversion
Thread-Index: AdvHHDVeJcB4iQLNSUyi0mBKVWt6UAADucfQ
References: <1733281010-23780-1-git-send-email-andremue@linux.microsoft.com>
 <1747428335-3736-1-git-send-email-andremue@linux.microsoft.com>
 <1747428335-3736-2-git-send-email-andremue@linux.microsoft.com>
 <CAOaVG15FDQTGgtA6VkqGMR1A=DwXvTYGGGcxDrNQrtqjxZxxhg@mail.gmail.com>
From: =?UTF-8?B?TW9ydGVuIEJyw7hydXA=?= <mb@smartsharesystems.com>
To: "Stephen Hemminger" <stephen@networkplumber.org>,
 "Andre Muezerie" <andremue@linux.microsoft.com>
Cc: "dev" <dev@dpdk.org>, "Medvedkin, Vladimir" <vladimir.medvedkin@intel.com>
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

RnJvbTogU3RlcGhlbiBIZW1taW5nZXIgW21haWx0bzpzdGVwaGVuQG5ldHdvcmtwbHVtYmVyLm9y
Z10gDQpTZW50OiBTYXR1cmRheSwgMTcgTWF5IDIwMjUgMTMuMTANCg0KT2suDQpXb25kZXIgaWYg
UlRFX1BUUl9BREQgc2hvdWxkIGhhdmUgdGhlIGNhc3QgdGhlcmUgaW5zdGVhZMKgDQoNCk1vcnRl
bjogQ29uc2lkZXJlZCB0aGUgc2FtZTsgYnV0IHByZWZlciBub3QuIEl0IHdpbGwgc3VwcHJlc3Mg
d2FybmluZ3MgbGlrZSB0aGlzLCB3aGljaCBtYXkgYmUgcmVhbC4NCg0KDQpPbiBTYXQsIE1heSAx
NywgMjAyNSwgMDU6NDUgQW5kcmUgTXVlemVyaWUgPGFuZHJlbXVlQGxpbnV4Lm1pY3Jvc29mdC5j
b20+IHdyb3RlOg0KTVNWQyBpc3N1ZXMgdGhlIHdhcm5pbmcgYmVsb3c6DQoNCi4uL2xpYi9maWIv
dHJpZS5jKDM0MSk6IHdhcm5pbmcgQzQzMzQ6ICc8PCc6DQpyZXN1bHQgb2YgMzItYml0IHNoaWZ0
IGltcGxpY2l0bHkgY29udmVydGVkIHRvIDY0IGJpdHMNCih3YXMgNjQtYml0IHNoaWZ0IGludGVu
ZGVkPykNCg0KVGhlIGZpeCBpcyB0byBjYXN0ICgxKSBleHBsaWNpdGx5IHRvIHVpbnRwdHJfdCBz
aW5jZSBpdCBpcyB1c2VkDQppbiBwb2ludGVyIGFyaXRobWV0aWMuDQoNClNpZ25lZC1vZmYtYnk6
IEFuZHJlIE11ZXplcmllIDxhbmRyZW11ZUBsaW51eC5taWNyb3NvZnQuY29tPg0KLS0tDQrCoGxp
Yi9maWIvdHJpZS5jIHwgMiArLQ0KwqAxIGZpbGUgY2hhbmdlZCwgMSBpbnNlcnRpb24oKyksIDEg
ZGVsZXRpb24oLSkNCg0KZGlmZiAtLWdpdCBhL2xpYi9maWIvdHJpZS5jIGIvbGliL2ZpYi90cmll
LmMNCmluZGV4IDZjMjAwNTdhYzUuLjI0YTA4YjgyN2QgMTAwNjQ0DQotLS0gYS9saWIvZmliL3Ry
aWUuYw0KKysrIGIvbGliL2ZpYi90cmllLmMNCkBAIC0zMzgsNyArMzM4LDcgQEAgd3JpdGVfZWRn
ZShzdHJ1Y3QgcnRlX3RyaWVfdGJsICpkcCwgY29uc3QgdWludDhfdCAqaXBfcGFydCwgdWludDY0
X3QgbmV4dF9ob3AsDQrCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCBpZiAocmV0IDwgMCkNCsKgIMKg
IMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIHJldHVybiByZXQ7DQrCoCDCoCDCoCDCoCDC
oCDCoCDCoCDCoCBpZiAoZWRnZSA9PSBMRURHRSkgew0KLcKgIMKgIMKgIMKgIMKgIMKgIMKgIMKg
IMKgIMKgIMKgIMKgd3JpdGVfdG9fZHAoKHVpbnQ4X3QgKilwICsgKDEgPDwgZHAtPm5oX3N6KSwN
CivCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoHdyaXRlX3RvX2RwKFJURV9QVFJf
QUREKHAsICh1aW50cHRyX3QpKDEpIDw8IGRwLT5uaF9zeiksDQrCoCDCoCDCoCDCoCDCoCDCoCDC
oCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCBuZXh0X2hvcCA8PCAxLCBkcC0+bmhfc3osIFVJ
TlQ4X01BWCAtICppcF9wYXJ0KTsNCsKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIH0gZWxzZSB7DQrC
oCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCB3cml0ZV90b19kcChnZXRfdGJsX3Bf
YnlfaWR4KGRwLT50Ymw4LCB0Ymw4X2lkeCAqDQotLSANCjIuNDkuMC52ZnMuMC4zDQo=
