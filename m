Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DBF4EC44529
	for <dpdk-dev@archiver.kernel.org>; Tue, 21 Jul 2026 09:18:21 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id D47C4402A7;
	Tue, 21 Jul 2026 11:18:20 +0200 (CEST)
Received: from dkmailrelay1.smartsharesystems.com
 (smartserver.smartsharesystems.com [77.243.40.215])
 by mails.dpdk.org (Postfix) with ESMTP id CB3C640289
 for <dev@dpdk.org>; Tue, 21 Jul 2026 11:18:19 +0200 (CEST)
Received: from smartserver.smartsharesystems.com
 (smartserver.smartsharesys.local [192.168.4.10])
 by dkmailrelay1.smartsharesystems.com (Postfix) with ESMTP id 981FB2109C;
 Tue, 21 Jul 2026 11:18:19 +0200 (CEST)
Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="UTF-8"
Content-Transfer-Encoding: base64
Subject: RE: mempool cache change
Date: Tue, 21 Jul 2026 11:18:17 +0200
Message-ID: <98CBD80474FA8B44BF855DF32C47DC35F65986@smartserver.smartshare.dk>
In-Reply-To: <CAOaVG17Ay+b1Hio90Mgq0jrYwFegxOmQ-+2ezXF_cSrk1Zi90g@mail.gmail.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: mempool cache change
X-MimeOLE: Produced By Microsoft Exchange V6.5
Thread-Index: Ad0Y2xE4w0HI1V8iRmuLuDuHmP/SQgAFZ01Q
References: <b54ad1f1692a0274da705d446972efd1@mail.gmail.com>
 <98CBD80474FA8B44BF855DF32C47DC35F6596D@smartserver.smartshare.dk>
 <e0b59e0b-1fb7-4a7b-84bb-9fc47f4feb5a@huawei.com>
 <98CBD80474FA8B44BF855DF32C47DC35F6596E@smartserver.smartshare.dk>
 <CA+BST0kV0w7teE2h8OVZ5Ont-BCrf6rSxw9+t+Bbn8hx6xUwtA@mail.gmail.com>
 <aliq6kqGI2TfyFoH@bricha3-mobl1.ger.corp.intel.com>
 <00fe4a299adc03ff7d39ef943e62b921@mail.gmail.com>
 <98CBD80474FA8B44BF855DF32C47DC35F65979@smartserver.smartshare.dk>
 <al3YgIWkXNihHGMv@bricha3-mobl1.ger.corp.intel.com>
 <CAOaVG17Ay+b1Hio90Mgq0jrYwFegxOmQ-+2ezXF_cSrk1Zi90g@mail.gmail.com>
From: =?UTF-8?B?TW9ydGVuIEJyw7hydXA=?= <mb@smartsharesystems.com>
To: "Stephen Hemminger" <stephen@networkplumber.org>,
 "Bruce Richardson" <bruce.richardson@intel.com>
Cc: "Kishore Padmanabha" <kishore.padmanabha@broadcom.com>,
 "fengchengwen" <fengchengwen@huawei.com>,
 "Thomas Monjalon" <thomas@monjalon.net>, "dev" <dev@dpdk.org>,
 "Wisam Jaddo" <wisamm@nvidia.com>,
 "Andrew Rybchenko" <andrew.rybchenko@oktetlabs.ru>
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
Z10gDQpTZW50OiBUdWVzZGF5LCAyMSBKdWx5IDIwMjYgMDguMzUNCg0KPkkgY2FuJ3QgaGVscCB0
aGlua2luZyB0aGF0IHRoZXJlIG5lZWRzIHRvIGJlIGEgbW9yZSBkeW5hbWljIGhldXJpc3RpYy4N
Cj5LZWVwIGV4aXN0aW5nIHVwcGVyIGxpbWl0IGJ1dCBvbmx5IGNhY2hlIGFzIG11Y2ggYXMgZ2V0
cyB1c2VkLg0KPg0KPlRoZXJlIGFyZSB0d28gbWFpbiB1c2FnZSBtb2RlbHMuDQo+T25lIGlzIGZh
c3QgZGlyZWN0IHJlY3ljbGluZyB3aGljaCBydW4gdG8gY29tcGxldGlvbiBnZW5lcmF0ZXMuIFRo
ZSBvdGhlciBpcyB3aGVuIHBpcGVsaW5lIGlzIHVzZWQgYW5kIGFycml2YWwgYW5kIGRlcGFydHVy
ZSBpcyBvbiBkaWZmZXJlbnQgY29yZXMuDQoNCkluIHRoZSAiZGlmZmVyZW50IGNvcmVzIiB1c2Fn
ZSBtb2RlbCwgb25seSBoYWxmIHRoZSBjYWNoZSBzaXplIGlzIGFjdGl2ZSBvbiBlYWNoIHRocmVh
ZC4NCkluIHRoZSAiZnJlZS9wdXQgb25seSIgdGhyZWFkLCBvbmx5IHRoZSB1cHBlciBoYWxmIGlz
IGFjdGl2ZSAoc2luY2Ugd2UgZmx1c2ggdG8gc2l6ZS8yKS4NCkluIHRoZSAiYWxsb2MvZ2V0IG9u
bHkiIHRocmVhZCwgb25seSB0aGUgbG93ZXIgaGFsZiBpcyBhY3RpdmUgKHNpbmNlIHdlIHJlcGxl
bmlzaCB0byBzaXplLzIpLg0KDQpTbywgZG91YmxpbmcgdGhlIGNvbmZpZ3VyZWQgY2FjaGUgc2l6
ZSB3aWxsIHBlcmZvcm0gdGhlIHNhbWUgYXMgYW4gb3B0aW1hbCBhbGdvcml0aG0uDQpCdXQgaXQg
d2lsbCB3YXN0ZSBzaXplLzIgb2JqZWN0cyBwZXIgImZyZWUvcHV0IG9ubHkiIHRocmVhZCBhcyBk
ZWFkIGluIHRoZSBwZXItdGhyZWFkIG1lbXBvb2wgY2FjaGUncyBsb3dlciBoYWxmLg0KDQpSdW50
aW1lIGhldXJpc3RpYyB3b3VsZCBpbnRyb2R1Y2UgYSBwZXJmb3JtYW5jZSBjb3N0IGZvciBjaGVj
a2luZyB1c2FnZSBtb2RlbC4NCg0K
