Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 88CCEEC1EAF
	for <dpdk-dev@archiver.kernel.org>; Thu,  5 Feb 2026 12:47:29 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 3FE874111B;
	Thu,  5 Feb 2026 13:46:49 +0100 (CET)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
 by mails.dpdk.org (Postfix) with ESMTP id AC8D541060
 for <dev@dpdk.org>; Thu,  5 Feb 2026 13:46:43 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1770295603; x=1801831603;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=wcckzaHOZsAOT9AfnJ+eg4ykadPhxay2+85F3c2KJZk=;
 b=N24RiU95AvbFHn+nKwYEm0n9l7tl+HECJatVll/UhZTjDFUXCF+28r8C
 Gbp9W/rS1fgiervCKvYk/wJxXSq1BxjgdYn9Ha/s8bVxsa0Z8jlzYuzem
 g+5UchSM3PVPgK0vstb3zSu72lllxyXOhzoL8RoMiaGqwJtS4x94SzQzv
 LmPoOnRuSHFJWwU8KFs027wW1oU/WZEaKKlrS7HPfs3jXkEsrh64SpFJR
 5fhlbqAqbslzBVO8HsiqDaipspq2cwu78JiKgd9MRj/UwqWjnSHoh1Eqt
 j17Pglr21YLx12oWcaXBCKR6j8h2JbvOBS3BIwymGIzIDjijoaEXC0v73 Q==;
X-CSE-ConnectionGUID: ocQQeZBQQzi4BNXcRI+SNw==
X-CSE-MsgGUID: Vrolj+YtSieP4EbiTtMiTA==
X-IronPort-AV: E=McAfee;i="6800,10657,11691"; a="71481867"
X-IronPort-AV: E=Sophos;i="6.21,274,1763452800"; d="scan'208";a="71481867"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
 by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 05 Feb 2026 04:46:43 -0800
X-CSE-ConnectionGUID: WPjbngpDTq63m1u1dq5H6g==
X-CSE-MsgGUID: 62YyAyj0QWeJxRdjz+gLRg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,274,1763452800"; d="scan'208";a="233454884"
Received: from silpixa00401177.ir.intel.com ([10.20.224.214])
 by fmviesa002.fm.intel.com with ESMTP; 05 Feb 2026 04:46:42 -0800
From: Ciara Loftus <ciara.loftus@intel.com>
To: dev@dpdk.org
Cc: Ciara Loftus <ciara.loftus@intel.com>
Subject: [PATCH v2 08/10] net/ice: permit secondary process Tx path selection
Date: Thu,  5 Feb 2026 12:46:25 +0000
Message-ID: <20260205124627.371733-9-ciara.loftus@intel.com>
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

Commit cf96ec231d02 ("net/ice: use common Tx path selection
infrastructure") changed the way that secondary processes selected their
Tx burst function. Instead of letting secondary processes select their
own function, they now used the function selected by the primary
process. However, the primary process only selects the function at
device start, so if the primary process hadn't started the device by the
time the secondary process was selecting its Tx burst function, the
secondary process would not select the correct function.

This commit addresses this issue by allowing the secondary process to
select the path if the device has not been started yet.

Fixes: cf96ec231d02 ("net/ice: use common Tx path selection infrastructure")

Signed-off-by: Ciara Loftus <ciara.loftus@intel.com>
---
 drivers/net/intel/ice/ice_rxtx.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/net/intel/ice/ice_rxtx.c b/drivers/net/intel/ice/ice_rxtx.c
index bbd9cfa7a5..8ed47b957f 100644
--- a/drivers/net/intel/ice/ice_rxtx.c
+++ b/drivers/net/intel/ice/ice_rxtx.c
@@ -4163,8 +4163,8 @@ ice_set_tx_function(struct rte_eth_dev *dev)
 		.simd_width = RTE_VECT_SIMD_DISABLED,
 	};
 
-	/* The primary process selects the tx path for all processes. */
-	if (rte_eal_process_type() != RTE_PROC_PRIMARY)
+	/* If the device has started the function has already been selected. */
+	if (dev->data->dev_started)
 		goto out;
 
 	req_features.simple_tx = ad->tx_simple_allowed;
-- 
2.43.0

