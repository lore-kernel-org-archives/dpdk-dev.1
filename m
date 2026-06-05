Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8DD4DCD6E7B
	for <dpdk-dev@archiver.kernel.org>; Fri,  5 Jun 2026 23:35:44 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 8573440676;
	Sat,  6 Jun 2026 01:35:26 +0200 (CEST)
Received: from fout-a5-smtp.messagingengine.com
 (fout-a5-smtp.messagingengine.com [103.168.172.148])
 by mails.dpdk.org (Postfix) with ESMTP id 29798402C3
 for <dev@dpdk.org>; Sat,  6 Jun 2026 01:35:24 +0200 (CEST)
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
 by mailfout.phl.internal (Postfix) with ESMTP id BAED8EC01B5;
 Fri,  5 Jun 2026 19:35:23 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
 by phl-compute-06.internal (MEProxy); Fri, 05 Jun 2026 19:35:23 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=monjalon.net; h=
 cc:cc:content-transfer-encoding:content-type:date:date:from:from
 :in-reply-to:in-reply-to:message-id:mime-version:references
 :reply-to:subject:subject:to:to; s=fm1; t=1780702523; x=
 1780788923; bh=VAxquYOIddEf2L78dY+E7qMlpgWhaOORmeZG4+JbNig=; b=K
 GDKXS84f6p20Hk0CkzYuCN2oYZgPMF/WbTiRpytoLerZim7xrkTSznoDMsZLJjqM
 QQ+VX5nhDCNaoe++u7dWbtCPcs0JoWqfcLtx7VBZGbcV2Ip+SG2DN7k2CUlNP5lz
 RpWZkvkNayEVsLdTkxB8RWZsQtBVtzKt7XN3bJJ2MItnsaVoJ3UfwSevWfJPwwU1
 Cu5KH3XC4vxre4Erx2Khn/kUB5q9W5d4QvvwYlwQifsemAC4L/IymvrTQOA+E4Zu
 c67o8GziLoc/LUywrRiCV3X2r7hZF35PEOj0+V5ukzC3JbgPcwC9Q66MhKGf1R3G
 uWNfEHd7VckmXMcfAqVuQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-transfer-encoding
 :content-type:date:date:feedback-id:feedback-id:from:from
 :in-reply-to:in-reply-to:message-id:mime-version:references
 :reply-to:subject:subject:to:to:x-me-proxy:x-me-sender
 :x-me-sender:x-sasl-enc; s=fm1; t=1780702523; x=1780788923; bh=V
 AxquYOIddEf2L78dY+E7qMlpgWhaOORmeZG4+JbNig=; b=lf+81qtu3G+00n+MD
 F2NZsUcelMfg+GO9d2WhSeP+Or9f/YTt5Kk7auyR1MpmtJfOegLXOJG7ZP5kIy3G
 nQhgrJie1rUqQh0+tjxEfTgS90t7FhzIAhCLHRSaGTIojiQvfh7hcEO7PEceqFN2
 Z1KGKBdsrmWUwov6f6P2CcbJmCNB/RrWssQZlgSLT5ipQJ9gXM93vQYa9KdcjHss
 npc3Yochb68ndLTOqACKgmQYMg3VSwE8yStLilwmUbg5QAGvvW9WMLvKtPlflqwf
 Bzm2he/FqbRm+f1nOAZRJpk5AVIU7n1MZ0XkMF5LtRKZtgXVDgMnDG5fjt1q0Oz+
 itVTQ==
X-ME-Sender: <xms:O10jajdeAalbum-WUCeuergCu130XzvOGPYpGqIPxpEzTwJLBG15FA>
 <xme:O10jalOFpp2bPPOM_BJDwZ_eMBQa9debLVAKCG-7dlowNL129csetMy3a683vgYtx
 80nPB8hG3-FvW89KacB6lGbnkEyih08pk5GHSAYYLFkjbIW_ARuRA>
X-ME-Received: <xmr:O10jauum9iBm6VQnctUT8qdSTZEwngZ1NoreYxu24ZMr2I7xMDoniMgIdSKm-GuxGdJb5AnxlsTLrmN4cpVotwNh05kFRLU>
X-ME-Proxy-Cause: dmFkZTFqmpkXDQSBPtmwRLgHjbXXacitbtSCfQbg6hh1/eqVki9438MkiHuZPawIr9Aqda
 SZ80gnAheg79EI/Os+vF7aG+9+xu+yNJROsKT/y6DTpDNGZ0uQfSw13Gnka+NAJSdwJ2CU
 vYyAXcaka1N6N7g7URPXXdxGOq5+oKS36Yzn0NyofAZLGgsujIyKw1UckgSzoPT2e74gj9
 BbAcCJjC/ReBkrLHFagJ4VsJ7EQx/SKINSc62sOrH3s0ZpNtEKekRRlLq/PS+Z4hPC+WJP
 +MJnRV3Q9wOidAJ0o7FMTvZ795sRl0UPltZwCKzPx0EkhauBrQzyrJuKMBJiFNosVVXHq5
 Xfyk/TlbG55Ij0GJgdxklvUkrvMA4NVFZVAIOro+mvxSAsHMpPjmAC/LI7IqKflHAYlNdg
 gqjF+oe7aao00lqpxHBqlRDWF4hVEMyO9mMkZX7vhn/fk7bTzsCac+cFqFUgBbzMnodP+p
 x4syYPImTgTO1zpGwaxwkLeQatfCVAp8zWGtPOQoY00VLTb25ey5v2NpmKUZTfL+OXKUSb
 yreExBWwLLuQMZCGHyHh/+amkx20WtTdNXKWf0VDtdawaOC8UzPSwqAC2WOE1NnhZlQuTZ
 QeTdsNp4EgXE261V/FNjEI20YKoovV6xNAe/q3SUS2shxlb3/i8ekQRkQSOg
