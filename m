Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 205C0CCD199
	for <dpdk-dev@archiver.kernel.org>; Thu, 16 Oct 2025 22:29:24 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 42CF44029A;
	Fri, 17 Oct 2025 00:29:23 +0200 (CEST)
Received: from dkmailrelay1.smartsharesystems.com
 (smartserver.smartsharesystems.com [77.243.40.215])
 by mails.dpdk.org (Postfix) with ESMTP id 7EA2A4026D
 for <dev@dpdk.org>; Fri, 17 Oct 2025 00:29:21 +0200 (CEST)
Received: from smartserver.smartsharesystems.com
 (smartserver.smartsharesys.local [192.168.4.10])
 by dkmailrelay1.smartsharesystems.com (Postfix) with ESMTP id 3EE94206E3;
 Fri, 17 Oct 2025 00:29:21 +0200 (CEST)
Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="UTF-8"
Content-Transfer-Encoding: base64
Subject: RE: [PATCH v7 3/7] mbuf: record mbuf operations history
Date: Fri, 17 Oct 2025 00:29:18 +0200
Message-ID: <98CBD80474FA8B44BF855DF32C47DC35F654D7@smartserver.smartshare.dk>
X-MimeOLE: Produced By Microsoft Exchange V6.5
In-Reply-To: <20251016203557.2554678-4-thomas@monjalon.net>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: [PATCH v7 3/7] mbuf: record mbuf operations history
Thread-Index: Adw+3ILcN1eY0xfvSGumh75XlHuXSwADopSA
References: <20250616072910.113042-1-shperetz@nvidia.com>
 <20251016203557.2554678-1-thomas@monjalon.net>
 <20251016203557.2554678-4-thomas@monjalon.net>
From: =?UTF-8?B?TW9ydGVuIEJyw7hydXA=?= <mb@smartsharesystems.com>
To: "Thomas Monjalon" <thomas@monjalon.net>,
	<dev@dpdk.org>
Cc: <shperetz@nvidia.com>, <viacheslavo@nvidia.com>,
 <bruce.richardson@intel.com>, <stephen@networkplumber.org>
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

