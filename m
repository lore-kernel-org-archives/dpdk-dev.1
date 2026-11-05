Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 07974606A328
	for <dpdk-dev@archiver.kernel.org>; Thu,  5 Nov 2026 12:33:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=d0Xky7EE
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 1F64840F1A;
	Thu,  5 Nov 2026 13:33:03 +0100 (CET)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
 by mails.dpdk.org (Postfix) with ESMTPS id BF73E40296;
 Thu,  5 Nov 2026 13:33:00 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1793881981; x=1825417981;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=buie4AUDWolwbrareSFKS38WVzHr4LJZeqUrg5lTRBM=;
 b=d0Xky7EEkRhwec6Qn4fIKCMSVfsD4DS6xHNcJluqpNXpFSF7r8BV0OW2
 YT0aURjn3DoeclvlxX6f1FhZL2IIFuW3Q/XDf2fdI44l5755a2c+oR3Tl
 Jn73HDorpJWjOnXPFK3wizsliTmIcgOHPAbS3yLuTn0kX89Zg6B2CvL0Y
 DurtNuyA7V4DXB+ZPMQ+X0hMefmvvcTY/M4svcC/CSV9JMnhDdjutNALY
 wplmz+NkT1TbK9ETquZoXlapOG6qu7T27XieHN2gJuDPvVpIAOsBOdWGu
 t531ggUGhr46hMMlRQzhAnyvM+EPETHFuFiMV75vl2vnLVQP5H2hiDkWa g==;
X-CSE-ConnectionGUID: Ym6b0gTpRLGF92ftdGfpxA==
X-CSE-MsgGUID: hWGz9ydiQeuiAqjSX81QGg==
X-IronPort-AV: E=McAfee;i="6800,10657,11956"; a="2556065"
X-IronPort-AV: E=Sophos;i="6.27,197,1787036400"; 
   d="scan'208";a="2556065"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
 by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 05 Nov 2026 04:32:58 -0800
X-CSE-ConnectionGUID: f5bY1/IdTOCC/n7l9Lwvwg==
X-CSE-MsgGUID: FA64OOyUQ8iCZIyi29WEqw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,197,1787036400"; 
   d="scan'208";a="7062114"
Received: from silpixa00401177.ir.intel.com (HELO vm-icx177..)
 ([10.20.224.214])
 by orviesa006.jf.intel.com with ESMTP; 05 Nov 2026 04:32:58 -0800
From: Ciara Loftus <ciara.loftus@intel.com>
To: dev@dpdk.org
Cc: Ciara Loftus <ciara.loftus@intel.com>, stable@dpdk.org,
 Bruce Richardson <bruce.richardson@intel.com>
Subject: [PATCH v3 1/4] net/iavf: fix crash in Tx drain on PF reset
Date: Thu,  5 Nov 2026 12:32:25 +0000
Message-ID: <20261105123237.12279-2-ciara.loftus@intel.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261105123237.12279-1-ciara.loftus@intel.com>
References: <20261104095510.10246-1-ciara.loftus@intel.com>
 <20261105123237.12279-1-ciara.loftus@intel.com>
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