X-ME-Proxy: <xmx:O10jamAUVIBqLaDybuKrTWOBM-vjJMbTRZ4s0IYamL_RPFpQQIAY8A>
 <xmx:O10jatbBuL0hhDwFvzs-C-Gn0Xkn-qhS18EladSfTptvNh7DQ9P6Mg>
 <xmx:O10japWBpRjRs0hRWhMg9wtAnZiYArMJL16CBbjvW7juKSc9-D5_2g>
 <xmx:O10jakM6wF3iEjeSef72dBMpBqfAyxgBGeSm305lsuYmzF4eEucS3g>
 <xmx:O10jaoDIRy1soVcub8bihqLfenBtQxqqUbp1V9t4uGfPtCMJXfXkelvy>
Feedback-ID: i47234305:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 5 Jun 2026 19:35:21 -0400 (EDT)
From: Thomas Monjalon <thomas@monjalon.net>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>,
 Gregory Etelson <getelson@nvidia.com>,
 Dariusz Sosnowski <dsosnowski@nvidia.com>,
 Viacheslav Ovsiienko <viacheslavo@nvidia.com>,
 Bing Zhao <bingz@nvidia.com>, Ori Kam <orika@nvidia.com>,
 Suanming Mou <suanmingm@nvidia.com>, Matan Azrad <matan@nvidia.com>
Subject: [PATCH v9 06/10] net/mlx5: support selective Rx
Date: Sat,  6 Jun 2026 01:33:46 +0200
Message-ID: <20260605233456.3017423-7-thomas@monjalon.net>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260605233456.3017423-1-thomas@monjalon.net>
References: <20260202160903.254621-1-getelson@nvidia.com>
 <20260605233456.3017423-1-thomas@monjalon.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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

From: Gregory Etelson <getelson@nvidia.com>

Selective Rx may save some PCI bandwidth.
Implement selective Rx in the (quite slow) scalar SPRQ Rx path
mlx5_rx_burst() where the performance impact
of the added condition branches is acceptable.
Other Rx functions do not support this feature.
When using selective Rx, mlx5_rx_burst will be selected.

A null Memory Region (MR) is always allocated
at shared device context initialization.
The selective Rx capability is not advertised
if this special MR allocation fails.

For each Rx segment configured with a NULL mempool,
a "null mbuf" is created.
It is a fake mbuf allocated outside any mempool,
used as a placeholder in the Rx ring.
The null MR lkey is used in the WQE for these segments
so the NIC writes received data to a discard buffer.
The mbuf data room size is resolved from the first segment having a pool.
For null segments, the buffer length is from the last seen pool,
so that the WQE stride size remains consistent.

In mlx5_rx_burst, discarded segments are not chained
into the packet mbuf list, NB_SEGS is decremented accordingly,
and no replacement buffer is allocated.
A separate data_seg_len accumulator tracks the total length
of delivered segments only.
The packet length is adjusted to reflect only the data
actually delivered to the application.

Signed-off-by: Gregory Etelson <getelson@nvidia.com>
Signed-off-by: Thomas Monjalon <thomas@monjalon.net>
---
 doc/guides/nics/features/mlx5.ini      |   1 +
 doc/guides/nics/mlx5.rst               |  86 +++++++++---
 doc/guides/rel_notes/release_26_07.rst |   4 +
 drivers/net/mlx5/mlx5.c                |   7 +
 drivers/net/mlx5/mlx5.h                |   1 +
 drivers/net/mlx5/mlx5_ethdev.c         |  25 ++++
 drivers/net/mlx5/mlx5_rx.c             | 187 +++++++++++++++----------
 drivers/net/mlx5/mlx5_rx.h             |   1 +
 drivers/net/mlx5/mlx5_rxq.c            |  95 +++++++++----
 drivers/net/mlx5/mlx5_trigger.c        |  64 +++++++--
 10 files changed, 330 insertions(+), 141 deletions(-)

diff --git a/doc/guides/nics/features/mlx5.ini b/doc/guides/nics/features/mlx5.ini
index 3b3eda28b8..ae8c83057b 100644
--- a/doc/guides/nics/features/mlx5.ini
+++ b/doc/guides/nics/features/mlx5.ini
@@ -16,6 +16,7 @@ Burst mode info      = Y
 Power mgmt address monitor = Y
 MTU update           = Y
 Buffer split on Rx   = Y
+Selective Rx         = Y
 Scattered Rx         = Y
 LRO                  = Y
 TSO                  = Y
diff --git a/doc/guides/nics/mlx5.rst b/doc/guides/nics/mlx5.rst
index 00bfb31370..afbf040e66 100644
--- a/doc/guides/nics/mlx5.rst
+++ b/doc/guides/nics/mlx5.rst
@@ -84,6 +84,9 @@ The Rx / Tx data path use different techniques to offer the best performance.
   with :ref:`multi-packet Rx queues (MPRQ) <mlx5_mprq_params>`.
   This feature is disabled by default.
 
+- Some PCI bandwidth is saved by receiving partial packets
+  with :ref:`selective Rx <mlx5_selective_rx>`.
+
 More details about Rx implementations and their configurations are provided
 in the chapter about :ref:`mlx5_rx_functions`.
 
@@ -879,6 +882,8 @@ MLX5 supports various methods to report statistics:
 Basic port statistics can be queried using ``rte_eth_stats_get()``.
 The received and sent statistics are through SW only
 and counts the number of packets received or sent successfully by the PMD.
+In the case of :ref:`selective Rx <mlx5_selective_rx>`,
+the ``ibytes`` counter matches segments delivered, not the skipped ones.
 The ``imissed`` counter is the amount of packets that could not be delivered
 to SW because a queue was full.
 Packets not received due to congestion in the bus or on the NIC
@@ -992,25 +997,26 @@ These configurations may also have an impact on the behavior:
 
 .. table:: Rx burst functions
 
