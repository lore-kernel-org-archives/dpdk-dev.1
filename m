Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 73C7BCA0EE4
	for <dpdk-dev@archiver.kernel.org>; Sun, 17 Aug 2025 13:02:38 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 8678740612;
	Sun, 17 Aug 2025 15:02:20 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.18])
 by mails.dpdk.org (Postfix) with ESMTP id 68F4740288
 for <dev@dpdk.org>; Sun, 17 Aug 2025 15:02:03 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1755435724; x=1786971724;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=Wqy5aOrCNnX2px9X5O00uteTfaRPfNJlLe8KXjZ3WgA=;
 b=Fe6//kg15BIgAZ6jD5GrFYS0XwQMABLOej2Ig63U7e4nDaVOj8jwKzDV
 PzzpnvFhSnLkTQElYVmcVGqV2GtsZgPkxNaEY2Tqcp4qKghIlpXIbzCYC
 KsQpa5OY3VdDOKOAipU0n3BPZqUcaJJ1XRr4HVlkyoSACJDPivemXh7aR
 g2+aT36M1Zs/4gDFsgwWUAPvZSWvbw709ioIEG72cTsXr5IA6TFsO9p4s
 zZDNUXXytFPcGGFrfIBYmA55CxNUI444TjgqB+ggxjwS3C9cdBopK6PrW
 bCW5FY7kjuccZ3iea3igDa98jhwIErOFRziMmvqRrLgyGqKDXlnHBDdPo g==;
X-CSE-ConnectionGUID: Q3i7i35tT1SrrhTo0wg8HQ==
X-CSE-MsgGUID: qKVSt0+jQ9WS4osEYQd27A==
X-IronPort-AV: E=McAfee;i="6800,10657,11524"; a="57756069"
X-IronPort-AV: E=Sophos;i="6.17,293,1747724400"; d="scan'208";a="57756069"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
 by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 17 Aug 2025 06:02:03 -0700
X-CSE-ConnectionGUID: x8/3GsQrQ3eCZnqdk+5y6Q==
X-CSE-MsgGUID: 1gmkQM2VRaOLUGJ/7a323g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.17,293,1747724400"; d="scan'208";a="171581478"
Received: from silpixa00401176.ir.intel.com (HELO
 silpixa00401176.ger.corp.intel.com) ([10.237.222.172])
 by fmviesa005.fm.intel.com with ESMTP; 17 Aug 2025 06:02:02 -0700
From: Vladimir Medvedkin <vladimir.medvedkin@intel.com>
To: dev@dpdk.org
Cc: bruce.richardson@intel.com,
	anatoly.burakov@intel.com
Subject: [PATCH v4 6/6] net/ice: add PFC statistics
Date: Sun, 17 Aug 2025 13:01:52 +0000
Message-ID: <20250817130152.682972-7-vladimir.medvedkin@intel.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250817130152.682972-1-vladimir.medvedkin@intel.com>
References: <20250812173252.507954-1-vladimir.medvedkin@intel.com>
 <20250817130152.682972-1-vladimir.medvedkin@intel.com>
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
index 62b7438218..8ab0da3549 100644
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

