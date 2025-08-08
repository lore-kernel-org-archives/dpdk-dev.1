Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 37544C87FDA
	for <dpdk-dev@archiver.kernel.org>; Fri,  8 Aug 2025 16:15:55 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 4F83D402AB;
	Fri,  8 Aug 2025 18:15:54 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
 by mails.dpdk.org (Postfix) with ESMTP id 9842F4028B;
 Fri,  8 Aug 2025 18:15:51 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1754669752; x=1786205752;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=uBUzc/Pffl5sbdhpqNYeUKvuTZN034d2Vg4zdceS8sk=;
 b=Q2vzGp+inVF/TQh3XIjiQKnhwvH0a77NRKLAkzEmE/nOSIxXi/0SlaV4
 o/6cSw4zLsdpHtCJ9Jtk4hCKv3oBC5OYSVHRgNTsaCxJ9yYyH8sTSDoUa
 9sKkj4k040cruXOFx0muBCPFdsoD7tGD9MQIGiw6V+yp2CuwPpvJXsOgH
 NoMSOKKLdgQNF/f8ooaWP6itMYODGfxbaL6u21bSVHwLJXYLgIQOKvEk6
 XqOTL6kBVAq6LuHSDoyIlFd/xuSO0bpsZvoYhiAFDBYCkJYgQpLRACVU0
 XopiKJ4iTqyWJPV9CcvQjWeiGs5cHYUOR3z68pBXKaGTOEyNcrqtTT1YF g==;
X-CSE-ConnectionGUID: fdvwLFjNQmeZFfnB4H18Aw==
X-CSE-MsgGUID: cLzYvpIdQPObAn3v/p/70g==
X-IronPort-AV: E=McAfee;i="6800,10657,11515"; a="67610377"
X-IronPort-AV: E=Sophos;i="6.17,274,1747724400"; d="scan'208";a="67610377"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
 by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 08 Aug 2025 09:15:51 -0700
X-CSE-ConnectionGUID: 0b90T+QcS5e3DIk5iw7A1A==
X-CSE-MsgGUID: kqXEzhjaQge5R8DwWQ2JWA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.17,274,1747724400"; d="scan'208";a="170615597"
Received: from silpixa00401385.ir.intel.com ([10.237.214.33])
 by fmviesa004.fm.intel.com with ESMTP; 08 Aug 2025 09:15:49 -0700
From: Bruce Richardson <bruce.richardson@intel.com>
To: dev@dpdk.org
Cc: techboard@dpdk.org,
	Bruce Richardson <bruce.richardson@intel.com>
Subject: [PATCH v2] doc: clarify VLAN and QinQ stripping behaviour
Date: Fri,  8 Aug 2025 17:15:19 +0100
Message-ID: <20250808161539.485512-1-bruce.richardson@intel.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250714133014.44597-1-bruce.richardson@intel.com>
References: <20250714133014.44597-1-bruce.richardson@intel.com>
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

The behaviour of VLAN tag stripping Rx offloads is unclear in DPDK, and
not very well documented. Even the documentation that does exist appears
contradictory.

For example, the doxygen docs for the mbuf flag
RTE_MBUF_F_RX_QINQ_STRIPPED says:

  "If RTE_MBUF_F_RX_QINQ_STRIPPED is set and RTE_MBUF_F_RX_VLAN_STRIPPED
  is unset, only the outer VLAN is removed from packet data,..."

but the docs for RTE_MBUF_F_RX_QINQ says:

  "If the flag RTE_MBUF_F_RX_QINQ_STRIPPED is also present, both VLANs
  headers have been stripped from mbuf data, ..."

Without a good definition of what the correct behaviour is, it's not
possible to assess and ensure conformance across drivers. Update the
documentation for NIC features, ethdev and mbuf library to all report
the same information.

- VLAN strip implies stripping a single/outer tag of type 0x8100
- QinQ strip implies stripping a single/outer tag of type 0x88a8, which
  may be followed by a tag of 0x8100. That inner tag is stripped
  if-and-only-if VLAN stripping is enabled too.

Signed-off-by: Bruce Richardson <bruce.richardson@intel.com>
---
V2: updated and reworded following discussion on RFC patch
---
 doc/guides/nics/features.rst | 31 +++++++++++++++++++++++++++++++
 lib/ethdev/rte_ethdev.h      | 28 ++++++++++++++++++++++++++++
 lib/mbuf/rte_mbuf_core.h     | 32 ++++++++++++++++++--------------
 3 files changed, 77 insertions(+), 14 deletions(-)

diff --git a/doc/guides/nics/features.rst b/doc/guides/nics/features.rst
index a075c057ec..df0b7edee7 100644
--- a/doc/guides/nics/features.rst
+++ b/doc/guides/nics/features.rst
@@ -483,6 +483,11 @@ VLAN offload
 ------------

 Supports VLAN offload to hardware.
