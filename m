Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 11A0F606A888
	for <dpdk-dev@archiver.kernel.org>; Thu, 12 Nov 2026 11:31:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=RaMmJsIS
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 6D2F740682;
	Thu, 12 Nov 2026 12:31:12 +0100 (CET)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
 by mails.dpdk.org (Postfix) with ESMTPS id B8D34402A2;
 Thu, 12 Nov 2026 12:31:09 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1794483070; x=1826019070;
 h=from:to:cc:subject:date:message-id:mime-version:
 content-transfer-encoding;
 bh=SfBjRyw+pPHjXegTmd4m31lGHIf72okBUpKSXeSYoEM=;
 b=RaMmJsISpgn78kWm+piq9Tdnqym9f7aoL6UU5v3j7Rw9zRR/P5UQdPo6
 SEMoU5Yi0JKDW4JNcgp05T+iIrdm8umi3CmAvITAIK7MvBI4f/BuCO0km
 95kCMI/tAj7TqL0c7taDjbZ/ulp0HVA2ZvBa8KA85fjmm2mW7WK0kDb/E
 bOAjIaF2dgnWl/yPcyf53M6BVWaIhXzU3PxVLBJm92Llsbc2Egu/lZGhQ
 tRQSbkXWBEZdUVd14mQOztrggImYehiG+J0ekBh8X0XjppryEAiIJISY3
 B0EPk37IdULKVl+msT2oObndDivHwzQEjgoewnZhbxAczuR7WRbZlsCbQ g==;
X-CSE-ConnectionGUID: mVqigVPZRnGRytzve+82qg==
X-CSE-MsgGUID: v0RNvQv/RmmJVFw9+xvOXg==
X-IronPort-AV: E=McAfee;i="6800,10657,11963"; a="3165965"
X-IronPort-AV: E=Sophos;i="6.27,209,1787036400"; 
   d="scan'208";a="3165965"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
 by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 12 Nov 2026 03:31:07 -0800
X-CSE-ConnectionGUID: MsH/s7lySMarGbWgRd+8pA==
X-CSE-MsgGUID: 6YjYQRK/Q/OH+bpUPSRcVA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,209,1787036400"; 
   d="scan'208";a="8804896"
Received: from silpixa00401385.ir.intel.com ([10.20.227.220])
 by fmviesa002.fm.intel.com with ESMTP; 12 Nov 2026 03:31:07 -0800
From: Bruce Richardson <bruce.richardson@intel.com>
To: dev@dpdk.org
Cc: Bruce Richardson <bruce.richardson@intel.com>, stable@dpdk.org,
 Naga Harish K S V <s.v.naga.harish.k@intel.com>,
 Jerin Jacob <jerinj@marvell.com>, Nikhil Rao <nikhil.rao@intel.com>
Subject: [PATCH] test/event_eth_rx_adapter: reduce memory footprint
Date: Thu, 12 Nov 2026 11:30:58 +0000
Message-ID: <20261112113059.2448878-1-bruce.richardson@intel.com>
X-Mailer: git-send-email 2.55.0
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

The event ethernet Rx adapter autotest was allocating far more buffers
than was actually needed. In a test run, the rings/queues were sized at
512 entries, but the NB_MBUFS calculation allocated 8k buffers in the
pool for each queue.

Using a buffer count value of 1k per queue is more reasonable, reducing
the memory size required by 7/8ths, while still allowing plenty of
headroom in the allocation.

Fixes: fc8030eb8fe9 ("test/eventdev: add tests for eth Rx adapter APIs")
Cc: stable@dpdk.org

Signed-off-by: Bruce Richardson <bruce.richardson@intel.com>
---
 app/test/test_event_eth_rx_adapter.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/app/test/test_event_eth_rx_adapter.c b/app/test/test_event_eth_rx_adapter.c
index 7b38935bec..82eace93fe 100644
--- a/app/test/test_event_eth_rx_adapter.c
+++ b/app/test/test_event_eth_rx_adapter.c
@@ -34,7 +34,7 @@ test_event_eth_rx_intr_adapter_common(void)
 #include <rte_event_eth_rx_adapter.h>
 
 #define MAX_NUM_RX_QUEUE	64
-#define NB_MBUFS		(8192 * num_ports * MAX_NUM_RX_QUEUE)
+#define NB_MBUFS		(1024 * num_ports * MAX_NUM_RX_QUEUE)
 #define MBUF_CACHE_SIZE		512
 #define MBUF_PRIV_SIZE		0
 #define TEST_INST_ID		0
-- 
2.55.0