-   +-------------------+------------------------+---------+-----------------+------+-------+---------+
-   || Function Name    || Parameters to Enable  || Scatter|| Error Recovery || CQE || Large|| Shared |
-   |                   |                        |         |                 || comp|| MTU  |  RxQ    |
-   +===================+========================+=========+=================+======+=======+=========+
-   | rx_burst          | rx_vec_en=0            |   Yes   | Yes             |  Yes |  Yes  | No      |
-   +-------------------+------------------------+---------+-----------------+------+-------+---------+
-   | rx_burst_vec      | rx_vec_en=1 (default)  |   No    | if CQE comp off |  Yes |  No   | No      |
-   +-------------------+------------------------+---------+-----------------+------+-------+---------+
-   | rx_burst_mprq     || mprq_en=1             |   No    | Yes             |  Yes |  Yes  | No      |
-   |                   || RxQs >= rxqs_min_mprq |         |                 |      |       |         |
-   +-------------------+------------------------+---------+-----------------+------+-------+---------+
-   | rx_burst_mprq_vec || rx_vec_en=1 (default) |   No    | if CQE comp off |  Yes |  Yes  | No      |
-   |                   || mprq_en=1             |         |                 |      |       |         |
-   |                   || RxQs >= rxqs_min_mprq |         |                 |      |       |         |
-   +-------------------+------------------------+---------+-----------------+------+-------+---------+
-   | rx_burst          | at least one Rx queue  |   Yes   | Yes             |  Yes |  Yes  | Yes     |
-   |  (out of order)   | on the device          |         |                 |      |       |         |
-   |                   | is shared              |         |                 |      |       |         |
-   +-------------------+------------------------+---------+-----------------+------+-------+---------+
+   +----------+-----------------------+---------+--------+----------+------+-------+--------+
+   || Function|| Parameters to Enable || Scatter|| Selec-|| Error   || CQE || Large|| Shared|
+   || Name    |                       |         || tive  || Recovery|| comp|| MTU  || RxQ   |
+   +==========+=======================+=========+========+==========+======+=======+========+
+   | rx_burst | rx_vec_en=0           |   Yes   |   Yes  | Yes      |  Yes |  Yes  |   No   |
+   +----------+-----------------------+---------+--------+----------+------+-------+--------+
+   | _vec     | rx_vec_en=1 (default) |   No    |   No   || if CQE  |  Yes |  No   |   No   |
+   |          |                       |         |        || comp off|      |       |        |
+   +----------+-----------------------+---------+--------+----------+------+-------+--------+
+   | _mprq    || mprq_en=1            |   No    |   No   | Yes      |  Yes |  Yes  |   No   |
+   |          || RxQs >= rxqs_min_mprq|         |        |          |      |       |        |
+   +----------+-----------------------+---------+--------+----------+------+-------+--------+
+   | _mprq_vec|| rx_vec_en=1 (default)|   No    |   No   || if CQE  |  Yes |  Yes  |   No   |
+   |          || mprq_en=1            |         |        || comp off|      |       |        |
+   |          || RxQs >= rxqs_min_mprq|         |        |          |      |       |        |
+   +----------+-----------------------+---------+--------+----------+------+-------+--------+
+   || _out_of || at least one Rx queue|   Yes   |   No   | Yes      |  Yes |  Yes  |   Yes  |
+   || _order  || on the device        |         |        |          |      |       |        |
+   |          || is shared            |         |        |          |      |       |        |
+   +----------+-----------------------+---------+--------+----------+------+-------+--------+
 
 
 Rx/Tx Tuning
@@ -1105,13 +1111,14 @@ Rx interrupt                                X
 :ref:`Rx threshold <mlx5_rx_threshold>`     X        X
 :ref:`Rx drop delay <mlx5_drop>`            X        X
 :ref:`Rx timestamp <mlx5_rx_timstp>`        X        X
+:ref:`buffer split <mlx5_buf_split>`        X        X
+:ref:`selective Rx <mlx5_selective_rx>`     X
+:ref:`multi-segment <mlx5_multiseg>`        X        X
 :ref:`Tx scheduling <mlx5_tx_sched>`        X
 :ref:`Tx rate limit <mlx5_rate_limit>`      X
 :ref:`Tx inline <mlx5_tx_inline>`           X        X
 :ref:`Tx fast free <mlx5_tx_fast_free>`     X        X
 :ref:`Tx affinity <mlx5_aggregated>`        X
-:ref:`buffer split <mlx5_buf_split>`        X        X
-:ref:`multi-segment <mlx5_multiseg>`        X        X
 promiscuous                                 X        X
 multicast promiscuous                       X        X
 multiple MAC addresses                      X
@@ -2248,13 +2255,50 @@ OFED       5.1-2
 DPDK       20.11
 =========  ==========
 
+Runtime configuration
+^^^^^^^^^^^^^^^^^^^^^
+
+The offload flag ``RTE_ETH_RX_OFFLOAD_BUFFER_SPLIT`` is required.
+
+When calling ``rte_eth_rx_queue_setup()``,
+the input ``rte_eth_rxconf::rx_seg`` defines the configuration of the segments,
+mainly offset and length.
+
 Limitations
 ^^^^^^^^^^^
 
+#. Splitting per protocol header is not supported.
+
 #. Buffer split offload is supported with regular Rx burst routine only,
    no MPRQ feature or vectorized code can be engaged.
 
 
+.. _mlx5_selective_rx:
+
+Selective Rx
+~~~~~~~~~~~~
+
+Some PCI bandwidth can be saved
+by :ref:`skipping some parts of Rx data <nic_features_selective_rx>`.
+It is enabled when using :ref:`buffer split <mlx5_buf_split>`
+and configuring no mempool in some segments to discard.
+
+Runtime configuration
+^^^^^^^^^^^^^^^^^^^^^
+
+The offload flag ``RTE_ETH_RX_OFFLOAD_BUFFER_SPLIT`` is required.
+
+When calling ``rte_eth_rx_queue_setup()``,
+the segment to discard (``rte_eth_rxconf::rx_seg::split``)
+is marked by the absence of mempool (``mp = NULL``).
+
+Limitations
+^^^^^^^^^^^
+
+#. Selective Rx is supported with regular Rx burst routine only,
+   no MPRQ feature or vectorized code can be engaged.
+
+
 .. _mlx5_multiseg:
 
 Multi-Segment Scatter/Gather
diff --git a/doc/guides/rel_notes/release_26_07.rst b/doc/guides/rel_notes/release_26_07.rst
index 46a8fe2cc1..0ac9816a85 100644
--- a/doc/guides/rel_notes/release_26_07.rst
+++ b/doc/guides/rel_notes/release_26_07.rst
@@ -103,6 +103,10 @@ New Features
   * Added support for transmitting LLDP packets based on mbuf packet type.
   * Implemented AVX2 context descriptor transmit paths.
 
