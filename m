Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3D8F7CA1005
	for <dpdk-dev@archiver.kernel.org>; Tue,  2 Sep 2025 17:28:21 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 5323E40A71;
	Tue,  2 Sep 2025 19:27:37 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
 by mails.dpdk.org (Postfix) with ESMTP id 21D1F4066E
 for <dev@dpdk.org>; Tue,  2 Sep 2025 19:27:27 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1756834048; x=1788370048;
 h=from:to:subject:date:message-id:in-reply-to:references:
 mime-version:content-transfer-encoding;
 bh=0s6zDLwONntzs7iGF3CfdVlRIGirq7SHUaTIC/9K8oQ=;
 b=nixEqTZACo5RqDAY/T40RVipyb9sId2YRoTNU7laUBw7fv4pJIebnwQf
 EVeE6JJM4JvYBbYJ+4bkKAYXWM1KmvwqCI2mqNn3n2dfYkXLu8hamjoBN
 b1Aq1C6pg00c+4Rhmwd5JNoaVdxEd7k5Ata61n046V6HOE/xUjtIAtHv5
 QGsihJ/dcR+NPGmhQrdW7f5w/LtoAdDomJeQK95cHgarldCMGXyqKpdnt
 vJuewC3k+2lVVNywIjDN6Pk0OUtJ+FwuToTmrKNydddo0M4ZtA9B71A4l
 zDvZzAvd19mMHsEVs7fk2p0xsRsyzUGLAUcb+hA56UN05N14CHHBA2ra+ Q==;
X-CSE-ConnectionGUID: laqGNQD2Txi/UYM4Ac8qaw==
X-CSE-MsgGUID: C1aoDQBERVG8kDVByJ1u0g==
X-IronPort-AV: E=McAfee;i="6800,10657,11541"; a="69732024"
X-IronPort-AV: E=Sophos;i="6.18,233,1751266800"; d="scan'208";a="69732024"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
 by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 02 Sep 2025 10:27:27 -0700
X-CSE-ConnectionGUID: 4D9UBcXYRle4yq/OUscHWw==
X-CSE-MsgGUID: mMvpHgP9TP62c11sPbsoZA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,233,1751266800"; d="scan'208";a="171229140"
Received: from silpixa00401119.ir.intel.com ([10.55.129.167])
 by orviesa007.jf.intel.com with ESMTP; 02 Sep 2025 10:27:27 -0700
From: Anatoly Burakov <anatoly.burakov@intel.com>
To: dev@dpdk.org,
	Bruce Richardson <bruce.richardson@intel.com>
Subject: [PATCH v1 10/12] net/ice: count drop-all filter stats in Rx stats
Date: Tue,  2 Sep 2025 18:27:00 +0100
Message-ID: <8b65313e9b85aa1a27e429c5dfbc2875d0ab724d.1756833701.git.anatoly.burakov@intel.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <cover.1756833701.git.anatoly.burakov@intel.com>
References: 
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

From: Shaiq Wani <shaiq.wani@intel.com>

Packets dropped in the receive direction are counted as
"rx_unknown_protocol" (GLSWID_RUPP),these packets need to be added to the
"ipackets" and the GLV_GORCH/GLV_GORCL counters need to be added to
rx_bytes.

Signed-off-by: Jeff Shaw <jeffrey.b.shaw@intel.com>
Signed-off-by: Shaiq Wani <shaiq.wani@intel.com>
Signed-off-by: Anatoly Burakov <anatoly.burakov@intel.com>
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
2.47.3

