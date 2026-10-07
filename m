Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D8EABCA5FF1
	for <dpdk-dev@archiver.kernel.org>; Wed,  7 Oct 2026 10:53:30 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 2E7C042E8B;
	Wed,  7 Oct 2026 12:51:10 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
 by mails.dpdk.org (Postfix) with ESMTP id 1408A42E80
 for <dev@dpdk.org>; Wed,  7 Oct 2026 12:51:06 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1791370267; x=1822906267;
 h=from:to:subject:date:message-id:in-reply-to:references:
 mime-version:content-transfer-encoding;
 bh=VUC7KFx4l9wV1xnHXqvtxmI3IorMff0R9ja1XEAp7a8=;
 b=grlZl3d6T7s1kTt9l/ilQ2WDdcSSToN+vIsZ25qYH5ST2hslSaEOkJbK
 FaPRm5STEUpQ+de/MvJrs55KQc8HhGlvWdRvKKysPgR4mUhkBz93MhmH3
 5v1sfPAMj6oOXeHFakZjURcOfpcUNMmMyJjMPRua9owv2uOsDFb0wCTA/
 anu+WTW8K3OmlH90nEp4oq6tBo24Ccg777KVkUmtHWoO0zG07yA/E25BI
 m3IfZzmPeuY+V7SPLfIzzWf8NH0N/Bc6eeN1X/JNceAnxLS2qZ8l8ehzh
 T9GaWBPfqNH8otVnGqhG7sS5bkOU/F7HCrzo7NaFuZ4ec3FqospuJCurY Q==;
X-CSE-ConnectionGUID: KPM0QRMoTV2dRNmmKmxezA==
X-CSE-MsgGUID: Rkx45aAvRdeaF9J5sSJUqQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11927"; a="121849"
X-IronPort-AV: E=Sophos;i="6.27,144,1787036400"; 
   d="scan'208";a="121849"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
 by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 07 Oct 2026 03:51:06 -0700
X-CSE-ConnectionGUID: SGPzVuD1S3OwpVJf6LJDkw==
X-CSE-MsgGUID: lrTXdzraQ06UmKM+FvbR7w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,144,1787036400"; d="scan'208";a="280652178"
Received: from silpixa00401119.ir.intel.com ([10.20.224.206])
 by orviesa003.jf.intel.com with ESMTP; 07 Oct 2026 03:51:06 -0700
From: Anatoly Burakov <anatoly.burakov@intel.com>
To: dev@dpdk.org,
	Bruce Richardson <bruce.richardson@intel.com>
Subject: [PATCH v5 25/25] net/i40e: advertise flow keep capability
Date: Wed,  7 Oct 2026 11:50:20 +0100
Message-ID: <3572ba2b0cdcac622ce335d4c1594d82289a4906.1791369982.git.anatoly.burakov@intel.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <cover.1791369979.git.anatoly.burakov@intel.com>
 <cover.1791369979.git.anatoly.burakov@intel.com>
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
index 932e8b2674f..226f4819c3a 100644
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