+* **Updated NVIDIA mlx5 ethernet driver.**
+
+  * Added support for selective Rx in scalar SPRQ Rx path.
+
 * **Updated PCAP ethernet driver.**
 
   * Added support for VLAN insertion and stripping.
diff --git a/drivers/net/mlx5/mlx5.c b/drivers/net/mlx5/mlx5.c
index f190654756..61c26d1206 100644
--- a/drivers/net/mlx5/mlx5.c
+++ b/drivers/net/mlx5/mlx5.c
@@ -1975,6 +1975,9 @@ mlx5_alloc_shared_dev_ctx(const struct mlx5_dev_spawn_data *spawn,
 	/* Init counter pool list header and lock. */
 	LIST_INIT(&sh->hws_cpool_list);
 	rte_spinlock_init(&sh->cpool_lock);
+	sh->null_mr = mlx5_os_alloc_null_mr(sh->cdev->dev, sh->cdev->pd);
+	if (!sh->null_mr)
+		DRV_LOG(DEBUG, "Fail to initialize NULL MR, selective Rx is disabled.");
 exit:
 	pthread_mutex_unlock(&mlx5_dev_ctx_list_mutex);
 	return sh;
@@ -2139,6 +2142,10 @@ mlx5_free_shared_dev_ctx(struct mlx5_dev_ctx_shared *sh)
 	MLX5_ASSERT(sh->geneve_tlv_option_resource == NULL);
 	pthread_mutex_destroy(&sh->txpp.mutex);
 	mlx5_lwm_unset(sh);
+	if (sh->null_mr) {
+		mlx5_os_free_null_mr(sh->null_mr);
+		sh->null_mr = NULL;
+	}
 	mlx5_physical_device_destroy(sh->phdev);
 	mlx5_free(sh);
 	return;
diff --git a/drivers/net/mlx5/mlx5.h b/drivers/net/mlx5/mlx5.h
index 92a00cfaa8..bd6ef35b53 100644
--- a/drivers/net/mlx5/mlx5.h
+++ b/drivers/net/mlx5/mlx5.h
@@ -1674,6 +1674,7 @@ struct mlx5_dev_ctx_shared {
 	rte_spinlock_t cpool_lock;
 	LIST_HEAD(hws_cpool_list, mlx5_hws_cnt_pool) hws_cpool_list; /* Count pool list. */
 	struct mlx5_dev_registers registers;
+	struct mlx5_pmd_mr *null_mr;
 	struct mlx5_dev_shared_port port[]; /* per device port data array. */
 };
 
diff --git a/drivers/net/mlx5/mlx5_ethdev.c b/drivers/net/mlx5/mlx5_ethdev.c
index a29cdeeb50..7b7536fa1e 100644
--- a/drivers/net/mlx5/mlx5_ethdev.c
+++ b/drivers/net/mlx5/mlx5_ethdev.c
@@ -381,6 +381,7 @@ mlx5_dev_infos_get(struct rte_eth_dev *dev, struct rte_eth_dev_info *info)
 	info->rx_seg_capa.multi_pools = !priv->config.mprq.enabled;
 	info->rx_seg_capa.offset_allowed = !priv->config.mprq.enabled;
 	info->rx_seg_capa.offset_align_log2 = 0;
+	info->rx_seg_capa.selective_rx = !!priv->sh->null_mr;
 	info->rx_offload_capa = (mlx5_get_rx_port_offloads() |
 				 info->rx_queue_offload_capa);
 	info->tx_offload_capa = mlx5_get_tx_port_offloads(dev);
@@ -708,6 +709,25 @@ mlx5_dev_set_mtu(struct rte_eth_dev *dev, uint16_t mtu)
 	return -rte_errno;
 }
 
+static bool
+mlx5_selective_rx_enabled(struct rte_eth_dev *dev)
+{
+	struct mlx5_priv *priv = dev->data->dev_private;
+
+	for (uint32_t q = 0; q < priv->rxqs_n; ++q) {
+		struct mlx5_rxq_ctrl *rxq_ctrl = mlx5_rxq_ctrl_get(dev, q);
+
+		if (rxq_ctrl == NULL || rxq_ctrl->is_hairpin)
+			continue;
+		for (uint16_t s = 0; s < rxq_ctrl->rxq.rxseg_n; s++) {
+			if (rxq_ctrl->rxq.rxseg[s].mp == NULL)
+				return true;
+		}
+	}
+
+	return false;
+}
+
 /**
  * Configure the RX function to use.
  *
@@ -723,6 +743,11 @@ mlx5_select_rx_function(struct rte_eth_dev *dev)
 	eth_rx_burst_t rx_pkt_burst = mlx5_rx_burst;
 
 	MLX5_ASSERT(dev != NULL);
+	if (mlx5_selective_rx_enabled(dev)) {
+		DRV_LOG(DEBUG, "port %u forced to scalar SPRQ Rx (selective Rx configured)",
+			dev->data->port_id);
+		return rx_pkt_burst;
+	}
 	if (mlx5_shared_rq_enabled(dev)) {
 		rx_pkt_burst = mlx5_rx_burst_out_of_order;
 		DRV_LOG(DEBUG, "port %u forced to use SPRQ"
diff --git a/drivers/net/mlx5/mlx5_rx.c b/drivers/net/mlx5/mlx5_rx.c
index 185bfd4fff..9812bc7929 100644
--- a/drivers/net/mlx5/mlx5_rx.c
+++ b/drivers/net/mlx5/mlx5_rx.c
@@ -486,7 +486,7 @@ mlx5_rxq_initialize(struct mlx5_rxq_data *rxq)
 					rxq->wqes)[i];
 			addr = rte_pktmbuf_mtod(buf, uintptr_t);
 			byte_count = DATA_LEN(buf);
-			lkey = mlx5_rx_mb2mr(rxq, buf);
+			lkey = buf->pool ? mlx5_rx_mb2mr(rxq, buf) : rxq->sh->null_mr->lkey;
 		}
 		/* scat->addr must be able to store a pointer. */
 		MLX5_ASSERT(sizeof(scat->addr) >= sizeof(uintptr_t));
