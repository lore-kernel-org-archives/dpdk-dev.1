Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 884C4CD6E44
	for <dpdk-dev@archiver.kernel.org>; Thu, 28 May 2026 12:48:21 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 404BB4060F;
	Thu, 28 May 2026 14:48:13 +0200 (CEST)
Received: from fout-a6-smtp.messagingengine.com
 (fout-a6-smtp.messagingengine.com [103.168.172.149])
 by mails.dpdk.org (Postfix) with ESMTP id 0A65340654
 for <dev@dpdk.org>; Thu, 28 May 2026 14:48:11 +0200 (CEST)
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
 by mailfout.phl.internal (Postfix) with ESMTP id B2AC7EC00E7;
 Thu, 28 May 2026 08:48:10 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
 by phl-compute-04.internal (MEProxy); Thu, 28 May 2026 08:48:10 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=monjalon.net; h=
 cc:cc:content-transfer-encoding:content-type:date:date:from:from
 :in-reply-to:in-reply-to:message-id:mime-version:references
 :reply-to:subject:subject:to:to; s=fm3; t=1779972490; x=
 1780058890; bh=7quJUMIc1vydnrLJOW+IUJFjD6DLeM9rigNWEs+NMgk=; b=q
 G550CEgeyjeKuRMD8JxfH83eRQWflfx3a8WKelmTP0f+9tuTSfiLOYJkgfO46MB4
 v9nXMhqrrKAF9wHccUUw4lSvyzXkZcph/WjQB2iwwCcu1zodpVqOsFQIi9TONRGv
 ipoVLMzGN+ifVJvN3ed3EgrqjT34L3aFQAbgpD1qts401kkTHDUsV6E81AoI6Yur
 C9jEagku463bjhPZyvfYHsL9u8io/Ctt99zZNR4xFTluJQpraeTxHA+tDvB/u5zk
 NT2nYEHgVe6AYS/2fwi5nfZsuGev5pzkuQeEJH4qgy8JkmRmSUPLhV/ty/cae45R
 0OJEUoOrt3wJjxL3P9ldA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-transfer-encoding
 :content-type:date:date:feedback-id:feedback-id:from:from
 :in-reply-to:in-reply-to:message-id:mime-version:references
 :reply-to:subject:subject:to:to:x-me-proxy:x-me-sender
 :x-me-sender:x-sasl-enc; s=fm3; t=1779972490; x=1780058890; bh=7
 quJUMIc1vydnrLJOW+IUJFjD6DLeM9rigNWEs+NMgk=; b=FHFU8KuQpJfAZ0RhI
 m2WtYNXnT3aBFNVcn4mVm+ZUWDlNTY4l+ug9BPLLstsJThrP3WqOAl1hQVrZ/aHo
 eCqtDIgeTBQsm/pZ9Ccyk7SUOe/yif/LPnqlWTo/nIIBnBg8waF/v/5ZaRpFIRij
 04RUGc7E79oLEwN3gzp0uAS4fGSHXbpCBZmk5tqzN8MnD347nd7IOwJwidONbqSU
 voZk1LjZYZmzbcbZLhJXBNxJ14DazpF6HIcuOlmddZ4Y8NargOtsukUZ2LE4h/50
 LCaKhbieGJ3e4vWs4qDph9T+gEbTA6TaPs6Gp0g0a63Od6vEucHMc2ij1Ng4R7c1
 SgEdw==
X-ME-Sender: <xms:ijkYatQ-Kd8M2bNqNGA1Mn5uZeJsuanzGUu0VKefL-ieDI1wziSPGQ>
 <xme:ijkYaiOGCCVwwluU83O8QVuEtjToFYaTa_jwPGKY-V7qROziAVeSXMdujUOE5FjhR
 S7X8VVVD9qcTQVD9_GBhrkYYMtTD5yIprPMWzlXtovJu-xACb3n>
