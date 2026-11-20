Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E4004606A325
	for <dpdk-dev@archiver.kernel.org>; Fri, 20 Nov 2026 10:22:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=AbwMROC4
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 0075440263;
	Fri, 20 Nov 2026 11:22:16 +0100 (CET)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
 by mails.dpdk.org (Postfix) with ESMTPS id 23F0640151
 for <dev@dpdk.org>; Fri, 20 Nov 2026 11:22:14 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1795170136; x=1826706136;
 h=from:to:subject:date:message-id:mime-version:
 content-transfer-encoding;
 bh=yM8rq8QOoClwhc6CMKx/BX2txEf0UWXnd0rMDDDjqNw=;
 b=AbwMROC4b9zZp9+PSyr/7OBdD8C9JBrjv0QJW3LdeBi+mSc6mxsmbe5J
 FGCMSwd9qPQ78ZhO2gqkELjpWeySbjtRa1TASzur99a3XT0ZPGqE3OGHj
 QpKLqAl/FPmZg9K/yTyOkepuPKNwhJtEJ78quihjyZGLZOZRHOEXHZYHb
 DzS8qnLX7SPZaknoJRlvp93p3EK63thS/QWNTnq3DPIQ2RC6sRNaH3Cmo
 nmF/5DM0gpacxBjUkU2kSGYZHqFCxSuYXqZHEd5Xl5w3Ej78Lh9E/d1TE
 z0P2lHFaCSFtp+g9P/e7Tn2fq3YrxvXKTVtR9OJh8/mZGyE/qmJukiLYW A==;
X-CSE-ConnectionGUID: 7lgNxy0rRxSVMbfzXLohxg==
X-CSE-MsgGUID: pm/YthAOTei8h+bvC5xU3g==
X-IronPort-AV: E=McAfee;i="6800,10657,11971"; a="3930098"
X-IronPort-AV: E=Sophos;i="6.27,222,1787036400"; 
   d="scan'208";a="3930098"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
 by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 20 Nov 2026 02:22:14 -0800
X-CSE-ConnectionGUID: QqxYsXT6TYuQIVFwZT5dfA==
X-CSE-MsgGUID: jiNxITZtQgCzLqAMsMLT4Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,222,1787036400"; d="scan'208";a="10748550"
Received: from silpixa00401119.ir.intel.com ([10.20.224.206])
 by fmviesa005.fm.intel.com with ESMTP; 20 Nov 2026 02:22:13 -0800
From: Anatoly Burakov <anatoly.burakov@intel.com>
To: dev@dpdk.org
Subject: [PATCH v1 1/1] net/ixgbe: fix PTP packet detection
Date: Fri, 20 Nov 2026 10:22:09 +0000
Message-ID: <a981e3347f36b5cda348c27448eba3c5d83e98a7.1795170123.git.anatoly.burakov@intel.com>
X-Mailer: git-send-email 2.52.0
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-BeenThere: dev@dpdk.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: DPDK patches and discussions <dev.dpdk.org>
List-Archive: <http://mails.dpdk.org/archives/dev/>
List-Post: <mailto:dev@dpdk.org>
List-Help: <mailto:dev-request@dpdk.org?subject=help>
List-Subscribe: <https://mails.dpdk.org/listinfo/dev>,
 <mailto:dev-request@dpdk.org?subject=subscribe>
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Currently, the Rx path decides whether a packet is a PTP packet by looking
at which ETQF filter index it was matched against, and it expects the
1588 filter to always be at index 3. However, when the Ethertype filter
table was made dynamic, the 1588 filter started being installed into
the first free slot instead, so the Rx path may not recognize PTP packets
and, if that happens, never sets RTE_MBUF_F_RX_IEEE1588_PTP on them.

Fix it by always reserving the last ETQF slot for the 1588 filter, and
only allocating the remaining slots dynamically.

Fixes: 3ba3f96f8f71 ("net/ixgbe: make ethertype filter table dynamic")
Cc: stable@dpdk.org

Signed-off-by: Anatoly Burakov <anatoly.burakov@intel.com>
---
 drivers/net/intel/ixgbe/ixgbe_ethdev.c | 33 +++++---------------------
 drivers/net/intel/ixgbe/ixgbe_ethdev.h |  9 +++----
 drivers/net/intel/ixgbe/ixgbe_rxtx.c   |  5 ++--
 3 files changed, 13 insertions(+), 34 deletions(-)

