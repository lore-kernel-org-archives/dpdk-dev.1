Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 72982C636B6
	for <dpdk-dev@archiver.kernel.org>; Sun, 22 Feb 2026 19:42:39 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 21FB5402D8;
	Sun, 22 Feb 2026 20:42:38 +0100 (CET)
Received: from dkmailrelay1.smartsharesystems.com
 (smartserver.smartsharesystems.com [77.243.40.215])
 by mails.dpdk.org (Postfix) with ESMTP id 9E8D1402B8
 for <dev@dpdk.org>; Sun, 22 Feb 2026 20:42:35 +0100 (CET)
Received: from smartserver.smartsharesystems.com
 (smartserver.smartsharesys.local [192.168.4.10])
 by dkmailrelay1.smartsharesystems.com (Postfix) with ESMTP id 7FA49206CD;
 Sun, 22 Feb 2026 20:42:35 +0100 (CET)
Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="UTF-8"
Content-Transfer-Encoding: base64
Subject: RE: [PATCH v4 00/10] riscv: implement accelerated crc using zbc
Date: Sun, 22 Feb 2026 20:42:29 +0100
X-MimeOLE: Produced By Microsoft Exchange V6.5
Message-ID: <98CBD80474FA8B44BF855DF32C47DC35F6573B@smartserver.smartshare.dk>
In-Reply-To: <20260222100313.5fd90e0c@phoenix.local>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: [PATCH v4 00/10] riscv: implement accelerated crc using zbc
Thread-Index: AdykJYrp/EsYUSCcQFu3TUCyZ3OU3QADTKwA
References: <20240827153230.52880-1-daniel.gregory@bytedance.com>
 <cover.1771772598.git.code@danielg0.com>
 <20260222100313.5fd90e0c@phoenix.local>
From: =?UTF-8?B?TW9ydGVuIEJyw7hydXA=?= <mb@smartsharesystems.com>
To: "Stephen Hemminger" <stephen@networkplumber.org>,
 "Daniel Gregory" <code@danielg0.com>
