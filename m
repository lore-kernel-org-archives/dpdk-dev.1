Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E44AAC5DF81
	for <dpdk-dev@archiver.kernel.org>; Thu, 20 Aug 2026 12:56:42 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id C11CE40150;
	Thu, 20 Aug 2026 14:56:41 +0200 (CEST)
Received: from dkmailrelay1.smartsharesystems.com
 (smartserver.smartsharesystems.com [77.243.40.215])
 by mails.dpdk.org (Postfix) with ESMTP id 423A8400EF
 for <dev@dpdk.org>; Thu, 20 Aug 2026 14:56:40 +0200 (CEST)
Received: from smartserver.smartsharesystems.com
 (smartserver.smartsharesys.local [192.168.4.10])
 by dkmailrelay1.smartsharesystems.com (Postfix) with ESMTP id 1009B207DD
 for <dev@dpdk.org>; Thu, 20 Aug 2026 14:56:40 +0200 (CEST)
Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="utf-8"
Content-Transfer-Encoding: base64
Subject: RE: [PATCH] mempool: optimizations
X-MimeOLE: Produced By Microsoft Exchange V6.5
Date: Thu, 20 Aug 2026 14:56:38 +0200
Message-ID: <98CBD80474FA8B44BF855DF32C47DC35F65A05@smartserver.smartshare.dk>
In-Reply-To: <20260820124139.276135-1-mb@smartsharesystems.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: [PATCH] mempool: optimizations
Thread-Index: Ad0woUAUP1uQz7O/S5GD+mC+0f64CwAAfggA
References: <20260820124139.276135-1-mb@smartsharesystems.com>
From: =?utf-8?B?TW9ydGVuIEJyw7hydXA=?= <mb@smartsharesystems.com>
To: <dev@dpdk.org>
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

UExFQVNFIElHTk9SRS4NCg0KSXQgd2FzIG9ubHkgZm9yIHRlc3RpbmcgRGVwZW5kcy1vbi4NCg0K
VmVubGlnIGhpbHNlbiAvIEtpbmQgcmVnYXJkcywNCi1Nb3J0ZW4gQnLDuHJ1cA0KDQoNCj4gLS0t
LS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogTW9ydGVuIEJyw7hydXAgW21haWx0bzpt
YkBzbWFydHNoYXJlc3lzdGVtcy5jb21dDQo+IFNlbnQ6IFRodXJzZGF5LCAyMCBBdWd1c3QgMjAy
NiAxNC40Mg0KPiBUbzogZGV2QGRwZGsub3JnDQo+IENjOiBNb3J0ZW4gQnLDuHJ1cA0KPiBTdWJq
ZWN0OiBbUEFUQ0hdIG1lbXBvb2w6IG9wdGltaXphdGlvbnMNCg==
