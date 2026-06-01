Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8D1FACD6E56
	for <dpdk-dev@archiver.kernel.org>; Mon,  1 Jun 2026 12:58:49 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 9BBA54025F;
	Mon,  1 Jun 2026 14:58:48 +0200 (CEST)
Received: from dkmailrelay1.smartsharesystems.com
 (smartserver.smartsharesystems.com [77.243.40.215])
 by mails.dpdk.org (Postfix) with ESMTP id 60D284025A
 for <dev@dpdk.org>; Mon,  1 Jun 2026 14:58:47 +0200 (CEST)
Received: from smartserver.smartsharesystems.com
 (smartserver.smartsharesys.local [192.168.4.10])
 by dkmailrelay1.smartsharesystems.com (Postfix) with ESMTP id 3356A208EE;
 Mon,  1 Jun 2026 14:58:47 +0200 (CEST)
Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="utf-8"
Content-Transfer-Encoding: base64
Subject: RE: [PATCH 5/7] app/test/mempool_perf: scale down for high core counts
Date: Mon, 1 Jun 2026 14:58:43 +0200
Message-ID: <98CBD80474FA8B44BF855DF32C47DC35F658CA@smartserver.smartshare.dk>
X-MimeOLE: Produced By Microsoft Exchange V6.5
In-Reply-To: <20260529171417.526892-6-stephen@networkplumber.org>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: [PATCH 5/7] app/test/mempool_perf: scale down for high core
 counts
Thread-Index: Adzvjpt6nB3F1gC+QPOjU5qLEW2C2gCMzt6w
References: <20260529171417.526892-1-stephen@networkplumber.org>
 <20260529171417.526892-6-stephen@networkplumber.org>
