Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 04238CC6B0F
	for <dpdk-dev@archiver.kernel.org>; Tue, 13 Oct 2026 12:07:11 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 8A7F14065A;
	Tue, 13 Oct 2026 14:04:25 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
 by mails.dpdk.org (Postfix) with ESMTP id 8FF79402F0
 for <dev@dpdk.org>; Tue, 13 Oct 2026 14:04:23 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1791893064; x=1823429064;
 h=from:to:subject:date:message-id:in-reply-to:references:
 mime-version:content-transfer-encoding;
 bh=Kv0y98z+IVJ5RpgSJVeVd2umxrqV46Dra8+jgz6UeQA=;
 b=kOXxuPdg9sCdCTLv4C4SBFxPPSmtdUjUmR4V3rlNKkqu79rtGxuXPbM0
 DZHpknZWs8zvXkOqIOPfqzDkPN2CLP4T7oj08EyAmjOai/kY1hq88lsJt
 Ng8eqjAxJw82VUJX05M/vmsHZcCI4494nCim8GIXXfqKyMrn8l+cTgCi+
 NoS7Vw8t/MRU7K9lnYpdMF75v19B214hgn2ONmmuiL2UbGNEnYE8v4M65
 xuR6O6hUu43pqU8WEhiiy0yMUnu44B9jPEuc4C19AxY/+/scR/3SlpFY5
 5h/UqCJPLVA5UH3oqz+uBicl+W8I1WT1vBYQPbVD9Yd2Z+Ceq87YhUvRK w==;
X-CSE-ConnectionGUID: kY5BzgwoS3mI3IOdk1elvA==
X-CSE-MsgGUID: XAkjkSV1TUK5TIoL2tyCxg==
X-IronPort-AV: E=McAfee;i="6800,10657,11933"; a="608437"
X-IronPort-AV: E=Sophos;i="6.27,155,1787036400"; 
   d="scan'208";a="608437"
Received: from fmviesa013.fm.intel.com ([10.60.135.153])
 by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 13 Oct 2026 05:04:08 -0700
X-CSE-ConnectionGUID: Wlh+d/5ASniLzI1i0QYb1w==
X-CSE-MsgGUID: dfng9J7CQk6chvMZVW5r6w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,155,1787036400"; 
   d="scan'208";a="2908681"
Received: from silpixa00401119.ir.intel.com ([10.20.224.206])
 by fmviesa013.fm.intel.com with ESMTP; 13 Oct 2026 05:04:07 -0700
From: Anatoly Burakov <anatoly.burakov@intel.com>
To: dev@dpdk.org,
	Bruce Richardson <bruce.richardson@intel.com>
Subject: [PATCH v7 25/25] net/i40e: advertise flow keep capability
Date: Tue, 13 Oct 2026 13:03:23 +0100
Message-ID: <2bcab3019dce26f7f356ac6cc36e4299201e20f5.1791892578.git.anatoly.burakov@intel.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <cover.1791892574.git.anatoly.burakov@intel.com>
 <cover.1791892574.git.anatoly.burakov@intel.com>
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

The i40e driver's rte_flow implementation has always endeavored to keep
flows across device restart, however it never advertised this capability.
Advertise it explicitly.

Signed-off-by: Anatoly Burakov <anatoly.burakov@intel.com>
Acked-by: Vladimir Medvedkin <vladimir.medvedkin@intel.com>
---
 doc/guides/rel_notes/release_26_11.rst | 5 +++++
 drivers/net/intel/i40e/i40e_ethdev.c   | 3 ++-
 2 files changed, 7 insertions(+), 1 deletion(-)

diff --git a/doc/guides/rel_notes/release_26_11.rst b/doc/guides/rel_notes/release_26_11.rst
index f4d88938bc3..e9e9fdec9cd 100644
--- a/doc/guides/rel_notes/release_26_11.rst
+++ b/doc/guides/rel_notes/release_26_11.rst
@@ -109,6 +109,11 @@ New Features
   * Advertised ``RTE_ETH_DEV_CAPA_FLOW_RULE_KEEP`` capability,
     as flow rules were already kept across device restart.
 
+* **Updated Intel i40e driver.**
+
+  * Advertised ``RTE_ETH_DEV_CAPA_FLOW_RULE_KEEP`` capability,
+    as flow rules were already kept across device restart.
+
 * **Updated NXP DPAA2 ethernet driver.**
 
   * Added the inner IP header to the RSS hash so tunneled traffic is
diff --git a/drivers/net/intel/i40e/i40e_ethdev.c b/drivers/net/intel/i40e/i40e_ethdev.c
index 5e59a859827..e26a849764a 100644
--- a/drivers/net/intel/i40e/i40e_ethdev.c
+++ b/drivers/net/intel/i40e/i40e_ethdev.c
@@ -3631,7 +3631,8 @@ i40e_dev_info_get(struct rte_eth_dev *dev, struct rte_eth_dev_info *dev_info)
 	dev_info->dev_capa =
 		RTE_ETH_DEV_CAPA_RUNTIME_RX_QUEUE_SETUP |
 		RTE_ETH_DEV_CAPA_RUNTIME_TX_QUEUE_SETUP;
-	dev_info->dev_capa &= ~RTE_ETH_DEV_CAPA_FLOW_RULE_KEEP;
+	/* rte_flow rules are kept across dev_stop/dev_start and replayed on start */
+	dev_info->dev_capa |= RTE_ETH_DEV_CAPA_FLOW_RULE_KEEP;
 
 	dev_info->hash_key_size = (I40E_PFQF_HKEY_MAX_INDEX + 1) *
 						sizeof(uint32_t);
-- 
2.52.0

