Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 46FBEC83F1A
	for <dpdk-dev@archiver.kernel.org>; Mon, 14 Jul 2025 13:30:26 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 37F934021F;
	Mon, 14 Jul 2025 15:30:25 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
 by mails.dpdk.org (Postfix) with ESMTP id 80B8A400D5;
 Mon, 14 Jul 2025 15:30:23 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1752499824; x=1784035824;
 h=from:to:cc:subject:date:message-id:mime-version:
 content-transfer-encoding;
 bh=/hjif1QR0HcLqs6WmB0Uc6nMdjXqGNbtjrly36afOJw=;
 b=gu+vvw6utwH6umEzZVrzC/saI0Dz/m56QjZWkkacWlZ4RkZqF2OhaPI6
 hE79BRsGbZxH45P2zDuroa9gqWBoYZsF/2f2yQZc8Mxzn4CGsGdETJz6q
 rTUrYdPY+vo+NMp17UTsvxgPHdvF8CjZghlW5qtkShILOHZhh3gj6QKoe
 iIEC3ooZ9+XL76kKo1QMBbJ8a0iQG6jdVaEVGBRZCg5MotezExrgC5MXO
 aTqOeC7sw6+w7KGMGZ15JXyUGtgHW/z8phX/gaBGS5gJTkAuNswQCSRYC
 uSeFTWIqWzEnBVQjmifhb8XsV+5PSdYmU0jv8nnWxnFA9sWzHGUDZS9jC A==;
X-CSE-ConnectionGUID: 4eX5nZ/LRLCrOs2DfOS0Og==
X-CSE-MsgGUID: g7LFH63RSneGe9loqWzk9Q==
X-IronPort-AV: E=McAfee;i="6800,10657,11491"; a="65262904"
X-IronPort-AV: E=Sophos;i="6.16,311,1744095600"; d="scan'208";a="65262904"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
 by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 14 Jul 2025 06:30:22 -0700
X-CSE-ConnectionGUID: xMIRiuVzR/6IYKGMYUiO+Q==
X-CSE-MsgGUID: QKo0x5+eTAGPSmm+ftSOsQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,311,1744095600"; d="scan'208";a="156348012"
Received: from silpixa00401385.ir.intel.com ([10.237.214.33])
 by orviesa010.jf.intel.com with ESMTP; 14 Jul 2025 06:30:21 -0700
From: Bruce Richardson <bruce.richardson@intel.com>
To: dev@dpdk.org
Cc: techboard@dpdk.org,
	Bruce Richardson <bruce.richardson@intel.com>
Subject: [RFC PATCH] doc: clarify VLAN and QinQ stripping behaviour
Date: Mon, 14 Jul 2025 14:30:14 +0100
Message-ID: <20250714133014.44597-1-bruce.richardson@intel.com>
X-Mailer: git-send-email 2.48.1
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
the same information: that VLAN strip feature is stripping one flag, and
QinQ strip feature is removing two.

Summary of VLAN and QinQ stripping behaviour as reported in docs after
this patch:

+-------------------+----------------------+----------------------------+
| Input Traffic     | VLAN-strip on        | QinQ strip on              |
+===================+======================+============================+
| Single VLAN pkts  | Tag in vlan_tci      | Tag in vlan_tci            |
+-------------------+----------------------+----------------------------+
| Double VLAN pkts  | Outer tag in vlan_tci| Outer tag in vlan_tci_outer|
|                   |                      | Inner tag in vlan_tci      |
+-------------------+----------------------+----------------------------+

Signed-off-by: Bruce Richardson <bruce.richardson@intel.com>
---
 doc/guides/nics/features.rst | 21 +++++++++++++++++++++
 lib/ethdev/rte_ethdev.h      | 20 ++++++++++++++++++++
 lib/mbuf/rte_mbuf_core.h     | 36 ++++++++++++++++++++----------------
 3 files changed, 61 insertions(+), 16 deletions(-)

diff --git a/doc/guides/nics/features.rst b/doc/guides/nics/features.rst
index a075c057ec..c57ea8e08f 100644
--- a/doc/guides/nics/features.rst
+++ b/doc/guides/nics/features.rst
@@ -483,6 +483,11 @@ VLAN offload
 ------------
 
 Supports VLAN offload to hardware.
