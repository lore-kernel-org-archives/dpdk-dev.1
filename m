Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1E611CD37B2
	for <dpdk-dev@archiver.kernel.org>; Sat,  9 May 2026 22:05:02 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id AAACD40661;
	Sun, 10 May 2026 00:04:46 +0200 (CEST)
Received: from fout-b4-smtp.messagingengine.com
 (fout-b4-smtp.messagingengine.com [202.12.124.147])
 by mails.dpdk.org (Postfix) with ESMTP id 628F140667
 for <dev@dpdk.org>; Sun, 10 May 2026 00:04:45 +0200 (CEST)
Received: from phl-compute-02.internal (phl-compute-02.internal [10.202.2.42])
 by mailfout.stl.internal (Postfix) with ESMTP id A40E01D00061;
 Sat,  9 May 2026 18:04:44 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
 by phl-compute-02.internal (MEProxy); Sat, 09 May 2026 18:04:44 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=monjalon.net; h=
 cc:cc:content-transfer-encoding:content-type:date:date:from:from
 :in-reply-to:in-reply-to:message-id:mime-version:references
 :reply-to:subject:subject:to:to; s=fm3; t=1778364284; x=
 1778450684; bh=cJOL09OWAzSygJCTk3IJm/s4ZGAxw1xIVQ69lKLTkWk=; b=q
 LnxMEvT9Z39Q973VDixtgEK/en4CQkBRaT/5iPvS+uhGhR8L8GNs+YiN8KqkGFnD
 6phM8U47/eyzbHvoMwPUg8Y4nsBR1/F1e6HFcFKH27Y/rU08TpTyJ7op+37yVJ4z
 7aiRwrOHJd7tZfTdWTBABPYlKEKSRX60rXH46o3yBze4mkw5NBvM193gM03ElLtX
 yqMgOl1pVEOsL7g8WBjtrnw/QuJttKnLAVBf+9ByYphHXQbE3AFdaEzJUzVcN7tv
 EBt03aybIsYovqqAEb0NVs/KML4VCGZjOtcUoF4sti8ONeLefvN/cIrQbfQD/31C
 9QzNMIjMVi2CxOLxsakzQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-transfer-encoding
 :content-type:date:date:feedback-id:feedback-id:from:from
 :in-reply-to:in-reply-to:message-id:mime-version:references
 :reply-to:subject:subject:to:to:x-me-proxy:x-me-sender
 :x-me-sender:x-sasl-enc; s=fm3; t=1778364284; x=1778450684; bh=c
 JOL09OWAzSygJCTk3IJm/s4ZGAxw1xIVQ69lKLTkWk=; b=VUSdJbpehhaxe3dxk
 LbYMvEIU48yMSKjQIdmpvffkXtju5f8R0BcmQvQLdgKWhcfGRlG+ssgacH8ktARc
 SOjH+n6V2I3N/PPSyjNlF2MvwbGNYt5/YgRnK3WTxHUP90cVI/pvMkjHisfR7Ih5
 Gsdi6h7b3sBQQsCXNtshH1qNclMRxy6Cdfaa9J0T705+AYFFJlbA9/ARl0z8/+CI
 s9eXkLJ3RatjmAcrRK2MVP7NmcOLyrbIOCMxAZHCGucHVHq2oEv8tQqNdKI8EdJy
 +8VlGbrmPH5GScCH0vEubcQ9fvLO5fOG8W9AFPPbREjt0vUt2GyzaGKzp9MgiFSI
 HeF1w==
X-ME-Sender: <xms:fK__aektRm5s0KO8mGCuWEXHl3pR8FqWEMPQXC-9b2n6FrYmvxgQLg>
 <xme:fK__aR3gpEIWnBuEyDP24cjXflpdFG1Jlik3-zlPjhD_yqf5ApA7s6wj_t_6NihHA
 bDEO4hosLUO6jsqItpJrboa8VTv1MjKOEDcn5_qpWkqO6ixagnvfg>
