Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B9F1B606A32A
	for <dpdk-dev@archiver.kernel.org>; Wed, 18 Nov 2026 10:30:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=kDbFyKGR
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id DA8324029D;
	Wed, 18 Nov 2026 11:30:08 +0100 (CET)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
 by mails.dpdk.org (Postfix) with ESMTPS id E1C1140298;
 Wed, 18 Nov 2026 11:30:06 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1794997807; x=1826533807;
 h=from:to:cc:subject:date:message-id:mime-version:
 content-transfer-encoding;
 bh=oPkjfrxUfsGTnfWS1j6MohgRIlhBCS5O4UIU922X+BA=;
 b=kDbFyKGRwl3cZYglpRN70HPD5OgSZQSjV0rfPwAfJnVolZEHdFYRVj/2
 q7e41d14NmoAUe2ZMMVwtWdtWGyTNYqlz69d5iDMzoj1i2KchIldHYX5V
 mSq1rFjw4RNOQAfSM65DG58/3ZeFOOIBcY4JOrMJazmrHITH/MiiPZPe+
 t3Ls1l3jLPls1Gpyce90y6poNA4DjoAxma7OXkGuqccvBAi9yQmjdAuSz
 HUNC6ufx0XTJN1Nfb+K9nw66PaOhFzeQPbOcjMmPj5CkGRg11yW+kOR72
 u4HL0d4D7PKIOkmxRyZRSj9T3z1aMCuDdeY+DwDYq0vLhPuf6CgrfpYyC w==;
X-CSE-ConnectionGUID: u70bibmtTKO0ZIywZpBcnA==
X-CSE-MsgGUID: ulKhca+HRu6sBLa2rNL+pA==
X-IronPort-AV: E=McAfee;i="6800,10657,11969"; a="3793276"
X-IronPort-AV: E=Sophos;i="6.27,219,1787036400"; 
   d="scan'208";a="3793276"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
 by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 18 Nov 2026 02:30:01 -0800
X-CSE-ConnectionGUID: 56S4tKOxS86Ouu4mtpPkZw==
X-CSE-MsgGUID: aF+oW1/aTeOMtSyZFSd8jw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,219,1787036400"; d="scan'208";a="10056784"
Received: from silpixa00401385.ir.intel.com ([10.20.224.226])
 by orviesa007.jf.intel.com with ESMTP; 18 Nov 2026 02:30:00 -0800
From: Bruce Richardson <bruce.richardson@intel.com>
To: dev@dpdk.org
Cc: Bruce Richardson <bruce.richardson@intel.com>,
	stable@dpdk.org
Subject: [PATCH] Revert "net/e1000: fix queue number initialization"
Date: Wed, 18 Nov 2026 10:29:27 +0000
Message-ID: <20261118102927.2679783-1-bruce.richardson@intel.com>
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

This reverts commit c1a42d646472fd3477429bf016f682e0865b77f0.

Although the hardware supported by the driver supports 2 queues, as
explained by the comment in the code, in practice only one queue per
port is usable. Therefore, revert the change upping the queue count, and
aligning the code with the comments in it.

Bugzilla ID: 2147
Fixes: c1a42d646472 ("net/e1000: fix queue number initialization")
Cc: stable@dpdk.org

Signed-off-by: Bruce Richardson <bruce.richardson@intel.com>
---
 drivers/net/intel/e1000/em_ethdev.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/net/intel/e1000/em_ethdev.c b/drivers/net/intel/e1000/em_ethdev.c
index be830881db..80029aa87b 100644
--- a/drivers/net/intel/e1000/em_ethdev.c
+++ b/drivers/net/intel/e1000/em_ethdev.c
@@ -1220,8 +1220,8 @@ eth_em_infos_get(struct rte_eth_dev *dev, struct rte_eth_dev_info *dev_info)
 	 * To avoid it we support just one RX queue for now (no RSS).
 	 */
 
-	dev_info->max_rx_queues = 2;
-	dev_info->max_tx_queues = 2;
+	dev_info->max_rx_queues = 1;
+	dev_info->max_tx_queues = 1;
 
 	dev_info->rx_queue_offload_capa = em_get_rx_queue_offloads_capa();
 	dev_info->rx_offload_capa = em_get_rx_port_offloads_capa() |
-- 
2.55.0