X-ME-Received: <xmr:ijkYamWiU_e9F0DHjQjQBnGif7qxQp_3qZFfZVB47nWsJIhgHyNUrFt_OD6aCCIu28NWu7yn6rXSLfLiD9H_cbBExLpIr9I>
X-ME-Proxy-Cause: dmFkZTEFn7AQHI48n9AODvJpJqUxdk72sZf0QLbOirQK2oyoi+UcGmNWDkA8MQxq/UNVpS
 kxC5Io4+kU3Fbdr2iWwXxCfnXp+UEUJi+bqAIR0An7WYiX1o8NsYAUQ+pI7oK7Eon+l6Qc
 5smSvBkE8YwlgQX4htbges5IHO+VQGpWCeK47LL9uKaWZSkQ5SQ07Hb2BFZLFyK7uXMXjg
 a1gXgJJv4QvNCyHA6ug7ni4QQm0Rb3dKyMtJ29hsub5yqp48T7fXlGEH0ytXZYMruyvqZu
 mw8vrT/WMNUWiTcH4tjJGnAZ2M5JgoyGW1r2WTRcytlCKxhVBJsOOZMhAqWbv+aQjxKVe7
 JNmsB5LVw/5YBmN0Q5Ss0FR5pmC17WjEBrJEJtG75zojpl2QNtnv67/HnU5AASEUHmpjWD
 I4UgmhQgRbe618jxdvGpQ1eQrdpEBLLx09W4c2o4u5xNP2EgJn+jMJxjB5cd6dcY5+W+3c
 HB9N0VIL64G+sr3m6t/8yWSgixlRBImVxohscHdC85huq2DUdwM9c2kzmEqOPG0x3FqbDF
 WQf62P3NIBWXgy8BWsd5sHlZbeDWcpiA4GrdQa+ALoohZR2p25ZYWeIeqPhQyQaGe4IBwt
 Yv/a1lRFtpFJ8Bf4GlJJmss7Oa4C57wrhAkSbIAmf5spBvMRzaX/vUVHtX9g
X-ME-Proxy: <xmx:ijkYapfJy9j5u78eigBO4ZGLOPD1xbu-qKMAHpeu-SK9nYnEPsBqlA>
 <xmx:ijkYaisSKdJPgmPkIKPELMFlcXWHjO2uap4Xlz-a1lsy7-_BL8aeiQ>
 <xmx:ijkYao-IFPH3KAbOjF0yXO3jI59g1MfhQnXrvn9n99s9poeIWwqpUg>
 <xmx:ijkYat1bWDNKCaBAd8FR_0GXtwJcGRnL5ItynJzJd6Kejrfsh4zbhw>
 <xmx:ijkYaiCInbbZWNFq32uwWwbNsSU7hxkSj4qepYZQDqtnFzqJFUd6Kazi>
Feedback-ID: i47234305:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 28 May 2026 08:48:09 -0400 (EDT)
From: Thomas Monjalon <thomas@monjalon.net>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>,
 Gregory Etelson <getelson@nvidia.com>,
 Aman Singh <aman.deep.singh@intel.com>,
 Andrew Rybchenko <andrew.rybchenko@oktetlabs.ru>
Subject: [PATCH v3 02/10] ethdev: introduce selective Rx
Date: Thu, 28 May 2026 14:46:29 +0200
Message-ID: <20260528124758.1984528-3-thomas@monjalon.net>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260528124758.1984528-1-thomas@monjalon.net>
References: <20260202160903.254621-1-getelson@nvidia.com>
 <20260528124758.1984528-1-thomas@monjalon.net>
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
index 1eac84895b..fc4dc7fb9b 100644
--- a/doc/guides/rel_notes/release_26_07.rst
+++ b/doc/guides/rel_notes/release_26_07.rst
@@ -63,6 +63,13 @@ New Features
     ``rte_eal_init`` and the application is responsible for probing each device,
   * ``--auto-probing`` enables the initial bus probing, which is the current default behavior.
 
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
index 3f4d2438e4..f048b5821d 100644
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

