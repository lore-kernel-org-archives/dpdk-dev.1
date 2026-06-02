Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6970FCD6E5D
	for <dpdk-dev@archiver.kernel.org>; Tue,  2 Jun 2026 21:50:40 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 6E55D40668;
	Tue,  2 Jun 2026 23:50:38 +0200 (CEST)
Received: from fout-b2-smtp.messagingengine.com
 (fout-b2-smtp.messagingengine.com [202.12.124.145])
 by mails.dpdk.org (Postfix) with ESMTP id 24C234065E
 for <dev@dpdk.org>; Tue,  2 Jun 2026 23:50:37 +0200 (CEST)
Received: from phl-compute-01.internal (phl-compute-01.internal [10.202.2.41])
 by mailfout.stl.internal (Postfix) with ESMTP id 50FBE1D00060;
 Tue,  2 Jun 2026 17:50:36 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
 by phl-compute-01.internal (MEProxy); Tue, 02 Jun 2026 17:50:36 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=monjalon.net; h=
 cc:cc:content-transfer-encoding:content-type:date:date:from:from
 :in-reply-to:in-reply-to:message-id:mime-version:references
 :reply-to:subject:subject:to:to; s=fm1; t=1780437036; x=
 1780523436; bh=PxKKo8dbDIKJXpDqQmAWMhpP32cwP3+QUQ5b/OiIF54=; b=I
 vm/VNFiI1golTodWgY0CCBVFzxM0rvw3MhziSr9OKZDAoC2ih0k9KpHkBe6e+K2G
 TGN4kWwsf2FLoqq4BzBU88r8HdoiiQDTh1LMmeasn0dC2fYh7NoYiAZVnhh2Jw7R
 csRg4P42dp49PIbrA15zzJVuuNm/EqDq/POZ0acowayLlOzcwQYbJsc2ao3X62K+
 1wKMSTSkqTM4ICmyW+Kyn7OSM1emiPsBy/iAbxVAmIeHxg8zLZBQLApIDCHBW+8S
 xBxP2bRjizi/bePoRttdrJlmazX2uBqQMoYhU7iADsS98Pg46l3pIIGSW3Qea0Zl
 fbLFj1Gatr6CqexTdqHTg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-transfer-encoding
 :content-type:date:date:feedback-id:feedback-id:from:from
 :in-reply-to:in-reply-to:message-id:mime-version:references
 :reply-to:subject:subject:to:to:x-me-proxy:x-me-sender
 :x-me-sender:x-sasl-enc; s=fm1; t=1780437036; x=1780523436; bh=P
 xKKo8dbDIKJXpDqQmAWMhpP32cwP3+QUQ5b/OiIF54=; b=EmmEDdud8x1VNyvao
 lFP0icPXDaaPcwKHyZ/HiCXOY7x2EbSclPsE0PrwScZ5hV4EbF/MQrQy4NXeuVmV
 Z4ciD23P+O2HT21RaOz7xHFr2h+VqXta+F9D4XwjgJvg/PwFE+jXIXp+LkZuZOcw
 p6X7htY4NxKn77D7ZIYiZC2QhYu5ZDbPzO41rgmb05qM1Cjadxi8bDa6Zo0vOMdK
 vZHH5Edg/H8VMV1j0VJP4LrhZTXdmX9VkzLz94HoM8r/uDfr53v6C3xhCXbv+K9b
 Vdnh3ZcPTiKNpaCK6t7Krw+U9YCfWW9fHZT+XqRf1QhskZwah0eXnhNo8KFWW2JW
 wpWdQ==
X-ME-Sender: <xms:K1AfamoW3j_8oDnjbaDjC0HNu69LM6i3mdqP8l6z8apMuMaamWXM5w>
 <xme:K1AfagEVAZ4vECgFfboVFb5hQ6a4-jE5F5Y0AMUThdxFA6roMqXdI5pjrUoW3TLF5
 H6_PiGqBm1_kJkVjH5G4buBYhaSeE8cwKSkzFayyHO-jn8aU6rxlA>
