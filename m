Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BA767E9A03E
	for <dpdk-dev@archiver.kernel.org>; Wed, 18 Feb 2026 09:51:09 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 17AA640672;
	Wed, 18 Feb 2026 10:50:26 +0100 (CET)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
 by mails.dpdk.org (Postfix) with ESMTP id A6D0B40657
 for <dev@dpdk.org>; Wed, 18 Feb 2026 10:50:12 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1771408213; x=1802944213;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=h/d25st9QxNxaxiO3E0INfUiTRHBuPYJkCkVNlIWfEE=;
 b=PKIjrBAGpRDdTByneSx0bANj6fNbVvqCdXyCsFlz/dc8RTmUhsy/65zV
 UIO8kTNFJXwRIMrXfx0URVpBKLCuWNqSYzMxMvQFRPvNe4DzA+XwbfIMZ
 YSv9fRUlmUULLvJfFrqKSWlzRXkhfJ2jiyaFHNH3r94+fsuh5y+XUbRCl
 S5yXADO+z2TayS9VUlF8SV0P2UiPKe6eaSYkMWIDIydT11tCOg+46aqnV
 3pXnx5nyMD/91tKewP3WLMoVrXOW7X37gbMSYAe9gbfxdCaxH9BxEz5UG
 vZJ6qRQq8K2KGLsc5mSUiMqDuB+dOKObqq9Glq9uaZbxs6KblkthP55Mf Q==;
X-CSE-ConnectionGUID: vxIz09fuQUqwbLozRNYG3g==
X-CSE-MsgGUID: o9PD7KQvQd2p2/EalG3vAw==
X-IronPort-AV: E=McAfee;i="6800,10657,11704"; a="83929851"
X-IronPort-AV: E=Sophos;i="6.21,298,1763452800"; d="scan'208";a="83929851"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
 by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 18 Feb 2026 01:50:13 -0800
X-CSE-ConnectionGUID: L0S1ljvvTByps23glHFmpA==
X-CSE-MsgGUID: 3P6KCfpDTkCKkxFPP5gbrw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,298,1763452800"; d="scan'208";a="214257138"
Received: from silpixa00401177.ir.intel.com ([10.20.224.214])
 by orviesa007.jf.intel.com with ESMTP; 18 Feb 2026 01:50:11 -0800
From: Ciara Loftus <ciara.loftus@intel.com>
To: dev@dpdk.org
Cc: Ciara Loftus <ciara.loftus@intel.com>
Subject: [PATCH v3 10/10] net/cpfl: permit secondary process Tx path selection
Date: Wed, 18 Feb 2026 09:49:37 +0000
Message-ID: <20260218094937.1652391-11-ciara.loftus@intel.com>
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

Commit 6970745698b9 ("net/cpfl: use common Tx path selection
infrastructure") changed the way that secondary processes selected their
Tx burst function. Instead of letting secondary processes select their
own function, they now used the function selected by the primary
process. However, the primary process only selects the function at
device start, so if the primary process hadn't started the device by the
time the secondary process was selecting its Tx burst function, the
secondary process would not select the correct function.

This commit addresses this issue by allowing the secondary process to
select the path if the device has not been started yet.

Fixes: 6970745698b9 ("net/cpfl: use common Tx path selection infrastructure")

Signed-off-by: Ciara Loftus <ciara.loftus@intel.com>
---
 drivers/net/intel/cpfl/cpfl_rxtx.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/net/intel/cpfl/cpfl_rxtx.c b/drivers/net/intel/cpfl/cpfl_rxtx.c
index dc729d31af..2e706aaaf1 100644
--- a/drivers/net/intel/cpfl/cpfl_rxtx.c
+++ b/drivers/net/intel/cpfl/cpfl_rxtx.c
@@ -1529,8 +1529,8 @@ cpfl_set_tx_function(struct rte_eth_dev *dev)
 		.simple_tx = simple_allowed
 	};
 
-	/* The primary process selects the tx path for all processes. */
-	if (rte_eal_process_type() != RTE_PROC_PRIMARY)
+	/* If the device has started the function has already been selected. */
+	if (dev->data->dev_started)
 		goto out;
 
 #ifdef RTE_ARCH_X86
-- 
2.43.0

