Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4F462CD6E7B
	for <dpdk-dev@archiver.kernel.org>; Fri,  5 Jun 2026 23:35:21 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 68C8D40664;
	Sat,  6 Jun 2026 01:35:13 +0200 (CEST)
Received: from fout-a5-smtp.messagingengine.com
 (fout-a5-smtp.messagingengine.com [103.168.172.148])
 by mails.dpdk.org (Postfix) with ESMTP id 1DB8E4065B
 for <dev@dpdk.org>; Sat,  6 Jun 2026 01:35:12 +0200 (CEST)
Received: from phl-compute-02.internal (phl-compute-02.internal [10.202.2.42])
 by mailfout.phl.internal (Postfix) with ESMTP id C5A6EEC01AE;
 Fri,  5 Jun 2026 19:35:11 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
 by phl-compute-02.internal (MEProxy); Fri, 05 Jun 2026 19:35:11 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=monjalon.net; h=
 cc:cc:content-transfer-encoding:content-type:date:date:from:from
 :in-reply-to:in-reply-to:message-id:mime-version:references
 :reply-to:subject:subject:to:to; s=fm1; t=1780702511; x=
 1780788911; bh=Y5ighdi1nNP6ThR2KtiKQaEWcfolrVBkEX9WvE/ggZM=; b=P
 S3YNPGipirKDQhVEmpZCp6oG4hmQrUtHyPBGVw6TYTYE1Ce4vFQfVlDhBFTLdRMe
 gc0DUZpYnmChBxAv+IUtgBLMokLYUZVpMcYlJBLpUi2iggtUh4JAbM0loJQ0z+/g
 JbMMTAMmok6P+POAAyEvb28a6KIyGuA/64N3uGkprna+KW8Qp3tG5vSx6rFHJAmY
 65qAj9E764YKRmPLPXMLg68V4KbVzd5bTk+aCJ4uKw0wr75epKpZpyWelPB6Zj9z
 9Z+rtx+S4R/shvZ/eMkJEkTyXrDBD/AnQ/IwF7sENwj35lttJYKb8Ubo4sifYJR+
 itMLNv+0cpRAUrLrK4KEQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-transfer-encoding
 :content-type:date:date:feedback-id:feedback-id:from:from
 :in-reply-to:in-reply-to:message-id:mime-version:references
 :reply-to:subject:subject:to:to:x-me-proxy:x-me-sender
 :x-me-sender:x-sasl-enc; s=fm1; t=1780702511; x=1780788911; bh=Y
 5ighdi1nNP6ThR2KtiKQaEWcfolrVBkEX9WvE/ggZM=; b=VEmX3Ec4DWKdT6iaJ
 REwOTDWIHtF9hW9IPFZx4DFO+kjIG7ZN6z9PhC+PHKgRfSbynszbzlfH77HSDQZ6
 QePL18ky/4kdptCudkb16bOGCedM6YSXUYXP6f+YFXxa80xn/Ban4y/NHHY+/RWn
 JZKk+aT5NM+2AyPeUvlT361tjZO2TkI7D3DWwJQgoWkumExrexNWuVGPThsezhLa
 fRXsvn7k/5p+OcfhmADDq1onW2+4geR/kwRDY1eS8ZjI8RLRIn4loPfIX2r1vjy9
 ey8kxcOOwxp6cGDt41jDExiWT5GHw5IIzHb5UChDaVjj8oJDkOtJCTcAZzKVqs7H
 Ad5vQ==
X-ME-Sender: <xms:Ll0javopplC_psmsKBr7TVF4g2L-XHuLzC1zRBBMl9anOxhVXhq8cw>
 <xme:Ll0jalHJhG1ywgJ88ZcyCtaieyGDWAjd6nfTW2QwJ3WD9HACHE42WrOAyCAiDOGjc
 UCdWYUm0sd0mi2Kn1QINzgH_oIB_XBa9bihLgM3E6C7tlaAKedXWQ>
X-ME-Received: <xmr:Ll0javuQ_0qFheSw__lWoObXRd7LCdXQm_EDc_mdU_LJI7Cv935AqRFX7Q88BblVnrTkwGHyM_If5-wsd4kvBfFeQkA6aQI>
X-ME-Proxy-Cause: dmFkZTF8TioU96Tq8QejfEYWkQIUsOFAOK0FW7DC0LiMj/WHoJBthbNIYQLZhbAbsRQFO2
 lhUgktCKGre+6Hnm7PQXDfi1me7GJ21rd3W+s+oTHe2orhprMWu2vu6WchUqxiyReLNIP/
 h3ejxiJXKpjK7apdIpmRIiSOfY1fUBhqsQ0e82bQFHzyD22eDCAo38hZuDD/ypb4Oztk6q
 OeXfKEwFSxXbs9e3Sev8qr5ihJ1wJqhq/BCqlbt+MotFGfBijxQCyHb3Pfm3eEogn9mTf7
 rZwf/OFQ2wp3HTDchj9Os4Lo4khXvPNfnxTbVv7CQBS9l+7W8MnadGcXfmGvlq8RLz+3QA
 YvbZf+fL6kAExFRgmHocRVMWFi4A40esmAdWEmH8M90Yo3iSPk95YAGcZCVaxWctgGuofY
 ss0PCnMWbSNrX7HFZ8tNXxBREJ3Ye4g0YQI5VIIZGniHHvXZxENlsq0rBVwtCF4VD+bQ/r
 PJNzT54Aoywhy+weAkQ9fPJsUOgnBW9tB470Hwui4OAjiB79IlruJ6ZgUt3Gj9GkNZ1qQn
 K3x2YoEJXudOTaQy74X+ezoH0XOm+erZMRLD1M2miz6gfWhWD9ic1+7pGpkwrpwHDtkHcP
 Rz/J/sErtCHnWr0gwZtAWKc2+y/YzYL/7oUTrSUdcXX/pdtCeA0UZ5UHHnfg
X-ME-Proxy: <xmx:Ll0janUjo_feZBk13BeE77hmqJ9wTpQcKt_o91vw1Ml-tAXMWoowBg>
 <xmx:Ll0jarHJP8tG4aOsTDqw4gHT3B6lNX8kVzoDQYYVjsBEe4-SXVGjXA>
 <xmx:Ll0jap0QK8zWtAcPoMmGzbtPFh-CGa6WCWG5UbvMm4IJRWX6b85BFg>
 <xmx:Ll0jatPdFEu0dgJNI2albpNY1NYMrf943tjRFKdSNrMPyXCr2zZV9w>
 <xmx:L10jakTMYac7wyzKjNV-PvzNCuu6vvWZqWC7i1nMFVmXT9ZXrRwRZkVz>
Feedback-ID: i47234305:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 5 Jun 2026 19:35:09 -0400 (EDT)
From: Thomas Monjalon <thomas@monjalon.net>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>,
 Gregory Etelson <getelson@nvidia.com>,
 Andrew Rybchenko <andrew.rybchenko@oktetlabs.ru>,
 Aman Singh <aman.deep.singh@intel.com>
Subject: [PATCH v9 02/10] ethdev: introduce selective Rx
Date: Sat,  6 Jun 2026 01:33:42 +0200
Message-ID: <20260605233456.3017423-3-thomas@monjalon.net>
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
index ce0407b67f..9efeaf77cb 100644
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

