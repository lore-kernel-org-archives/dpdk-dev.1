Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4D20DCAC5B0
	for <dpdk-dev@archiver.kernel.org>; Fri,  3 Oct 2025 12:41:03 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id A572940665;
	Fri,  3 Oct 2025 14:40:47 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
 by mails.dpdk.org (Postfix) with ESMTP id C64B54025D
 for <dev@dpdk.org>; Fri,  3 Oct 2025 14:40:44 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1759495245; x=1791031245;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=Bk2qGVFegcRu9XWPUEU+pyk6Y0btq9hWoRXKecJZlLI=;
 b=Tf//pp54I82Gm+yNarAEVjxpDJkj6ShcvZ+9QB4xDvXIL9BPoEsYkB6X
 Jckc6aPVTgQsUNEBodhQGxsh200KZ/O+DZnVCJcLf2grkrZ9l5hEjHyd7
 JwNZx7bQYMwGCZxqMtwVqiDEdI2bDMVDqCfiy1Pa2u+UW0rRwje3gA9CO
 vDrtC2Eu5tQaYmCuXl1LdX75SnwU2ZT42opNj4mPrLBl07hBNeTJxu3tq
 IdqVFAWhE4djH8sKDMjFPy52xcWq1lPd4B0DQ2YM1qTOCt9jqb1v1rD9m
 lNDcHxiRcpIkIFwXiEA36tclqCFiEpJzY1b9CTRj/9k9ypXC2//c1Gh5c w==;
X-CSE-ConnectionGUID: 4UoUT+htSsmWtfAxzLv4wA==
X-CSE-MsgGUID: C5AOYUBXTL24k6tyWUZtOg==
X-IronPort-AV: E=McAfee;i="6800,10657,11571"; a="72395407"
X-IronPort-AV: E=Sophos;i="6.18,312,1751266800"; d="scan'208";a="72395407"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
 by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 03 Oct 2025 05:40:44 -0700
X-CSE-ConnectionGUID: LYH+dwNFTIur+t6qFCRntg==
X-CSE-MsgGUID: TtKjVrkXQzOXfYsbDNy/yA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,312,1751266800"; d="scan'208";a="178572356"
Received: from silpixa00401176.ir.intel.com ([10.20.224.212])
 by orviesa010.jf.intel.com with ESMTP; 03 Oct 2025 05:40:44 -0700
From: Vladimir Medvedkin <vladimir.medvedkin@intel.com>
To: dev@dpdk.org
Cc: bruce.richardson@intel.com,
	anatoly.burakov@intel.com
Subject: [PATCH v5 3/3] net/ice: add PFC statistics
Date: Fri,  3 Oct 2025 12:40:37 +0000
Message-ID: <20251003124037.342760-4-vladimir.medvedkin@intel.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20251003124037.342760-1-vladimir.medvedkin@intel.com>
References: <20250817130152.682972-1-vladimir.medvedkin@intel.com>
 <20251003124037.342760-1-vladimir.medvedkin@intel.com>
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
index 6cfcc3a46e..0b193b1c31 100644
--- a/drivers/net/intel/ice/ice_ethdev.c
+++ b/drivers/net/intel/ice/ice_ethdev.c
@@ -389,6 +389,46 @@ static const struct ice_xstats_name_off ice_hw_port_strings[] = {
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
@@ -6641,6 +6681,29 @@ ice_read_stats_registers(struct ice_pf *pf, struct ice_hw *hw)
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

