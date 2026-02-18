Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9FC2AE9A03E
	for <dpdk-dev@archiver.kernel.org>; Wed, 18 Feb 2026 09:50:13 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 3BFFD4060C;
	Wed, 18 Feb 2026 10:50:09 +0100 (CET)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
 by mails.dpdk.org (Postfix) with ESMTP id 82F0B4014F;
 Wed, 18 Feb 2026 10:50:05 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1771408206; x=1802944206;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=A5UsXxDtfaAfGgqaEyvzsQQqiKdu+JDvbqdBCDq3xs0=;
 b=KDDVVFzEc3fdeZAHq5Oj9altieSXY8UB0VIObsDhqPCMOSLoMFTNd9l/
 PpYhyJSBlbzKRyPBete62vxRga+mWXzOnj2BfbSxzHKvL4+77GR1QGL2d
 e3z3T++1/wzbYyONyfQLm9RXuNU5nTTQzcs676TO8B8+CDa+1UD4cBbAw
 edh29/OFN1ICGnNz+eGEjH2nHZ5RxMVvlJ32bBApSqxoeFblq5rJgYKzi
 0eBbc3HCfhHKG4xOByY36ZNOTnwU5NUdHg2MCDhll6KQ9cKTy3W1HpLJC
 AvYqhTYi5oXv8s+cDR+lndPh1XBWgOsper07mQf60QMqM9IWLb9WaNFS7 w==;
X-CSE-ConnectionGUID: KQa5NXfVSrucZwU+sBup8A==
X-CSE-MsgGUID: T94QPYHuSg6Te8ZrjoN8Yw==
X-IronPort-AV: E=McAfee;i="6800,10657,11704"; a="83929841"
X-IronPort-AV: E=Sophos;i="6.21,298,1763452800"; d="scan'208";a="83929841"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
 by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 18 Feb 2026 01:50:04 -0800
X-CSE-ConnectionGUID: rnRcBCJfQ02kFTMc/9Kl4w==
X-CSE-MsgGUID: V3Uoz5pSTxurZNW7FGBKkg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,298,1763452800"; d="scan'208";a="214257058"
Received: from silpixa00401177.ir.intel.com ([10.20.224.214])
 by orviesa007.jf.intel.com with ESMTP; 18 Feb 2026 01:50:03 -0800
From: Ciara Loftus <ciara.loftus@intel.com>
To: dev@dpdk.org
Cc: Ciara Loftus <ciara.loftus@intel.com>,
	stable@dpdk.org
Subject: [PATCH v3 01/10] net/i40e: permit secondary process Rx path selection
Date: Wed, 18 Feb 2026 09:49:28 +0000
Message-ID: <20260218094937.1652391-2-ciara.loftus@intel.com>
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

Commit 258f346f5d5e ("net/i40e: use same Rx path across processes")
changed the way that secondary processes selected their Rx burst
function. Instead of letting secondary processes select their own
function, they now used the function selected by the primary process.
However, the primary process only selects the function at device start,
so if the primary process hadn't started the device by the time the
secondary process was selecting its Rx burst function, the secondary
process would not select the correct function.

This commit addresses this issue by allowing the secondary process to
select the path if the device has not been started yet.

Fixes: 258f346f5d5e ("net/i40e: use same Rx path across processes")
Cc: stable@dpdk.org

Signed-off-by: Ciara Loftus <ciara.loftus@intel.com>
---
 drivers/net/intel/i40e/i40e_rxtx.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/net/intel/i40e/i40e_rxtx.c b/drivers/net/intel/i40e/i40e_rxtx.c
index ffb303158b..d189ba263b 100644
--- a/drivers/net/intel/i40e/i40e_rxtx.c
+++ b/drivers/net/intel/i40e/i40e_rxtx.c
@@ -3001,8 +3001,8 @@ i40e_set_rx_function(struct rte_eth_dev *dev)
 	uint16_t i;
 	enum rte_vect_max_simd rx_simd_width = i40e_get_max_simd_bitwidth();
 
-	/* The primary process selects the rx path for all processes. */
-	if (rte_eal_process_type() != RTE_PROC_PRIMARY)
+	/* If the device has started the function has already been selected. */
+	if (dev->data->dev_started)
 		goto out;
 
 	/* In order to allow Vector Rx there are a few configuration
-- 
2.43.0