X-ME-Received: <xmr:fK__ae3KDMXe9Nn2Az1Ty2FqW9VDgpFLlAERjvqMMvCgLPYsVujpaZCOaXGarZFuEMaSHXuyen01mF0H45_jQXaV3PseDOQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefhedrtddtgdduudegfeelucetufdoteggodetrf
 dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
 rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
 gurhephffvvefufffkofgjfhgggfestdekredtredttdenucfhrhhomhepvfhhohhmrghs
 ucfoohhnjhgrlhhonhcuoehthhhomhgrshesmhhonhhjrghlohhnrdhnvghtqeenucggtf
 frrghtthgvrhhnpedvjefhudeghedvtdeijeeigeetuedugfejueekieeltdfhteevkeeh
 hfeilefhtdenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhroh
 hmpehthhhomhgrshesmhhonhhjrghlohhnrdhnvghtpdhnsggprhgtphhtthhopeelpdhm
 ohguvgepshhmthhpohhuthdprhgtphhtthhopeguvghvseguphgukhdrohhrghdprhgtph
 htthhopehsthgvphhhvghnsehnvghtfihorhhkphhluhhmsggvrhdrohhrghdprhgtphht
 thhopehgvghtvghlshhonhesnhhvihguihgrrdgtohhmpdhrtghpthhtohepughsohhsnh
 hofihskhhisehnvhhiughirgdrtghomhdprhgtphhtthhopehvihgrtghhvghslhgrvhho
 sehnvhhiughirgdrtghomhdprhgtphhtthhopegsihhnghiisehnvhhiughirgdrtghomh
 dprhgtphhtthhopehorhhikhgrsehnvhhiughirgdrtghomhdprhgtphhtthhopehsuhgr
 nhhmihhnghhmsehnvhhiughirgdrtghomhdprhgtphhtthhopehmrghtrghnsehnvhhiug
 hirgdrtghomh
X-ME-Proxy: <xmx:fK__aTo18y9EVwhjCK4esK87UMdIoi7dTntuvAB7CnlyqNoN3O6CNQ>
 <xmx:fK__aaia9dADl9rZ8ObBD5XD9tc9QnfriwyTxW_PdWRi0FhO8ASMng>
 <xmx:fK__af9-8vHLhMoSQk4a8ZYx01HuUjxx_5X26WniZtJjXKZ_bTxUPQ>
 <xmx:fK__aWVc7ZjcUaeKxytaYM1I3WxpF6saAuWtfN2PFhda8swMoWQqcg>
 <xmx:fK__aTiDO5VRpHF0iWOvHTSrBTlZOtDlH5b0JbQ8IXrDDsgL1kM7aegI>
Feedback-ID: i47234305:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sat,
 9 May 2026 18:04:43 -0400 (EDT)
From: Thomas Monjalon <thomas@monjalon.net>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>,
 Gregory Etelson <getelson@nvidia.com>,
 Dariusz Sosnowski <dsosnowski@nvidia.com>,
 Viacheslav Ovsiienko <viacheslavo@nvidia.com>,
 Bing Zhao <bingz@nvidia.com>, Ori Kam <orika@nvidia.com>,
 Suanming Mou <suanmingm@nvidia.com>, Matan Azrad <matan@nvidia.com>
Subject: [PATCH v2 06/10] net/mlx5: support selective Rx
Date: Sat,  9 May 2026 23:56:57 +0200
Message-ID: <20260509220356.3679114-7-thomas@monjalon.net>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260509220356.3679114-1-thomas@monjalon.net>
References: <20260202160903.254621-1-getelson@nvidia.com>
 <20260509220356.3679114-1-thomas@monjalon.net>
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
 doc/guides/nics/features/mlx5.ini      |  1 +
 doc/guides/nics/mlx5.rst               | 86 +++++++++++++++++++-------
 doc/guides/rel_notes/release_26_07.rst |  4 ++
 drivers/net/mlx5/mlx5.c                |  7 +++
 drivers/net/mlx5/mlx5.h                |  1 +
 drivers/net/mlx5/mlx5_ethdev.c         | 25 ++++++++
 drivers/net/mlx5/mlx5_rx.c             | 24 +++++--
 drivers/net/mlx5/mlx5_rx.h             |  1 +
 drivers/net/mlx5/mlx5_rxq.c            | 45 ++++++++++++--
 drivers/net/mlx5/mlx5_trigger.c        | 52 +++++++++++++---
 10 files changed, 208 insertions(+), 38 deletions(-)

diff --git a/doc/guides/nics/features/mlx5.ini b/doc/guides/nics/features/mlx5.ini
index 4f9c4c309b..08aee58e7a 100644
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
index a144f43336..9a5f712b6c 100644
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
 
@@ -854,6 +857,8 @@ MLX5 supports various methods to report statistics:
 Basic port statistics can be queried using ``rte_eth_stats_get()``.
 The received and sent statistics are through SW only
 and counts the number of packets received or sent successfully by the PMD.
