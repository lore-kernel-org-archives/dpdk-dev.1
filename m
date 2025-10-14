Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 57458CCD184
	for <dpdk-dev@archiver.kernel.org>; Tue, 14 Oct 2025 16:13:21 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id D980240612;
	Tue, 14 Oct 2025 18:13:19 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
 by mails.dpdk.org (Postfix) with ESMTP id B4269402A8;
 Tue, 14 Oct 2025 18:13:17 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1760458398; x=1791994398;
 h=from:to:cc:subject:date:message-id:mime-version:
 content-transfer-encoding;
 bh=Bi6Nt/061tZhlpN62B5ECNUJ6U2U3Oi4xdzjrfz18Sc=;
 b=FuwgnPG9v3kNcZcHPBe1usDr5l2NLTG00itguSuL1N7OCiwamINnkZR8
 I/T2WzZuTxkyrrp/Nj8b+zbloKZI7MEOvOJ3pQopK6yzRAVS3gn4zWU5G
 fzMQhYpQpXAc6H6OKL2+qFBkJcUkxcK7mI+zhQcPV5Sp5s86Dey3WYOPW
 DZvaQ05zXDpBdRCrQJsqnfM549Bh7QmTFmrW2oBOjtd7uwG41fEsYjQN0
 FXtGHUgO4gb8XdIcEcY1DAVvRtJpd0eceFDeBQPVV77w7tlUw2RBYQjFI
 Kklh5XG7VDbD6NwjwIOMmk1KCMa6fFvK/ljDg78olga/YznnIvhIKbp+c A==;
X-CSE-ConnectionGUID: WScXPlhvQUGEXE1PnfUSLA==
X-CSE-MsgGUID: ibPx8nXeRT+rLEp47BoyKw==
X-IronPort-AV: E=McAfee;i="6800,10657,11582"; a="88085773"
X-IronPort-AV: E=Sophos;i="6.19,228,1754982000"; d="scan'208";a="88085773"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
 by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 14 Oct 2025 09:13:17 -0700
X-CSE-ConnectionGUID: CAbcpEd9RsmL36R0qcnr2w==
X-CSE-MsgGUID: uMadIm8CSdSDCLwvs7kwNA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,228,1754982000"; d="scan'208";a="212885809"
Received: from pae60.iind.intel.com ([10.49.105.174])
 by fmviesa001.fm.intel.com with ESMTP; 14 Oct 2025 09:13:15 -0700
From: Anurag Mandal <anurag.mandal@intel.com>
To: dev@dpdk.org
Cc: bruce.richardson@intel.com, Anurag Mandal <anurag.mandal@intel.com>,
 stable@dpdk.org
Subject: [PATCH] net/i40e: fix symmetric toeplitz hashing for SCTP
Date: Tue, 14 Oct 2025 21:37:18 +0530
Message-Id: <20251014160718.92171-1-anurag.mandal@intel.com>
X-Mailer: git-send-email 2.39.1
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

Fixes: 0e4ae6c7e864 ("net/i40e: fix symmetric toeplitz hashing for SCTP")
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
index 02e1457d80..661215d777 100644
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
+        }
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

