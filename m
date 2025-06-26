Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E545EC7EE30
	for <dpdk-dev@archiver.kernel.org>; Thu, 26 Jun 2025 15:23:44 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 3C3E94021F;
	Thu, 26 Jun 2025 17:23:44 +0200 (CEST)
Received: from dkmailrelay1.smartsharesystems.com
 (smartserver.smartsharesystems.com [77.243.40.215])
 by mails.dpdk.org (Postfix) with ESMTP id CE95F40156
 for <dev@dpdk.org>; Thu, 26 Jun 2025 17:23:42 +0200 (CEST)
Received: from smartserver.smartsharesystems.com
 (smartserver.smartsharesys.local [192.168.4.10])
 by dkmailrelay1.smartsharesystems.com (Postfix) with ESMTP id 956462045F;
 Thu, 26 Jun 2025 17:23:42 +0200 (CEST)
Subject: RE: Function to fail at build time?
MIME-Version: 1.0
Content-Type: text/plain;
	charset="UTF-8"
Date: Thu, 26 Jun 2025 17:23:40 +0200
Content-Transfer-Encoding: base64
Message-ID: <98CBD80474FA8B44BF855DF32C47DC35E9FD46@smartserver.smartshare.dk>
Content-class: urn:content-classes:message
X-MimeOLE: Produced By Microsoft Exchange V6.5
In-Reply-To: <20250626073131.1b4e3449@hermes.local>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: Function to fail at build time?
Thread-Index: AdvmpwUWIeSPMzKiR6a+iLpKDJEFpwAAP+tQ
References: <98CBD80474FA8B44BF855DF32C47DC35E9FD40@smartserver.smartshare.dk>
 <20250626073131.1b4e3449@hermes.local>
From: =?UTF-8?B?TW9ydGVuIEJyw7hydXA=?= <mb@smartsharesystems.com>
To: "Stephen Hemminger" <stephen@networkplumber.org>
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

PiBGcm9tOiBTdGVwaGVuIEhlbW1pbmdlciBbbWFpbHRvOnN0ZXBoZW5AbmV0d29ya3BsdW1iZXIu
b3JnXQ0KPiBTZW50OiBUaHVyc2RheSwgMjYgSnVuZSAyMDI1IDE2LjMyDQo+IA0KPiBPbiBUaHUs
IDI2IEp1biAyMDI1IDAxOjU1OjAyICswMjAwDQo+IE1vcnRlbiBCcsO4cnVwIDxtYkBzbWFydHNo
YXJlc3lzdGVtcy5jb20+IHdyb3RlOg0KPiANCj4gPiBJIHdhcyB3b25kZXJpbmcgaWYgdGhpcyB3
YXMgc29tZWhvdyBwb3NzaWJsZToNCj4gPg0KPiA+ICNkZWZpbmUgUlRFX1ZFUklGWShleHApIGRv
IHsgXA0KPiA+ICsJaWYgKF9fcnRlX2NvbnN0YW50KGV4cCkpIFwNCj4gPiArCQlGQUlMX0FUX0JV
SUxEX1RJTUUoKTsgXA0KPiA+IAlpZiAodW5saWtlbHkoIShleHApKSkgXA0KPiA+IAkJcnRlX3Bh
bmljKCJsaW5lICVkXHRhc3NlcnQgXCIlc1wiIGZhaWxlZFxuIiwgX19MSU5FX18sDQo+ICNleHAp
OyBcDQo+ID4gfSB3aGlsZSAoMCkNCj4gPg0KPiA+IEkgdHJpZWQgc3RhdGljX2Fzc2VydCgpLCBi
dXQgaXQgY2Fubm90IGJlIHVzZWQgaW4gdGhpcyB3YXkuDQo+IA0KPiANCj4gV2hhdCBoYXBwZW5z
Pw0KDQpUaGUgY29tcGlsZXIgc2F5czoNCmVycm9yOiBleHBlY3RlZCBleHByZXNzaW9uIGJlZm9y
ZSAnX1N0YXRpY19hc3NlcnQnDQoNCkl0IHNlZW1zIHN0YXRpY19hc3NlcnQgaXMgYSBkZWNsYXJh
dGlvbiwgc28geW91IGNhbm5vdCB0cmVhdCBpdCBhcyBhIGZ1bmN0aW9uLCB1c2luZyBlLmcuOg0K
aWYgKDEpIHN0YXRpY19hc3NlcnQoMSwgIk9LIik7DQoNCg0K
