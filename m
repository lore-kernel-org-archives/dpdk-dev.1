Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9A470CCD199
	for <dpdk-dev@archiver.kernel.org>; Wed, 15 Oct 2025 18:18:03 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id C404C4067E;
	Wed, 15 Oct 2025 20:18:02 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
 by mails.dpdk.org (Postfix) with ESMTP id 50D4140273;
 Wed, 15 Oct 2025 20:18:00 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1760552280; x=1792088280;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=81z2kwWQqd1OfQ5biPhTcup3rda96dHYeIAOzX6Jf+4=;
 b=HHijeajPa3XJTjJuLslpYER26d+u93FvOZXK4Es3xqeLfoxgFPlQBHyA
 2cOJRRzXvIMEsMmd+7QTitmOQwWEbaODuY/LM+i4rEuaP54oK0S9pZC5C
 SB84YtecNPkHL6pNmfzQmkXBBp0KPIc6TihApUj/j6VL1iyH7WsiZUVdv
 /qvXzGnRtn74P+b1JoYC7IjdCbdoGtOWZbgcEWbUWiDjTXjFzAgL//z64
 TGTa8ZJVp+jb8dAcBWrqBMSz4aDU4y+Dwi7xeaoK2u32EevWbDdi6gBYJ
 1g87gypFp1BLrK7v8jhBDlmwhDrVtepfrF03BDuTIteN14uq+kWa7yKnA g==;
X-CSE-ConnectionGUID: lxz3iYuRSOqrpFb0f0O6zw==
X-CSE-MsgGUID: tAMzESTGTgeCd7Pp/SqxGQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11583"; a="61944351"
X-IronPort-AV: E=Sophos;i="6.19,232,1754982000"; d="scan'208";a="61944351"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
 by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 15 Oct 2025 11:17:51 -0700
X-CSE-ConnectionGUID: IEN0zuiZR9OnuyTpmnsCKg==
X-CSE-MsgGUID: ACGQ80JtTS+tZUKy6Ljs8g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,232,1754982000"; d="scan'208";a="182033067"
Received: from pae60.iind.intel.com ([10.49.105.174])
 by orviesa007.jf.intel.com with ESMTP; 15 Oct 2025 11:17:49 -0700
From: Anurag Mandal <anurag.mandal@intel.com>
To: dev@dpdk.org
Cc: bruce.richardson@intel.com, Anurag Mandal <anurag.mandal@intel.com>,
 stable@dpdk.org
Subject: [PATCH v2] net/i40e: fix symmetric toeplitz hashing for SCTP
Date: Wed, 15 Oct 2025 23:41:50 +0530
Message-Id: <20251015181150.93621-1-anurag.mandal@intel.com>
X-Mailer: git-send-email 2.39.1
In-Reply-To: <20251014160718.92171-1-anurag.mandal@intel.com>
References: <20251014160718.92171-1-anurag.mandal@intel.com>
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

When symmetric toeplitz is configured for SCTP, packets belonging
to the same SCTP session are getting distributed to multiple queues
due to improper hash computation.

Removed SCTP Verification Tag from hash computation of symmetric toeplitz
as it changes for same SCTP session.

Tested the following with the fix & enabling symmetric toeplitz for SCTP:-
1. Packets belonging to the same SCTP session getting into the same queue.
2. Packets belonging to the different SCTP sessions getting distributed
to multiple queues.

Fixes: a14c6941fcb8 ("net/i40e: fix symmetric toeplitz hashing for SCTP")
Cc: stable@dpdk.org

Signed-off-by: Anurag Mandal <anurag.mandal@intel.com>
---
 .mailmap                           |  1 +
 drivers/net/intel/i40e/i40e_hash.c | 16 ++++++++++++++--
 2 files changed, 15 insertions(+), 2 deletions(-)

diff --git a/.mailmap b/.mailmap
index 0b043cb0c0..1f1265fe20 100644
--- a/.mailmap
+++ b/.mailmap
@@ -136,6 +136,7 @@ Anthony Harivel <aharivel@redhat.com>
 Antonio Fischetti <antonio.fischetti@intel.com>
 Anup Prabhu <aprabhu@marvell.com>
 Anupam Kapoor <anupam.kapoor@gmail.com>
+Anurag Mandal <anurag.mandal@intel.com>
 Apeksha Gupta <apeksha.gupta@nxp.com>
 Archana Muniganti <marchana@marvell.com> <muniganti.archana@caviumnetworks.com>
 Archit Pandey <architpandeynitk@gmail.com>
diff --git a/drivers/net/intel/i40e/i40e_hash.c b/drivers/net/intel/i40e/i40e_hash.c
index 02e1457d80..3149682197 100644
--- a/drivers/net/intel/i40e/i40e_hash.c
+++ b/drivers/net/intel/i40e/i40e_hash.c
@@ -561,7 +561,7 @@ i40e_hash_get_pattern_pctypes(const struct rte_eth_dev *dev,
 }
 
 static uint64_t
-i40e_hash_get_inset(uint64_t rss_types)
+i40e_hash_get_inset(uint64_t rss_types, bool symmetric_enable)
 {
 	uint64_t mask, inset = 0;
 	int i;
@@ -608,6 +608,17 @@ i40e_hash_get_inset(uint64_t rss_types)
 				 I40E_INSET_IPV4_SRC | I40E_INSET_IPV6_SRC);
 	}
 
+	/* SCTP Verification Tag is not required in hash computation for SYMMETRIC_TOEPLITZ */
+	if (symmetric_enable) {
+		mask = rss_types & RTE_ETH_RSS_NONFRAG_IPV4_SCTP;
+		if (mask == RTE_ETH_RSS_NONFRAG_IPV4_SCTP)
+			inset &= ~I40E_INSET_SCTP_VT;
+
+		mask = rss_types & RTE_ETH_RSS_NONFRAG_IPV6_SCTP;
+		if (mask == RTE_ETH_RSS_NONFRAG_IPV6_SCTP)
+			inset &= ~I40E_INSET_SCTP_VT;
+	}
+
 	return inset;
 }
 
@@ -1113,6 +1124,7 @@ i40e_hash_parse_pattern_act(const struct rte_eth_dev *dev,
 					  RTE_FLOW_ERROR_TYPE_ACTION_CONF,
 					  NULL,
 					  "RSS Queues not supported when pattern specified");
+	rss_conf->symmetric_enable = false;  /* by default, symmetric is disabled */
 
 	switch (rss_act->func) {
 	case RTE_ETH_HASH_FUNCTION_SYMMETRIC_TOEPLITZ:
@@ -1140,7 +1152,7 @@ i40e_hash_parse_pattern_act(const struct rte_eth_dev *dev,
 
 	rss_conf->conf.func = rss_act->func;
 	rss_conf->conf.types = rss_act->types;
-	rss_conf->inset = i40e_hash_get_inset(rss_act->types);
+	rss_conf->inset = i40e_hash_get_inset(rss_act->types, rss_conf->symmetric_enable);
 
 	return i40e_hash_get_pattern_pctypes(dev, pattern, rss_act,
 					     rss_conf, error);
-- 
2.39.1