Cc: =?UTF-8?B?U3RhbmlzxYJhdyBLYXJkYWNo?= <stanislaw.kardach@gmail.com>,
 <dev@dpdk.org>, "Punit Agrawal" <punit.agrawal@bytedance.com>,
 "Liang Ma" <liangma@liangbit.com>,
 "Pengcheng Wang" <wangpengcheng.pp@bytedance.com>,
 "Chunsong Feng" <fengchunsong@bytedance.com>,
 "Daniel Gregory" <daniel.gregory@bytedance.com>,
 "Sun Yuechi" <sunyuechi@iscas.ac.cn>
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
b3JnXQ0KPiBTZW50OiBTdW5kYXksIDIyIEZlYnJ1YXJ5IDIwMjYgMTkuMDMNCj4gDQo+IE9uIFN1
biwgMjIgRmViIDIwMjYgMTY6Mjk6NTQgKzAxMDANCj4gRGFuaWVsIEdyZWdvcnkgPGNvZGVAZGFu
aWVsZzAuY29tPiB3cm90ZToNCj4gDQo+ID4gVGhlIFJJU0MtViBaYmMgZXh0ZW5zaW9uIGFkZHMg
aW5zdHJ1Y3Rpb25zIGZvciBjYXJyeS1sZXNzDQo+IG11bHRpcGxpY2F0aW9uDQo+ID4gd2UgY2Fu
IHVzZSB0byBpbXBsZW1lbnQgQ1JDIGluIGhhcmR3YXJlLiBUaGlzIHBhdGNoIHNldCBjb250YWlu
cyB0d28NCj4gbmV3DQo+ID4gaW1wbGVtZW50YXRpb25zOg0KPiA+DQo+ID4gLSBvbmUgaW4gbGli
L2hhc2gvcnRlX2NyY19yaXNjdjY0LmggdGhhdCB1c2VzIGEgQmFycmV0dCByZWR1Y3Rpb24gdG8N
Cj4gPiAgIGltcGxlbWVudCB0aGUgZm91ciBydGVfaGFzaF9jcmNfKiBmdW5jdGlvbnMNCj4gPiAt
IG9uZSBpbiBsaWIvbmV0L25ldF9jcmNfemJjLmMgdGhhdCB1c2VzIHJlcGVhdGVkIHNpbmdsZS1m
b2xkcyB0bw0KPiByZWR1Y2UNCj4gPiAgIHRoZSBidWZmZXIgdW50aWwgaXQgaXMgc21hbGwgZW5v
dWdoIGZvciBhIEJhcnJldHQgcmVkdWN0aW9uIHRvDQo+ID4gICBpbXBsZW1lbnQgcnRlX2NyYzE2
X2NjaXR0X3piY19oYW5kbGVyIGFuZCBydGVfY3JjMzJfZXRoX3piY19oYW5kbGVyDQo+ID4NCj4g
DQo+IEFJIHBhdGNoIHJldmlldyBzdW1tYXJ5OiB0aGUgb3ZlcmFsbCBhcHByb2FjaCBsb29rcyBn
b29kIOKAlCB0aGUgaHdwcm9iZQ0KPiBpbnRlZ3JhdGlvbiBpcyBjbGVhbiBhbmQgdGhlIEJhcnJl
dHQgcmVkdWN0aW9uIG1hdGggYXBwZWFycyBjb3JyZWN0Lg0KPiBBIGZldyBpc3N1ZXMgbmVlZCBh
ZGRyZXNzaW5nIGJlZm9yZSB0aGlzIGNhbiBiZSBtZXJnZWQ6DQo+IA0KPiAxLiBbRVJST1IsIHBh
dGNoIDAxXSAxIDw8IG4gdXNlZCBmb3IgYWxsIDI2IEhXQ0FQIG1hc2sgZW50cmllcw0KPiANCj4g
ICAgVGhlIGZlYXR1cmUgdGFibGUgZW50cmllcyBub3cgc3RvcmUgbWFza3MgaW4gYSB1aW50NjRf
dCBmaWVsZCwgYnV0DQo+ICAgIGFsbCAyNiBleGlzdGluZyBSSVNDVl9JU0FfKiBlbnRyaWVzIHN0
aWxsIHVzZSBwbGFpbiAnMSA8PCBuJyAoc2lnbmVkDQo+ICAgIGludCkuIFRoaXMgcHJvZHVjZXMg
MzItYml0IHZhbHVlcyBzdG9yZWQgaW4gYSA2NC1iaXQgZmllbGQgYW5kDQo+IGNhdXNlcw0KPiAg
ICB1bmRlZmluZWQgYmVoYXZpb3VyIGZvciBuID49IDMxLiBBbGwgZW50cmllcyBtdXN0IHVzZSBV
SU5UNjRfQygxKSA8PA0KPiBuOg0KPiANCj4gICAgICBGRUFUX0RFRihSSVNDVl9JU0FfQSwgUkVH
X0hXQ0FQLCBVSU5UNjRfQygxKSA8PCAgMCkNCj4gICAgICAuLi4NCj4gICAgICBGRUFUX0RFRihS
SVNDVl9JU0FfWiwgUkVHX0hXQ0FQLCBVSU5UNjRfQygxKSA8PCAyNSkNCg0KRnVydGhlcm1vcmUs
IFJURV9CSVQ2NCgyNSkgWzFdIGlzIHByZWZlcnJlZCBvdmVyIFVJTlQ2NF9DKDEpIDw8IDI1Lg0K
DQpbMV06IGh0dHBzOi8vZWxpeGlyLmJvb3RsaW4uY29tL2RwZGsvdjI1LjExL3NvdXJjZS9saWIv
ZWFsL2luY2x1ZGUvcnRlX2JpdG9wcy5oI0wzNg0KDQpJdCBzZWVtcyB0aGUgQUkgbWlzc2VkIHRo
aXMgcHJlZmVyZW5jZS4NCg0K
