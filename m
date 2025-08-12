Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7F1EFCA0EC4
	for <dpdk-dev@archiver.kernel.org>; Tue, 12 Aug 2025 17:33:39 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 8BB0340666;
	Tue, 12 Aug 2025 19:33:14 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
 by mails.dpdk.org (Postfix) with ESMTP id DC8D140659
 for <dev@dpdk.org>; Tue, 12 Aug 2025 19:33:12 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1755019993; x=1786555993;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=9trfNNjNVtDJICizGPFUNl2oKyrd82Mlv/JJjVq0dRs=;
 b=mjW78y5lwMoTSuYC67L1vL66BJzRYZQkZ2XvGb385nCQMfZ1ml/jE8uk
 oMYUfVls31muMVD9hRHcAJIL9epAUG9KpPcLPbta8Lmhs3CIOxyqIInW/
 dHt//Yk5dWXYEf9XNP7e0lE8qG5QcJDabdtKaf7mTap0HkmFre2K1ov3o
 FEqlSOxEcg0w7uufrGH6Lo/jK/sM+RcnqNFXX2uMhWNXoGarKz40dKUlO
 KEM+PNy4VvbaKNYS36MI9l9Lr+KRUE1ZMRVpLOf8bdfJsLR3ZgS4VKCBL
 KTxV044UXnu0bhF/lYjJG45lj7EIKOGiBxWCwFk3cj9eiKmP2idM3NF41 A==;
X-CSE-ConnectionGUID: 49OIDuiRTdOjGNqefFeCgg==
X-CSE-MsgGUID: T0SpSCuDRJKxn/sQYyTKUQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11520"; a="74751918"
X-IronPort-AV: E=Sophos;i="6.17,284,1747724400"; d="scan'208";a="74751918"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
 by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 12 Aug 2025 10:33:12 -0700
X-CSE-ConnectionGUID: /0HinYElRMm01rCFlslyew==
X-CSE-MsgGUID: 7/I1VyMRS3yDdd7XrF7zoQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.17,284,1747724400"; d="scan'208";a="170472963"
Received: from unknown (HELO silpixa00401176.ger.corp.intel.com)
 ([10.237.222.172])
 by fmviesa005.fm.intel.com with ESMTP; 12 Aug 2025 10:33:03 -0700
From: Vladimir Medvedkin <vladimir.medvedkin@intel.com>
To: dev@dpdk.org
Cc: bruce.richardson@intel.com,
	anatoly.burakov@intel.com
Subject: [PATCH v3 6/6] net/ice: add PFC statistics
Date: Tue, 12 Aug 2025 17:32:52 +0000
Message-ID: <20250812173252.507954-7-vladimir.medvedkin@intel.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250812173252.507954-1-vladimir.medvedkin@intel.com>
References: <20250811134301.459523-1-vladimir.medvedkin@intel.com>
 <20250812173252.507954-1-vladimir.medvedkin@intel.com>
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

Expose PFC statistics in xstats.

Signed-off-by: Vladimir Medvedkin <vladimir.medvedkin@intel.com>
---
 drivers/net/intel/ice/ice_ethdev.c | 63 ++++++++++++++++++++++++++++++
 1 file changed, 63 insertions(+)

