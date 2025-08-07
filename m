Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 956E4C87FCA
	for <dpdk-dev@archiver.kernel.org>; Thu,  7 Aug 2025 12:23:22 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 62DD540669;
	Thu,  7 Aug 2025 14:22:53 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
 by mails.dpdk.org (Postfix) with ESMTP id C981040652
 for <dev@dpdk.org>; Thu,  7 Aug 2025 14:22:49 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1754569370; x=1786105370;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=o+NE3dLLM570idv5IU8m9CYGxo7jmNrTxDXAcBGaDzk=;
 b=XZeAY7k8mav3XIYh82j4HyJ7U17i4+mTr1/naPBvtbkuU1i6ntvIA+dn
 jgkWScCyAMzdECwYv7BHG2n+iXuxJjFLhNjXsdD/drr3drONCRDZXZfAo
 RQ8ZpFHdcHaBoNGhCt1HUP9U1HciuwcgVMQ/LYKjbr5ICuhA/B3SgrTBv
 gVnsEGZHikGsAc5gJ00Up6hb/ALIhFowDBPxYCPblxJAmIC643OBvZJDL
 tSE34OWPwKNoOkaQ/kx0uhT4WytWM9CguysstXUwpjyPXcf7C4SNHjBt2
 bSzLH0dJxy4BKUlaNwZWFsA/5a5NrOv25YccUeG7ml13WD6ZFEvWUVGrd g==;
X-CSE-ConnectionGUID: bQ91eiR1RnSlt1qbZp7ETg==
X-CSE-MsgGUID: 2Kd7gi9XQvGkb0AXqfRTAg==
X-IronPort-AV: E=McAfee;i="6800,10657,11514"; a="59517173"
X-IronPort-AV: E=Sophos;i="6.17,271,1747724400"; d="scan'208";a="59517173"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
 by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 07 Aug 2025 05:22:50 -0700
X-CSE-ConnectionGUID: +IS+0AUKS/6jitIrqdcgvw==
X-CSE-MsgGUID: acR+OupcQESQ6sjjYHncaQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.17,271,1747724400"; d="scan'208";a="169171656"
Received: from silpixa00401176.ir.intel.com (HELO
 silpixa00401176.ger.corp.intel.com) ([10.237.222.172])
 by fmviesa003.fm.intel.com with ESMTP; 07 Aug 2025 05:22:48 -0700
From: Vladimir Medvedkin <vladimir.medvedkin@intel.com>
To: dev@dpdk.org
Cc: bruce.richardson@intel.com,
	anatoly.burakov@intel.com
Subject: [PATCH 6/6] net/ice: add PFC statistics
Date: Thu,  7 Aug 2025 12:22:37 +0000
Message-ID: <20250807122238.334177-7-vladimir.medvedkin@intel.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250807122238.334177-1-vladimir.medvedkin@intel.com>
References: <20250807122238.334177-1-vladimir.medvedkin@intel.com>
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
index b3be2e7c7e..7ac1c0872a 100644
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
@@ -6669,6 +6709,29 @@ ice_read_stats_registers(struct ice_pf *pf, struct ice_hw *hw)
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

