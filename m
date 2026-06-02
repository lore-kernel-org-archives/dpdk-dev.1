Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4307CCD6E60
	for <dpdk-dev@archiver.kernel.org>; Tue,  2 Jun 2026 12:41:59 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 70161402A9;
	Tue,  2 Jun 2026 14:41:58 +0200 (CEST)
Received: from dkmailrelay1.smartsharesystems.com
 (smartserver.smartsharesystems.com [77.243.40.215])
 by mails.dpdk.org (Postfix) with ESMTP id 4F49140150
 for <dev@dpdk.org>; Tue,  2 Jun 2026 14:41:57 +0200 (CEST)
Received: from smartserver.smartsharesystems.com
 (smartserver.smartsharesys.local [192.168.4.10])
 by dkmailrelay1.smartsharesystems.com (Postfix) with ESMTP id 1C446208EE;
 Tue,  2 Jun 2026 14:41:57 +0200 (CEST)
Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="utf-8"
Content-Transfer-Encoding: base64
Subject: RE: [RFC PATCH 3/3] build: deprecate HPET build option
Date: Tue, 2 Jun 2026 14:41:56 +0200
Message-ID: <98CBD80474FA8B44BF855DF32C47DC35F658DA@smartserver.smartshare.dk>
X-MimeOLE: Produced By Microsoft Exchange V6.5
In-Reply-To: <CAJFAV8x5_JihAXe_bruriVu01b5wmF4fJ7vD42yFfNwpJQwDtQ@mail.gmail.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: [RFC PATCH 3/3] build: deprecate HPET build option
Thread-Index: AdzyhIu3FHsBMcheSMmS92Dm8RxWBAAB+Z5A
References: <20260602090847.905721-1-bruce.richardson@intel.com>
 <20260602090847.905721-4-bruce.richardson@intel.com>
 <98CBD80474FA8B44BF855DF32C47DC35F658D8@smartserver.smartshare.dk>
 <CAJFAV8x5_JihAXe_bruriVu01b5wmF4fJ7vD42yFfNwpJQwDtQ@mail.gmail.com>
From: =?utf-8?B?TW9ydGVuIEJyw7hydXA=?= <mb@smartsharesystems.com>
To: "David Marchand" <david.marchand@redhat.com>,
 "Bruce Richardson" <bruce.richardson@intel.com>
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

PiBPbiB0aGUgb3RoZXIgaGFuZCwgZGlkIHlvdSBjb25zaWRlciBkcm9wcGluZyBIUEVUIGFsdG9n
ZXRoZXI/DQoNCkdvb2dsZSBBSSBzYXlzIHRoYXQgLSBvbiBtb2Rlcm4gQ1BVcyAtIHRoZSBIUEVU
IGhhcyBubyBhZHZhbnRhZ2VzIG92ZXIgdGhlIFRTQy4NClRoaXMgc3VwcG9ydHMgRGF2aWQncyBp
ZGVhLg0KDQpTdWdnZXN0aW9uOg0KUmV3cml0ZSBIUEVUIEFQSXMgYXMgYSBzaGltIHRvIFRTQywg
YW5kIGRlcHJlY2F0ZSB0aGUgSFBFVCBBUElzLg0KDQotTW9ydGVuDQoNCg==