+This includes both VLAN stripping on Rx and VLAN insertion on Tx.
+
+On Rx VLAN strip always strips one VLAN tag if available.
+If multiple VLAN tags are present, it strips the outer tag.
+The stripped VLAN TCI is saved in mbuf->vlan_tci.
 
 * **[uses]       rte_eth_rxconf,rte_eth_rxmode**: ``offloads:RTE_ETH_RX_OFFLOAD_VLAN_STRIP,RTE_ETH_RX_OFFLOAD_VLAN_FILTER,RTE_ETH_RX_OFFLOAD_VLAN_EXTEND``.
 * **[uses]       rte_eth_txconf,rte_eth_txmode**: ``offloads:RTE_ETH_TX_OFFLOAD_VLAN_INSERT``.
@@ -501,6 +506,22 @@ QinQ offload
 ------------
 
 Supports QinQ (queue in queue) offload.
+This includes both QinQ stripping on Rx and QinQ insertion on Tx.
+
+On Rx, QinQ strip strips two VLAN tags if present.
+If only one tag is present, it behaves as VLAN strip.
+Specifying both VLAN strip and QinQ strip is equivalent to QinQ strip alone.
+
+Summary of VLAN and QinQ stripping behavior:
+
++----------------------+----------------------+------------------------------+
+| Input Traffic        | VLAN-strip on        | QinQ strip on                |
++======================+======================+==============================+
+| Single VLAN packets  | Tag in vlan_tci      | Tag in vlan_tci              |
++----------------------+----------------------+------------------------------+
+| Double VLAN packets  | Outer tag in vlan_tci| Outer tag in vlan_tci_outer  |
+|                      |                      | Inner tag in vlan_tci        |
++----------------------+----------------------+------------------------------+
 
 * **[uses]     rte_eth_rxconf,rte_eth_rxmode**: ``offloads:RTE_ETH_RX_OFFLOAD_QINQ_STRIP``.
 * **[uses]     rte_eth_txconf,rte_eth_txmode**: ``offloads:RTE_ETH_TX_OFFLOAD_QINQ_INSERT``.
