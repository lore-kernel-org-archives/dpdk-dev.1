Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7C459C5B543
	for <dpdk-dev@archiver.kernel.org>; Tue, 10 Jun 2025 06:42:02 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id BB971402D4;
	Tue, 10 Jun 2025 08:42:01 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
 by mails.dpdk.org (Postfix) with ESMTP id DFA1640299;
 Tue, 10 Jun 2025 08:41:59 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1749537720; x=1781073720;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=cplHAm6TEeLaDeOe0Jma5Oal4HHegIQILUUNSdwVDIk=;
 b=JM/CFJjRQsrcsjv+mBZikrTXxZbcdU7CfJhf3XuuXlXNIc8tGcuqFwnr
 m6K0xV0ArwPOWgwqnYmVxwp9h2mx5mY7CIvzmZ11smKw0mGJOhilGvYbx
 fdQnobA/50FMLw2K7gCVXhpTmI537x6zaDkdyNPpqCvDs56aDBHkATw+F
 QwfDnfKXIMEjrKpitogozhkEn1nQ/9cOVj1wSoqrTFxyFvzpCTbmd2tWI
 nVgAqnsIpcgp3Bwzoi0Cwlsq9NvD9jDXl15mdL0Aa/F8sLlaLuRNB5K18
 qx4Xra/Oaj5mv/6sPIx+0Qq4xz5fZRIRZ9cEg4cy8M5gb0idfHenjeGpe Q==;
X-CSE-ConnectionGUID: E1ktzfwTRkWY2w3r8JXH3w==
X-CSE-MsgGUID: PRJrg/gQSUiz4TP3ow+blQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11459"; a="55424896"
X-IronPort-AV: E=Sophos;i="6.16,224,1744095600"; d="scan'208";a="55424896"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
 by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 09 Jun 2025 23:41:59 -0700
X-CSE-ConnectionGUID: T+HWIWX6Re6ThxRMhT2xrQ==
X-CSE-MsgGUID: tc6aarvZReGvIx2ZnAEJMg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,224,1744095600"; d="scan'208";a="147248999"
Received: from shwdenpg561.ccr.corp.intel.com (HELO dpdk..) ([10.239.252.3])
 by fmviesa010-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 09 Jun 2025 23:41:57 -0700
From: Kaiwen Deng <kaiwenx.deng@intel.com>
To: dev@dpdk.org
Cc: stable@dpdk.org, Kaiwen Deng <kaiwenx.deng@intel.com>,
 Anatoly Burakov <anatoly.burakov@intel.com>,
 Vladimir Medvedkin <vladimir.medvedkin@intel.com>,
 Tiwei Bie <tiwei.bie@intel.com>, Wenzhuo Lu <wenzhuo.lu@intel.com>
Subject: [PATCH] net/ixgbe: fix unexpected data in the xstats info
Date: Tue, 10 Jun 2025 13:42:25 +0800
Message-Id: <20250610054225.988840-1-kaiwenx.deng@intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250520011316.561890-1-kaiwenx.deng@intel.com>
References: <20250520011316.561890-1-kaiwenx.deng@intel.com>
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

E610 device does not support MACsec.

This commit will excluding MACsec stats from the xstats info
display for E610 device.

Fixes: b35d309710fe ("net/ixgbe: add MACsec offload")
Cc: stable@dpdk.org

Signed-off-by: Kaiwen Deng <kaiwenx.deng@intel.com>
---
 drivers/net/intel/ixgbe/ixgbe_ethdev.c | 121 ++++++++++++++-----------
 1 file changed, 67 insertions(+), 54 deletions(-)

diff --git a/drivers/net/intel/ixgbe/ixgbe_ethdev.c b/drivers/net/intel/ixgbe/ixgbe_ethdev.c
index 0fa4898aba..130a23cd9d 100644
--- a/drivers/net/intel/ixgbe/ixgbe_ethdev.c
+++ b/drivers/net/intel/ixgbe/ixgbe_ethdev.c
@@ -3354,38 +3354,40 @@ ixgbe_read_stats_registers(struct ixgbe_hw *hw,
 					IXGBE_FDIRFSTAT) >> 16) & 0xFFFF;
 	}
 	/* MACsec Stats registers */