diff --git a/drivers/net/intel/ixgbe/ixgbe_ethdev.c b/drivers/net/intel/ixgbe/ixgbe_ethdev.c
index 75920312173..a284dd485ae 100644
--- a/drivers/net/intel/ixgbe/ixgbe_ethdev.c
+++ b/drivers/net/intel/ixgbe/ixgbe_ethdev.c
@@ -6499,7 +6499,7 @@ ixgbe_ethertype_table_add(struct ixgbe_ethertype_table *table,
 	int free_idx = -1;
 	int i;
 
-	for (i = 0; i < IXGBE_MAX_ETQF_FILTERS; i++) {
+	for (i = 0; i < IXGBE_ETQF_TABLE_SIZE; i++) {
 		if (table->entries[i].used) {
 			if (table->entries[i].ethertype == ethertype)
 				return -EEXIST;
@@ -6521,7 +6521,7 @@ ixgbe_ethertype_table_add(struct ixgbe_ethertype_table *table,
 int
 ixgbe_ethertype_table_del(struct ixgbe_ethertype_table *table, uint8_t idx)
 {
-	if (idx >= IXGBE_MAX_ETQF_FILTERS || !table->entries[idx].used)
+	if (idx >= IXGBE_ETQF_TABLE_SIZE || !table->entries[idx].used)
 		return -ENOENT;
 
 	table->entries[idx] = (struct ixgbe_ethertype_entry){0};
@@ -6762,28 +6762,13 @@ static int
 ixgbe_timesync_enable(struct rte_eth_dev *dev)
 {
 	struct ixgbe_hw *hw = IXGBE_DEV_PRIVATE_TO_HW(dev->data->dev_private);
-	struct ixgbe_filter_info *filter_info =
-		IXGBE_DEV_PRIVATE_TO_FILTER_INFO(dev->data->dev_private);
 	uint32_t tsync_ctl;
 	uint32_t tsauxc;
-	uint32_t etqf;
 	struct timespec ts;
-	int idx;
 
 	memset(&ts, 0, sizeof(struct timespec));
 
-	/* Reserve the shared ETQF slot before changing timestamp hardware. */
-	etqf = RTE_ETHER_TYPE_1588 | IXGBE_ETQF_FILTER_EN | IXGBE_ETQF_1588;
-	if (!filter_info->timesync_installed) {
-		idx = ixgbe_ethertype_table_add(&filter_info->ethertype_table,
-				RTE_ETHER_TYPE_1588, etqf, 0);
-		if (idx < 0) {
-			PMD_DRV_LOG(ERR, "no free ETQF slot for 1588 timestamping");
-			return idx;
-		}
-		filter_info->timesync_idx = idx;
-		filter_info->timesync_installed = true;
-	}
+	/* 1588 uses a fixed ETQF table slot, no need to reserve it */
 
 	/* get current system time */
 	clock_gettime(CLOCK_REALTIME, &ts);
@@ -6802,7 +6787,8 @@ ixgbe_timesync_enable(struct rte_eth_dev *dev)
 	ixgbe_start_timecounters(dev);
 
 	/* Enable L2 filtering of IEEE1588/802.1AS Ethernet frame types. */
-	ixgbe_ethertype_filter_program(hw, filter_info->timesync_idx, etqf, 0);
+	ixgbe_ethertype_filter_program(hw, IXGBE_ETQF_FILTER_TIMESYNC,
+			RTE_ETHER_TYPE_1588 | IXGBE_ETQF_FILTER_EN | IXGBE_ETQF_1588, 0);
 
 	/* Enable timestamping of received PTP packets. */
 	tsync_ctl = IXGBE_READ_REG(hw, IXGBE_TSYNCRXCTL);
@@ -6826,8 +6812,6 @@ static int
 ixgbe_timesync_disable(struct rte_eth_dev *dev)
 {
 	struct ixgbe_hw *hw = IXGBE_DEV_PRIVATE_TO_HW(dev->data->dev_private);
-	struct ixgbe_filter_info *filter_info =
-		IXGBE_DEV_PRIVATE_TO_FILTER_INFO(dev->data->dev_private);
 	uint32_t tsync_ctl;
 
 	/* Disable timestamping of transmitted PTP packets. */
@@ -6841,12 +6825,7 @@ ixgbe_timesync_disable(struct rte_eth_dev *dev)
 	IXGBE_WRITE_REG(hw, IXGBE_TSYNCRXCTL, tsync_ctl);
 
 	/* Disable L2 filtering of IEEE1588/802.1AS Ethernet frame types. */
-	if (filter_info->timesync_installed) {
-		ixgbe_ethertype_filter_program(hw, filter_info->timesync_idx, 0, 0);
-		ixgbe_ethertype_table_del(&filter_info->ethertype_table,
-				filter_info->timesync_idx);
-		filter_info->timesync_installed = false;
-	}
+	ixgbe_ethertype_filter_program(hw, IXGBE_ETQF_FILTER_TIMESYNC, 0, 0);
 
 	/* Stop incrementing the System Time registers. */
 	IXGBE_WRITE_REG(hw, IXGBE_TIMINCA, 0);
diff --git a/drivers/net/intel/ixgbe/ixgbe_ethdev.h b/drivers/net/intel/ixgbe/ixgbe_ethdev.h
index a646909b4e9..3b231f802fc 100644
--- a/drivers/net/intel/ixgbe/ixgbe_ethdev.h
+++ b/drivers/net/intel/ixgbe/ixgbe_ethdev.h
@@ -287,6 +287,10 @@ struct ixgbe_5tuple_filter_info {
 		proto_mask:1;    /* if mask is 1b, do not compare protocol. */
 };
 
+/* Last ETQF slot is reserved for 1588, Rx path maps its index to PTP flag. */
+#define IXGBE_ETQF_FILTER_TIMESYNC	(IXGBE_MAX_ETQF_FILTERS - 1)
+#define IXGBE_ETQF_TABLE_SIZE		(IXGBE_MAX_ETQF_FILTERS - 1)
+
 /* Shared EtherType (ETQF) filter table. */
 struct ixgbe_ethertype_table {
 	struct ixgbe_ethertype_entry {
@@ -294,7 +298,7 @@ struct ixgbe_ethertype_table {
 		uint16_t ethertype; /* ethertype, for dedup */
 		uint32_t etqf; /* ETQF register value */
 		uint32_t etqs; /* ETQS register value */
-	} entries[IXGBE_MAX_ETQF_FILTERS];
+	} entries[IXGBE_ETQF_TABLE_SIZE];
 };
 
 /*
@@ -303,9 +307,6 @@ struct ixgbe_ethertype_table {
 struct ixgbe_filter_info {
 	/* shared EtherType (ETQF) slot table */
 	struct ixgbe_ethertype_table ethertype_table;
-	/* 1588 timestamping ETQF slot (valid when timesync_installed) */
-	bool timesync_installed;
-	uint8_t timesync_idx;
 	/* Tx anti-spoof ETQF slot (valid when antispoof_installed) */
 	bool antispoof_installed;
 	uint8_t antispoof_idx;
diff --git a/drivers/net/intel/ixgbe/ixgbe_rxtx.c b/drivers/net/intel/ixgbe/ixgbe_rxtx.c
index 4cf43fae16e..19018118834 100644
--- a/drivers/net/intel/ixgbe/ixgbe_rxtx.c
+++ b/drivers/net/intel/ixgbe/ixgbe_rxtx.c
@@ -1428,9 +1428,8 @@ ixgbe_rxd_pkt_info_to_pkt_flags(uint16_t pkt_info)
 		0, 0, 0,  RTE_MBUF_F_RX_FDIR,
 	};
 #ifdef RTE_LIBRTE_IEEE1588
-	static uint64_t ip_pkt_etqf_map[8] = {
-		0, 0, 0, RTE_MBUF_F_RX_IEEE1588_PTP,
-		0, 0, 0, 0,
+	static const uint64_t ip_pkt_etqf_map[IXGBE_MAX_ETQF_FILTERS] = {
+		[IXGBE_ETQF_FILTER_TIMESYNC] = RTE_MBUF_F_RX_IEEE1588_PTP,
 	};
 
 	if (likely(pkt_info & IXGBE_RXDADV_PKTTYPE_ETQF))
-- 
2.52.0

