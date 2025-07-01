Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 19022C7EE30
	for <dpdk-dev@archiver.kernel.org>; Tue,  1 Jul 2025 09:09:05 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 1A40340269;
	Tue,  1 Jul 2025 11:09:04 +0200 (CEST)
Received: from dkmailrelay1.smartsharesystems.com
 (smartserver.smartsharesystems.com [77.243.40.215])
 by mails.dpdk.org (Postfix) with ESMTP id 179D0400D7
 for <dev@dpdk.org>; Tue,  1 Jul 2025 11:09:02 +0200 (CEST)
Received: from smartserver.smartsharesystems.com
 (smartserver.smartsharesys.local [192.168.4.10])
 by dkmailrelay1.smartsharesystems.com (Postfix) with ESMTP id C273A20525;
 Tue,  1 Jul 2025 11:09:01 +0200 (CEST)
Content-class: urn:content-classes:message
Subject: RE: [PATCH] net/i40e: Fast release optimizations
MIME-Version: 1.0
Content-Type: text/plain;
	charset="UTF-8"
Content-Transfer-Encoding: base64
Date: Tue, 1 Jul 2025 11:09:01 +0200
X-MimeOLE: Produced By Microsoft Exchange V6.5
Message-ID: <98CBD80474FA8B44BF855DF32C47DC35E9FD67@smartserver.smartshare.dk>
In-Reply-To: <bb4a70c74968437491d61714994a7006@huawei.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: [PATCH] net/i40e: Fast release optimizations
Thread-Index: AQHb5M8cy6WBmzI3MUC2TH1cjpMU4LQbm/iwgAAfruCAACXVQIAAjgtQgACQEeA=
References: <20250624061238.89259-1-mb@smartsharesystems.com><cda18d9197ed4ee9bd5ed73fd02bd032@huawei.com><98CBD80474FA8B44BF855DF32C47DC35E9FD5F@smartserver.smartshare.dk>
 <98CBD80474FA8B44BF855DF32C47DC35E9FD60@smartserver.smartshare.dk>
 <bb4a70c74968437491d61714994a7006@huawei.com>
From: =?UTF-8?B?TW9ydGVuIEJyw7hydXA=?= <mb@smartsharesystems.com>
To: "Konstantin Ananyev" <konstantin.ananyev@huawei.com>,
 "Bruce Richardson" <bruce.richardson@intel.com>, <dev@dpdk.org>
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

