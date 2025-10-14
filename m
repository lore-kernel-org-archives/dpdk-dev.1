Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 22BC6CCD187
	for <dpdk-dev@archiver.kernel.org>; Tue, 14 Oct 2025 05:44:15 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 09B4D402A0;
	Tue, 14 Oct 2025 07:44:15 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
 by mails.dpdk.org (Postfix) with ESMTP id D0F8F40288;
 Tue, 14 Oct 2025 07:44:13 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1760420654; x=1791956654;
 h=from:to:cc:subject:date:message-id:mime-version:
 content-transfer-encoding;
 bh=/vE4DhxHzvZl6NHQLDMkJpQeysb0mxCxoVLauUBl2to=;
 b=XwFxSMQuLAMhAJYB4yQniLdfU+6Ax7CPAb7jk37MAu4JpCruWCHBVbvf
 tAGpE+on2Z4tfojbrRUsif6jAvPuWphNv+4Mkg826welcvj2UzCrGw1rT
 O2qBLEVk12tgsN/N3o+7llF0wxQxaILsONrC8SGQnux/tX/XYtAyyST7D
 D36xyoVp2XcSY/6cuKLQcGpJCBjCIGI//Qcn53WLfg+pJ+HvnJ/Eg1OQU
 b5a1oTQSOkqDwnDV2E0RKT51uiavyc4w6k+ejpk26ylq6ezdDnLDCk65O
 DMN/abYDTlVwKdGwGELslxbnEvct3iIiSKwC4a6Yl3qI/0tW51sXkaBk9 g==;
X-CSE-ConnectionGUID: vjLcSQ0aSO60B8OzQpAPeg==
X-CSE-MsgGUID: QqPWR6TuTXePH82SyNPMdg==
X-IronPort-AV: E=McAfee;i="6800,10657,11581"; a="65194070"
X-IronPort-AV: E=Sophos;i="6.19,227,1754982000"; d="scan'208";a="65194070"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
 by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 13 Oct 2025 22:44:13 -0700
X-CSE-ConnectionGUID: FrJfAb5aRGSzBxTrEQ8cbg==
X-CSE-MsgGUID: vNk00O/0TtugSgjzJjTY0w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,227,1754982000"; d="scan'208";a="181350192"
Received: from unknown (HELO srv24..) ([10.138.182.231])
 by orviesa009.jf.intel.com with ESMTP; 13 Oct 2025 22:44:11 -0700
From: Shaiq Wani <shaiq.wani@intel.com>
To: dev@dpdk.org,
	bruce.richardson@intel.com,
	aman.deep.singh@intel.com
Cc: stable@dpdk.org
Subject: [PATCH] net/ice: revert count drop-all filter in Rx stats
Date: Tue, 14 Oct 2025 11:13:24 +0530
Message-Id: <20251014054324.3908737-1-shaiq.wani@intel.com>
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

This reverts commit af05f9e37153c53335938bcde2978a359c5f4efa

This patch caused testpmd to count packets not destined for our MAC
even when promiscuous mode is off.This behaviour is inconsistent with
other drivers and leads to incorrect Rx statistics.

Fixes: af05f9e ("net/ice: count drop-all filter in Rx stats")
Cc: stable@dpdk.org

Signed-off-by: Shaiq Wani <shaiq.wani@intel.com>
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

