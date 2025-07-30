Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DDE53C87FCB
	for <dpdk-dev@archiver.kernel.org>; Wed, 30 Jul 2025 07:59:56 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id CA28F40668;
	Wed, 30 Jul 2025 09:59:55 +0200 (CEST)
Received: from dkmailrelay1.smartsharesystems.com
 (smartserver.smartsharesystems.com [77.243.40.215])
 by mails.dpdk.org (Postfix) with ESMTP id 20F014025E
 for <dev@dpdk.org>; Wed, 30 Jul 2025 09:59:54 +0200 (CEST)
Received: from smartserver.smartsharesystems.com
 (smartserver.smartsharesys.local [192.168.4.10])
 by dkmailrelay1.smartsharesystems.com (Postfix) with ESMTP id AB6AE209B9;
 Wed, 30 Jul 2025 09:59:53 +0200 (CEST)
Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Subject: Ethdev driver request for changes
X-MimeOLE: Produced By Microsoft Exchange V6.5
Date: Wed, 30 Jul 2025 09:59:52 +0200
Message-ID: <98CBD80474FA8B44BF855DF32C47DC35E9FDD3@smartserver.smartshare.dk>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: Ethdev driver request for changes
Thread-Index: AdwBJ+39pe7zqIBrReydHFmPzH8bMg==
From: =?iso-8859-1?Q?Morten_Br=F8rup?= <mb@smartsharesystems.com>
To: "Ajit Khaparde" <ajit.khaparde@broadcom.com>,
 "Somnath Kotur" <somnath.kotur@broadcom.com>,
 "Chas Williams" <chas3@att.com>, "Min Hu (Connor" <humin29@huawei.com>,
 "Nithin Dabilpuram" <ndabilpuram@marvell.com>,
 "Kiran Kumar K" <kirankumark@marvell.com>,
 "Sunil Kumar Kori" <skori@marvell.com>,
 "Satha Rao" <skoteshwar@marvell.com>, "Harman Kalra" <hkalra@marvell.com>,
 "Hemant Agrawal" <hemant.agrawal@nxp.com>,
 "Sachin Saxena" <sachin.saxena@oss.nxp.com>,
 "Shai Brandes" <shaibran@amazon.com>,
 "Evgeny Schemeilin" <evgenys@amazon.com>,
 "Ron Beider" <rbeider@amazon.com>, "Amit Bernstein" <amitbern@amazon.com>,
 "Wajeeh Atrash" <atrwajee@amazon.com>, "Gaetan Rivet" <grive@u256.net>,
 "Dengdui Huang" <huangdengdui@huawei.com>,
 "Bruce Richardson" <bruce.richardson@intel.com>,
 "Praveen Shetty" <praveen.shetty@intel.com>,
 "Vladimir Medvedkin" <vladimir.medvedkin@intel.com>,
 "Anatoly Burakov" <anatoly.burakov@intel.com>,
 "Jingjing Wu" <jingjing.wu@intel.com>, "Rosen Xu" <rosen.xu@altera.com>,
 "Andrew Boyer" <andrew.boyer@amd.com>,
 "Dariusz Sosnowski" <dsosnowski@nvidia.com>,
 "Viacheslav Ovsiienko" <viacheslavo@nvidia.com>,
 "Bing Zhao" <bingz@nvidia.com>, "Ori Kam" <orika@nvidia.com>,
 "Suanming Mou" <suanmingm@nvidia.com>, "Matan Azrad" <matan@nvidia.com>,
 "Harman Kalra" <hkalra@marvell.com>, "Wenbo Cao" <caowenbo@mucse.com>,
 "Andrew Rybchenko" <andrew.rybchenko@oktetlabs.ru>,
 "Jerin Jacob" <jerinj@marvell.com>, "Maciej Czekaj" <mczekaj@marvell.com>
Cc: "Thomas Monjalon" <thomas@monjalon.net>,
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

Ethdev driver maintainers (CC: Ethdev API maintainers),

Your ethdev drivers support RTE_ETH_TX_OFFLOAD_MBUF_FAST_FREE, and =
probably call rte_mempool_put_bulk() in the mempool lib when =
FAST_FREE'ing mbufs, thereby bypassing the mbuf lib.
The appropriate mbuf lib function is rte_mbuf_raw_free_bulk(), which is =
a relatively new [1] inline function.
It's a simple wrapper calling rte_mempool_put_bulk(), with the addition =
of performing mbuf sanity checks when the appropriate defines are =
enabled.

In this context, "the appropriate defines" should be =
RTE_LIBRTE_MBUF_DEBUG (and not also RTE_ENABLE_ASSERT), so I have =
provided a patch [2] to fix this.

Similarly, the relatively new [1] inline function =
rte_mbuf_raw_alloc_bulk() in the mbuf lib is a wrapper for =
rte_mempool_get_bulk() in the mempool lib, with added sanity checks =
(when the appropriate defines are enabled).

Request 1: Please consider changing your driver to call =
rte_mbuf_raw_free_bulk() instead of rte_mempool_put_bulk() when =
FAST_FREE'ing mbufs.

Request 2: Please consider changing your driver to call =
rte_mbuf_raw_alloc_bulk() instead of rte_mempool_get_bulk() when =
allocating mbufs.

Request 3: Please review the patch [2].

General question: Are ethdev drivers being tested with =
RTE_LIBRTE_MBUF_DEBUG enabled, or should they be?

[1]: =
https://git.dpdk.org/dpdk/commit/lib/mbuf/rte_mbuf.h?id=3D55624173bacb2be=
caa67793b71391884876673c1
[2]: =
https://inbox.dpdk.org/dev/20250722093431.555214-1-mb@smartsharesystems.c=
om/

-Morten