+This includes both VLAN stripping on Rx and VLAN insertion on Tx.
+
+On Rx, VLAN strip removes one VLAN tag (default ethertype=0x8100) if present.
+If multiple VLAN tags are present, it strips the outer tag only.
+The stripped VLAN TCI is saved in mbuf->vlan_tci.

 * **[uses]       rte_eth_rxconf,rte_eth_rxmode**: ``offloads:RTE_ETH_RX_OFFLOAD_VLAN_STRIP,RTE_ETH_RX_OFFLOAD_VLAN_FILTER,RTE_ETH_RX_OFFLOAD_VLAN_EXTEND``.
 * **[uses]       rte_eth_txconf,rte_eth_txmode**: ``offloads:RTE_ETH_TX_OFFLOAD_VLAN_INSERT``.
@@ -501,6 +506,32 @@ QinQ offload
 ------------

 Supports QinQ (queue in queue) offload.
+This includes both QinQ stripping on Rx and QinQ insertion on Tx.
+
+On Rx, QinQ strip removes the outer QinQ tag (default ethertype=0x88a8) if present.
+If multiple QinQ tags are present it only strips the outer tag.
+The tag stripped is saved in mbuf->vlan_tci_outer.
+
+If an outer QinQ tag is stripped and if VLAN stripping is also enabled,
+any inner VLAN tag (default ethertype=0x8100) is also stripped.
+That tag is stored in mbuf->vlan_tci.
+
+Summary of VLAN and QinQ stripping behavior for some possible input traffic options:
+
++----------------------+-----------------------+------------------------------+------------------------------+
+| Input Traffic        | VLAN-strip on         | QinQ strip on                | Both on                      |
++======================+=======================+==============================+==============================+
+| Single Tag 0x8100    | Tag in vlan_tci       |                              | Tag in vlan_tci              |
++----------------------+-----------------------+------------------------------+------------------------------+
+| Single Tag 0x88a8    |                       | Tag in vlan_tci_outer        | Tag in vlan_tci_outer        |
++----------------------+-----------------------+------------------------------+------------------------------+
+| Tag 88a8 + Tag 8100  |                       | Outer tag in vlan_tci_outer  | Outer tag in vlan_tci_outer  |
+|                      |                       |                              |                              |
+|                      |                       |                              | Inner tag in vlan_tci        |
++----------------------+-----------------------+------------------------------+------------------------------+
+| Double Tag 0x8100    | Outer tag in vlan_tci |                              | Outer tag in vlan_tci        |
++----------------------+-----------------------+------------------------------+------------------------------+
+

 * **[uses]     rte_eth_rxconf,rte_eth_rxmode**: ``offloads:RTE_ETH_RX_OFFLOAD_QINQ_STRIP``.
 * **[uses]     rte_eth_txconf,rte_eth_txmode**: ``offloads:RTE_ETH_TX_OFFLOAD_QINQ_INSERT``.
