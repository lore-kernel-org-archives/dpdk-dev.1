Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 66367C87FCA
	for <dpdk-dev@archiver.kernel.org>; Thu, 31 Jul 2025 04:42:30 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id DCC8A402E8;
	Thu, 31 Jul 2025 06:42:20 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
 by mails.dpdk.org (Postfix) with ESMTP id 78A3D402DB
 for <dev@dpdk.org>; Thu, 31 Jul 2025 06:42:18 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1753936938; x=1785472938;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=xrwZ2nwY92bEq+0yAKYODEd8QYXXGAkLpfRqNFSZjm8=;
 b=KAO8k0B+bER5KHCTRU5UJtdtzh5yaosbcfpgJsL0P9sZNntOY/IqpVtv
 8zoq+Pen3a8DApzMLO8qpAoxTAXDgqVVdo9dmCcDeDnSk2poSRjjvDe7l
 EXCZZV2D6I4XMtoSMsyq+UwDCCOGybPIj7qG46awLIrBhoZZQn/DVBk0w
 QUeQ1cJporAlpLCR2P3yZXshhI3/98hbm61aPq9RpfSkT5hx8b3HBHUJ9
 SmX0afjrXaO5X+k3pLMfYqjBTtMgv/9LDuofLVqM9/7qyN2ixpi46PzFp
 VjQfaa4falOpymbm8DsA37fKqXVIFamSpF84vxMFeFVUpUcC92kVh9fnz Q==;
X-CSE-ConnectionGUID: /6tcLonDQzuts3bB+YiHig==
X-CSE-MsgGUID: vDOZRuuLSLOXWnL7kTmboQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11507"; a="81702740"
X-IronPort-AV: E=Sophos;i="6.16,353,1744095600"; d="scan'208";a="81702740"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
 by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 30 Jul 2025 21:42:17 -0700
X-CSE-ConnectionGUID: e/3S+xwDRCyO/6zDiyenKg==
X-CSE-MsgGUID: NdHpah/YTFqsMzLgp21pcg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,353,1744095600"; d="scan'208";a="163614044"
Received: from unknown (HELO srv24..) ([10.138.182.231])
 by fmviesa008.fm.intel.com with ESMTP; 30 Jul 2025 21:42:16 -0700
From: Shaiq Wani <shaiq.wani@intel.com>
To: dev@dpdk.org,
	bruce.richardson@intel.com,
	aman.deep.singh@intel.com
Cc: Jeff Shaw <jeffrey.b.shaw@intel.com>
Subject: [PATCH 2/2] net/ice: count drop- all filter stats in Rx stats
Date: Thu, 31 Jul 2025 10:11:32 +0530
Message-Id: <20250731044132.110174-3-shaiq.wani@intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250731044132.110174-1-shaiq.wani@intel.com>
References: <20250731044132.110174-1-shaiq.wani@intel.com>
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

Packets dropped in the receive direction are counted as
"rx_unknown_protocol" (GLSWID_RUPP),these packets need to be added
to the "ipackets" and the GLV_GORCH/GLV_GORCL counters
need to be added to rx_bytes.

Signed-off-by: Jeff Shaw <jeffrey.b.shaw@intel.com>
Signed-off-by: Shaiq Wani <shaiq.wani@intel.com>
---
 drivers/net/intel/ice/ice_ethdev.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/net/intel/ice/ice_ethdev.c b/drivers/net/intel/ice/ice_ethdev.c
index 513777e372..0ebe58f858 100644
--- a/drivers/net/intel/ice/ice_ethdev.c
+++ b/drivers/net/intel/ice/ice_ethdev.c
@@ -6383,12 +6383,13 @@ ice_stats_get(struct rte_eth_dev *dev, struct rte_eth_stats *stats)
 
 	stats->ipackets = pf->main_vsi->eth_stats.rx_unicast +
 			  pf->main_vsi->eth_stats.rx_multicast +
+			  ns->eth.rx_unknown_protocol +
 			  pf->main_vsi->eth_stats.rx_broadcast -
 			  pf->main_vsi->eth_stats.rx_discards;
 	stats->opackets = ns->eth.tx_unicast +
 			  ns->eth.tx_multicast +
 			  ns->eth.tx_broadcast;
-	stats->ibytes   = pf->main_vsi->eth_stats.rx_bytes;
+	stats->ibytes   = ns->eth.rx_bytes;
 	stats->obytes   = ns->eth.tx_bytes;
 	stats->oerrors  = ns->eth.tx_errors +
 			  pf->main_vsi->eth_stats.tx_errors;
-- 
2.34.1