+In the case of :ref:`selective Rx <mlx5_selective_rx>`,
+the ``ibytes`` counter matches segments delivered, not the skipped ones.
 The ``imissed`` counter is the amount of packets that could not be delivered
 to SW because a queue was full.
 Packets not received due to congestion in the bus or on the NIC
@@ -963,25 +968,26 @@ These configurations may also have an impact on the behavior:
 
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
@@ -1076,12 +1082,13 @@ Rx interrupt                                X
 :ref:`Rx threshold <mlx5_rx_threshold>`     X        X
 :ref:`Rx drop delay <mlx5_drop>`            X        X
 :ref:`Rx timestamp <mlx5_rx_timstp>`        X        X
+:ref:`buffer split <mlx5_buf_split>`        X        X
+:ref:`selective Rx <mlx5_selective_rx>`     X
+:ref:`multi-segment <mlx5_multiseg>`        X        X
 :ref:`Tx scheduling <mlx5_tx_sched>`        X
 :ref:`Tx inline <mlx5_tx_inline>`           X        X
 :ref:`Tx fast free <mlx5_tx_fast_free>`     X        X
 :ref:`Tx affinity <mlx5_aggregated>`        X
-:ref:`buffer split <mlx5_buf_split>`        X        X
-:ref:`multi-segment <mlx5_multiseg>`        X        X
 promiscuous                                 X        X
 multicast promiscuous                       X        X
 multiple MAC addresses                      X
@@ -2114,13 +2121,50 @@ OFED       5.1-2
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
index 5f53d93558..33b76c7e27 100644
--- a/doc/guides/rel_notes/release_26_07.rst
+++ b/doc/guides/rel_notes/release_26_07.rst
@@ -70,6 +70,10 @@ New Features
   and assigning no mempool to some configuration segments.
   This is a driver capability advertised in the ``selective_rx`` bit.
 
+* **Updated NVIDIA mlx5 ethernet driver.**
+
+  * Added support for selective Rx in scalar SPRQ Rx path.
+
 
 Removed Items
 -------------