diff --git a/lib/ethdev/rte_ethdev.h b/lib/ethdev/rte_ethdev.h
index f9fb6ae549..5e226ff1c9 100644
--- a/lib/ethdev/rte_ethdev.h
+++ b/lib/ethdev/rte_ethdev.h
@@ -1552,11 +1552,39 @@ struct rte_eth_conf {
 /**
  * Rx offload capabilities of a device.
  */
+/**
+ * VLAN strip offload.
+ *
+ * When enabled, strips one VLAN tag (ethtype=0x8100) if available.
+ * If multiple VLAN tags are present, it strips the outer tag.
+ * The stripped VLAN TCI is saved in mbuf->vlan_tci
+ * and @ref RTE_MBUF_F_RX_VLAN_STRIPPED flag is set.
+ *
+ * Note: if @ref RTE_ETH_RX_OFFLOAD_QINQ_STRIP is also enabled,
+ * the stripped tag may be an inner tag present after a QinQ tag (ethtype=0x88a8).
+ * In this case, both @ref RTE_MBUF_F_RX_QINQ_STRIPPED and
+ * @ref RTE_MBUF_F_RX_VLAN_STRIPPED flags will be set in the received mbuf.
+ */
 #define RTE_ETH_RX_OFFLOAD_VLAN_STRIP       RTE_BIT64(0)
 #define RTE_ETH_RX_OFFLOAD_IPV4_CKSUM       RTE_BIT64(1)
 #define RTE_ETH_RX_OFFLOAD_UDP_CKSUM        RTE_BIT64(2)
 #define RTE_ETH_RX_OFFLOAD_TCP_CKSUM        RTE_BIT64(3)
 #define RTE_ETH_RX_OFFLOAD_TCP_LRO          RTE_BIT64(4)
+/**
+ * QinQ strip offload.
+ *
+ * When enabled, strips outer QinQ tag (ethtype=0x88a8) if present.
+ * The stripped QinQ tag is saved in mbuf field vlan_tci_outer
+ * and @ref RTE_MBUF_F_RX_QINQ_STRIPPED flag is set.
+ *
+ * If a QinQ tag is stripped and VLAN stripping is also enabled,
+ * any inner VLAN tag (ethtype=0x8100) is also stripped and
+ * stored in mbuf field vlan_tci, with the flag @ref RTE_MBUF_F_RX_VLAN_STRIPPED
+ * being set.
+ *
+ * @see RTE_ETH_RX_OFFLOAD_VLAN_STRIP, @see RTE_MBUF_F_RX_QINQ_STRIPPED,
+ * @see RTE_MBUF_F_RX_VLAN_STRIPPED
+ */
 #define RTE_ETH_RX_OFFLOAD_QINQ_STRIP       RTE_BIT64(5)
 #define RTE_ETH_RX_OFFLOAD_OUTER_IPV4_CKSUM RTE_BIT64(6)
 #define RTE_ETH_RX_OFFLOAD_MACSEC_STRIP     RTE_BIT64(7)
diff --git a/lib/mbuf/rte_mbuf_core.h b/lib/mbuf/rte_mbuf_core.h
index a0df265b5d..824f11d438 100644
--- a/lib/mbuf/rte_mbuf_core.h
+++ b/lib/mbuf/rte_mbuf_core.h
@@ -44,7 +44,7 @@ extern "C" {
 /**
  * The RX packet is a 802.1q VLAN packet, and the tci has been
  * saved in mbuf->vlan_tci.
- * If the flag RTE_MBUF_F_RX_VLAN_STRIPPED is also present, the VLAN
+ * If the flag @ref RTE_MBUF_F_RX_VLAN_STRIPPED is also present, the VLAN
  * header has been stripped from mbuf data, else it is still
  * present.
  */
@@ -66,7 +66,11 @@ extern "C" {
  * A vlan has been stripped by the hardware and its tci is saved in
  * mbuf->vlan_tci. This can only happen if vlan stripping is enabled
  * in the RX configuration of the PMD.
- * When RTE_MBUF_F_RX_VLAN_STRIPPED is set, RTE_MBUF_F_RX_VLAN must also be set.
+ * When RTE_MBUF_F_RX_VLAN_STRIPPED is set, @ref RTE_MBUF_F_RX_VLAN must also be set.
+ *
+ * Note: When @ref RTE_MBUF_F_RX_QINQ_STRIPPED is also set,
+ * the stripped tag is an inner tag, rather than a single or outer tag.
+ * @see RTE_MBUF_F_RX_QINQ_STRIPPED for more information.
  */
 #define RTE_MBUF_F_RX_VLAN_STRIPPED (1ULL << 6)

@@ -113,19 +117,19 @@ extern "C" {
 #define RTE_MBUF_F_RX_FDIR_FLX      (1ULL << 14)

 /**
- * The outer VLAN has been stripped by the hardware and its TCI is
+ * The outer QinQ Tag (ethtype=0x88a8) has been stripped by the hardware and its TCI is
  * saved in mbuf->vlan_tci_outer.
- * This can only happen if VLAN stripping is enabled in the Rx
+ * This can only happen if QinQ stripping is enabled in the Rx
  * configuration of the PMD.
- * When RTE_MBUF_F_RX_QINQ_STRIPPED is set, the flags RTE_MBUF_F_RX_VLAN
- * and RTE_MBUF_F_RX_QINQ must also be set.
+ * When RTE_MBUF_F_RX_QINQ_STRIPPED is set, the flag RTE_MBUF_F_RX_QINQ must also be set.
  *
  * - If both RTE_MBUF_F_RX_QINQ_STRIPPED and RTE_MBUF_F_RX_VLAN_STRIPPED are
  *   set, the 2 VLANs have been stripped by the hardware and their TCIs are
  *   saved in mbuf->vlan_tci (inner) and mbuf->vlan_tci_outer (outer).
  * - If RTE_MBUF_F_RX_QINQ_STRIPPED is set and RTE_MBUF_F_RX_VLAN_STRIPPED
- *   is unset, only the outer VLAN is removed from packet data, but both tci
- *   are saved in mbuf->vlan_tci (inner) and mbuf->vlan_tci_outer (outer).
+ *   is unset, only the outer VLAN is removed from packet data and
+ *   stored in mbuf->vlan_tci_outer.
+ *   The contents of mbuf->vlan_tci are undefined in this case.
  */
 #define RTE_MBUF_F_RX_QINQ_STRIPPED (1ULL << 15)

@@ -149,12 +153,12 @@ extern "C" {
 #define RTE_MBUF_F_RX_SEC_OFFLOAD_FAILED	(1ULL << 19)

 /**
- * The RX packet is a double VLAN, and the outer tci has been
- * saved in mbuf->vlan_tci_outer. If this flag is set, RTE_MBUF_F_RX_VLAN
- * must also be set and the inner tci is saved in mbuf->vlan_tci.
- * If the flag RTE_MBUF_F_RX_QINQ_STRIPPED is also present, both VLANs
- * headers have been stripped from mbuf data, else they are still
- * present.
+ * The RX packet is a QinQ packet, and the outer tci has been
+ * saved in mbuf->vlan_tci_outer.
+ * If the flag @ref RTE_MBUF_F_RX_QINQ_STRIPPED is also present,
+ * the QinQ tag has been stripped from mbuf data.
+ *
+ * @see RTE_MBUF_F_RX_QINQ_STRIPPED, @see RTE_MBUF_F_RX_VLAN, @see RTE_MBUF_F_RX_VLAN_STRIPPED
  */
 #define RTE_MBUF_F_RX_QINQ          (1ULL << 20)

--
2.48.1

