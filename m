Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 804C0C5DF88
	for <dpdk-dev@archiver.kernel.org>; Fri, 21 Aug 2026 06:25:23 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id A07A94028C;
	Fri, 21 Aug 2026 08:25:22 +0200 (CEST)
Received: from dkmailrelay1.smartsharesystems.com
 (smartserver.smartsharesystems.com [77.243.40.215])
 by mails.dpdk.org (Postfix) with ESMTP id 12B294027B
 for <dev@dpdk.org>; Fri, 21 Aug 2026 08:25:21 +0200 (CEST)
Received: from smartserver.smartsharesystems.com
 (smartserver.smartsharesys.local [192.168.4.10])
 by dkmailrelay1.smartsharesystems.com (Postfix) with ESMTP id D602120FDE;
 Fri, 21 Aug 2026 08:25:18 +0200 (CEST)
Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="utf-8"
Content-Transfer-Encoding: base64
Subject: RE: [dpdk-dev v1] mempool: double cache max size using ABI-neutral
 struct compaction
X-MimeOLE: Produced By Microsoft Exchange V6.5
Date: Fri, 21 Aug 2026 08:25:18 +0200
Message-ID: <98CBD80474FA8B44BF855DF32C47DC35F65A07@smartserver.smartshare.dk>
In-Reply-To: <20260820154527.1989178-1-kai.ji@intel.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: [dpdk-dev v1] mempool: double cache max size using ABI-neutral
 struct compaction
Thread-Index: Ad0wuvbPqkrt5dw0RdCKP2chgs+6PwAeqJ1w
References: <20260820154527.1989178-1-kai.ji@intel.com>
From: =?utf-8?B?TW9ydGVuIEJyw7hydXA=?= <mb@smartsharesystems.com>
To: "Kai Ji" <kai.ji@intel.com>,
	<dev@dpdk.org>
Cc: "Bruce Richardson" <bruce.richardson@intel.com>,
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

PiBpbmRleCA1MGQ5NThjN2M2Li42MWRmZTM4NmMwIDEwMDY0NA0KPiAtLS0gYS9saWIvbWVtcG9v
bC9ydGVfbWVtcG9vbC5oDQo+ICsrKyBiL2xpYi9tZW1wb29sL3J0ZV9tZW1wb29sLmgNCj4gQEAg
LTEwNiwxMyArMTA2LDggQEAgc3RydWN0IF9fcnRlX2NhY2hlX2FsaWduZWQgcnRlX21lbXBvb2xf
Y2FjaGUgew0KPiAgI2VuZGlmDQo+ICAJLyoqDQo+ICAJICogQ2FjaGUgb2JqZWN0cw0KPiAtCSAq
DQo+IC0JICogTm90ZToNCj4gLQkgKiBDYWNoZSBpcyBhbGxvY2F0ZWQgYXQgZG91YmxlIHNpemUg
Zm9yIEFQSS9BQkkgY29tcGF0aWJpbGl0eQ0KPiBwdXJwb3NlcyBvbmx5Lg0KPiAtCSAqIFdoZW4g
cmVkdWNpbmcgaXRzIHNpemUgYXQgYW4gQVBJL0FCSSBicmVha2luZyByZWxlYXNlLA0KPiAtCSAq
IHJlbWVtYmVyIHRvIGFkZCBhIGNhY2hlIGd1YXJkIGFmdGVyIGl0Lg0KPiAgCSAqLw0KPiAtCWFs
aWduYXMoUlRFX0NBQ0hFX0xJTkVfU0laRSkgdm9pZA0KPiAqb2Jqc1tSVEVfTUVNUE9PTF9DQUNI
RV9NQVhfU0laRSAqIDJdOw0KPiArCWFsaWduYXMoUlRFX0NBQ0hFX0xJTkVfU0laRSkgdm9pZA0K
PiAqb2Jqc1tSVEVfTUVNUE9PTF9DQUNIRV9NQVhfU0laRV07DQoNClRoaXMgY2hhbmdlIGhhcyBh
bHJlYWR5IGJlZW4gYWRkcmVzc2VkLg0KUGxlYXNlIHJldmlldyB0aGlzIHBhdGNoOg0KaHR0cHM6
Ly9wYXRjaHdvcmsuZHBkay5vcmcvcHJvamVjdC9kcGRrL3BhdGNoLzIwMjYwODA2MTU0NTA2LjE1
MzIzNzUtMS1tYkBzbWFydHNoYXJlc3lzdGVtcy5jb20vDQoNCg==