-	macsec_stats->out_pkts_untagged += IXGBE_READ_REG(hw, IXGBE_LSECTXUT);
-	macsec_stats->out_pkts_encrypted +=
-		IXGBE_READ_REG(hw, IXGBE_LSECTXPKTE);
-	macsec_stats->out_pkts_protected +=
-		IXGBE_READ_REG(hw, IXGBE_LSECTXPKTP);
-	macsec_stats->out_octets_encrypted +=
-		IXGBE_READ_REG(hw, IXGBE_LSECTXOCTE);
-	macsec_stats->out_octets_protected +=
-		IXGBE_READ_REG(hw, IXGBE_LSECTXOCTP);
-	macsec_stats->in_pkts_untagged += IXGBE_READ_REG(hw, IXGBE_LSECRXUT);
-	macsec_stats->in_pkts_badtag += IXGBE_READ_REG(hw, IXGBE_LSECRXBAD);
-	macsec_stats->in_pkts_nosci += IXGBE_READ_REG(hw, IXGBE_LSECRXNOSCI);
-	macsec_stats->in_pkts_unknownsci +=
-		IXGBE_READ_REG(hw, IXGBE_LSECRXUNSCI);
-	macsec_stats->in_octets_decrypted +=
-		IXGBE_READ_REG(hw, IXGBE_LSECRXOCTD);
-	macsec_stats->in_octets_validated +=
-		IXGBE_READ_REG(hw, IXGBE_LSECRXOCTV);
-	macsec_stats->in_pkts_unchecked += IXGBE_READ_REG(hw, IXGBE_LSECRXUNCH);
-	macsec_stats->in_pkts_delayed += IXGBE_READ_REG(hw, IXGBE_LSECRXDELAY);
-	macsec_stats->in_pkts_late += IXGBE_READ_REG(hw, IXGBE_LSECRXLATE);
-	for (i = 0; i < 2; i++) {
-		macsec_stats->in_pkts_ok +=
-			IXGBE_READ_REG(hw, IXGBE_LSECRXOK(i));
-		macsec_stats->in_pkts_invalid +=
-			IXGBE_READ_REG(hw, IXGBE_LSECRXINV(i));
-		macsec_stats->in_pkts_notvalid +=
-			IXGBE_READ_REG(hw, IXGBE_LSECRXNV(i));
-	}
-	macsec_stats->in_pkts_unusedsa += IXGBE_READ_REG(hw, IXGBE_LSECRXUNSA);
-	macsec_stats->in_pkts_notusingsa +=
-		IXGBE_READ_REG(hw, IXGBE_LSECRXNUSA);
+	if (hw->mac.type != ixgbe_mac_E610) {
+		macsec_stats->out_pkts_untagged += IXGBE_READ_REG(hw, IXGBE_LSECTXUT);
+		macsec_stats->out_pkts_encrypted +=
+			IXGBE_READ_REG(hw, IXGBE_LSECTXPKTE);
+		macsec_stats->out_pkts_protected +=
+			IXGBE_READ_REG(hw, IXGBE_LSECTXPKTP);
+		macsec_stats->out_octets_encrypted +=
+			IXGBE_READ_REG(hw, IXGBE_LSECTXOCTE);
+		macsec_stats->out_octets_protected +=
+			IXGBE_READ_REG(hw, IXGBE_LSECTXOCTP);
+		macsec_stats->in_pkts_untagged += IXGBE_READ_REG(hw, IXGBE_LSECRXUT);
+		macsec_stats->in_pkts_badtag += IXGBE_READ_REG(hw, IXGBE_LSECRXBAD);
+		macsec_stats->in_pkts_nosci += IXGBE_READ_REG(hw, IXGBE_LSECRXNOSCI);
+		macsec_stats->in_pkts_unknownsci +=
+			IXGBE_READ_REG(hw, IXGBE_LSECRXUNSCI);
+		macsec_stats->in_octets_decrypted +=
+			IXGBE_READ_REG(hw, IXGBE_LSECRXOCTD);
+		macsec_stats->in_octets_validated +=
+			IXGBE_READ_REG(hw, IXGBE_LSECRXOCTV);
+		macsec_stats->in_pkts_unchecked += IXGBE_READ_REG(hw, IXGBE_LSECRXUNCH);
+		macsec_stats->in_pkts_delayed += IXGBE_READ_REG(hw, IXGBE_LSECRXDELAY);
+		macsec_stats->in_pkts_late += IXGBE_READ_REG(hw, IXGBE_LSECRXLATE);
+		for (i = 0; i < 2; i++) {
+			macsec_stats->in_pkts_ok +=
+				IXGBE_READ_REG(hw, IXGBE_LSECRXOK(i));
+			macsec_stats->in_pkts_invalid +=
+				IXGBE_READ_REG(hw, IXGBE_LSECRXINV(i));
+			macsec_stats->in_pkts_notvalid +=
+				IXGBE_READ_REG(hw, IXGBE_LSECRXNV(i));
+		}
+		macsec_stats->in_pkts_unusedsa += IXGBE_READ_REG(hw, IXGBE_LSECRXUNSA);
+		macsec_stats->in_pkts_notusingsa +=
+			IXGBE_READ_REG(hw, IXGBE_LSECRXNUSA);
+	}
 }
 
 /*
@@ -3478,15 +3480,19 @@ ixgbe_dev_stats_reset(struct rte_eth_dev *dev)
 	(IXGBE_NB_TXQ_PRIO_STATS * IXGBE_NB_TXQ_PRIO_VALUES))
 
 static unsigned
-ixgbe_xstats_calc_num(void)
+ixgbe_xstats_calc_num(struct rte_eth_dev *dev)
 {
+	struct ixgbe_hw *hw = IXGBE_DEV_PRIVATE_TO_HW(dev->data->dev_private);
+	if (hw->mac.type == ixgbe_mac_E610)
+		return IXGBE_XSTATS_CALC_NUM - IXGBE_NB_MACSEC_STATS;
 	return IXGBE_XSTATS_CALC_NUM;
 }
 
-static int ixgbe_dev_xstats_get_names(__rte_unused struct rte_eth_dev *dev,
+static int ixgbe_dev_xstats_get_names(struct rte_eth_dev *dev,
 	struct rte_eth_xstat_name *xstats_names, __rte_unused unsigned int size)
 {
-	const unsigned cnt_stats = ixgbe_xstats_calc_num();
+	struct ixgbe_hw *hw = IXGBE_DEV_PRIVATE_TO_HW(dev->data->dev_private);
+	const unsigned int cnt_stats = ixgbe_xstats_calc_num(dev);
 	unsigned stat, i, count;
 
 	if (xstats_names != NULL) {
@@ -3505,11 +3511,13 @@ static int ixgbe_dev_xstats_get_names(__rte_unused struct rte_eth_dev *dev,
 		}
 
 		/* MACsec Stats */
