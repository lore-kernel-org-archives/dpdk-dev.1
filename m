Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AEEB3C3600C
	for <dpdk-dev@archiver.kernel.org>; Fri,  4 Apr 2025 01:48:11 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 5B05B40270;
	Fri,  4 Apr 2025 03:48:10 +0200 (CEST)
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
 by mails.dpdk.org (Postfix) with ESMTP id B54904026D
 for <dev@dpdk.org>; Fri,  4 Apr 2025 03:48:08 +0200 (CEST)
Received: by linux.microsoft.com (Postfix, from userid 1213)
 id CDA7D2027E03; Thu,  3 Apr 2025 18:48:07 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com CDA7D2027E03
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
 s=default; t=1743731287;
 bh=X6LUG9Qqwyl4Qv2zRZtCS+GuUhcPtG1oODhctNDFSGA=;
 h=From:To:Cc:Subject:Date:From;
 b=rO9k1JKZ56ljkesd1wKPhNiz52UoRH/of8KgsD52wfrIxAPkS0mOVpMDwX42aWMaU
 dnOWKW1xQkOBpSzPgimkYa/5PmJM5yB7BI5wt+etSWB/cHi63AiRjZ65dFlJ3spqHO
 aHgAI7f1WergAPOJDdjzMMfxq7oZIeKJmvqLOSQ4=
From: Andre Muezerie <andremue@linux.microsoft.com>
To: Nithin Dabilpuram <ndabilpuram@marvell.com>,
 Kiran Kumar K <kirankumark@marvell.com>,
 Sunil Kumar Kori <skori@marvell.com>, Satha Rao <skoteshwar@marvell.com>,
 Harman Kalra <hkalra@marvell.com>
Cc: dev@dpdk.org,
	Andre Muezerie <andremue@linux.microsoft.com>
Subject: [PATCH] drivers: remove __rte_used from functions for compatibility
 with MSVC
Date: Thu,  3 Apr 2025 18:47:49 -0700
Message-Id: <1743731269-5936-1-git-send-email-andremue@linux.microsoft.com>
X-Mailer: git-send-email 1.8.3.1
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

With gcc, the macro __rte_used translates to __attribute__((used)).
MSVC has something to the same effect, but harder to use and with some
limitations (one being that it cannot be used with "static"). Therefore,
it makes sense to avoid __rte_used in some cases.

The functions modified in this patch don't really need to use __rte_used.
Instead, these functions can be involved in same ifdefs used in the
callers. That way, they are only defined when needed (when
someone is actually calling the function). Doing so makes the code
compatible with MSVC and avoids compiler warnings about functions being
defined but not used.

Signed-off-by: Andre Muezerie <andremue@linux.microsoft.com>
---
 drivers/net/cnxk/cn10k_rx_select.c | 6 +++++-
 drivers/net/cnxk/cn10k_tx_select.c | 6 ++++--
 drivers/net/cnxk/cn20k_rx_select.c | 6 +++++-
 drivers/net/cnxk/cn20k_tx_select.c | 6 ++++--
 drivers/net/cnxk/cn9k_rx_select.c  | 6 ++++--
 drivers/net/cnxk/cn9k_tx_select.c  | 6 ++++--
 6 files changed, 26 insertions(+), 10 deletions(-)

diff --git a/drivers/net/cnxk/cn10k_rx_select.c b/drivers/net/cnxk/cn10k_rx_select.c
index fe1f0dda73..658a434d75 100644
--- a/drivers/net/cnxk/cn10k_rx_select.c
+++ b/drivers/net/cnxk/cn10k_rx_select.c
@@ -5,7 +5,9 @@
 #include "cn10k_ethdev.h"
 #include "cn10k_rx.h"
 
