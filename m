Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B8446074640
	for <dpdk-dev@archiver.kernel.org>; Mon,  2 Nov 2026 15:46:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=ejUBIOu5
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 24EF0402E3;
	Mon,  2 Nov 2026 16:46:15 +0100 (CET)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
 by mails.dpdk.org (Postfix) with ESMTPS id 75C2E4028D;
 Mon,  2 Nov 2026 16:46:13 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1793634373; x=1825170373;
 h=from:to:cc:subject:date:message-id:mime-version:
 content-transfer-encoding;
 bh=+ChnEvAydnZ5komn/ZjM32PSm5uHkhuAS85mXgSLaJ8=;
 b=ejUBIOu5VmjM8D6JrisXSOLHSUMZd4oetY1klpyxh2vzCPY7xjorUinE
 Z5N+HMpMLAmyse7l53RJa0/WtUQM17gACJCRkjsSsHaLVZCGsFs3YytEJ
 743+3+maMprM96lXQ59vRgmhFFfq9fdiTM0X7vsu4u3SCGGOvnsQGnTaO
 s98QSr0FxDQmgxPI3ujiSUyrg8cLY6xF0hrag5pAwWZxVPXrGinaQ0SzI
 20cw9eVoLt9bBC7RDpmBvKlncOcapPDw9+F7+jUrHiHepr+mnpih/C1aM
 KJudYmEUsd0F/eBHIUyZS8XJSFtN4na8RvkPsRWVyioeYNc4Ir9y/Wh2U g==;
X-CSE-ConnectionGUID: tZ/FsQypTeiH9mKr1lp51A==
X-CSE-MsgGUID: rAU8W5BMQ+iRxvmNzu8lqA==
X-IronPort-AV: E=McAfee;i="6800,10657,11954"; a="2333603"
X-IronPort-AV: E=Sophos;i="6.27,191,1787036400"; 
   d="scan'208";a="2333603"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
 by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 02 Nov 2026 07:46:11 -0800
X-CSE-ConnectionGUID: 9g0itCg+RdSfq7Gy9tNncg==
X-CSE-MsgGUID: ntGKe+2xQyqd8DDrH8UI1A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,191,1787036400"; 
   d="scan'208";a="6203741"
Received: from silpixa00401177.ir.intel.com (HELO vm-icx177..)
 ([10.20.224.214])
 by orviesa006.jf.intel.com with ESMTP; 02 Nov 2026 07:46:10 -0800
From: Ciara Loftus <ciara.loftus@intel.com>
To: dev@dpdk.org
Cc: Ciara Loftus <ciara.loftus@intel.com>,
	stable@dpdk.org
Subject: [PATCH] net/iavf: fix crash in Tx drain on PF reset
Date: Mon,  2 Nov 2026 15:45:58 +0000
Message-ID: <20261102154558.78361-1-ciara.loftus@intel.com>
X-Mailer: git-send-email 2.43.0
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-BeenThere: dev@dpdk.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: DPDK patches and discussions <dev.dpdk.org>
List-Archive: <http://mails.dpdk.org/archives/dev/>
List-Post: <mailto:dev@dpdk.org>
List-Help: <mailto:dev-request@dpdk.org?subject=help>
List-Subscribe: <https://mails.dpdk.org/listinfo/dev>,
 <mailto:dev-request@dpdk.org?subject=subscribe>
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

The Tx cleanup helpers check the DD bit of the descriptor at the next
RS boundary and assume software has already posted it. The burst path
guarantees this by only cleaning up when nb_tx_free drops below
tx_free_thresh, but iavf_dev_tx_drain() called the helpers on any
non-empty queue.

With fewer than tx_rs_thresh descriptors outstanding, that descriptor
still held the DESC_DONE value set by reset_tx_queue(), so the helpers
treated the block as complete and freed NULL (or already freed) mbufs,
crashing on PF reset.

Only clean up a queue once a full RS block is outstanding.

Fixes: 30e1aab01bae ("net/iavf: drain in-flight Tx before reset")
Cc: stable@dpdk.org

Signed-off-by: Ciara Loftus <ciara.loftus@intel.com>
---
 drivers/net/intel/iavf/iavf_rxtx.c | 8 +++-----
 1 file changed, 3 insertions(+), 5 deletions(-)

diff --git a/drivers/net/intel/iavf/iavf_rxtx.c b/drivers/net/intel/iavf/iavf_rxtx.c
index 84b931e78a..8c84991b86 100644
--- a/drivers/net/intel/iavf/iavf_rxtx.c
+++ b/drivers/net/intel/iavf/iavf_rxtx.c
@@ -4098,11 +4098,9 @@ iavf_dev_tx_drain(struct rte_eth_dev *dev)
 				RTE_ETH_QUEUE_STATE_STARTED)
 				continue;
 
-			/*
-			 * nb_tx_free == nb_tx_desc - 1 means the ring is
-			 * empty (one descriptor is always reserved).
-			 */
-			if (txq->nb_tx_free >= txq->nb_tx_desc - 1)
+			/* Only clean up once a full RS block is outstanding. */
+			if ((uint16_t)(txq->nb_tx_desc - 1 - txq->nb_tx_free) <
+			    txq->tx_rs_thresh)
 				continue;
 
 			any_pending = true;
-- 
2.43.0