-		for (i = 0; i < IXGBE_NB_MACSEC_STATS; i++) {
-			strlcpy(xstats_names[count].name,
-				rte_ixgbe_macsec_strings[i].name,
-				sizeof(xstats_names[count].name));
-			count++;
+		if (hw->mac.type != ixgbe_mac_E610) {
+			for (i = 0; i < IXGBE_NB_MACSEC_STATS; i++) {
+				strlcpy(xstats_names[count].name,
+					rte_ixgbe_macsec_strings[i].name,
+					sizeof(xstats_names[count].name));
+				count++;
+			}
 		}
 
 		/* RX Priority Stats */
@@ -3544,7 +3552,8 @@ static int ixgbe_dev_xstats_get_names_by_id(
 	unsigned int limit)
 {
 	if (!ids) {
-		const unsigned int cnt_stats = ixgbe_xstats_calc_num();
+		struct ixgbe_hw *hw = IXGBE_DEV_PRIVATE_TO_HW(dev->data->dev_private);
+		const unsigned int cnt_stats = ixgbe_xstats_calc_num(dev);
 		unsigned int stat, i, count;
 
 		if (xstats_names != NULL) {
@@ -3563,11 +3572,13 @@ static int ixgbe_dev_xstats_get_names_by_id(
 			}
 
 			/* MACsec Stats */
-			for (i = 0; i < IXGBE_NB_MACSEC_STATS; i++) {
-				strlcpy(xstats_names[count].name,
-					rte_ixgbe_macsec_strings[i].name,
-					sizeof(xstats_names[count].name));
-				count++;
+			if (hw->mac.type != ixgbe_mac_E610) {
+				for (i = 0; i < IXGBE_NB_MACSEC_STATS; i++) {
+					strlcpy(xstats_names[count].name,
+						rte_ixgbe_macsec_strings[i].name,
+						sizeof(xstats_names[count].name));
+					count++;
+				}
 			}
 
 			/* RX Priority Stats */
@@ -3643,7 +3654,7 @@ ixgbe_dev_xstats_get(struct rte_eth_dev *dev, struct rte_eth_xstat *xstats,
 	uint64_t total_missed_rx, total_qbrc, total_qprc, total_qprdc;
 	unsigned i, stat, count = 0;
 
-	count = ixgbe_xstats_calc_num();
+	count = ixgbe_xstats_calc_num(dev);
 
 	if (n < count)
 		return count;
@@ -3672,11 +3683,13 @@ ixgbe_dev_xstats_get(struct rte_eth_dev *dev, struct rte_eth_xstat *xstats,
 	}
 
 	/* MACsec Stats */
-	for (i = 0; i < IXGBE_NB_MACSEC_STATS; i++) {
-		xstats[count].value = *(uint64_t *)(((char *)macsec_stats) +
-				rte_ixgbe_macsec_strings[i].offset);
-		xstats[count].id = count;
-		count++;
+	if (hw->mac.type != ixgbe_mac_E610) {
+		for (i = 0; i < IXGBE_NB_MACSEC_STATS; i++) {
+			xstats[count].value = *(uint64_t *)(((char *)macsec_stats) +
+					rte_ixgbe_macsec_strings[i].offset);
+			xstats[count].id = count;
+			count++;
+		}
 	}
 
 	/* RX Priority Stats */
@@ -3719,7 +3732,7 @@ ixgbe_dev_xstats_get_by_id(struct rte_eth_dev *dev, const uint64_t *ids,
 		uint64_t total_missed_rx, total_qbrc, total_qprc, total_qprdc;
 		unsigned int i, stat, count = 0;
 
-		count = ixgbe_xstats_calc_num();
+		count = ixgbe_xstats_calc_num(dev);
 
 		if (!ids && n < count)
 			return count;
@@ -3803,7 +3816,7 @@ ixgbe_dev_xstats_reset(struct rte_eth_dev *dev)
 			IXGBE_DEV_PRIVATE_TO_MACSEC_STATS(
 				dev->data->dev_private);
 
-	unsigned count = ixgbe_xstats_calc_num();
+	unsigned int count = ixgbe_xstats_calc_num(dev);
 
 	/* HW registers are cleared on read */
 	ixgbe_dev_xstats_get(dev, NULL, count);
-- 
2.34.1

