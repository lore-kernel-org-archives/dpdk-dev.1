Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AA44AE9A03E
	for <dpdk-dev@archiver.kernel.org>; Wed, 18 Feb 2026 09:50:46 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id E7F1B40668;
	Wed, 18 Feb 2026 10:50:21 +0100 (CET)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
 by mails.dpdk.org (Postfix) with ESMTP id 70AD940299
 for <dev@dpdk.org>; Wed, 18 Feb 2026 10:50:09 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1771408210; x=1802944210;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=Sw3xy4VkT+ovfSoCik6ox9suAALnWsaI9goAjEsqPk4=;
 b=SbpkJdQt9zCPb6Z9OHC8qk4GYV/1vhhw2aekFf3lRSDuWkI+Iyz0Xtjy
 tJ7AN+pbAeDjmzaBogI2Zsgzi97SBl0uHKTgF9H3k4iKpA2p7aXx9hdqI
 v5R1K20NAWi19YbhnhiznVCqiUZsaMJOFLCFTWdzN8rMCCGZ/40aYVWfW
 6eLytAR1+CKBtdOUY3ow8ZXi2JxkjnZJUJ+m+2XK63Eg1cBOb1+iw2R1P
 WCPsEZFEPjpCX2CilqlL21Q2cBdi8uYqQUDh/PG7A1YHHyyaLQBFWmQPk
 oNcn4IyLZ3Xee44HtIYkUiIgTZksY50kXL4o5XK5CkeI/o0wx3rjq9vS/ Q==;
X-CSE-ConnectionGUID: ZLRdW5S/Rgq23TtjgtM46w==
X-CSE-MsgGUID: 2icd12jfSN2SYl8cS1Jnmw==
X-IronPort-AV: E=McAfee;i="6800,10657,11704"; a="83929847"
X-IronPort-AV: E=Sophos;i="6.21,298,1763452800"; d="scan'208";a="83929847"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
 by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 18 Feb 2026 01:50:09 -0800
X-CSE-ConnectionGUID: LscsJ5bITemSvrGIQ2odJA==
X-CSE-MsgGUID: m76iOs6wS5Wd6E0ll6bS1w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,298,1763452800"; d="scan'208";a="214257119"
Received: from silpixa00401177.ir.intel.com ([10.20.224.214])
 by orviesa007.jf.intel.com with ESMTP; 18 Feb 2026 01:50:08 -0800
From: Ciara Loftus <ciara.loftus@intel.com>
To: dev@dpdk.org
Cc: Ciara Loftus <ciara.loftus@intel.com>
Subject: [PATCH v3 06/10] net/i40e: permit secondary process Tx path selection
Date: Wed, 18 Feb 2026 09:49:33 +0000
Message-ID: <20260218094937.1652391-7-ciara.loftus@intel.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260218094937.1652391-1-ciara.loftus@intel.com>
References: <20260205124627.371733-1-ciara.loftus@intel.com>
 <20260218094937.1652391-1-ciara.loftus@intel.com>
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

Commit 8d57c1788806 ("net/i40e: use common Tx path selection
infrastructure") changed the way that secondary processes selected their
Tx burst function. Instead of letting secondary processes select their
own function, they now used the function selected by the primary
process. However, the primary process only selects the function at
device start, so if the primary process hadn't started the device by the
time the secondary process was selecting its Tx burst function, the
secondary process would not select the correct function.

This commit addresses this issue by allowing the secondary process to
select the path if the device has not been started yet.

Fixes: 8d57c1788806 ("net/i40e: use common Tx path selection infrastructure")

Signed-off-by: Ciara Loftus <ciara.loftus@intel.com>
---
 drivers/net/intel/i40e/i40e_rxtx.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/net/intel/i40e/i40e_rxtx.c b/drivers/net/intel/i40e/i40e_rxtx.c
index d189ba263b..c5ac75e0f0 100644
--- a/drivers/net/intel/i40e/i40e_rxtx.c
+++ b/drivers/net/intel/i40e/i40e_rxtx.c
@@ -3104,8 +3104,8 @@ i40e_set_tx_function(struct rte_eth_dev *dev)
 		.simple_tx = ad->tx_simple_allowed
 	};
 
-	/* The primary process selects the tx path for all processes. */
-	if (rte_eal_process_type() != RTE_PROC_PRIMARY)
+	/* If the device has started the function has already been selected. */
+	if (dev->data->dev_started)
 		goto out;
 
 	if (ad->tx_vec_allowed) {
-- 
2.43.0

