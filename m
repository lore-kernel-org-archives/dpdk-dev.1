Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0E475CD6E6E
	for <dpdk-dev@archiver.kernel.org>; Thu,  4 Jun 2026 19:33:44 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 3CF4B4065C;
	Thu,  4 Jun 2026 21:33:34 +0200 (CEST)
Received: from fout-a8-smtp.messagingengine.com
 (fout-a8-smtp.messagingengine.com [103.168.172.151])
 by mails.dpdk.org (Postfix) with ESMTP id 888FA4028C
 for <dev@dpdk.org>; Thu,  4 Jun 2026 21:33:33 +0200 (CEST)
Received: from phl-compute-09.internal (phl-compute-09.internal [10.202.2.49])
 by mailfout.phl.internal (Postfix) with ESMTP id 3C1AAEC00EF;
 Thu,  4 Jun 2026 15:33:33 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
 by phl-compute-09.internal (MEProxy); Thu, 04 Jun 2026 15:33:33 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=monjalon.net; h=
 cc:cc:content-transfer-encoding:content-type:date:date:from:from
 :in-reply-to:in-reply-to:message-id:mime-version:references
 :reply-to:subject:subject:to:to; s=fm1; t=1780601613; x=
 1780688013; bh=v+pXF9JSKvev2VHTEhq+LMZH09OgG7vpiZh2jthoQHE=; b=n
 825yuzkobVkHZp9IJWWcakj0Xw2I4X72PlVIPqwc0o223sIphuHq0DzjpsnFf2QK
 1kbYIMOKtjTIFl9z4N8nrWdHIPI3jJWWuxsDYvfp3M0q1uJXdFJVkVhMDWEVjMf0
 8iWD9Z7QpCPOOWyUTC+Xg/eYimf/ShgFerwNrwqWD7wFAhBMFDvZ0HAVI5sIN10l
 MT2a3GwrcE82vJ+21Q8x4s2Ok3Sq1YTmzZhV7ISewLnNpAJClmiEhiLQ+62n/v+Y
 f3bVy8sbntLsKjiQnXGqkt41f07C7R+suDWNxA2CxWOQYIqbIY1xlSI4vgSNZPSz
 hnX2uaZHjwPbThO3FjhMw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-transfer-encoding
 :content-type:date:date:feedback-id:feedback-id:from:from
 :in-reply-to:in-reply-to:message-id:mime-version:references
 :reply-to:subject:subject:to:to:x-me-proxy:x-me-sender
 :x-me-sender:x-sasl-enc; s=fm1; t=1780601613; x=1780688013; bh=v
 +pXF9JSKvev2VHTEhq+LMZH09OgG7vpiZh2jthoQHE=; b=N4TrOZTnv5MyLH2a0
 IQbMOZNXN0+e+kkCXKhzbqcQEoIly9NHv8WZMEdiQL2Ewrn07Xh0i8T2QN3Lo6AJ
 8Byos+MMIX0NyGkpve8vn7aZ7O2RsNp/GIIoktb1ueN3ir9FuUjO+uQinwyRuxQn
 EjFlcvGVE5w+G1d+rTXcpAwMdL2+m9D0ZwKyqxlCSV2wSuyAtBVvX6babMY/k/nO
 vqGjQV7tl7YikJXbSbxGqrC9Ss1IxACfJnkW5t72r9YopmL92vjpPNBN14iyXB9z
 P4N7Uw8cRm9pi5WD2MQMfblv3skFeDD14mDcUOwg3+/8ddJD7pr7/Hl8aH+iRE6j
 tXB/w==
X-ME-Sender: <xms:DNMhajR_lZcZ6AjWrHEX9K-PBTJZ_PLRgTZtvktVqT8G6q559mobag>
 <xme:DNMhagMvdoU4CMm5OlsKkcsm5Xv_z4879x7rDOymaEVdOX8Ej_Vk-dCrTuErJ49bD
 AHIIzZZmtH_SB9zF9JOQjO-AVEenPbnizrBS8_tlk26xwlnTF6OPg>
