Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F1EACCCD19F
	for <dpdk-dev@archiver.kernel.org>; Mon, 20 Oct 2025 16:42:45 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 458B7402D3;
	Mon, 20 Oct 2025 18:42:45 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
 by mails.dpdk.org (Postfix) with ESMTP id CE414402B0
 for <dev@dpdk.org>; Mon, 20 Oct 2025 18:42:42 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1760978563; x=1792514563;
 h=from:to:cc:subject:date:message-id:mime-version:
 content-transfer-encoding;
 bh=pCuPMB7YmQQlXj1JOok6e9ixm1aZ3TWJ1kZPhqJHf2M=;
 b=i+uT8PsHiCC35z2q5OwI8f7StDoLkMunD0Q5nB/n/+9I08foSFo46xfi
 iB8LGHO5BDlDIfS0yG/KRsRCGogIWm4BME9TSu7ZI/V089O2eiseqVL2Z
 d7+LbFwylSFVfAbF2MpOEfWZBGb0zv81xo1xRhZc3fYZcsgCRUUKe8mJ2
 1Tf++vVJuMo4jWiYv9c64euVK5BJX/sY9lx1H1Je+RBg7y73L9djTC2AJ
 FEE5gVG2GNgO6nH/p/8EjMNyimX45Hmnf1aKu9nxM0JBISW+DFxkSaE1R
 oOj7EVKBVrckbpujRwOqMfO57Luf45QgJ23hKy00RD4UxVrStBmGLlLfp A==;
X-CSE-ConnectionGUID: AWWfSrCNRlqjLvji1e3iIA==
X-CSE-MsgGUID: NZ46g9e+StiFqgFnpx/+4Q==
X-IronPort-AV: E=McAfee;i="6800,10657,11586"; a="66960246"
X-IronPort-AV: E=Sophos;i="6.19,242,1754982000"; d="scan'208";a="66960246"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
 by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 20 Oct 2025 09:42:42 -0700
X-CSE-ConnectionGUID: da7tofLCS96ibnaxqS3TFQ==
X-CSE-MsgGUID: wrCSlv2XS3eafwO18lIo8w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,242,1754982000"; d="scan'208";a="207051676"
Received: from ae13-07.jf.intel.com ([10.166.188.76])
 by fmviesa002.fm.intel.com with ESMTP; 20 Oct 2025 09:42:42 -0700
From: Jeff Shaw <jeffrey.b.shaw@intel.com>
To: dev@dpdk.org
Cc: Jeff Shaw <jeffrey.b.shaw@intel.com>,
 Bruce Richardson <bruce.richardson@intel.com>,
 Anatoly Burakov <anatoly.burakov@intel.com>
Subject: [PATCH] Revert "net/ice: count drop-all filter in Rx stats"
Date: Mon, 20 Oct 2025 09:42:29 -0700
Message-Id: <20251020164230.3724539-1-jeffrey.b.shaw@intel.com>
X-Mailer: git-send-email 2.34.1
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

This reverts commit af05f9e37153c53335938bcde2978a359c5f4efa.

A side effect of this patch is that it also counts frames which
are dropped when the PF receives frames not destined for it when
promiscuous mode is disabled.

Signed-off-by: Jeff Shaw <jeffrey.b.shaw@intel.com>
---
 drivers/net/intel/ice/ice_ethdev.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/net/intel/ice/ice_ethdev.c b/drivers/net/intel/ice/ice_ethdev.c
index a9a49cd924..9d0fbd2a5a 100644
--- a/drivers/net/intel/ice/ice_ethdev.c
+++ b/drivers/net/intel/ice/ice_ethdev.c
@@ -6353,13 +6353,12 @@ ice_stats_get(struct rte_eth_dev *dev, struct rte_eth_stats *stats)
 
 	stats->ipackets = pf->main_vsi->eth_stats.rx_unicast +
 			  pf->main_vsi->eth_stats.rx_multicast +
-			  ns->eth.rx_unknown_protocol +
 			  pf->main_vsi->eth_stats.rx_broadcast -
 			  pf->main_vsi->eth_stats.rx_discards;
 	stats->opackets = ns->eth.tx_unicast +
 			  ns->eth.tx_multicast +
 			  ns->eth.tx_broadcast;
-	stats->ibytes   = ns->eth.rx_bytes;
+	stats->ibytes   = pf->main_vsi->eth_stats.rx_bytes;
 	stats->obytes   = ns->eth.tx_bytes;
 	stats->oerrors  = ns->eth.tx_errors +
 			  pf->main_vsi->eth_stats.tx_errors;
-- 
2.34.1

