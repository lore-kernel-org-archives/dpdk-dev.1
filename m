Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 75A65C3ABCC
	for <dpdk-dev@archiver.kernel.org>; Tue, 13 May 2025 11:37:00 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 3007F4026C;
	Tue, 13 May 2025 13:36:59 +0200 (CEST)
Received: from dkmailrelay1.smartsharesystems.com
 (smartserver.smartsharesystems.com [77.243.40.215])
 by mails.dpdk.org (Postfix) with ESMTP id 051A74025F
 for <dev@dpdk.org>; Tue, 13 May 2025 13:36:56 +0200 (CEST)
Received: from smartserver.smartsharesystems.com
 (smartserver.smartsharesys.local [192.168.4.10])
 by dkmailrelay1.smartsharesystems.com (Postfix) with ESMTP id 9686A209C9
 for <dev@dpdk.org>; Tue, 13 May 2025 13:36:56 +0200 (CEST)
Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Subject: lcore vs control thread function return type
X-MimeOLE: Produced By Microsoft Exchange V6.5
Date: Tue, 13 May 2025 13:36:51 +0200
Message-ID: <98CBD80474FA8B44BF855DF32C47DC35E9FC4B@smartserver.smartshare.dk>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: lcore vs control thread function return type
Thread-Index: AdvD+1Hbp3XenN30Q5i6agLJXpYvGA==
From: =?iso-8859-1?Q?Morten_Br=F8rup?= <mb@smartsharesystems.com>
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

Why do control thread functions return uint32_t [1], when lcore thread =
functions return int [2]?

https://elixir.bootlin.com/dpdk/v25.03/source/lib/eal/include/rte_thread.=
h#L53
https://elixir.bootlin.com/dpdk/v25.03/source/lib/eal/include/rte_launch.=
h#L31

