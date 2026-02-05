Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 40DC5EC1EAD
	for <dpdk-dev@archiver.kernel.org>; Thu,  5 Feb 2026 12:46:47 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 504D140ED0;
	Thu,  5 Feb 2026 13:46:41 +0100 (CET)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
 by mails.dpdk.org (Postfix) with ESMTP id DD2744021F;
 Thu,  5 Feb 2026 13:46:38 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1770295599; x=1801831599;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=lgkG9pCe0KkwwIvhM1C9TG6Mc/X6LfgtBsTz2npNkN4=;
 b=frCg2f7CwXEXghiIlcguspoLaJ4nzzDKO+awjlMfYxI2DvSvvovHAnVE
 PP7T6PEneajP7p5VJx4YPru1zbIOtjT2ReE+EQU0DN+B4e4RmxfNDWT5R
 OnwU3UDpBj+aGxShbbG0Ih+/O22qWr8xFQlUwqY6zL2ROKUrng8WL+g7Y
 Twqca+h/o4X2r1aB0wpwQSmVKZinJRMwQqLGF98RUGO5A4p17Rm0n3ixs
 UaN6bdbZlJ2N4Nfu3GN/P+e6s5aMvhjB0UUeeDEIcRb576irIZDsIjQCF
 OaPWsa447w/o6dviTYhmA9tAybGPnmxWgUeNtnDtUHWaDQGoQwmZ72A8+ w==;
X-CSE-ConnectionGUID: 5wVsHMq0Q8e7yDKH92X8fg==
X-CSE-MsgGUID: HyiyTpSuS4i0icIzhIx+JA==
X-IronPort-AV: E=McAfee;i="6800,10657,11691"; a="71481842"
X-IronPort-AV: E=Sophos;i="6.21,274,1763452800"; d="scan'208";a="71481842"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
 by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 05 Feb 2026 04:46:37 -0800
X-CSE-ConnectionGUID: 70t3F0ajSVeHZHCzDpDmCQ==
X-CSE-MsgGUID: MdtuTGIuRo+/DKCMrOajPQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,274,1763452800"; d="scan'208";a="233454843"
Received: from silpixa00401177.ir.intel.com ([10.20.224.214])
 by fmviesa002.fm.intel.com with ESMTP; 05 Feb 2026 04:46:37 -0800
From: Ciara Loftus <ciara.loftus@intel.com>
To: dev@dpdk.org
Cc: Ciara Loftus <ciara.loftus@intel.com>,
	stable@dpdk.org
Subject: [PATCH v2 01/10] net/i40e: permit secondary process Rx path selection
Date: Thu,  5 Feb 2026 12:46:18 +0000
Message-ID: <20260205124627.371733-2-ciara.loftus@intel.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260205124627.371733-1-ciara.loftus@intel.com>
References: <20260205103008.190493-1-ciara.loftus@intel.com>
 <20260205124627.371733-1-ciara.loftus@intel.com>
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
index 1c3586778c..3deeff165d 100644
--- a/drivers/net/intel/i40e/i40e_rxtx.c
+++ b/drivers/net/intel/i40e/i40e_rxtx.c
@@ -3494,8 +3494,8 @@ i40e_set_rx_function(struct rte_eth_dev *dev)
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