diff --git a/lib/ethdev/rte_ethdev.h b/lib/ethdev/rte_ethdev.h
index f9fb6ae549..ccf0cf5e30 100644
--- a/lib/ethdev/rte_ethdev.h
+++ b/lib/ethdev/rte_ethdev.h
@@ -1552,11 +1552,31 @@ struct rte_eth_conf {
 /**
  * Rx offload capabilities of a device.
  */
+/**
+ * VLAN strip offload.
+ *
+ * When enabled, strips one VLAN tag if available.
+ * If multiple VLAN tags are present, it strips the outer tag.
+ * The stripped VLAN TCI is saved in mbuf->vlan_tci and RTE_MBUF_F_RX_VLAN_STRIPPED flag is set.
+ */
 #define RTE_ETH_RX_OFFLOAD_VLAN_STRIP       RTE_BIT64(0)
 #define RTE_ETH_RX_OFFLOAD_IPV4_CKSUM       RTE_BIT64(1)
 #define RTE_ETH_RX_OFFLOAD_UDP_CKSUM        RTE_BIT64(2)
 #define RTE_ETH_RX_OFFLOAD_TCP_CKSUM        RTE_BIT64(3)
 #define RTE_ETH_RX_OFFLOAD_TCP_LRO          RTE_BIT64(4)
+/**
+ * QinQ strip offload.
+ *
+ * When enabled, strips two VLAN tags if present.
+ * If only one tag is present, it behaves as VLAN strip.
+ * The stripped VLAN TCIs are saved in mbuf fields and appropriate RTE_MBUF_F_RX_* flags are set.
+ *
+ * For single VLAN packets: Tag is saved in mbuf->vlan_tci (same as VLAN strip)
+ * For double VLAN packets: Outer tag is saved in mbuf->vlan_tci_outer,
+ *                          Inner tag is saved in mbuf->vlan_tci
+ *
+ * Note: Specifying both VLAN strip and QinQ strip is equivalent to QinQ strip alone.
+ */
 #define RTE_ETH_RX_OFFLOAD_QINQ_STRIP       RTE_BIT64(5)
 #define RTE_ETH_RX_OFFLOAD_OUTER_IPV4_CKSUM RTE_BIT64(6)
 #define RTE_ETH_RX_OFFLOAD_MACSEC_STRIP     RTE_BIT64(7)
diff --git a/lib/mbuf/rte_mbuf_core.h b/lib/mbuf/rte_mbuf_core.h
index a0df265b5d..23aed8ec69 100644
--- a/lib/mbuf/rte_mbuf_core.h
+++ b/lib/mbuf/rte_mbuf_core.h
@@ -63,10 +63,17 @@ extern "C" {
 #define RTE_MBUF_F_RX_OUTER_IP_CKSUM_BAD (1ULL << 5)
 
 /**
- * A vlan has been stripped by the hardware and its tci is saved in
- * mbuf->vlan_tci. This can only happen if vlan stripping is enabled
- * in the RX configuration of the PMD.
- * When RTE_MBUF_F_RX_VLAN_STRIPPED is set, RTE_MBUF_F_RX_VLAN must also be set.
+ * A vlan has been stripped by the hardware and its tci is saved in mbuf->vlan_tci.
+ * This can only happen if vlan or QinQ stripping is enabled in the RX configuration of the PMD.
+ *
+ * NOTE:
+ * - If VLAN stripping is enabled, but not QinQ, the tag stripped will be the outer
+ *   VLAN tag of a QinQ packet.
+ * - If QinQ stripping is enabled, then the outer VLAN tag is stripped and saved in
+ *   mbuf->vlan_tci_outer (indicated by the presence of flag @ref RTE_MBUF_F_RX_QINQ_STRIPPED),
+ *   while the inner VLAN tag is stripped and saved in mbuf->vlan_tci.
+ *
+ * When @ref RTE_MBUF_F_RX_VLAN_STRIPPED is set, @ref RTE_MBUF_F_RX_VLAN must also be set.
  */
 #define RTE_MBUF_F_RX_VLAN_STRIPPED (1ULL << 6)
 
@@ -113,19 +120,16 @@ extern "C" {
 #define RTE_MBUF_F_RX_FDIR_FLX      (1ULL << 14)
 
 /**
- * The outer VLAN has been stripped by the hardware and its TCI is
- * saved in mbuf->vlan_tci_outer.
- * This can only happen if VLAN stripping is enabled in the Rx
- * configuration of the PMD.
- * When RTE_MBUF_F_RX_QINQ_STRIPPED is set, the flags RTE_MBUF_F_RX_VLAN
- * and RTE_MBUF_F_RX_QINQ must also be set.
+ * Two VLANs have been stripped from the packet by hardware and are
+ * reported in the vlan_tci and vlan_tci_outer fields.
+ *
+ * When this flag is set:
+ * - The outer VLAN has been stripped by the hardware and it is saved in mbuf->vlan_tci_outer.
+ * - The inner VLAN has also been stripped by the hardware and it is saved in mbuf->vlan_tci.
  *
- * - If both RTE_MBUF_F_RX_QINQ_STRIPPED and RTE_MBUF_F_RX_VLAN_STRIPPED are
- *   set, the 2 VLANs have been stripped by the hardware and their TCIs are
- *   saved in mbuf->vlan_tci (inner) and mbuf->vlan_tci_outer (outer).
- * - If RTE_MBUF_F_RX_QINQ_STRIPPED is set and RTE_MBUF_F_RX_VLAN_STRIPPED
- *   is unset, only the outer VLAN is removed from packet data, but both tci
- *   are saved in mbuf->vlan_tci (inner) and mbuf->vlan_tci_outer (outer).
+ * When @ref RTE_MBUF_F_RX_QINQ_STRIPPED is set, the flags @ref RTE_MBUF_F_RX_VLAN,
+ * @ref RTE_MBUF_F_RX_VLAN_STRIPPED,
+ * and @ref RTE_MBUF_F_RX_QINQ must also be set.
  */
 #define RTE_MBUF_F_RX_QINQ_STRIPPED (1ULL << 15)
 
-- 
2.48.1

