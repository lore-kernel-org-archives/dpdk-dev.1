Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CABC2CA6019
	for <dpdk-dev@archiver.kernel.org>; Fri,  9 Oct 2026 11:02:28 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id B84A540E4C;
	Fri,  9 Oct 2026 13:00:02 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
 by mails.dpdk.org (Postfix) with ESMTP id B5AE440E3F
 for <dev@dpdk.org>; Fri,  9 Oct 2026 13:00:01 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1791543602; x=1823079602;
 h=from:to:subject:date:message-id:in-reply-to:references:
 mime-version:content-transfer-encoding;
 bh=CEH2LGGdh1hxp+FHv6QW6sgkgl3XNVhEJzAt+TFbr1A=;
 b=aE36kkb1os7mJqzL1urUNywI/JtwjxBBdb0I/8zX8Q9iRhMlNpog4CJb
 PTTzZKgm7+5yzlLLf9Ldi+qx7dv7LF/N4ycDmz9hq/1ytJyEDIu8onB2h
 3nTNOKWX42qlJRbJ/RmYv7kEik5xKb+oAES1rnDKuIKgzL1wvatsHJiRy
 RAzIaxnBqwncK/l9+FIfLpFiQ4dIAGPIjn+YQWoSV9/7cJPjUqHvBKJOG
 VYE0lXtRkvYfF8ziBX0QmJTQF5dZATE6EO3e3seidV92nPAHVJu7oQs1V
 ujSR/8FdbKIU3ceyE916+UcTgW9ncBs0J7jTSZ4ZwdYl7H90go2gtgdgR Q==;
X-CSE-ConnectionGUID: uyLQTf7lQLi0kf18dkXjkw==
X-CSE-MsgGUID: hx91ySI5Rou7YpTsGy3SAA==
X-IronPort-AV: E=McAfee;i="6800,10657,11929"; a="241463"
X-IronPort-AV: E=Sophos;i="6.27,148,1787036400"; 
   d="scan'208";a="241463"
Received: from fmviesa012.fm.intel.com ([10.60.135.152])
 by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 09 Oct 2026 04:00:01 -0700
X-CSE-ConnectionGUID: 10D7idU3T1+QzF5cjh5LzQ==
X-CSE-MsgGUID: 4gTSwqUsS5GkTSt9ndK8yg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,148,1787036400"; 
   d="scan'208";a="2088506"
Received: from silpixa00401119.ir.intel.com ([10.20.224.206])
 by fmviesa012.fm.intel.com with ESMTP; 09 Oct 2026 03:59:59 -0700
From: Anatoly Burakov <anatoly.burakov@intel.com>
To: dev@dpdk.org,
	Bruce Richardson <bruce.richardson@intel.com>
Subject: [PATCH v6 25/25] net/i40e: advertise flow keep capability
Date: Fri,  9 Oct 2026 11:59:15 +0100
Message-ID: <ee1e4def8baddcb567c4201d6860dc87699f4138.1791543156.git.anatoly.burakov@intel.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <cover.1791543153.git.anatoly.burakov@intel.com>
 <cover.1791543153.git.anatoly.burakov@intel.com>
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
index 1eb4db5556d..4e34290aa55 100644
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

