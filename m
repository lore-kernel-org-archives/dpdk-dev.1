Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EA4F5C369C2
	for <dpdk-dev@archiver.kernel.org>; Fri, 25 Apr 2025 11:53:01 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id BB6F84028C;
	Fri, 25 Apr 2025 13:53:00 +0200 (CEST)
Received: from dkmailrelay1.smartsharesystems.com
 (smartserver.smartsharesystems.com [77.243.40.215])
 by mails.dpdk.org (Postfix) with ESMTP id 0407A40279
 for <dev@dpdk.org>; Fri, 25 Apr 2025 13:52:59 +0200 (CEST)
Received: from smartserver.smartsharesystems.com
 (smartserver.smartsharesys.local [192.168.4.10])
 by dkmailrelay1.smartsharesystems.com (Postfix) with ESMTP id 539482064E;
 Fri, 25 Apr 2025 13:52:58 +0200 (CEST)
Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Subject: rte_eth_stats_get seems slow
X-MimeOLE: Produced By Microsoft Exchange V6.5
Date: Fri, 25 Apr 2025 13:52:55 +0200
Message-ID: <98CBD80474FA8B44BF855DF32C47DC35E9FC02@smartserver.smartshare.dk>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: rte_eth_stats_get seems slow
Thread-Index: Adu12JTg+rpJS3OCRReKlbG9wgVtRg==
From: =?iso-8859-1?Q?Morten_Br=F8rup?= <mb@smartsharesystems.com>
To: <bruce.richardson@intel.com>
Cc: "Ian Stokes" <ian.stokes@intel.com>,
	<dev@dpdk.org>
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

Bruce,

rte_eth_stats_get() on Intel NICs seems slow to me.

E.g. getting the stats on a single port takes ~132 us (~451,000 CPU =
cycles) using the igb driver, and ~50 us using the i40e driver.

Referring to the igb driver source code [1], it's 44 calls to =
E1000_READ_REG(), so the math says that each one takes 3 us (~10,000 CPU =
cycles).

Is this expected behavior?

It adds up, e.g. it takes a full millisecond to fetch the stats from =
eight ports using the igb driver.

[1]: =
https://elixir.bootlin.com/dpdk/v24.11.1/source/drivers/net/e1000/igb_eth=
dev.c#L1724


Med venlig hilsen / Kind regards,
-Morten Br=F8rup

