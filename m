Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 69507EC1EB1
	for <dpdk-dev@archiver.kernel.org>; Thu,  5 Feb 2026 12:46:53 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 8579040EE5;
	Thu,  5 Feb 2026 13:46:42 +0100 (CET)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
 by mails.dpdk.org (Postfix) with ESMTP id 9E7904021F;
 Thu,  5 Feb 2026 13:46:39 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1770295600; x=1801831600;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=2c2pPNo0EHgVq38GbJa9e//6RDS/Jc1Z25rqM5cJDPw=;
 b=JIrIPx5AIJRgLM1W6FrzVqdGQlGCYgc8g2qfaitjBxN6S1NUsUO7m5in
 AoIcKBYFTW4RdQI5DWNyqSINsTkuYRT8Oj+MGw5OAmDxRuwnEdCQ7Epgv
 ZeXSYqXLFLnvYMzpHQdqy5lWVCs72GsrJobyjCVQ4bJ9GC/V6Pcb1toXS
 OpA0AUFl0uMS8Cpsme5bPN9A00AnCwR0ORj8c+yaAMMo8SD7ASc5QOCW8
 et+NvGlLGFyDN9aZzcpquXYinIk4q4QfWI/uuOxSetxmbTXBfKGuF1tAI
 ZDJOb3Ab3c33SW0MYeKhqsj/A9tzCkZSFudkwuacqHf2dgnE8m0FJoxJ5 A==;
X-CSE-ConnectionGUID: CQM5bUhXTimAavjQrkS9EA==
X-CSE-MsgGUID: X5xYJDE8SkCJG62HGMyUXQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11691"; a="71481846"
X-IronPort-AV: E=Sophos;i="6.21,274,1763452800"; d="scan'208";a="71481846"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
 by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 05 Feb 2026 04:46:38 -0800
X-CSE-ConnectionGUID: l99D7UDrQXOQvbuSOn8PGQ==
X-CSE-MsgGUID: Ta6CECC8RQiBa+SvcLEhAg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,274,1763452800"; d="scan'208";a="233454852"
Received: from silpixa00401177.ir.intel.com ([10.20.224.214])
 by fmviesa002.fm.intel.com with ESMTP; 05 Feb 2026 04:46:37 -0800
From: Ciara Loftus <ciara.loftus@intel.com>
To: dev@dpdk.org
Cc: Ciara Loftus <ciara.loftus@intel.com>,
	stable@dpdk.org
Subject: [PATCH v2 02/10] net/iavf: permit secondary process Rx path selection
Date: Thu,  5 Feb 2026 12:46:19 +0000
Message-ID: <20260205124627.371733-3-ciara.loftus@intel.com>
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

Commit 3f59c3d97a89 ("net/iavf: use same Rx path across processes")
changed the way that secondary processes selected their Rx burst
function. Instead of letting secondary processes select their own
function, they now used the function selected by the primary process.
However, the primary process only selects the function at device start,
so if the primary process hadn't started the device by the time the
secondary process was selecting its Rx burst function, the secondary
process would not select the correct function.

This commit addresses this issue by allowing the secondary process to
select the path if the device has not been started yet.

Fixes: 3f59c3d97a89 ("net/iavf: use same Rx path across processes")
Cc: stable@dpdk.org

Signed-off-by: Ciara Loftus <ciara.loftus@intel.com>
---
 drivers/net/intel/iavf/iavf_rxtx.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/net/intel/iavf/iavf_rxtx.c b/drivers/net/intel/iavf/iavf_rxtx.c
index 4b763627bc..bca80eccfa 100644
--- a/drivers/net/intel/iavf/iavf_rxtx.c
+++ b/drivers/net/intel/iavf/iavf_rxtx.c
@@ -4173,8 +4173,8 @@ iavf_set_rx_function(struct rte_eth_dev *dev)
 		.simd_width = RTE_VECT_SIMD_DISABLED,
 	};
 
-	/* The primary process selects the rx path for all processes. */
-	if (rte_eal_process_type() != RTE_PROC_PRIMARY)
+	/* If the device has started the function has already been selected. */
+	if (dev->data->dev_started)
 		goto out;
 
 	for (i = 0; i < dev->data->nb_rx_queues; i++) {
-- 
2.43.0