PiArCS8qIENhbGN1bGF0ZSB0b3RhbCBhbGxvY2F0ZWQgbWJ1ZnMgKi8NCj4gKwl1aW50NjRfdCB0
b3RhbF9hbGxvY2F0ZWQgPSAwOw0KPiArCWZvciAoZW51bSBydGVfbWJ1Zl9oaXN0b3J5X29wIG9w
ID0gUlRFX01CVUZfSElTVE9SWV9PUF9MSUJfQUxMT0M7DQo+ICsJCQlvcCA8IFJURV9NQlVGX0hJ
U1RPUllfT1BfTUFYOyBvcCsrKQ0KPiArCQl0b3RhbF9hbGxvY2F0ZWQgKz0gc3RhdHNbb3BdOw0K
DQpJIG1pZ2h0IGJlIG92ZXJseSBjYXV0aW91cyBoZXJlLCBidXQgdGhlIGFwcCAob3IgZHJpdmVy
KSBtaWdodCBoYXZlIGEgYnVnLCBhbmQgbWFyayB0aGUgbWJ1ZiB3aXRoIE9QX0FQUF9GUkVFIChv
ciBPUF9QTURfRlJFRSkgd2l0aG91dCBhY3R1YWxseSBmcmVlaW5nIHRoZSBtYnVmIGJhY2sgdG8g
dGhlIG1lbXBvb2wuDQpTbyB5b3Ugc2hvdWxkIG9ubHkgdHJ1c3QgdGhlIG1lbXBvb2wgbGlicmFy
eSAoT1BfTElCX0ZSRUUpIHRvIG1hcmsgdGhlIG1idWYgYXMgYWN0dWFsbHkgZnJlZWQuIEkuZS4g
c3RhcnQgdGhlIGxvb3AgYXQgb3AgPSBSVEVfTUJVRl9ISVNUT1JZX09QX0xJQl9GUkVFLg0KVGhl
IGFwcC9kcml2ZXIgc2hvdWxkIGV2ZW50dWFsbHkgY2FsbCBydGVfbWJ1Zl9yYXdfZnJlZV9idWxr
KCkgb3Igc2ltaWxhciB0byByZWxlYXNlIHRoZSBtYnVmIGJhY2sgdG8gdGhlIG1lbXBvb2wuDQoN
Cj4gKy8qKg0KPiArICogSGlzdG9yeSBvcGVyYXRpb24gdHlwZXMuDQo+ICsgKi8NCj4gK2VudW0g
cnRlX21idWZfaGlzdG9yeV9vcCB7DQo+ICsJUlRFX01CVUZfSElTVE9SWV9PUF9ORVZFUiAgICAg
PSAgMCwgLyoqPCBJbml0aWFsIHN0YXRlIC0gbmV2ZXINCj4gYWxsb2NhdGVkICovDQo+ICsJUlRF
X01CVUZfSElTVE9SWV9PUF9MSUJfRlJFRSAgPSAgMSwgLyoqPCBGcmVlZCBiYWNrIHRvIHBvb2wg
Ki8NCj4gKwlSVEVfTUJVRl9ISVNUT1JZX09QX1BNRF9GUkVFICA9ICAyLCAvKio8IEZyZWVkIGJ5
IFBNRCAqLw0KPiArCVJURV9NQlVGX0hJU1RPUllfT1BfQVBQX0ZSRUUgID0gIDMsIC8qKjwgRnJl
ZWQgYnkgYXBwbGljYXRpb24gKi8NCj4gKwkvKiBXaXRoIG9wcyBiZWxvdywgbWJ1ZiBpcyBjb25z
aWRlcmVkIGFsbG9jYXRlZC4gKi8NCj4gKwlSVEVfTUJVRl9ISVNUT1JZX09QX0xJQl9BTExPQyA9
ICA0LCAvKio8IEFsbG9jYXRpb24gaW4gbWJ1Zg0KPiBsaWJyYXJ5ICovDQo+ICsJUlRFX01CVUZf
SElTVE9SWV9PUF9QTURfQUxMT0MgPSAgNSwgLyoqPCBBbGxvY2F0ZWQgYnkgUE1EIGZvciBSeA0K
PiAqLw0KPiArCVJURV9NQlVGX0hJU1RPUllfT1BfQVBQX0FMTE9DID0gIDYsIC8qKjwgQWxsb2Nh
dGVkIGJ5IGFwcGxpY2F0aW9uDQo+ICovDQo+ICsJUlRFX01CVUZfSElTVE9SWV9PUF9SWCAgICAg
ICAgPSAgNywgLyoqPCBSZWNlaXZlZCAqLw0KPiArCVJURV9NQlVGX0hJU1RPUllfT1BfVFggICAg
ICAgID0gIDgsIC8qKjwgU2VudCAqLw0KPiArCVJURV9NQlVGX0hJU1RPUllfT1BfVFhfUFJFUCAg
ID0gIDksIC8qKjwgQmVpbmcgcHJlcGFyZWQgYmVmb3JlIFR4DQo+ICovDQo+ICsJUlRFX01CVUZf
SElTVE9SWV9PUF9UWF9CVVNZICAgPSAxMCwgLyoqPCBSZXR1cm5lZCBkdWUgdG8gVHggYnVzeQ0K
PiAqLw0KPiArCVJURV9NQlVGX0hJU1RPUllfT1BfRU5RVUVVRSAgID0gMTEsIC8qKjwgRW5xdWV1
ZWQgZm9yIHByb2Nlc3NpbmcNCj4gKi8NCj4gKwlSVEVfTUJVRl9ISVNUT1JZX09QX0RFUVVFVUUg
ICA9IDEyLCAvKio8IERlcXVldWVkIGZvciBwcm9jZXNzaW5nDQo+ICovDQo+ICsJLyogICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAxMywgICAgICByZXNlcnZlZCBmb3IgZnV0dXJlICovDQo+
ICsJUlRFX01CVUZfSElTVE9SWV9PUF9VU1IyICAgICAgPSAxNCwgLyoqPCBBcHBsaWNhdGlvbi1k
ZWZpbmVkDQo+IGV2ZW50IDIgKi8NCj4gKwlSVEVfTUJVRl9ISVNUT1JZX09QX1VTUjEgICAgICA9
IDE1LCAvKio8IEFwcGxpY2F0aW9uLWRlZmluZWQNCj4gZXZlbnQgMSAqLw0KPiArCVJURV9NQlVG
X0hJU1RPUllfT1BfTUFYICAgICAgID0gMTYsIC8qKjwgTWF4aW11bSBudW1iZXIgb2YNCj4gb3Bl
cmF0aW9uIHR5cGVzICovDQo+ICt9Ow0KDQo=
