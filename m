Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 06D78606A328
	for <dpdk-dev@archiver.kernel.org>; Tue,  3 Nov 2026 17:31:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=evVhOiP+
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 6A971427B4;
	Tue,  3 Nov 2026 18:30:51 +0100 (CET)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
 by mails.dpdk.org (Postfix) with ESMTPS id 16F86400D6;
 Tue,  3 Nov 2026 18:30:47 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1793727049; x=1825263049;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=akXwOvRCeB/IiXaAxTqPmdSCtYzNoARdsz81pVrf7uY=;
 b=evVhOiP+5iVp/2QTeYLTRUoBGnDOJFLT3tsXeKFZrOKdvLvCWCfkstp0
 gfWWUh+nlzV8Xe78WS5QraQFbd3Qcu7hXUIfsj/nV7Nr1hGTPzeqSPm0j
 gAnYUDLK6tC31MjPB3ZAwCAlLKu6mQ0Var7B3tKsSYUBS0R8K+LUZnZcf
 jxeV28iUHClH698PFnJBQGyqrBfiYSVUbXrEWEsONqLBlihGX3f6FaWwR
 j8TF/41bSvk+V0rTxvFYF79SWc8YILJBIimDk0BuzmQAeLAd6fiwAqSXe
 hmQ8uvge9SD3+swkla7NQ9l0gogtJoeL2FBz1jpht75dXFMUc3pvwlIPE A==;
X-CSE-ConnectionGUID: tOjaTI58Qxi3HuMNPZLduA==
X-CSE-MsgGUID: Yv2hCKJlSAixNXpUm+hquQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11955"; a="2553284"
X-IronPort-AV: E=Sophos;i="6.27,193,1787036400"; 
   d="scan'208";a="2553284"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
 by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 03 Nov 2026 09:28:59 -0800
X-CSE-ConnectionGUID: Sn+niwiGSDOKEjTfin+WOw==
X-CSE-MsgGUID: iS4KaTRGRNeoxGhNwoZbiw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,193,1787036400"; 
   d="scan'208";a="6495713"
Received: from unknown (HELO an4-swa15-spr.example.org) ([10.241.130.94])
 by fmviesa004.fm.intel.com with ESMTP; 03 Nov 2026 09:28:58 -0800
From: Hernan Vargas <hernan.vargas@intel.com>
To: dev@dpdk.org, gakhil@marvell.com, trix@redhat.com,
 maxime.coquelin@redhat.com
Cc: nicolas.chautru@intel.com, qi.z.zhang@intel.com,
 Hernan Vargas <hernan.vargas@intel.com>, stable@dpdk.org
Subject: [PATCH v1 4/5] baseband/acc: fix ring interrupt handler err path
Date: Tue,  3 Nov 2026 09:29:01 -0800
Message-Id: <20261103172902.4152956-5-hernan.vargas@intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20261103172902.4152956-1-hernan.vargas@intel.com>
References: <20261103172902.4152956-1-hernan.vargas@intel.com>
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

When get_queue_id_from_ring_info() fails to match a queue index
(returning UINT16_MAX), an early return skipped clearing the ring
entry and advancing the head pointer. This left the valid bit set,
causing the same malformed entry to be reprocessed on every
subsequent interrupt, blocking all further ring processing.

Replace the return with break so the entry is consumed and the
loop continues normally. Fix applies to both PF and VF paths.

Fixes: 3cabc8eaf524 ("baseband/acc200: support interrupt")
Cc: stable@dpdk.org

Signed-off-by: Hernan Vargas <hernan.vargas@intel.com>
---
 drivers/baseband/acc/rte_vrb_pmd.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/baseband/acc/rte_vrb_pmd.c b/drivers/baseband/acc/rte_vrb_pmd.c
index b9ff027ce8..803e0c9177 100644
--- a/drivers/baseband/acc/rte_vrb_pmd.c
+++ b/drivers/baseband/acc/rte_vrb_pmd.c
@@ -454,7 +454,7 @@ vrb_dev_interrupt_handler(void *cb_arg)
 					rte_bbdev_log(ERR,
 							"Couldn't find queue: aq_id: %u, qg_id: %u, vf_id: %u",
 							aq_id, qg_id, vf_id);
-					return;
+					break;
 				}
 				rte_bbdev_pmd_callback_process(dev,
 						RTE_BBDEV_EVENT_DEQUEUE, &deq_intr_det);
@@ -482,7 +482,7 @@ vrb_dev_interrupt_handler(void *cb_arg)
 					rte_bbdev_log(ERR,
 							"Couldn't find queue: aq_id: %u, qg_id: %u",
 							aq_id, qg_id);
-					return;
+					break;
 				}
 				rte_bbdev_pmd_callback_process(dev,
 						RTE_BBDEV_EVENT_DEQUEUE, &deq_intr_det);
-- 
2.34.1