PiBGcm9tOiBLb25zdGFudGluIEFuYW55ZXYgW21haWx0bzprb25zdGFudGluLmFuYW55ZXZAaHVh
d2VpLmNvbV0NCj4gU2VudDogVHVlc2RheSwgMSBKdWx5IDIwMjUgMTAuMTYNCg0KWy4uLl0NCg0K
PiBJIGFtIHRhbGtpbmcgYWJvdXQgZGlmZmVyZW50IHRoaW5nOg0KPiBJIHRoaW5rIHdpdGggc29t
ZSBleHRyYSBlZmZvcnQgZHJpdmVyIGNhbiB1c2UgKGluIHNvbWUgY2FzZXMpDQo+IHJ0ZV9tYnVm
X3Jhd19mcmVlX2J1bGsoKSAgZXZlbiAgd2hlbiAgIFJURV9FVEhfVFhfT0ZGTE9BRF9NQlVGX0ZB
U1RfRlJFRQ0KPiBpcyBub3Qgc3BlY2lmaWVkLg0KPiBMZXQgc2F5IHdlIGNhbiBtYWtlIHR4cS0+
ZmFzdF9mcmVlX21wW10gYW4gYXJyYXkgd2l0aCB0aGUgc2FtZSBzaXplIGFzIHR4cS0NCj4gPnR4
ZXBbXS4NCj4gQXQgdHhfYnVyc3QoKSB3aGVuIGZpbGxpbmcgdHhlcFtdIHdlIGNhbiBkbyBwcmVf
ZnJlZSgpIGNoZWNrcyBmb3IgdGhhdCBtYnVmLA0KPiBhbmQgaW4gY2FzZSBvZiBzdWNjZXNzIHN0
b3JlIGl0J3MgbWVtcG9vbCBwb2ludGVyIGluIGNvcnJlc3BvbmRpbmcgIHR4cS0NCj4gPmZhc3Rf
ZnJlZV9tcFtdLA0KPiBvdGhlcndpc2UgcHV0IE5VTEwgdGhlcmUuDQo+IFRoZW4gYXQgdHhfZnJl
ZSgpIHdlIGNhbiBzY2FuIGZhc3RfZnJlZV9tcFtdIGFuZCBpbnZva2UgICByYXdfZnJlZSgpIGZv
ciBub24tDQo+IE5VTEwgZW50cmllcy4NCj4gQWdhaW4sIGZvciBub3cgaXQgaXMganVzdCBhbiBp
ZGVhIHByb2JhYmx5IHdvcnRoIHRvIHRoaW5rIGFib3V0Lg0KDQpZZXMsIHRoYXQgc2VlbXMgbGlr
ZSBhbiBleGNlbGxlbnQgaWRlYSwgY2VydGFpbmx5IHdvcnRoIGNvbnNpZGVyaW5nIQ0KDQpBdCB0
eF9mcmVlKCksIHRoZSBtYnVmcyBtaWdodCBiZSBjb2xkLCBzbyBub3QgYWNjZXNzaW5nIHRoZW0g
YXQgdGhpcyBwb2ludCBpbXByb3ZlcyBwZXJmb3JtYW5jZS4gKFdoaWNoIGlzIGFsc28gdGhlIHBv
aW50IG9mIG15IHBhdGNoLikNCg0KQXQgdHhfYnVyc3QoKSwgdGhlIG1idWZzIGFyZSByZWFkIGFu
eXdheSAodGhlaXIgaW5mb3JtYXRpb24gaXMgd3JpdHRlbiBpbnRvIHRoZSB0eCBkZXNjcmlwdG9y
cyksIHNvIHRoZSBtYnVmcyBhcmUgaG90IGluIHRoZSBjYWNoZSBhdCB0aGlzIHBvaW50Lg0KDQpC
ZXN0IGNhc2Ugd2l0aCB5b3VyIHN1Z2dlc3Rpb24sIHJ0ZV9wa3RtYnVmX3ByZWZyZWVfc2VnKCkg
ZG9lc24ndCB3cml0ZSB0aGUgbWJ1Ziwgc28gdGhlIHBlcmZvcm1hbmNlIGNvc3Qgb2YgZG9pbmcg
aXQgYXQgdHhfYnVyc3QoKSBpcyBleHRyZW1lbHkgbG93Lg0KDQpXb3JzdCBjYXNlIHdpdGggeW91
ciBzdWdnZXN0aW9uLCBydGVfcGt0bWJ1Zl9wcmVmcmVlX3NlZygpIGRvZXMgd3JpdGUgdGhlIG1i
dWYsIHNvIHRoZSBtYnVmIHdyaXRlIG9wZXJhdGlvbiBzaW1wbHkgbW92ZXMgZnJvbSB0eF9mcmVl
KCkgdG8gdHhfYnVyc3QoKS4NCkhvd2V2ZXIsIGluIHR4X2J1cnN0KCksIHRoZSBtYnVmIGlzIGFs
cmVhZHkgaG90IGluIHRoZSBjYWNoZSwgc28gcGVyIHRyYW5zbWl0dGVkIG1idWYsIHdlIGdldCBv
bmUgbG9hZCtzdG9yZSBhdCB0eF9idXJzdCgpIGluc3RlYWQgb2Ygb25lIGxvYWQgYXQgdHhfYnVy
c3QoKSArIG9uZSBsb2FkK3N0b3JlIGF0IHR4X2ZyZWUoKS4NCg0K
