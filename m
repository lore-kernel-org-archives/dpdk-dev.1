Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6C74EEC1EAF
	for <dpdk-dev@archiver.kernel.org>; Thu,  5 Feb 2026 12:47:41 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 9610341153;
	Thu,  5 Feb 2026 13:46:51 +0100 (CET)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
 by mails.dpdk.org (Postfix) with ESMTP id B491140EDB
 for <dev@dpdk.org>; Thu,  5 Feb 2026 13:46:45 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1770295605; x=1801831605;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=XOr4wvkoyyDUuvizdq2FqoUdTV8bOAbczx7JQbChWeg=;
 b=V4P0ROMvp7zQ5vrzlyXRTYWEqB2Sg3wTgjU+XngjFIzQtczcOUjUkhxT
 Xr1aGonHw0GgHhZ0V/c0NpKLNFL5x+1wOIemwdlr+ZRSt65IrNzsgjPVd
 QQcRGD8mO6lX9zk0h/oWa2tQB/mUwzNHvvZqmSPVGaZAdLTDtSraMQeE3
 8tF/JqyhlY1FpmLZmn4SJOiTI0DCW348yiNpA7C6UbQbu0DLuO4j9+zkM
 RydcaTFl6GhZ3ihZlFZJGr5yBphzSkwJe/DywBVs/1Lsb2FNw8TRMpehJ
 Xo3FSgIFUTBWBlPvdgAezR7LN+cK1AEBhhLHRDqibrUZGiGDkNuYV3T3R A==;
X-CSE-ConnectionGUID: L6EhTqL6TwK9JpA0XPgxJQ==
X-CSE-MsgGUID: y8wez3w6Q3mxMcGJaE5lig==
X-IronPort-AV: E=McAfee;i="6800,10657,11691"; a="71481871"
X-IronPort-AV: E=Sophos;i="6.21,274,1763452800"; d="scan'208";a="71481871"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
 by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 05 Feb 2026 04:46:44 -0800
X-CSE-ConnectionGUID: o67Tqa72TRKcgPNeMPPw4A==
X-CSE-MsgGUID: wwPBK5kJSOOEO0YW2/59rg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,274,1763452800"; d="scan'208";a="233454891"
Received: from silpixa00401177.ir.intel.com ([10.20.224.214])
 by fmviesa002.fm.intel.com with ESMTP; 05 Feb 2026 04:46:44 -0800
From: Ciara Loftus <ciara.loftus@intel.com>
To: dev@dpdk.org
Cc: Ciara Loftus <ciara.loftus@intel.com>
Subject: [PATCH v2 10/10] net/cpfl: permit secondary process Tx path selection
Date: Thu,  5 Feb 2026 12:46:27 +0000
Message-ID: <20260205124627.371733-11-ciara.loftus@intel.com>
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
index 7da360d56e..b7d62a1379 100644
--- a/drivers/net/intel/cpfl/cpfl_rxtx.c
+++ b/drivers/net/intel/cpfl/cpfl_rxtx.c
@@ -1493,8 +1493,8 @@ cpfl_set_tx_function(struct rte_eth_dev *dev)
 		.single_queue = (vport->txq_model == VIRTCHNL2_QUEUE_MODEL_SINGLE)
 	};
 
-	/* The primary process selects the tx path for all processes. */
-	if (rte_eal_process_type() != RTE_PROC_PRIMARY)
+	/* If the device has started the function has already been selected. */
+	if (dev->data->dev_started)
 		goto out;
 
 #ifdef RTE_ARCH_X86
-- 
2.43.0