From: =?utf-8?B?TW9ydGVuIEJyw7hydXA=?= <mb@smartsharesystems.com>
To: "Stephen Hemminger" <stephen@networkplumber.org>,
 "Andrew Rybchenko" <andrew.rybchenko@oktetlabs.ru>, <dev@dpdk.org>
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
b3JnXQ0KPiBTZW50OiBGcmlkYXksIDI5IE1heSAyMDI2IDE5LjExDQo+IA0KPiBPbiBhIDMyLWNv
cmUgc3lzdGVtIHRoZSB0ZXN0IG1hdHJpeCBydW5zIHRoZSBjYXJ0ZXNpYW4gcHJvZHVjdCBvZg0K
PiA0IG1lbXBvb2xzLCAzIGNvcmUtY291bnQgY29uZmlndXJhdGlvbnMgYW5kIH4zNDAgKG5fa2Vl
cCwgYnVsaykNCj4gcG9pbnRzIGF0IFRJTUVfUz0xIHNlY29uZCBlYWNoOiBhYm91dCA2NyBtaW51
dGVzIHRvdGFsLCB3ZWxsIHBhc3QNCj4gdGhlIDEwIG1pbnV0ZSBwZXJmLXRlc3QgdGltZW91dC4N
Cj4gDQo+IFR3byByZWR1Y3Rpb25zLCBubyBsb3NzIG9mIG1lYW5pbmdmdWwgc2lnbmFsOg0KPiAN
Cj4gMS4gUGVyLXBvaW50IGR1cmF0aW9uOiAxIHNlY29uZCAtPiAyMDAgbXMuICBFYWNoIHBvaW50
IGN1cnJlbnRseQ0KPiAgICBjb2xsZWN0cyAxMF41LTEwXjYgbWVtcG9vbCBvcHM7IDIwMCBtcyBz
dGlsbCB5aWVsZHMgPjEwXjQNCj4gICAgc2FtcGxlcywgd2VsbCBhYm92ZSB0aGUgbm9pc2UgZmxv
b3IgZm9yIGEgY3ljbGVzLXBlci1vcCBhdmVyYWdlLg0KDQpBY2sgdG8gdGhpcy4NCg0KPiANCj4g
Mi4gTWF0cml4IHRyaW06IGRyb3AgYWRqYWNlbnQgYnVsayBhbmQgbl9rZWVwIHBvaW50cyB0aGF0
IGRvbid0DQo+ICAgIHByb2R1Y2UgcmVnaW1lIGNoYW5nZXMuICBSZXRhaW5lZCBzZXQgY292ZXJz
IHRoZSBib3VuZGFyaWVzDQo+ICAgIHRoYXQgbWF0dGVyOiAxLCA0LCBjYWNoZS1saW5lIGJ1cnN0
ICg4KSwgdHlwaWNhbCBwYWNrZXQgYnVyc3QNCj4gICAgKDMyKSBhbmQgY2FjaGUgc2l6ZSAoUlRF
X01FTVBPT0xfQ0FDSEVfTUFYX1NJWkUgPSA1MTIpIGZvciBidWxrOw0KPiAgICAzMiAoZml0cyBp
biBjYWNoZSksIDUxMiAoPSBjYWNoZSBzaXplKSBhbmQgMzI3NjggKGZhciBleGNlZWRzDQo+ICAg
IGNhY2hlKSBmb3Igbl9rZWVwLg0KDQpNeSBtZW1wb29sIG9wdGltaXphdGlvbiBwYXRjaCBbMV0g
aW50cm9kdWNlcyBhIGJvdW5jZSBidWZmZXIgbGltaXQsIHNvIGh1Z2UgcmVxdWVzdHMgYXJlIG5v
dCBuZWVkbGVzc2x5IGNvcGllZCB0d2ljZSB0byBib3VuY2UgdGhyb3VnaCB0aGUgY2FjaGUsIGJ1
dCBhcmUgbW92ZWQgZGlyZWN0bHkgYmV0d2VlbiBhcHBsaWNhdGlvbiBtZW1vcnkgYW5kIHRoZSBt
ZW1wb29sIGJhY2tlbmQgZHJpdmVyLg0KVGhlIGJvdW5jZSBidWZmZXIgbGltaXQgaXMgaGFsZiB0
aGUgY2FjaGUgc2l6ZS4NClNvLCBwbGVhc2Uga2VlcCAyNTYuIE1heWJlIGNoYW5nZSBpdCB0byBS
VEVfTUVNUE9PTF9DQUNIRV9NQVhfU0laRSAvIDIuDQoNClsxXTogaHR0cHM6Ly9wYXRjaHdvcmsu
ZHBkay5vcmcvcHJvamVjdC9kcGRrL3BhdGNoLzIwMjYwNTI2MTQwMDAwLjE3NTA5Mi0xLW1iQHNt
YXJ0c2hhcmVzeXN0ZW1zLmNvbS8NCg0KQWxzbyBjb25zaWRlciBrZWVwaW5nIDY0OyBpdCBzZWVt
cyB0byBiZSBhIHBvcHVsYXIgZGVmYXVsdCBidXJzdCBzaXplIGZvciBzb21lIENQVXMuDQpPbiB0
aGUgb3RoZXIgaGFuZCwgaWYgdGhlIHBhdGNoIGludHJvZHVjaW5nIGRlZmF1bHQgbWJ1ZiBidXJz
dCBzaXplcyBbMl0gZ2V0cyBhY2NlcHRlZCwgd2UgY291bGQgcmVwbGFjZSAzMiB3aXRoIFJURV9N
QlVGX0JVUlNUX1NJWkVfVEhST1VHSFBVVCBhbmQgNCB3aXRoIFJURV9NQlVGX0JVUlNUX1NJWkVf
TEFURU5DWS4NCk5vIHN0cm9uZyBvcGluaW9uIG9uIDY0OyBJJ2xsIGxlYXZlIHRoYXQgdXAgdG8g
eW91Lg0KDQpbMl06IGh0dHBzOi8vcGF0Y2h3b3JrLmRwZGsub3JnL3Byb2plY3QvZHBkay9saXN0
Lz9zZXJpZXM9Mzc5MTQNCg0KPiANCj4gQ29tYmluZWQgZWZmZWN0OiB+MTB4IHJ1bnRpbWUgcmVk
dWN0aW9uLg0KPiANCj4gU2lnbmVkLW9mZi1ieTogU3RlcGhlbiBIZW1taW5nZXIgPHN0ZXBoZW5A
bmV0d29ya3BsdW1iZXIub3JnPg0KDQpXaXRoIHN1Z2dlc3RlZCBjaGFuZ2VzLA0KQWNrZWQtYnk6
IE1vcnRlbiBCcsO4cnVwIDxtYkBzbWFydHNoYXJlc3lzdGVtcy5jb20+DQoNCg==