@@ -1044,11 +1044,14 @@ mlx5_rx_burst(void *dpdk_rxq, struct rte_mbuf **pkts, uint16_t pkts_n)
 	const unsigned int sges_n = rxq->sges_n;
 	struct rte_mbuf *pkt = NULL;
 	struct rte_mbuf *seg = NULL;
+	struct rte_mbuf *tail = NULL;
 	volatile struct mlx5_cqe *cqe =
 		&(*rxq->cqes)[rxq->cq_ci & cqe_mask];
+	volatile struct mlx5_mini_cqe8 *mcqe = NULL;
 	unsigned int i = 0;
 	unsigned int rq_ci = rxq->rq_ci << sges_n;
 	int len = 0; /* keep its value across iterations. */
+	uint32_t data_seg_len = 0;
 
 	while (pkts_n) {
 		uint16_t skip_cnt;
@@ -1056,105 +1059,137 @@ mlx5_rx_burst(void *dpdk_rxq, struct rte_mbuf **pkts, uint16_t pkts_n)
 		volatile struct mlx5_wqe_data_seg *wqe =
 			&((volatile struct mlx5_wqe_data_seg *)rxq->wqes)[idx];
 		struct rte_mbuf *rep = (*rxq->elts)[idx];
-		volatile struct mlx5_mini_cqe8 *mcqe = NULL;
 
-		if (pkt)
-			NEXT(seg) = rep;
+		if (pkt) {
+			if (rep->pool)
+				NEXT(tail) = rep;
+			else
+				--NB_SEGS(pkt);
+		}
 		seg = rep;
 		rte_prefetch0(seg);
 		rte_prefetch0(cqe);
 		rte_prefetch0(wqe);
-		/* Allocate the buf from the same pool. */
-		rep = rte_mbuf_raw_alloc(seg->pool);
-		if (unlikely(rep == NULL)) {
-			++rxq->stats.rx_nombuf;
-			if (!pkt) {
-				/*
-				 * no buffers before we even started,
-				 * bail out silently.
-				 */
-				break;
-			}
-			while (pkt != seg) {
-				MLX5_ASSERT(pkt != (*rxq->elts)[idx]);
-				rep = NEXT(pkt);
-				NEXT(pkt) = NULL;
-				NB_SEGS(pkt) = 1;
-				rte_mbuf_raw_free(pkt);
-				pkt = rep;
-			}
-			rq_ci >>= sges_n;
-			++rq_ci;
-			rq_ci <<= sges_n;
-			break;
-		}
-		if (!pkt) {
-			cqe = &(*rxq->cqes)[rxq->cq_ci & cqe_mask];
-			len = mlx5_rx_poll_len(rxq, cqe, cqe_n, cqe_mask,
-					       &mcqe, &skip_cnt, false, NULL);
-			if (unlikely(len & MLX5_ERROR_CQE_MASK)) {
-				/* We drop packets with non-critical errors */
-				rte_mbuf_raw_free(rep);
-				if (len == MLX5_CRITICAL_ERROR_CQE_RET) {
-					rq_ci = rxq->rq_ci << sges_n;
+		if (seg->pool) {
+			/* Allocate the buf from the same pool. */
+			rep = rte_mbuf_raw_alloc(seg->pool);
+			if (unlikely(rep == NULL)) {
+				++rxq->stats.rx_nombuf;
+				if (!pkt) {
+					/*
+					 * no buffers before we even started,
+					 * bail out silently.
+					 */
 					break;
 				}
-				/* Skip specified amount of error CQEs packets */
+				while (pkt != seg) {
+					MLX5_ASSERT(pkt != (*rxq->elts)[idx]);
+					rep = NEXT(pkt);
+					NEXT(pkt) = NULL;
+					NB_SEGS(pkt) = 1;
+					rte_mbuf_raw_free(pkt);
+					pkt = rep;
+				}
 				rq_ci >>= sges_n;
-				rq_ci += skip_cnt;
+				++rq_ci;
 				rq_ci <<= sges_n;
-				MLX5_ASSERT(!pkt);
-				continue;
-			}
-			if (len == 0) {
-				rte_mbuf_raw_free(rep);
 				break;
 			}
-			pkt = seg;
-			MLX5_ASSERT(len >= (int)(rxq->crc_present << 2));
-			pkt->ol_flags &= RTE_MBUF_F_EXTERNAL;
-			if (rxq->cqe_comp_layout && mcqe)
-				cqe = &rxq->title_cqe;
-			rxq_cq_to_mbuf(rxq, pkt, cqe, mcqe);
-			if (rxq->crc_present)
-				len -= RTE_ETHER_CRC_LEN;
-			PKT_LEN(pkt) = len;
-			if (cqe->lro_num_seg > 1) {
-				mlx5_lro_update_hdr
-					(rte_pktmbuf_mtod(pkt, uint8_t *), cqe,
-					 mcqe, rxq, len);
-				pkt->ol_flags |= RTE_MBUF_F_RX_LRO;
-				pkt->tso_segsz = len / cqe->lro_num_seg;
+		}
+		if (!pkt) { /* new packet */
+			if (len == 0) { /* no CQE polled yet */
+				mcqe = NULL;
+				cqe = &(*rxq->cqes)[rxq->cq_ci & cqe_mask];
+				len = mlx5_rx_poll_len(rxq, cqe, cqe_n, cqe_mask,
+							   &mcqe, &skip_cnt, false, NULL);
+				if (unlikely(len & MLX5_ERROR_CQE_MASK)) {
+					/* We drop packets with non-critical errors */
+					if (seg->pool)
+						rte_mbuf_raw_free(rep);
+					if (len == MLX5_CRITICAL_ERROR_CQE_RET) {
+						rq_ci = rxq->rq_ci << sges_n;
+						break;
+					}
+					/* Skip specified amount of error CQEs packets */
+					rq_ci >>= sges_n;
+					rq_ci += skip_cnt;
+					rq_ci <<= sges_n;
+					MLX5_ASSERT(!pkt);
+					len = 0;
+					continue;
+				}
+				if (len == 0) {
+					if (seg->pool)
+						rte_mbuf_raw_free(rep);
+					break;
+				}
+				MLX5_ASSERT(len >= (int)(rxq->crc_present << 2));
+				if (rxq->crc_present)
+					len -= RTE_ETHER_CRC_LEN;
+			}
+			if (seg->pool) { /* first real segment */
+				pkt = seg;
+				pkt->ol_flags &= RTE_MBUF_F_EXTERNAL;
+				if (rxq->cqe_comp_layout && mcqe)
+					cqe = &rxq->title_cqe;
+				rxq_cq_to_mbuf(rxq, pkt, cqe, mcqe);
+				PKT_LEN(pkt) = len;
+				if (cqe->lro_num_seg > 1) {
+					mlx5_lro_update_hdr
+						(rte_pktmbuf_mtod(pkt, uint8_t *), cqe,
+						 mcqe, rxq, len);
+					pkt->ol_flags |= RTE_MBUF_F_RX_LRO;
+					pkt->tso_segsz = len / cqe->lro_num_seg;
+				}
 			}
 		}
-		DATA_LEN(rep) = DATA_LEN(seg);
-		PKT_LEN(rep) = PKT_LEN(seg);
-		SET_DATA_OFF(rep, DATA_OFF(seg));
-		PORT(rep) = PORT(seg);
-		(*rxq->elts)[idx] = rep;
-		/*
-		 * Fill NIC descriptor with the new buffer. The lkey and size
-		 * of the buffers are already known, only the buffer address
-		 * changes.
-		 */
-		wqe->addr = rte_cpu_to_be_64(rte_pktmbuf_mtod(rep, uintptr_t));
-		/* If there's only one MR, no need to replace LKey in WQE. */
-		if (unlikely(mlx5_mr_btree_len(&rxq->mr_ctrl.cache_bh) > 1))
-			wqe->lkey = mlx5_rx_mb2mr(rxq, rep);
-		if (len > DATA_LEN(seg)) {
+		if (seg->pool) { /* real segment: replenish WQE */
+			tail = seg;
+			DATA_LEN(rep) = DATA_LEN(seg);
+			PKT_LEN(rep) = PKT_LEN(seg);
+			SET_DATA_OFF(rep, DATA_OFF(seg));
+			PORT(rep) = PORT(seg);
+			(*rxq->elts)[idx] = rep;
+			/*
+			 * Fill NIC descriptor with the new buffer. The lkey and size
+			 * of the buffers are already known, only the buffer address
+			 * changes.
+			 */
+			wqe->addr = rte_cpu_to_be_64(rte_pktmbuf_mtod(rep, uintptr_t));
+			/* If there's only one MR, no need to replace LKey in WQE. */
+			if (unlikely(mlx5_mr_btree_len(&rxq->mr_ctrl.cache_bh) > 1))
+				wqe->lkey = mlx5_rx_mb2mr(rxq, rep);
+		}
+		if (len > DATA_LEN(seg)) { /* more data: move to next segment */
+			if (seg->pool)
+				data_seg_len += DATA_LEN(seg);
 			len -= DATA_LEN(seg);
-			++NB_SEGS(pkt);
+			if (pkt)
+				++NB_SEGS(pkt);
 			++rq_ci;
 			continue;
 		}
-		DATA_LEN(seg) = len;
+		if (seg->pool) { /* last segment */
+			DATA_LEN(seg) = len;
+			data_seg_len += len;
+		}
+		if (unlikely(!pkt)) { /* no real segment found, skip packet */
+			len = 0;
+			rq_ci >>= sges_n;
+			++rq_ci;
+			rq_ci <<= sges_n;
+			continue;
+		}
+		PKT_LEN(pkt) = RTE_MIN(PKT_LEN(pkt), data_seg_len);
 #ifdef MLX5_PMD_SOFT_COUNTERS
 		/* Increment bytes counter. */
 		rxq->stats.ibytes += PKT_LEN(pkt);
 #endif
+		data_seg_len = 0;
 		/* Return packet. */
 		*(pkts++) = pkt;
 		pkt = NULL;
+		len = 0;
 		--pkts_n;
 		++i;
 		/* Align consumer index to the next stride. */
diff --git a/drivers/net/mlx5/mlx5_rx.h b/drivers/net/mlx5/mlx5_rx.h
index 01b563d981..cd48ee37ef 100644
--- a/drivers/net/mlx5/mlx5_rx.h
+++ b/drivers/net/mlx5/mlx5_rx.h
@@ -96,6 +96,7 @@ struct mlx5_eth_rxseg {
 	uint16_t length; /**< Segment data length, configures split point. */
 	uint16_t offset; /**< Data offset from beginning of mbuf data buffer. */
 	uint32_t reserved; /**< Reserved field. */
+	struct rte_mbuf *null_mbuf; /**< For selective Rx. */
 };
 
 /* RX queue descriptor. */
diff --git a/drivers/net/mlx5/mlx5_rxq.c b/drivers/net/mlx5/mlx5_rxq.c
index 48d982a8c2..25dba7f4d9 100644
--- a/drivers/net/mlx5/mlx5_rxq.c
+++ b/drivers/net/mlx5/mlx5_rxq.c
@@ -151,26 +151,30 @@ rxq_alloc_elts_sprq(struct mlx5_rxq_ctrl *rxq_ctrl)
 		struct mlx5_eth_rxseg *seg = &rxq_ctrl->rxq.rxseg[i % sges_n];
 		struct rte_mbuf *buf;
 
-		buf = rte_pktmbuf_alloc(seg->mp);
-		if (buf == NULL) {
-			if (rxq_ctrl->share_group == 0)
-				DRV_LOG(ERR, "port %u queue %u empty mbuf pool",
-					RXQ_PORT_ID(rxq_ctrl),
-					rxq_ctrl->rxq.idx);
-			else
-				DRV_LOG(ERR, "share group %u queue %u empty mbuf pool",
-					rxq_ctrl->share_group,
-					rxq_ctrl->share_qid);
-			rte_errno = ENOMEM;
-			goto error;
+		if (seg->mp) {
+			buf = rte_pktmbuf_alloc(seg->mp);
+			if (buf == NULL) {
+				if (rxq_ctrl->share_group == 0)
+					DRV_LOG(ERR, "port %u queue %u empty mbuf pool",
+						RXQ_PORT_ID(rxq_ctrl),
+						rxq_ctrl->rxq.idx);
+				else
+					DRV_LOG(ERR, "share group %u queue %u empty mbuf pool",
+						rxq_ctrl->share_group,
+						rxq_ctrl->share_qid);
+				rte_errno = ENOMEM;
+				goto error;
+			}
+			/* Only vectored Rx routines rely on headroom size. */
+			MLX5_ASSERT(!has_vec_support ||
+				    DATA_OFF(buf) >= RTE_PKTMBUF_HEADROOM);
+			/* Buffer is supposed to be empty. */
+			MLX5_ASSERT(rte_pktmbuf_data_len(buf) == 0);
+			MLX5_ASSERT(rte_pktmbuf_pkt_len(buf) == 0);
+			MLX5_ASSERT(!buf->next);
+		} else {
+			buf = seg->null_mbuf;
 		}
-		/* Only vectored Rx routines rely on headroom size. */
-		MLX5_ASSERT(!has_vec_support ||
-			    DATA_OFF(buf) >= RTE_PKTMBUF_HEADROOM);
-		/* Buffer is supposed to be empty. */
-		MLX5_ASSERT(rte_pktmbuf_data_len(buf) == 0);
-		MLX5_ASSERT(rte_pktmbuf_pkt_len(buf) == 0);
-		MLX5_ASSERT(!buf->next);
 		SET_DATA_OFF(buf, seg->offset);
 		PORT(buf) = rxq_ctrl->rxq.port_id;
 		DATA_LEN(buf) = seg->length;
@@ -324,10 +328,14 @@ rxq_free_elts_sprq(struct mlx5_rxq_ctrl *rxq_ctrl)
 		rxq->rq_pi = elts_ci;
 	}
 	for (i = 0; i != q_n; ++i) {
-		if ((*rxq->elts)[i] != NULL)
+		if ((*rxq->elts)[i] != NULL && (*rxq->elts)[i]->pool != NULL)
 			rte_pktmbuf_free_seg((*rxq->elts)[i]);
 		(*rxq->elts)[i] = NULL;
 	}
+	for (i = 0; i < rxq->rxseg_n; i++) {
+		mlx5_free(rxq->rxseg[i].null_mbuf);
+		rxq->rxseg[i].null_mbuf = NULL;
+	}
 }
 
 /**
@@ -1815,7 +1823,9 @@ mlx5_rxq_new(struct rte_eth_dev *dev, uint16_t idx, uint16_t desc,
 	int ret;
 	struct mlx5_priv *priv = dev->data->dev_private;
 	struct mlx5_rxq_ctrl *tmpl;
-	unsigned int mb_len = rte_pktmbuf_data_room_size(rx_seg[0].mp);
+	struct rte_mempool *first_mp = NULL;
+	struct rte_mempool *last_mp = NULL;
+	unsigned int mb_len;
 	struct mlx5_port_config *config = &priv->config;
 	uint64_t offloads = conf->offloads |
 			   dev->data->dev_conf.rxmode.offloads;
@@ -1827,7 +1837,7 @@ mlx5_rxq_new(struct rte_eth_dev *dev, uint16_t idx, uint16_t desc,
 	unsigned int non_scatter_min_mbuf_size = max_rx_pktlen +
 							RTE_PKTMBUF_HEADROOM;
 	unsigned int max_lro_size = 0;
-	unsigned int first_mb_free_size = mb_len - RTE_PKTMBUF_HEADROOM;
+	unsigned int first_mb_free_size;
 	uint32_t mprq_log_actual_stride_num = 0;
 	uint32_t mprq_log_actual_stride_size = 0;
 	bool rx_seg_en = n_seg != 1 || rx_seg[0].offset || rx_seg[0].length;
@@ -1845,6 +1855,21 @@ mlx5_rxq_new(struct rte_eth_dev *dev, uint16_t idx, uint16_t desc,
 	const struct rte_eth_rxseg_split *qs_seg = rx_seg;
 	unsigned int tail_len;
 
+	/* Find first segment with a mempool. */
+	for (uint16_t seg = 0; seg < n_seg; seg++) {
+		if (rx_seg[seg].mp != NULL) {
+			first_mp = rx_seg[seg].mp;
+			break;
+		}
+	}
+	if (first_mp == NULL) {
+		DRV_LOG(ERR, "port %u Rx queue %u has no mempool", dev->data->port_id, idx);
+		rte_errno = EINVAL;
+		return NULL;
+	}
+	mb_len = rte_pktmbuf_data_room_size(first_mp);
+	first_mb_free_size = mb_len - RTE_PKTMBUF_HEADROOM;
+
 	if (mprq_en) {
 		/* Trim the number of descs needed. */
 		desc >>= mprq_log_actual_stride_num;
@@ -1884,35 +1909,44 @@ mlx5_rxq_new(struct rte_eth_dev *dev, uint16_t idx, uint16_t desc,
 	do {
 		struct mlx5_eth_rxseg *hw_seg =
 					&tmpl->rxq.rxseg[tmpl->rxq.rxseg_n];
-		uint32_t buf_len, offset, seg_len;
+		uint32_t buf_len = 0, offset, seg_len;
 
 		/*
 		 * For the buffers beyond descriptions offset is zero,
 		 * the first buffer contains head room.
 		 */
-		buf_len = rte_pktmbuf_data_room_size(qs_seg->mp);
+		if (qs_seg->mp != NULL) {
+			last_mp = qs_seg->mp;
+			buf_len = rte_pktmbuf_data_room_size(qs_seg->mp);
+		} else if (last_mp != NULL) {
+			buf_len = rte_pktmbuf_data_room_size(last_mp);
+		} else {
+			buf_len = mb_len;
+		}
 		offset = (tmpl->rxq.rxseg_n >= n_seg ? 0 : qs_seg->offset) +
 			 (tmpl->rxq.rxseg_n ? 0 : RTE_PKTMBUF_HEADROOM);
 		/*
 		 * For the buffers beyond descriptions the length is
 		 * pool buffer length, zero lengths are replaced with
-		 * pool buffer length either.
+		 * pool buffer length for real segments,
+		 * or remaining packet length for discard segments.
 		 */
 		seg_len = tmpl->rxq.rxseg_n >= n_seg ? buf_len :
 						       qs_seg->length ?
 						       qs_seg->length :
-						       (buf_len - offset);
+						       qs_seg->mp != NULL ?
+						       (buf_len - offset) : tail_len;
 		/* Check is done in long int, now overflows. */
-		if (buf_len < seg_len + offset) {
+		if (qs_seg->mp != NULL && buf_len < seg_len + offset) {
 			DRV_LOG(ERR, "port %u Rx queue %u: Split offset/length "
 				     "%u/%u can't be satisfied",
 				     dev->data->port_id, idx,
-				     qs_seg->length, qs_seg->offset);
+				     qs_seg->offset, qs_seg->length);
 			rte_errno = EINVAL;
 			goto error;
 		}
 		if (seg_len > tail_len)
-			seg_len = buf_len - offset;
+			seg_len = qs_seg->mp != NULL ? buf_len - offset : tail_len;
 		if (++tmpl->rxq.rxseg_n > MLX5_MAX_RXQ_NSEG) {
 			DRV_LOG(ERR,
 				"port %u too many SGEs (%u) needed to handle"
@@ -2077,7 +2111,8 @@ mlx5_rxq_new(struct rte_eth_dev *dev, uint16_t idx, uint16_t desc,
 	/* Save port ID. */
 	tmpl->rxq.port_id = dev->data->port_id;
 	tmpl->sh = priv->sh;
-	tmpl->rxq.mp = rx_seg[0].mp;
+	tmpl->rxq.sh = priv->sh;
+	tmpl->rxq.mp = first_mp;
 	tmpl->rxq.elts_n = log2above(desc);
 	tmpl->rxq.rq_repl_thresh = MLX5_VPMD_RXQ_RPLNSH_THRESH(desc_n);
 	tmpl->rxq.elts = (struct rte_mbuf *(*)[])(tmpl + 1);
diff --git a/drivers/net/mlx5/mlx5_trigger.c b/drivers/net/mlx5/mlx5_trigger.c
index a070aaecfd..ac966c51b4 100644
--- a/drivers/net/mlx5/mlx5_trigger.c
+++ b/drivers/net/mlx5/mlx5_trigger.c
@@ -116,6 +116,27 @@ mlx5_txq_start(struct rte_eth_dev *dev)
 	return -rte_errno;
 }
 
+static struct rte_mbuf *
+mlx5_alloc_null_mbuf(uint32_t data_len)
+{
+	size_t alloc_size = sizeof(struct rte_mbuf) + RTE_PKTMBUF_HEADROOM +
+		rte_align32pow2(data_len);
+	struct rte_mbuf *m;
+
+	m = mlx5_malloc(MLX5_MEM_ZERO, alloc_size, 0, SOCKET_ID_ANY);
+	if (m == NULL)
+		return NULL;
+	m->buf_addr = RTE_PTR_ADD(m, sizeof(*m));
+	m->buf_len = alloc_size - sizeof(*m);
+	rte_mbuf_iova_set(m, rte_mem_virt2iova(m->buf_addr));
+	m->data_off = RTE_PKTMBUF_HEADROOM;
+	m->refcnt = 1;
+	m->nb_segs = 1;
+	m->port = RTE_MBUF_PORT_INVALID;
+	m->pool = NULL;
+	return m;
+}
+
 /**
  * Register Rx queue mempools and fill the Rx queue cache.
  * This function tolerates repeated mempool registration.
@@ -130,7 +151,8 @@ static int
 mlx5_rxq_mempool_register(struct mlx5_rxq_ctrl *rxq_ctrl)
 {
 	struct rte_mempool *mp;
-	uint32_t s;
+	struct mlx5_eth_rxseg *seg;
+	uint16_t s;
 	int ret = 0;
 
 	mlx5_mr_flush_local_cache(&rxq_ctrl->rxq.mr_ctrl);
@@ -139,21 +161,35 @@ mlx5_rxq_mempool_register(struct mlx5_rxq_ctrl *rxq_ctrl)
 		return mlx5_mr_mempool_populate_cache(&rxq_ctrl->rxq.mr_ctrl,
 						      rxq_ctrl->rxq.mprq_mp);
 	for (s = 0; s < rxq_ctrl->rxq.rxseg_n; s++) {
-		bool is_extmem;
-
-		mp = rxq_ctrl->rxq.rxseg[s].mp;
-		is_extmem = (rte_pktmbuf_priv_flags(mp) &
-			     RTE_PKTMBUF_POOL_F_PINNED_EXT_BUF) != 0;
-		ret = mlx5_mr_mempool_register(rxq_ctrl->sh->cdev, mp,
-					       is_extmem);
-		if (ret < 0 && rte_errno != EEXIST)
-			return ret;
-		ret = mlx5_mr_mempool_populate_cache(&rxq_ctrl->rxq.mr_ctrl,
-						     mp);
-		if (ret < 0)
-			return ret;
+		seg = &rxq_ctrl->rxq.rxseg[s];
+		mp = seg->mp;
+		if (mp) { /* Regular segment */
+			bool is_extmem = (rte_pktmbuf_priv_flags(mp) &
+					RTE_PKTMBUF_POOL_F_PINNED_EXT_BUF) != 0;
+			ret = mlx5_mr_mempool_register(rxq_ctrl->sh->cdev, mp, is_extmem);
+			if (ret < 0 && rte_errno != EEXIST)
+				goto error;
+			ret = mlx5_mr_mempool_populate_cache(&rxq_ctrl->rxq.mr_ctrl, mp);
+			if (ret < 0)
+				goto error;
+		} else { /* NULL segment used in selective Rx */
+			seg->null_mbuf = mlx5_alloc_null_mbuf(seg->length);
+			if (seg->null_mbuf == NULL) {
+				rte_errno = ENOMEM;
+				ret = -rte_errno;
+				goto error;
+			}
+		}
 	}
 	return 0;
+
+error:
+	while (s-- > 0) {
+		seg = &rxq_ctrl->rxq.rxseg[s];
+		mlx5_free(seg->null_mbuf);
+		seg->null_mbuf = NULL;
+	}
+	return ret;
 }
 
 /**
-- 
2.54.0