X-ME-Received: <xmr:K1AfauvqKwLDXI6I0TrqW7VQjwPFkHOdYDOYd0YZif2FosHFRslLuvVopjNCGv6nzP_wW5_97E-syIdPWWRR7q31vQaykUc>
X-ME-Proxy-Cause: dmFkZTGLViGudKsDyOQu7nlm3XZoPyesT9J8ZxOjQv8yq/MS1wAtj7j/V43Ic8lLIHpkM6
 u24csRGGOkjs/xNroLPu8HoNMq3e+8KP1NdqdSASIoO1axjHcjiZOnVqcJ07F1Hjk3y36h
 cOeSppG+igu2yT5H7V4wx+FFyjv+hJThrxxIWnTfg+f53qnusY+JeNkBxIBphEIWRawUW8
 ZOckHyfoXvSira7ocBEEgW0JlZI/VwLw1KxI16ukL54AOtHUKBt6rrwo13xrAhPxd4duBh
 nuMJPl5ZZJ3y7Z1atoozu4BpCMZ49HNleOgNEFAuqdsKfKkox402xD1lavnWn5WRw4/fqR
 ciLv7HqVyMiCVhXMkVt65bIB8PRZot2sp+BhQei8bvbrkzx89lGgKpg87Eux4MNtl7/imv
 +3cbLz0bAa+jW5KyT1O5Ov6J5vCSNCXYLEBTXoYYFmFnIGzrsX3mrEce4Wm5nf0CHSLd5Q
 1aE/geawbRUkFEw6G/SW/UYVX5usuKiQSeOGNAiQdItlwzYjKujaXrbZgfqc9UNiV1C62n
 k0UkeYvf5MWl+tPglDBNntw28Ujt9WcbpN8f40LI8ko55B8X+jFjAsigOFX7pQilA9tDp5
 8RDVIUmjL5md+e+cEzIWpBFfxJQ9M+7MQnND6qTN2NJJTRqMlWWY5lA0LK1w
X-ME-Proxy: <xmx:K1AfaqUOk9c6-hkmfCzVkljrGejNctU7YjLzlql02anzzLukSKTsWw>
 <xmx:K1AfaiEN9CHC-2Byg1lBK1Yj_pYTp9Kd0RjaUSqmUpFrZnJIKyCtWw>
 <xmx:K1Afak1nwvYKXZbRPGicd8fkTDBR_W0mXe-PblA6CysA4dUAVLYYkQ>
 <xmx:K1AfasPmpu8949zNQLVQg0du6C_Yu6tHhIbzrmtsKzOgVMbJvzXf-Q>
 <xmx:LFAfamjbMC9vheDCe8bZcQnco7m6McMRzIzA5p7a-T9MnvFMLlUuCRmh>
Feedback-ID: i47234305:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 2 Jun 2026 17:50:34 -0400 (EDT)
From: Thomas Monjalon <thomas@monjalon.net>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>,
 Gregory Etelson <getelson@nvidia.com>,
 Andrew Rybchenko <andrew.rybchenko@oktetlabs.ru>,
 Aman Singh <aman.deep.singh@intel.com>
Subject: [PATCH v6 02/10] ethdev: introduce selective Rx
Date: Tue,  2 Jun 2026 23:49:14 +0200
Message-ID: <20260602215022.3698662-3-thomas@monjalon.net>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260602215022.3698662-1-thomas@monjalon.net>
References: <20260202160903.254621-1-getelson@nvidia.com>
 <20260602215022.3698662-1-thomas@monjalon.net>
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

Receiving an entire packet is not always needed.
The Rx performance can be improved by receiving only partial data
and safely discard the rest of the packet data,
because it reduces the PCI bandwidth and the memory consumption.

Selective Rx allows an application to receive
only pre-configured packet segments and discard the rest.
For example:
- Deliver the first N bytes only.
- Deliver the last N bytes only.
- Deliver N1 bytes from offset Off1 and N2 bytes from offset Off2.

Selective Rx is implemented on top of the Rx buffer split API:
- rte_eth_rxseg_split uses the null mempool for segments
that should be discarded.
- the PMD does not create mbuf segments if no data read.

For example: Deliver Ethernet header only

Rx queue segments configuration:
struct rte_eth_rxseg_split split[2] = {
    {
        .mp = <some mempool>,
        .length = sizeof(struct rte_ether_hdr)
    },
    {
        .mp = NULL, /* discard data */
        .length = 0 /* default to buffer size */
    }
};

Received mbuf:
    pkt_len = sizeof(struct rte_ether_hdr);
    data_len = sizeof(struct rte_ether_hdr);
    next = NULL; /* The next segment did not deliver data */

After selective Rx, the mbuf packet length reflects only the data
that was actually received,
and can be less than the original wire packet length.

A PMD activates the selective Rx capability by setting
the rte_eth_rxseg_capa.selective_rx bit.

This new capability bit is inserted in a bitmap hole
of the struct rte_eth_rxseg_capa,
but it needs to be ignored in the ABI check as libabigail sees a change.

