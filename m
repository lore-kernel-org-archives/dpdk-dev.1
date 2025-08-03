Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AB75EC87FCB
	for <dpdk-dev@archiver.kernel.org>; Sun,  3 Aug 2025 19:42:35 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 3BB4E402F2;
	Sun,  3 Aug 2025 21:42:31 +0200 (CEST)
Received: from dkmailrelay1.smartsharesystems.com
 (smartserver.smartsharesystems.com [77.243.40.215])
 by mails.dpdk.org (Postfix) with ESMTP id D4AD94026C
 for <dev@dpdk.org>; Sun,  3 Aug 2025 21:42:27 +0200 (CEST)
Received: from smartserver.smartsharesystems.com
 (smartserver.smartsharesys.local [192.168.4.10])
 by dkmailrelay1.smartsharesystems.com (Postfix) with ESMTP id A525B20446;
 Sun,  3 Aug 2025 21:42:26 +0200 (CEST)
Received: from dkrd4.smartsharesys.local ([192.168.4.26]) by
 smartserver.smartsharesystems.com with Microsoft SMTPSVC(6.0.3790.4675); 
 Sun, 3 Aug 2025 21:42:26 +0200
From: =?UTF-8?q?Morten=20Br=C3=B8rup?= <mb@smartsharesystems.com>
To: dev@dpdk.org, Aman Singh <aman.deep.singh@intel.com>,
 Thomas Monjalon <thomas@monjalon.net>,
 Andrew Rybchenko <andrew.rybchenko@oktetlabs.ru>,
 Ivan Malov <ivan.malov@arknetworks.am>,
 Stephen Hemminger <stephen@networkplumber.org>
Cc: Konstantin Ananyev <konstantin.ananyev@huawei.com>,
 =?UTF-8?q?Morten=20Br=C3=B8rup?= <mb@smartsharesystems.com>
Subject: [PATCH v3 1/3] testpmd: Do not enable mbuf fast release TX offload by
 default
Date: Sun,  3 Aug 2025 19:42:16 +0000
Message-ID: <20250803194218.683318-1-mb@smartsharesystems.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250731090731.671589-1-mb@smartsharesystems.com>
References: <20250731090731.671589-1-mb@smartsharesystems.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-OriginalArrivalTime: 03 Aug 2025 19:42:26.0340 (UTC)
 FILETIME=[BD711E40:01DC04AE]
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

Enabling some offload by default may conflict with a manually configured
offload.
Specifically, the mbuf fast release TX offload, which conflicts with multi
segment packet TX offload, was enabled by default.
Therefore, mbuf fast release TX offload (the only TX offload which was
enabled by default) is not enabled by default anymore.

Signed-off-by: Morten Brørup <mb@smartsharesystems.com>
---
 app/test-pmd/testpmd.c | 11 +----------
 1 file changed, 1 insertion(+), 10 deletions(-)

diff --git a/app/test-pmd/testpmd.c b/app/test-pmd/testpmd.c
index bb88555328..f00eae3992 100644
--- a/app/test-pmd/testpmd.c
+++ b/app/test-pmd/testpmd.c
@@ -490,9 +490,7 @@ lcoreid_t latencystats_lcore_id = -1;
  */
 struct rte_eth_rxmode rx_mode;
 
-struct rte_eth_txmode tx_mode = {
-	.offloads = RTE_ETH_TX_OFFLOAD_MBUF_FAST_FREE,
-};
+struct rte_eth_txmode tx_mode;
 
 volatile int test_done = 1; /* stop packet forwarding when set to 1. */
 
@@ -1592,10 +1590,6 @@ init_config_port_offloads(portid_t pid, uint32_t socket_id)
 	if (ret != 0)
 		rte_exit(EXIT_FAILURE, "rte_eth_dev_info_get() failed\n");
 
-	if (!(port->dev_info.tx_offload_capa & RTE_ETH_TX_OFFLOAD_MBUF_FAST_FREE))
-		port->dev_conf.txmode.offloads &=
-			~RTE_ETH_TX_OFFLOAD_MBUF_FAST_FREE;
-
 	/* Apply Rx offloads configuration */
 	for (i = 0; i < port->dev_info.max_rx_queues; i++)
 		port->rxq[i].conf.offloads = port->dev_conf.rxmode.offloads;
@@ -2857,9 +2851,6 @@ update_bonding_port_dev_conf(portid_t bond_pid)
 		return;
 	}
 
-	if (port->dev_info.tx_offload_capa & RTE_ETH_TX_OFFLOAD_MBUF_FAST_FREE)
-		port->dev_conf.txmode.offloads |=
-				RTE_ETH_TX_OFFLOAD_MBUF_FAST_FREE;
 	/* Apply Tx offloads configuration */
 	for (i = 0; i < port->dev_info.max_tx_queues; i++)
 		port->txq[i].conf.offloads = port->dev_conf.txmode.offloads;
-- 
2.43.0