X-ME-Received: <xmr:DNMhasXJPXoTWX8yg7ESAhf93vzG3FYgdyK7pb9CDnDIk5JXrpZyQ8c0oqm6ARMs_n1qn939jtzNSP4S_gAQBc2p4KXIzD8>
X-ME-Proxy-Cause: dmFkZTFBVtFu73v6kEfmvEVYm2wybPSOOTBO2QZQTLxMmhRKicwazOPAhmwg6YOl/udFjG
 9CMckWvsaG3S/jXdOqGQ5YBD4798m4D3rAKVoB8d50ghLHACp09RRpMyKxbxJtg2kE4byq
 Wp+HcF41u2/fePWGB0Uoi0ggfcS2OmIDt7CA/hRM1+p1IN9erhF5steHvQA9oFz66G1z/y
 O12rNKrmv1xf2hrywdgv534RP7gMBVDK99h9nsQJRbuaOBkZo8ScTD2/4XPDewNtPAzPjR
 ComfayxCQpZAQ5JXvsrV1I8vr239TJi7FrAX9RwQ6Hiol1JR4VNExV6vm4spCCRsmuhAPb
 MnpmBy3CONS2hMK0XTnN9TfO3uiNXpeAWuDD38DIQtzdFXu7oJTRLfKtye1HSQJP5+udpU
 bSxtktI4EcY17c+1v3I5jDEclqrSoKeK1dDxmtCooc2zZnXaklg9ZkiUrQ4DVe5s1lWw+F
 U4w3v9RwCNkmB6zF+mvDs/0HigJHROrkzmH7jmdJ84RFeXs70eEphimPat1E7HmVyVXdi6
 nS3ltmzlLwtalpA91bng2jcIWBfvhNPZSniEc7ymtkn1sbBn+dw2e0i9pzTtXWcxeCDrcd
 sUMxr3SPxcnIr2tDAZXNJBcCpCLBaIxTwTLwudzhInJGEkYxDmPbOSMxu3Ag
X-ME-Proxy: <xmx:DNMhanfNXoLyrK8CW_5XFJiKmE_Ks-49BD17xz3a2CggJjWqlUmNKg>
 <xmx:DNMhaov4vO0G0LB3f6LXzArdxKRUljBL-tdoHJVrfuObVtrPow1ErA>
 <xmx:DNMham_fhzApDc7-cy_0wUW-l8fy9OCZcO-19I5EOI-a-znQsm_ezA>
 <xmx:DNMhaj2ZAS4hFNt3XGejHTtLBAZ-GgViCMYghtN26cxe9whBDzLVtw>
 <xmx:DdMhavb0PAHndMUTwpl4gwY0pDNrgIkapZtF9LND12zkg448nmvjQW6i>
Feedback-ID: i47234305:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 4 Jun 2026 15:33:31 -0400 (EDT)
From: Thomas Monjalon <thomas@monjalon.net>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>,
 Gregory Etelson <getelson@nvidia.com>,
 Andrew Rybchenko <andrew.rybchenko@oktetlabs.ru>,
 Aman Singh <aman.deep.singh@intel.com>
Subject: [PATCH v8 2/9] ethdev: introduce selective Rx
Date: Thu,  4 Jun 2026 21:30:54 +0200
Message-ID: <20260604193324.1996141-3-thomas@monjalon.net>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260604193324.1996141-1-thomas@monjalon.net>
References: <20260202160903.254621-1-getelson@nvidia.com>
 <20260604193324.1996141-1-thomas@monjalon.net>
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
 lib/ethdev/rte_ethdev.h                | 17 +++++++++++++++--
 7 files changed, 61 insertions(+), 10 deletions(-)

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
index d2563ac503..46a8fe2cc1 100644
--- a/doc/guides/rel_notes/release_26_07.rst
+++ b/doc/guides/rel_notes/release_26_07.rst
@@ -87,6 +87,13 @@ New Features
 
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
index dedbc05554..ee400b386f 100644
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
@@ -1090,7 +1091,8 @@ struct rte_eth_txmode {
  *
  * - If the length in the segment description element is zero
  *   the actual buffer size will be deduced from the appropriate
- *   memory pool properties.
+ *   memory pool properties, or from the remaining packet length
+ *   in case of no memory pool to discard the end of the packet.
  *
  * - If there is not enough elements to describe the buffer for entire
  *   packet of maximal length the following parameters will be used
@@ -1121,7 +1123,15 @@ struct rte_eth_txmode {
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
@@ -1752,12 +1762,15 @@ struct rte_eth_switch_info {
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