Signed-off-by: Gregory Etelson <getelson@nvidia.com>
Signed-off-by: Thomas Monjalon <thomas@monjalon.net>
Reviewed-by: Andrew Rybchenko <andrew.rybchenko@oktetlabs.ru>
---
 app/test-pmd/config.c                  |  1 +
 devtools/libabigail.abignore           |  7 +++++++
 doc/guides/nics/features.rst           | 14 ++++++++++++++
 doc/guides/nics/features/default.ini   |  1 +
 doc/guides/rel_notes/release_26_07.rst |  7 +++++++
 lib/ethdev/rte_ethdev.c                | 24 ++++++++++++++++--------
 lib/ethdev/rte_ethdev.h                | 14 +++++++++++++-
 7 files changed, 59 insertions(+), 9 deletions(-)

diff --git a/app/test-pmd/config.c b/app/test-pmd/config.c
index 55d1c6d696..9d457ca88e 100644
--- a/app/test-pmd/config.c
+++ b/app/test-pmd/config.c
@@ -925,6 +925,7 @@ port_infos_display(portid_t port_id)
 		print_bool_capa("\tBuffer offset", dev_info.rx_seg_capa.offset_allowed);
 		printf("\tOffset alignment: %u\n",
 				RTE_BIT32(dev_info.rx_seg_capa.offset_align_log2));
+		print_bool_capa("\tSelective Rx", dev_info.rx_seg_capa.selective_rx);
 	}
 
 	if (dev_info.max_vfs)
diff --git a/devtools/libabigail.abignore b/devtools/libabigail.abignore
index 21b8cd6113..2a0efd718e 100644
--- a/devtools/libabigail.abignore
+++ b/devtools/libabigail.abignore
@@ -33,3 +33,10 @@
 ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
 ; Temporary exceptions till next major ABI version ;
 ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
+
+; Ignore new bit selective_rx in rte_eth_rxseg_capa bitmap hole
+[suppress_type]
+        name = rte_eth_rxseg_capa
+        type_kind = struct
+        has_size_change = no
+        has_data_member_inserted_at = 6
diff --git a/doc/guides/nics/features.rst b/doc/guides/nics/features.rst
index a075c057ec..26357036ca 100644
--- a/doc/guides/nics/features.rst
+++ b/doc/guides/nics/features.rst
@@ -199,6 +199,20 @@ Scatters the packets being received on specified boundaries to segmented mbufs.
 * **[related] API**: ``rte_eth_rx_queue_setup()``, ``rte_eth_buffer_split_get_supported_hdr_ptypes()``.
 
 
+.. _nic_features_selective_rx:
+
+Selective Rx
+------------
+
+Discards some segments of buffer split on Rx.
+
+* **[uses]     rte_eth_rxconf,rte_eth_rxmode**: ``offloads:RTE_ETH_RX_OFFLOAD_BUFFER_SPLIT``.
+* **[uses]     rte_eth_rxconf**: ``rx_seg.mp = NULL`` to discard segments.
+* **[provides] rte_eth_dev_info**: ``rx_offload_capa:RTE_ETH_RX_OFFLOAD_BUFFER_SPLIT``.
+* **[provides] rte_eth_dev_info**: ``rx_seg_capa.selective_rx``.
+* **[related]  API**: ``rte_eth_rx_queue_setup()``.
+
+
 .. _nic_features_lro:
 
 LRO
diff --git a/doc/guides/nics/features/default.ini b/doc/guides/nics/features/default.ini
index e50514d750..8303a530c1 100644
--- a/doc/guides/nics/features/default.ini
+++ b/doc/guides/nics/features/default.ini
@@ -25,6 +25,7 @@ Burst mode info      =
 Power mgmt address monitor =
 MTU update           =
 Buffer split on Rx   =
+Selective Rx         =
 Scattered Rx         =
 LRO                  =
 TSO                  =
diff --git a/doc/guides/rel_notes/release_26_07.rst b/doc/guides/rel_notes/release_26_07.rst
index b8a3e2ced9..90a7948c1d 100644
--- a/doc/guides/rel_notes/release_26_07.rst
+++ b/doc/guides/rel_notes/release_26_07.rst
@@ -81,6 +81,13 @@ New Features
 
   Added no-IOMMU mode for devices without or not enabling IOMMU/SVA.
 
+* **Added selective Rx in ethdev API.**
+
+  Some parts of packets may be discarded in Rx
+  by configuring a split of packets received in a queue,
+  and assigning no mempool to some configuration segments.
+  This is a driver capability advertised in the ``selective_rx`` bit.
+
 * **Added LinkData sxe2 ethernet driver.**
 
   Added network driver for the LinkData network adapters.