-static __rte_used void
+#if defined(RTE_ARCH_ARM64)
+#if !defined(CNXK_DIS_TMPLT_FUNC)
+static void
 pick_rx_func(struct rte_eth_dev *eth_dev,
 	     const eth_rx_burst_t rx_burst[NIX_RX_OFFLOAD_MAX])
 {
@@ -21,6 +23,8 @@ pick_rx_func(struct rte_eth_dev *eth_dev,
 
 	rte_atomic_thread_fence(rte_memory_order_release);
 }
+#endif
+#endif
 
 static uint16_t __rte_noinline __rte_hot __rte_unused
 cn10k_nix_flush_rx(void *rx_queue, struct rte_mbuf **rx_pkts, uint16_t pkts)
diff --git a/drivers/net/cnxk/cn10k_tx_select.c b/drivers/net/cnxk/cn10k_tx_select.c
index 56fddac5a0..b9a17b8bc2 100644
--- a/drivers/net/cnxk/cn10k_tx_select.c
+++ b/drivers/net/cnxk/cn10k_tx_select.c
@@ -5,7 +5,9 @@
 #include "cn10k_ethdev.h"
 #include "cn10k_tx.h"
 
-static __rte_used inline void
+#if defined(RTE_ARCH_ARM64)
+#if !defined(CNXK_DIS_TMPLT_FUNC)
+static inline void
 pick_tx_func(struct rte_eth_dev *eth_dev,
 	     const eth_tx_burst_t tx_burst[NIX_TX_OFFLOAD_MAX])
 {
@@ -19,8 +21,8 @@ pick_tx_func(struct rte_eth_dev *eth_dev,
 		rte_eth_fp_ops[eth_dev->data->port_id].tx_pkt_burst =
 			eth_dev->tx_pkt_burst;
 }
+#endif
 
-#if defined(RTE_ARCH_ARM64)
 static int
 cn10k_nix_tx_queue_count(void *tx_queue)
 {
diff --git a/drivers/net/cnxk/cn20k_rx_select.c b/drivers/net/cnxk/cn20k_rx_select.c
index 25c79434cd..df12befc20 100644
--- a/drivers/net/cnxk/cn20k_rx_select.c
+++ b/drivers/net/cnxk/cn20k_rx_select.c
@@ -5,7 +5,9 @@
 #include "cn20k_ethdev.h"
 #include "cn20k_rx.h"
 
-static __rte_used void
+#if defined(RTE_ARCH_ARM64)
+#if !defined(CNXK_DIS_TMPLT_FUNC)
+static void
 pick_rx_func(struct rte_eth_dev *eth_dev, const eth_rx_burst_t rx_burst[NIX_RX_OFFLOAD_MAX])
 {
 	struct cnxk_eth_dev *dev = cnxk_eth_pmd_priv(eth_dev);
@@ -18,6 +20,8 @@ pick_rx_func(struct rte_eth_dev *eth_dev, const eth_rx_burst_t rx_burst[NIX_RX_O
 
 	rte_atomic_thread_fence(rte_memory_order_release);
 }
+#endif
+#endif
 
 static uint16_t __rte_noinline __rte_hot __rte_unused
 cn20k_nix_flush_rx(void *rx_queue, struct rte_mbuf **rx_pkts, uint16_t pkts)
diff --git a/drivers/net/cnxk/cn20k_tx_select.c b/drivers/net/cnxk/cn20k_tx_select.c
index fb62b54a5f..d0c97a6c19 100644
--- a/drivers/net/cnxk/cn20k_tx_select.c
+++ b/drivers/net/cnxk/cn20k_tx_select.c
@@ -5,7 +5,9 @@
 #include "cn20k_ethdev.h"
 #include "cn20k_tx.h"
 
-static __rte_used inline void
+#if defined(RTE_ARCH_ARM64)
+#if !defined(CNXK_DIS_TMPLT_FUNC)
+static inline void
 pick_tx_func(struct rte_eth_dev *eth_dev, const eth_tx_burst_t tx_burst[NIX_TX_OFFLOAD_MAX])
 {
 	struct cnxk_eth_dev *dev = cnxk_eth_pmd_priv(eth_dev);
@@ -16,8 +18,8 @@ pick_tx_func(struct rte_eth_dev *eth_dev, const eth_tx_burst_t tx_burst[NIX_TX_O
 	if (eth_dev->data->dev_started)
 		rte_eth_fp_ops[eth_dev->data->port_id].tx_pkt_burst = eth_dev->tx_pkt_burst;
 }
+#endif
 
-#if defined(RTE_ARCH_ARM64)
 static int
 cn20k_nix_tx_queue_count(void *tx_queue)
 {
diff --git a/drivers/net/cnxk/cn9k_rx_select.c b/drivers/net/cnxk/cn9k_rx_select.c
index 0d4031ddeb..8cddc88e5d 100644
--- a/drivers/net/cnxk/cn9k_rx_select.c
+++ b/drivers/net/cnxk/cn9k_rx_select.c
@@ -5,7 +5,9 @@
 #include "cn9k_ethdev.h"
 #include "cn9k_rx.h"
 
-static __rte_used void
+#if defined(RTE_ARCH_ARM64)
+#if !defined(CNXK_DIS_TMPLT_FUNC)
+static void
 pick_rx_func(struct rte_eth_dev *eth_dev,
 	     const eth_rx_burst_t rx_burst[NIX_RX_OFFLOAD_MAX])
 {
@@ -19,8 +21,8 @@ pick_rx_func(struct rte_eth_dev *eth_dev,
 		rte_eth_fp_ops[eth_dev->data->port_id].rx_pkt_burst =
 			eth_dev->rx_pkt_burst;
 }
+#endif
 
-#if defined(RTE_ARCH_ARM64)
 static void
 cn9k_eth_set_rx_tmplt_func(struct rte_eth_dev *eth_dev)
 {
diff --git a/drivers/net/cnxk/cn9k_tx_select.c b/drivers/net/cnxk/cn9k_tx_select.c
index 497449b1c4..8eaf6ad1d1 100644
--- a/drivers/net/cnxk/cn9k_tx_select.c
+++ b/drivers/net/cnxk/cn9k_tx_select.c
@@ -5,7 +5,9 @@
 #include "cn9k_ethdev.h"
 #include "cn9k_tx.h"
 
-static __rte_used void
+#if defined(RTE_ARCH_ARM64)
+#if !defined(CNXK_DIS_TMPLT_FUNC)
+static void
 pick_tx_func(struct rte_eth_dev *eth_dev,
 	     const eth_tx_burst_t tx_burst[NIX_TX_OFFLOAD_MAX])
 {
@@ -19,8 +21,8 @@ pick_tx_func(struct rte_eth_dev *eth_dev,
 		rte_eth_fp_ops[eth_dev->data->port_id].tx_pkt_burst =
 			eth_dev->tx_pkt_burst;
 }
+#endif
 
-#if defined(RTE_ARCH_ARM64)
 static int
 cn9k_nix_tx_queue_count(void *tx_queue)
 {
-- 
2.49.0.vfs.0.0

