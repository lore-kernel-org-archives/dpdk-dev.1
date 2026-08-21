Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0D578C5DF88
	for <dpdk-dev@archiver.kernel.org>; Fri, 21 Aug 2026 06:32:01 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 23B7A4028C;
	Fri, 21 Aug 2026 08:32:01 +0200 (CEST)
Received: from dkmailrelay1.smartsharesystems.com
 (smartserver.smartsharesystems.com [77.243.40.215])
 by mails.dpdk.org (Postfix) with ESMTP id 87FE34027B
 for <dev@dpdk.org>; Fri, 21 Aug 2026 08:31:59 +0200 (CEST)
Received: from smartserver.smartsharesystems.com
 (smartserver.smartsharesys.local [192.168.4.10])
 by dkmailrelay1.smartsharesystems.com (Postfix) with ESMTP id 6495820FDE;
 Fri, 21 Aug 2026 08:31:59 +0200 (CEST)
Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="utf-8"
Content-Transfer-Encoding: base64
Subject: RE: [dpdk-dev v1] mempool: double cache max size using ABI-neutral
 struct compaction
X-MimeOLE: Produced By Microsoft Exchange V6.5
Date: Fri, 21 Aug 2026 08:31:59 +0200
Message-ID: <98CBD80474FA8B44BF855DF32C47DC35F65A08@smartserver.smartshare.dk>
In-Reply-To: <20260820154527.1989178-1-kai.ji@intel.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: [dpdk-dev v1] mempool: double cache max size using ABI-neutral
 struct compaction
Thread-Index: Ad0wuvbPqkrt5dw0RdCKP2chgs+6PwAextfw
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

PiAgLyogbWVtcG9vbCBkZWZpbmVzICovDQo+IC0jZGVmaW5lIFJURV9NRU1QT09MX0NBQ0hFX01B
WF9TSVpFIDUxMg0KPiArI2RlZmluZSBSVEVfTUVNUE9PTF9DQUNIRV9NQVhfU0laRSAxMDI0DQoN
CkkgZG9uJ3QgdGhpbmsgd2Ugc2hvdWxkIGluY3JlYXNlIHRoZSBkZWZhdWx0IHZhbHVlLg0KSWYg
c29tZSBleG90aWMgYXBwbGljYXRpb24gbmVlZHMgYW4gZXh0cmVtZWx5IGxhcmdlIG1lbXBvb2wg
Y2FjaGUsIGl0IGNhbiBiZSBjaGFuZ2VkIGF0IGJ1aWxkIHRpbWUuDQoNClBsZWFzZSBhbHNvIGNv
bnNpZGVyIHRoaXMgcGF0Y2gsIHdoaWNoIHVuY29uZGl0aW9uYWxseSBhbGxvY2F0ZXMgbWVtcG9v
bCBjYWNoZSBmb3IgYWxsIG1lbXBvb2xzOg0KaHR0cHM6Ly9wYXRjaHdvcmsuZHBkay5vcmcvcHJv
amVjdC9kcGRrL3BhdGNoLzIwMjYwODEyMDkwNzIzLjE3NzE2MjgtMS1tYkBzbWFydHNoYXJlc3lz
dGVtcy5jb20vDQoNCg==
