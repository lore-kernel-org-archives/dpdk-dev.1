Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2A668CD98C7
	for <dpdk-dev@archiver.kernel.org>; Mon, 15 Jun 2026 11:02:04 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 25CED436D4;
	Mon, 15 Jun 2026 13:02:03 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
 by mails.dpdk.org (Postfix) with ESMTP id 586E9400D5
 for <dev@dpdk.org>; Mon, 15 Jun 2026 13:02:01 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1781521322; x=1813057322;
 h=from:to:subject:date:message-id:mime-version:
 content-transfer-encoding;
 bh=zktKgxvAa+Gen/mg1HwCebJgRJEmpxEJKZFNhJCMJaE=;
 b=LOIZWXjaYTGySszRiqH9h1wsF3L32TLK3+CA7V6q7n5DH5i9PwI1QuF7
 Yk8PbD4FyrQL2hC35TgXL0VONR82GkQZK8CJmiS71m2sZ7ljCabyZlMZe
 td+8Ibu0u1Ad/6Mz12EZVsdsn5wDy9BSVbpcMVgoNpD7j0oGMom5gjcUP
 B8rQo0Ca304XSaGSnaGig7FezeyAKr0u5DSs2uj7f1gfY0/Q9jKeczuUE
 ZitXcMnCr7snHW+v9+7Zu6+omHwvnPAbI/YdtupqIaeLcLRYhAH8jtUnD
 GktW4kCyUiVNdCRWT1g5gCXOr3JCKpnLG9aGq0dsvazHpF6flyzMTMEo2 Q==;
X-CSE-ConnectionGUID: qwrRcmRtTvOSsZfQzsh5Dg==
X-CSE-MsgGUID: uD4nj1ZJTh+Oui9OT7GBaA==
X-IronPort-AV: E=McAfee;i="6800,10657,11817"; a="85891152"
X-IronPort-AV: E=Sophos;i="6.24,206,1774335600"; d="scan'208";a="85891152"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
 by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 15 Jun 2026 04:02:00 -0700
X-CSE-ConnectionGUID: 4C06kX6UQWuf5G040LoU9g==
X-CSE-MsgGUID: /d/4X/dHRKS6OxvyZDuglQ==
X-ExtLoop1: 1
Received: from silpixa00401119.ir.intel.com ([10.20.224.206])
 by fmviesa003.fm.intel.com with ESMTP; 15 Jun 2026 04:01:59 -0700
From: Anatoly Burakov <anatoly.burakov@intel.com>
To: dev@dpdk.org,
	Bruce Richardson <bruce.richardson@intel.com>
Subject: [PATCH v1 1/1] net/i40e: allow discontiguous queue lists in hash
Date: Mon, 15 Jun 2026 12:01:58 +0100
Message-ID: <9999fab5d9491d15ff98ac5aafa248e11df558de.1781521311.git.anatoly.burakov@intel.com>
X-Mailer: git-send-email 2.47.3
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

Due to recent refactors and code unification, there are now the following
properties of RSS queue list that can be checked by common infrastructure:

- Monotony (i.e. queue indices always increase, never decrease)
- No duplication (i.e. can't have the same index specified twice)
- Contiguousness (i.e. can't have holes in the queue list)

The latter is an optional feature that can be enabled with a flag. However,
previous hash code only enforced contiguousness for queue *regions* but not
queue *lists*, whereas after the refactor, all queue lists were required to
be contiguous. This is an unnecessary restriction, and it breaks backwards
compatibility.

Fix it by only specifying contiguousness requirement for the VLAN branch
where we are actually looking for a queue *region* not queue *list*.

Fixes: 0185303c2e24 ("net/i40e: refactor RSS flow parameter checks")

Signed-off-by: Anatoly Burakov <anatoly.burakov@intel.com>
---
 drivers/net/intel/i40e/i40e_hash.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/net/intel/i40e/i40e_hash.c b/drivers/net/intel/i40e/i40e_hash.c
index 3c1302469c..8b80d0a91c 100644
--- a/drivers/net/intel/i40e/i40e_hash.c
+++ b/drivers/net/intel/i40e/i40e_hash.c
@@ -1238,7 +1238,6 @@ i40e_hash_parse(struct rte_eth_dev *dev,
 		},
 		.max_actions = 1,
 		.driver_ctx = dev->data->dev_private,
-		.rss_queues_contig = true,
 		/* each pattern type will add specific check function */
 	};
 	const struct rte_flow_action_rss *rss_act;
@@ -1265,6 +1264,8 @@ i40e_hash_parse(struct rte_eth_dev *dev,
 	/* VLAN path */
 	if (is_vlan) {
 		ac_param.check = i40e_hash_validate_queue_region;
+		/* queue regions must be contiguous */
+		ac_param.rss_queues_contig = true;
 		ret = ci_flow_check_actions(actions, &ac_param, &parsed_actions, error);
 		if (ret)
 			return ret;
-- 
2.47.3