diff --git a/lib/ethdev/rte_ethdev.c b/lib/ethdev/rte_ethdev.c
index d0273e3f7b..67d609820c 100644
--- a/lib/ethdev/rte_ethdev.c
+++ b/lib/ethdev/rte_ethdev.c
@@ -2129,7 +2129,7 @@ rte_eth_rx_queue_check_split(uint16_t port_id,
 			const struct rte_eth_dev_info *dev_info)
 {
 	const struct rte_eth_rxseg_capa *seg_capa = &dev_info->rx_seg_capa;
-	struct rte_mempool *mp_first;
+	struct rte_mempool *mp_first = NULL;
 	uint32_t offset_mask;
 	uint16_t seg_idx;
 	int ret = 0;
@@ -2148,7 +2148,6 @@ rte_eth_rx_queue_check_split(uint16_t port_id,
 	 * Check the sizes and offsets against buffer sizes
 	 * for each segment specified in extended configuration.
 	 */
-	mp_first = rx_seg[0].mp;
 	offset_mask = RTE_BIT32(seg_capa->offset_align_log2) - 1;
 
 	ptypes = NULL;
@@ -2160,13 +2159,17 @@ rte_eth_rx_queue_check_split(uint16_t port_id,
 		uint32_t offset = rx_seg[seg_idx].offset;
 		uint32_t proto_hdr = rx_seg[seg_idx].proto_hdr;
 
-		if (mpl == NULL) {
-			RTE_ETHDEV_LOG_LINE(ERR, "null mempool pointer");
-			ret = -EINVAL;
-			goto out;
+		if (mpl == NULL) { /* discarded segment */
+			if (seg_capa->selective_rx == 0) { /* not supported */
+				RTE_ETHDEV_LOG_LINE(ERR, "null mempool pointer");
+				ret = -EINVAL;
+				goto out;
+			}
+			continue; /* next checks are not relevant if no mempool */
 		}
-		if (seg_idx != 0 && mp_first != mpl &&
-		    seg_capa->multi_pools == 0) {
+		if (mp_first == NULL)
+			mp_first = mpl;
+		if (mp_first != mpl && seg_capa->multi_pools == 0) {
 			RTE_ETHDEV_LOG_LINE(ERR, "Receiving to multiple pools is not supported");
 			ret = -ENOTSUP;
 			goto out;
@@ -2233,6 +2236,11 @@ rte_eth_rx_queue_check_split(uint16_t port_id,
 		if (ret != 0)
 			goto out;
 	}
+	if (mp_first == NULL) {
+		RTE_ETHDEV_LOG_LINE(ERR, "At least one Rx segment must have a mempool");
+		ret = -EINVAL;
+		goto out;
+	}
 out:
 	free(ptypes);
 	return ret;
diff --git a/lib/ethdev/rte_ethdev.h b/lib/ethdev/rte_ethdev.h
index dedbc05554..d7e1560828 100644
--- a/lib/ethdev/rte_ethdev.h
+++ b/lib/ethdev/rte_ethdev.h
@@ -1073,6 +1073,7 @@ struct rte_eth_txmode {
  * - The first network buffer will be allocated from the memory pool,
  *   specified in the first array element, the second buffer, from the
  *   pool in the second element, and so on.
+ *   If the pool is NULL, the segment will be discarded, i.e. not received.
  *
  * - The proto_hdrs in the elements define the split position of
  *   received packets.
@@ -1121,7 +1122,15 @@ struct rte_eth_txmode {
  *   The rest will be put into the last valid pool.
  */
 struct rte_eth_rxseg_split {
-	struct rte_mempool *mp; /**< Memory pool to allocate segment from. */
+	/**
+	 * Memory pool to allocate segment from.
+	 *
+	 * NULL means discarded segment.
+	 * Length of discarded segment is not reflected in mbuf packet length
+	 * and not accounted in ibytes statistics.
+	 * @see rte_eth_rxseg_capa::selective_rx
+	 */
+	struct rte_mempool *mp;
 	uint16_t length; /**< Segment data length, configures split point. */
 	uint16_t offset; /**< Data offset from beginning of mbuf data buffer. */
 	/**
@@ -1752,12 +1761,15 @@ struct rte_eth_switch_info {
  * @b EXPERIMENTAL: this structure may change without prior notice.
  *
  * Ethernet device Rx buffer segmentation capabilities.
+ *
+ * @see rte_eth_rxseg_split
  */
 struct rte_eth_rxseg_capa {
 	__extension__
 	uint32_t multi_pools:1; /**< Supports receiving to multiple pools.*/
 	uint32_t offset_allowed:1; /**< Supports buffer offsets. */
 	uint32_t offset_align_log2:4; /**< Required offset alignment. */
+	uint32_t selective_rx:1; /**< Supports discarding segment. */
 	uint16_t max_nseg; /**< Maximum amount of segments to split. */
 	uint16_t reserved; /**< Reserved field. */
 };
-- 
2.54.0

