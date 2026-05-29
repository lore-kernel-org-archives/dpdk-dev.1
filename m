Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A81AACD6E4A
	for <dpdk-dev@archiver.kernel.org>; Fri, 29 May 2026 13:35:42 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id DA0A44064A;
	Fri, 29 May 2026 15:35:34 +0200 (CEST)
Received: from fhigh-b8-smtp.messagingengine.com
 (fhigh-b8-smtp.messagingengine.com [202.12.124.159])
 by mails.dpdk.org (Postfix) with ESMTP id 732894064A
 for <dev@dpdk.org>; Fri, 29 May 2026 15:35:33 +0200 (CEST)
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
 by mailfhigh.stl.internal (Postfix) with ESMTP id BC5567A0078;
 Fri, 29 May 2026 09:35:32 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
 by phl-compute-04.internal (MEProxy); Fri, 29 May 2026 09:35:32 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=monjalon.net; h=
 cc:cc:content-transfer-encoding:content-type:date:date:from:from
 :in-reply-to:in-reply-to:message-id:mime-version:references
 :reply-to:subject:subject:to:to; s=fm3; t=1780061732; x=
 1780148132; bh=+0djjXwP5SqJ/L+82dH8eZ7bJDb0PNGZaYbSI/aSxiU=; b=i
 YNRqeeNzFvBPXnUrx6qCsMMmosOJaM8jYRSUrmsacC/z2S3IFIAw2x+bcJ9jHnrW
 GkSHUp3NyMGZ+K18FkYCi2LoNhMC/ei/jElEEU/qj6NqCP4RADVmnCPeFmg0P6hd
 MGRBEf5nn9SP6KjKIVOd4PA4XcP4bRlAoYvHM8+op7lq9Fc/OxLKiWZ0+RtQkZks
 DcYT/c2Yb/sBAsZk8Lk91O09fi5IFfecJOS5YnBABDpjegbRG4kJCviEjuAe2bYO
 1F3JYfEi6N36mucuor+FUcPi6Zv9A8yQBJI6XMc3nJWKECjfr5pEJOk7PjO+Pwbh
 QhIjZCT6v0kzCmSk6ch6Q==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-transfer-encoding
 :content-type:date:date:feedback-id:feedback-id:from:from
 :in-reply-to:in-reply-to:message-id:mime-version:references
 :reply-to:subject:subject:to:to:x-me-proxy:x-me-sender
 :x-me-sender:x-sasl-enc; s=fm3; t=1780061732; x=1780148132; bh=+
 0djjXwP5SqJ/L+82dH8eZ7bJDb0PNGZaYbSI/aSxiU=; b=hFMWUYz4ThLHoMeSI
 ka+YEWNcfclHZkNoyXB5GcDdDgJNqj7l+NdlUBE3AyDhSK/JdtFbx9IB6xbgz0zD
 f4ujVs55fv5KtbCVdeYPRa6xUVSisknqdD40tefgHh132EkvIuctEskJinvkQcJG
 W+VIGHtL+63HriS0QU4BczZbKPO87MZAHAHzcm1yzPhGRzF1kAZju4Z7/mXC1qKq
 Nl3rJnbbcJXr1oRxS14biIlHhJlLF2OE03ziwFrq672Y6zmh5z372yjLUX1RMCap
 Q4n+/gknvNo/SdfdDnL5BSfunPMInutrhOWLSMrPMwd1kwP0m0AGJxRxx9/SWIWy
 1GLZQ==
X-ME-Sender: <xms:I5YZajjLD7sf8oScmBW_6plnjJQTe9V8Aau48fWn9LljqBm6MNJZVg>
 <xme:I5YZarckhAy-3ZkWTamIIpg33Iy6XduMUoJUbhWjBCdalAgkoWRn9wg30D9Q5dy5D
 6EyDCvbBP-6ECBhD7o4rTty4leR0wvzZS4iSpTZc3OBDJ6uqcQT1g>
X-ME-Received: <xmr:I5YZamkf3x-ZdOF41bYjSWBfq9SiIizmuO35_BMnVFSYfMCq_B9TLeHdRYkOfgnaJL0a24-X0XlYyHB8G2sdD90nq--HHB0>
X-ME-Proxy-Cause: dmFkZTE3poQ72lyOLUtTls1iSE7jC1cJW+MwUIT4Kv644ZOrdNRKfQ3/Ev2gXgL395veoh
 ZDdDjLNSO0BG2KHpNIwo2dedZS3b32AgoiPrSkQK080JNV3qskw91CJsXhQZC3e3ycJ3Se
 KN6SHiNywBxxxsKjfeWSX5APDcmRKffqT9WfPe7MtMaXzo3bkvgDnD78AQ/3mlvaYa0TPN
 SLRcV4tweUNBMms/TSSl1iNBPpWug9xdFZbzi1A97ZkW3VS6oHW+6Gk+78N/5RM4vbcms/
 3U8SKm8B1c/qgSmjmyTj2xQPClqshWpEG250DNhdWY0QdMyhpQEDT0oNzp/PKMy5jCCDTh
 /g9E8BN869NY2GwTC/j59u4/XkoJ561vmZKZTDP4OtGHPli1VV1cIRDJvazljuEImffBlC
 hmJ2eMgS/hSWQG1TpTQY6hVn7zxZbhEUrQGmUpfX3F5mSB3TAQ40knJBrS415r0yxwhCpT
 psmDOimSX0mATP9nkLGH/XZyeYjehEYyt5TEvDxLawfemNqjmlzo7OJo5VLOd+gQwwRz4L
 59NLGWlC51XngwJVjCBwI2raL8/AjEkGrWWvNOF+Y9E5lM5g3zp8tNEmqwBnjXNTo2xDuy
 eIKe9B6kCv1mBkDjBEsXctN3Y4hJa1zJvNbFY8GsFXAr1+FQE1+qJWKI6Pvg
X-ME-Proxy: <xmx:I5YZakucMSbTTFrfJzxht9iRyb0lztFrmJgARzRBdOlTv1yJv3buPQ>
 <xmx:JJYZas-AwZeLV1z0NS3ZvZAnFNL5F86DAYFuRWOHYp4qfuuwNVTIXw>
 <xmx:JJYZamP8kj3ngEAVKCEtESXC93FfpP_6uaH9h2NqfM-wSDOSfu3z2A>
 <xmx:JJYZaiElsADuFcdowYuYcidWkR9M5wIYdLpy4ILc4tPGLNK62ezlzg>
 <xmx:JJYZaqqodJo9i6NpL3H9Qqg1ID3DaEMYc4TXbNuAycQ819okWPyi9PCy>
Feedback-ID: i47234305:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 29 May 2026 09:35:31 -0400 (EDT)
From: Thomas Monjalon <thomas@monjalon.net>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>,
 Gregory Etelson <getelson@nvidia.com>,
 Aman Singh <aman.deep.singh@intel.com>,
 Andrew Rybchenko <andrew.rybchenko@oktetlabs.ru>
Subject: [PATCH v4 02/10] ethdev: introduce selective Rx
Date: Fri, 29 May 2026 15:33:56 +0200
Message-ID: <20260529133522.2646044-3-thomas@monjalon.net>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260529133522.2646044-1-thomas@monjalon.net>
References: <20260202160903.254621-1-getelson@nvidia.com>
 <20260529133522.2646044-1-thomas@monjalon.net>
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
index 8b4f8401e2..d3b77028d6 100644
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

