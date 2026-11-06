Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A291606A920
	for <dpdk-dev@archiver.kernel.org>; Fri,  6 Nov 2026 09:40:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=TNttF/Ep
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id CB43D42D28;
	Fri,  6 Nov 2026 10:40:28 +0100 (CET)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
 by mails.dpdk.org (Postfix) with ESMTPS id C65F94026A;
 Fri,  6 Nov 2026 10:40:25 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1793958026; x=1825494026;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=buie4AUDWolwbrareSFKS38WVzHr4LJZeqUrg5lTRBM=;
 b=TNttF/Ep9DtHBVLCKejvVsz9YZ9t5qoTghWPAKqTTtuS8tqV/S3Dv0wU
 3c4CNTXvMXF3LSM4L8kJYaVaAEuQOsI1Ici6GQkKqHhSu7wm/OtDX82tW
 rkZChg5xLMKJ+T5LpQhUZlUA+cJ9MvAKhQXTbaXgG+lwm/N8aXd6yXPFP
 Rn9+0dPPZBYfrUD/OzWGSLwYMQgjHBohgAp5QWhgItV55Z/1gEh1nmCPn
 spotk3S6zRBACivrJAoxSgPMJRBAMONAkuYMfwPr2+vpLM8xttvx46oDE
 LrTuxbSxicF+UQyTSXzPw4LS/vpfFBi+mgXbTHPQfEe1YgctOfrilplPA A==;
X-CSE-ConnectionGUID: JL3lIOxURD2PYS9hklZT2w==
X-CSE-MsgGUID: EIp7LOa4RviUKEongskKPw==
X-IronPort-AV: E=McAfee;i="6800,10657,11957"; a="2808506"
X-IronPort-AV: E=Sophos;i="6.27,197,1787036400"; 
   d="scan'208";a="2808506"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
 by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 06 Nov 2026 01:40:24 -0800
X-CSE-ConnectionGUID: spZTyhbIRDqv6ylxANqDAg==
X-CSE-MsgGUID: 7bLHTyq3QbywZQm/aJB8Rw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,197,1787036400"; 
   d="scan'208";a="7287082"
Received: from silpixa00401177.ir.intel.com (HELO vm-icx177..)
 ([10.20.224.214])
 by orviesa002.jf.intel.com with ESMTP; 06 Nov 2026 01:40:23 -0800
From: Ciara Loftus <ciara.loftus@intel.com>
To: dev@dpdk.org
Cc: Ciara Loftus <ciara.loftus@intel.com>, stable@dpdk.org,
 Bruce Richardson <bruce.richardson@intel.com>
Subject: [PATCH v4 1/4] net/iavf: fix crash in Tx drain on PF reset
Date: Fri,  6 Nov 2026 09:40:09 +0000
Message-ID: <20261106094014.28784-2-ciara.loftus@intel.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261106094014.28784-1-ciara.loftus@intel.com>
References: <20261105123237.12279-1-ciara.loftus@intel.com>
 <20261106094014.28784-1-ciara.loftus@intel.com>
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
Acked-by: Bruce Richardson <bruce.richardson@intel.com>
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

