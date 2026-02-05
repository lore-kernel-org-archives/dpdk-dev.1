Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 69CD6EC1EAF
	for <dpdk-dev@archiver.kernel.org>; Thu,  5 Feb 2026 12:47:01 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 16C03410E4;
	Thu,  5 Feb 2026 13:46:44 +0100 (CET)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
 by mails.dpdk.org (Postfix) with ESMTP id 4D3DF40E5A;
 Thu,  5 Feb 2026 13:46:40 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1770295600; x=1801831600;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=9mxlPWZbTHWZRj7O3gcBAM+l7gjkzTO3LOOKzEpmldQ=;
 b=STFT8DQQR//4LTpBPsJ174vv/xSn/b7daxs91TRU4dLcJjI8f2MpkBDz
 WjolHh47ncYwuCcIkYUNx7U2xDdYCeJeLNmo95tpoj/6FJAmfwZK2XRZA
 k6NDIA6aO69ES7EzcoqBt9mg5aQCd4ON/5Cn+pGf/gelUUOfr1zfkejNn
 unj9bIW9gryHZQVGMsNjIo7mYQeJ+PSIQAQTThjLvlF5wS50t6HQncqZi
 JL+Kjhrx6y+z0Qfgvinnj34r0m5DlHj+jqqvaQP/sxA7q//dwcyTIhU7d
 F+mqy8Mmu0bTr55uZjFhW+CcVF8qdxkujdvwfMzxIaxn/lQMOqBYg+/4i g==;
X-CSE-ConnectionGUID: nyvPyj9dSiWMY0LD1qgagg==
X-CSE-MsgGUID: zR7tuIsdSEqYK8V9Shzulg==
X-IronPort-AV: E=McAfee;i="6800,10657,11691"; a="71481847"
X-IronPort-AV: E=Sophos;i="6.21,274,1763452800"; d="scan'208";a="71481847"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
 by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 05 Feb 2026 04:46:39 -0800
X-CSE-ConnectionGUID: E/tBrt9ZS6aVExbIz0C8SA==
X-CSE-MsgGUID: 3tYlgu/ISa632N/9LYWhfQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,274,1763452800"; d="scan'208";a="233454856"
Received: from silpixa00401177.ir.intel.com ([10.20.224.214])
 by fmviesa002.fm.intel.com with ESMTP; 05 Feb 2026 04:46:38 -0800
From: Ciara Loftus <ciara.loftus@intel.com>
To: dev@dpdk.org
Cc: Ciara Loftus <ciara.loftus@intel.com>,
	stable@dpdk.org
Subject: [PATCH v2 03/10] net/ice: permit secondary process Rx path selection
Date: Thu,  5 Feb 2026 12:46:20 +0000
Message-ID: <20260205124627.371733-4-ciara.loftus@intel.com>
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

Commit 197e70fb8961 ("net/ice: use same Rx path across processes")
changed the way that secondary processes selected their Rx burst
function. Instead of letting secondary processes select their own
function, they now used the function selected by the primary process.
However, the primary process only selects the function at device start,
so if the primary process hadn't started the device by the time the
secondary process was selecting its Rx burst function, the secondary
process would not select the correct function.

This commit addresses this issue by allowing the secondary process to
select the path if the device has not been started yet.

Fixes: 197e70fb8961 ("net/ice: use same Rx path across processes")
Cc: stable@dpdk.org

Signed-off-by: Ciara Loftus <ciara.loftus@intel.com>
---
 drivers/net/intel/ice/ice_rxtx.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/net/intel/ice/ice_rxtx.c b/drivers/net/intel/ice/ice_rxtx.c
index f3bc79423d..bbd9cfa7a5 100644
--- a/drivers/net/intel/ice/ice_rxtx.c
+++ b/drivers/net/intel/ice/ice_rxtx.c
@@ -3822,8 +3822,8 @@ ice_set_rx_function(struct rte_eth_dev *dev)
 		.simd_width = RTE_VECT_SIMD_DISABLED,
 	};
 
-	/* The primary process selects the rx path for all processes. */
-	if (rte_eal_process_type() != RTE_PROC_PRIMARY)
+	/* If the device has started the function has already been selected. */
+	if (dev->data->dev_started)
 		goto out;
 
 #ifdef RTE_ARCH_X86
-- 
2.43.0