diff --git a/drivers/net/mlx5/mlx5.c b/drivers/net/mlx5/mlx5.c
index 70f52df78a..ef60c5c071 100644
--- a/drivers/net/mlx5/mlx5.c
+++ b/drivers/net/mlx5/mlx5.c
@@ -1945,6 +1945,9 @@ mlx5_alloc_shared_dev_ctx(const struct mlx5_dev_spawn_data *spawn,
 	/* Init counter pool list header and lock. */
 	LIST_INIT(&sh->hws_cpool_list);
 	rte_spinlock_init(&sh->cpool_lock);
+	sh->null_mr = mlx5_os_alloc_null_mr(sh->cdev->dev, sh->cdev->pd);
+	if (!sh->null_mr)
+		DRV_LOG(DEBUG, "Fail to initialize NULL MR, selective Rx is disabled.");
 exit:
 	pthread_mutex_unlock(&mlx5_dev_ctx_list_mutex);
 	return sh;
@@ -2109,6 +2112,10 @@ mlx5_free_shared_dev_ctx(struct mlx5_dev_ctx_shared *sh)
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
index 4da184eb47..b7980d329d 100644
--- a/drivers/net/mlx5/mlx5.h
+++ b/drivers/net/mlx5/mlx5.h
@@ -1663,6 +1663,7 @@ struct mlx5_dev_ctx_shared {
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
index 185bfd4fff..6d4dd85e66 100644
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
@@ -1044,11 +1044,13 @@ mlx5_rx_burst(void *dpdk_rxq, struct rte_mbuf **pkts, uint16_t pkts_n)
 	const unsigned int sges_n = rxq->sges_n;
 	struct rte_mbuf *pkt = NULL;
 	struct rte_mbuf *seg = NULL;
+	struct rte_mbuf *tail = NULL;
 	volatile struct mlx5_cqe *cqe =
 		&(*rxq->cqes)[rxq->cq_ci & cqe_mask];
 	unsigned int i = 0;
 	unsigned int rq_ci = rxq->rq_ci << sges_n;
 	int len = 0; /* keep its value across iterations. */
+	uint32_t data_seg_len = 0;
 
 	while (pkts_n) {
 		uint16_t skip_cnt;
@@ -1058,13 +1060,18 @@ mlx5_rx_burst(void *dpdk_rxq, struct rte_mbuf **pkts, uint16_t pkts_n)
 		struct rte_mbuf *rep = (*rxq->elts)[idx];
 		volatile struct mlx5_mini_cqe8 *mcqe = NULL;
 
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
+		if (seg->pool) {
+		/* Allocate buf from the same pool. */
 		rep = rte_mbuf_raw_alloc(seg->pool);
 		if (unlikely(rep == NULL)) {
 			++rxq->stats.rx_nombuf;
@@ -1127,6 +1134,7 @@ mlx5_rx_burst(void *dpdk_rxq, struct rte_mbuf **pkts, uint16_t pkts_n)
 				pkt->tso_segsz = len / cqe->lro_num_seg;
 			}
 		}
+		tail = seg;
 		DATA_LEN(rep) = DATA_LEN(seg);
 		PKT_LEN(rep) = PKT_LEN(seg);
 		SET_DATA_OFF(rep, DATA_OFF(seg));
@@ -1141,17 +1149,25 @@ mlx5_rx_burst(void *dpdk_rxq, struct rte_mbuf **pkts, uint16_t pkts_n)
 		/* If there's only one MR, no need to replace LKey in WQE. */
 		if (unlikely(mlx5_mr_btree_len(&rxq->mr_ctrl.cache_bh) > 1))
 			wqe->lkey = mlx5_rx_mb2mr(rxq, rep);
+		}
 		if (len > DATA_LEN(seg)) {
+			if (seg->pool)
+				data_seg_len += DATA_LEN(seg);
 			len -= DATA_LEN(seg);
 			++NB_SEGS(pkt);
 			++rq_ci;
 			continue;
 		}
+		if (seg->pool) {
 		DATA_LEN(seg) = len;
+		data_seg_len += len;
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
index 48d982a8c2..3fae189fa4 100644
--- a/drivers/net/mlx5/mlx5_rxq.c
+++ b/drivers/net/mlx5/mlx5_rxq.c
@@ -151,6 +151,7 @@ rxq_alloc_elts_sprq(struct mlx5_rxq_ctrl *rxq_ctrl)
 		struct mlx5_eth_rxseg *seg = &rxq_ctrl->rxq.rxseg[i % sges_n];
 		struct rte_mbuf *buf;
 
+		if (seg->mp) {
 		buf = rte_pktmbuf_alloc(seg->mp);
 		if (buf == NULL) {
 			if (rxq_ctrl->share_group == 0)
@@ -167,6 +168,9 @@ rxq_alloc_elts_sprq(struct mlx5_rxq_ctrl *rxq_ctrl)
 		/* Only vectored Rx routines rely on headroom size. */
 		MLX5_ASSERT(!has_vec_support ||
 			    DATA_OFF(buf) >= RTE_PKTMBUF_HEADROOM);
+		} else {
+			buf = seg->null_mbuf;
+		}
 		/* Buffer is supposed to be empty. */
 		MLX5_ASSERT(rte_pktmbuf_data_len(buf) == 0);
 		MLX5_ASSERT(rte_pktmbuf_pkt_len(buf) == 0);
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
@@ -1884,13 +1909,20 @@ mlx5_rxq_new(struct rte_eth_dev *dev, uint16_t idx, uint16_t desc,
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
@@ -2077,7 +2109,8 @@ mlx5_rxq_new(struct rte_eth_dev *dev, uint16_t idx, uint16_t desc,
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
index a070aaecfd..5b04d9a234 100644
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
@@ -139,21 +161,37 @@ mlx5_rxq_mempool_register(struct mlx5_rxq_ctrl *rxq_ctrl)
 		return mlx5_mr_mempool_populate_cache(&rxq_ctrl->rxq.mr_ctrl,
 						      rxq_ctrl->rxq.mprq_mp);
 	for (s = 0; s < rxq_ctrl->rxq.rxseg_n; s++) {
-		bool is_extmem;
-
-		mp = rxq_ctrl->rxq.rxseg[s].mp;
-		is_extmem = (rte_pktmbuf_priv_flags(mp) &
+		seg = &rxq_ctrl->rxq.rxseg[s];
+		mp = seg->mp;
+		if (mp) { /* Regular segment */
+		bool is_extmem = (rte_pktmbuf_priv_flags(mp) &
 			     RTE_PKTMBUF_POOL_F_PINNED_EXT_BUF) != 0;
 		ret = mlx5_mr_mempool_register(rxq_ctrl->sh->cdev, mp,
 					       is_extmem);
 		if (ret < 0 && rte_errno != EEXIST)
-			return ret;
+			goto error;
 		ret = mlx5_mr_mempool_populate_cache(&rxq_ctrl->rxq.mr_ctrl,
 						     mp);
 		if (ret < 0)
-			return ret;
+			goto error;
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