diff --git a/drivers/net/intel/ice/ice_ethdev.c b/drivers/net/intel/ice/ice_ethdev.c
index a9cc2dc65b..ddd13952b3 100644
--- a/drivers/net/intel/ice/ice_ethdev.c
+++ b/drivers/net/intel/ice/ice_ethdev.c
@@ -380,6 +380,46 @@ static const struct ice_xstats_name_off ice_hw_port_strings[] = {
 	{"rx_xon_packets", offsetof(struct ice_hw_port_stats, link_xon_rx)},
 	{"tx_xoff_packets", offsetof(struct ice_hw_port_stats, link_xoff_tx)},
 	{"rx_xoff_packets", offsetof(struct ice_hw_port_stats, link_xoff_rx)},
+	{"priority_xon_rx_tc0", offsetof(struct ice_hw_port_stats, priority_xon_rx[0])},
+	{"priority_xon_rx_tc1", offsetof(struct ice_hw_port_stats, priority_xon_rx[1])},
+	{"priority_xon_rx_tc2", offsetof(struct ice_hw_port_stats, priority_xon_rx[2])},
+	{"priority_xon_rx_tc3", offsetof(struct ice_hw_port_stats, priority_xon_rx[3])},
+	{"priority_xon_rx_tc4", offsetof(struct ice_hw_port_stats, priority_xon_rx[4])},
+	{"priority_xon_rx_tc5", offsetof(struct ice_hw_port_stats, priority_xon_rx[5])},
+	{"priority_xon_rx_tc6", offsetof(struct ice_hw_port_stats, priority_xon_rx[6])},
+	{"priority_xon_rx_tc7", offsetof(struct ice_hw_port_stats, priority_xon_rx[7])},
+	{"priority_xoff_rx_tc0", offsetof(struct ice_hw_port_stats, priority_xoff_rx[0])},
+	{"priority_xoff_rx_tc1", offsetof(struct ice_hw_port_stats, priority_xoff_rx[1])},
+	{"priority_xoff_rx_tc2", offsetof(struct ice_hw_port_stats, priority_xoff_rx[2])},
+	{"priority_xoff_rx_tc3", offsetof(struct ice_hw_port_stats, priority_xoff_rx[3])},
+	{"priority_xoff_rx_tc4", offsetof(struct ice_hw_port_stats, priority_xoff_rx[4])},
+	{"priority_xoff_rx_tc5", offsetof(struct ice_hw_port_stats, priority_xoff_rx[5])},
+	{"priority_xoff_rx_tc6", offsetof(struct ice_hw_port_stats, priority_xoff_rx[6])},
+	{"priority_xoff_rx_tc7", offsetof(struct ice_hw_port_stats, priority_xoff_rx[7])},
+	{"priority_xon_tx_tc0", offsetof(struct ice_hw_port_stats, priority_xon_tx[0])},
+	{"priority_xon_tx_tc1", offsetof(struct ice_hw_port_stats, priority_xon_tx[1])},
+	{"priority_xon_tx_tc2", offsetof(struct ice_hw_port_stats, priority_xon_tx[2])},
+	{"priority_xon_tx_tc3", offsetof(struct ice_hw_port_stats, priority_xon_tx[3])},
+	{"priority_xon_tx_tc4", offsetof(struct ice_hw_port_stats, priority_xon_tx[4])},
+	{"priority_xon_tx_tc5", offsetof(struct ice_hw_port_stats, priority_xon_tx[5])},
+	{"priority_xon_tx_tc6", offsetof(struct ice_hw_port_stats, priority_xon_tx[6])},
+	{"priority_xon_tx_tc7", offsetof(struct ice_hw_port_stats, priority_xon_tx[7])},
+	{"priority_xoff_tx_tc0", offsetof(struct ice_hw_port_stats, priority_xoff_tx[0])},
+	{"priority_xoff_tx_tc1", offsetof(struct ice_hw_port_stats, priority_xoff_tx[1])},
+	{"priority_xoff_tx_tc2", offsetof(struct ice_hw_port_stats, priority_xoff_tx[2])},
+	{"priority_xoff_tx_tc3", offsetof(struct ice_hw_port_stats, priority_xoff_tx[3])},
+	{"priority_xoff_tx_tc4", offsetof(struct ice_hw_port_stats, priority_xoff_tx[4])},
+	{"priority_xoff_tx_tc5", offsetof(struct ice_hw_port_stats, priority_xoff_tx[5])},
+	{"priority_xoff_tx_tc6", offsetof(struct ice_hw_port_stats, priority_xoff_tx[6])},
+	{"priority_xoff_tx_tc7", offsetof(struct ice_hw_port_stats, priority_xoff_tx[7])},
+	{"priority_xon_2_xoff_tc0", offsetof(struct ice_hw_port_stats, priority_xon_2_xoff[0])},
+	{"priority_xon_2_xoff_tc1", offsetof(struct ice_hw_port_stats, priority_xon_2_xoff[0])},
+	{"priority_xon_2_xoff_tc2", offsetof(struct ice_hw_port_stats, priority_xon_2_xoff[0])},
+	{"priority_xon_2_xoff_tc3", offsetof(struct ice_hw_port_stats, priority_xon_2_xoff[0])},
+	{"priority_xon_2_xoff_tc4", offsetof(struct ice_hw_port_stats, priority_xon_2_xoff[0])},
+	{"priority_xon_2_xoff_tc5", offsetof(struct ice_hw_port_stats, priority_xon_2_xoff[0])},
+	{"priority_xon_2_xoff_tc6", offsetof(struct ice_hw_port_stats, priority_xon_2_xoff[0])},
+	{"priority_xon_2_xoff_tc7", offsetof(struct ice_hw_port_stats, priority_xon_2_xoff[0])},
 	{"rx_size_64_packets", offsetof(struct ice_hw_port_stats, rx_size_64)},
 	{"rx_size_65_to_127_packets", offsetof(struct ice_hw_port_stats,
 		rx_size_127)},
@@ -6671,6 +6711,29 @@ ice_read_stats_registers(struct ice_pf *pf, struct ice_hw *hw)
 	/* GLPRT_MSPDC not supported */
 	/* GLPRT_XEC not supported */
 
+	for (int i = 0; i < ICE_MAX_TRAFFIC_CLASS; i++) {
+		ice_stat_update_40(hw, GLPRT_PXONRXC_H(hw->port_info->lport, i),
+			   GLPRT_PXONRXC(hw->port_info->lport, i),
+			   pf->offset_loaded, &os->priority_xon_rx[i],
+			   &ns->priority_xon_rx[i]);
+		ice_stat_update_40(hw, GLPRT_PXONTXC_H(hw->port_info->lport, i),
+			   GLPRT_PXONTXC(hw->port_info->lport, i),
+			   pf->offset_loaded, &os->priority_xon_tx[i],
+			   &ns->priority_xon_tx[i]);
+		ice_stat_update_40(hw, GLPRT_PXOFFRXC_H(hw->port_info->lport, i),
+			   GLPRT_PXOFFRXC(hw->port_info->lport, i),
+			   pf->offset_loaded, &os->priority_xoff_rx[i],
+			   &ns->priority_xoff_rx[i]);
+		ice_stat_update_40(hw, GLPRT_PXOFFTXC_H(hw->port_info->lport, i),
+			   GLPRT_PXOFFTXC(hw->port_info->lport, i),
+			   pf->offset_loaded, &os->priority_xoff_tx[i],
+			   &ns->priority_xoff_tx[i]);
+		ice_stat_update_40(hw, GLPRT_RXON2OFFCNT_H(hw->port_info->lport, i),
+			   GLPRT_RXON2OFFCNT(hw->port_info->lport, i),
+			   pf->offset_loaded, &os->priority_xon_2_xoff[i],
+			   &ns->priority_xon_2_xoff[i]);
+	}
+
 	pf->offset_loaded = true;
 
 	if (pf->main_vsi)
-- 
2.43.0

