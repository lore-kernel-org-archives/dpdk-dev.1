Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ABE2C606A31B
	for <dpdk-dev@archiver.kernel.org>; Thu,  5 Nov 2026 09:53:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=eKLGLw2x
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 4F08F4278B;
	Thu,  5 Nov 2026 10:53:16 +0100 (CET)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
 by mails.dpdk.org (Postfix) with ESMTPS id 3A5FD4278B;
 Thu,  5 Nov 2026 10:53:15 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1793872396; x=1825408396;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=bdOkDF7J7LCBtRLPxuylClObVsqkrf1HVSJc5FMzOis=;
 b=eKLGLw2xVD4ZQe8JD2zg7FOh5QQ4dj+LKSG9SQshtv5pSx6wDIMyzeAl
 iga4+neKKVnJmvPJo8S2/Wt3gWG3xUbBIcEOW0EKfquAUb9BAV44mtY4f
 /iE1sH2dU/NQuTqd9C1bAFuV92cQ7tLubpkhzn9ggkMRMSt8vQ7uhN7bS
 LyfXFox1Lw7N99Gu5abPQDu8pQ1ez6qwmxgl+Z+4v8UYjX7xfuJnmdG5v
 jZsG5MnOzRjh70TB3bO2AlxL90vKCW9sPGFPHh+m8QB3LeJnDLU6u5I7c
 1Y9r4zjyNYvrof3dlbdivss6xcn5+8v8XnIAnZOnpG7F47CDG8n9qrmPZ g==;
X-CSE-ConnectionGUID: cgQoKM0fTTuApP6rqCmviw==
X-CSE-MsgGUID: RrJBEa8eQESrfBrVXh6u1Q==
X-IronPort-AV: E=McAfee;i="6800,10657,11956"; a="2683970"
X-IronPort-AV: E=Sophos;i="6.27,197,1787036400"; 
   d="scan'208";a="2683970"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
 by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 05 Nov 2026 01:53:15 -0800
X-CSE-ConnectionGUID: th+lZr4NSf6B5ouMydtimg==
X-CSE-MsgGUID: YMv4My4cQ6WHqtr0k+/N2g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,197,1787036400"; 
   d="scan'208";a="7034308"
Received: from pae.iind.intel.com (HELO PAE-35.iind.intel.com) ([10.49.105.82])
 by orviesa006.jf.intel.com with ESMTP; 05 Nov 2026 01:53:13 -0800
From: Anurag Mandal <anurag.mandal@intel.com>
To: dev@dpdk.org
Cc: bruce.richardson@intel.com, anatoly.burakov@intel.com,
 Anurag Mandal <anurag.mandal@intel.com>, stable@dpdk.org
Subject: [PATCH 6/8] net/ice: fix DCF TM config leak on close
Date: Thu,  5 Nov 2026 09:47:23 +0000
Message-Id: <bfdadcc397cf1d1569dc23ec99317f910c66a8bb.1793871697.git.anurag.mandal@intel.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <cover.1793871697.git.anurag.mandal@intel.com>
References: <cover.1793871697.git.anurag.mandal@intel.com>
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

ice_dcf_uninit_hw() releases the TM nodes and shaper profiles only
when the hierarchy gets committed.
If the application adds nodes or profiles but never commits them,
or the commit fails without clearing them, they leak on close and
reset.

Only clearing the bandwidth needs a committed hierarchy,
so releasing the TM config whenever QoS is supported.

Fixes: 775a25a372f5 ("net/ice: clear QoS bandwidth on DCF close")
Cc: stable@dpdk.org

Signed-off-by: Anurag Mandal <anurag.mandal@intel.com>
---
 drivers/net/intel/ice/ice_dcf.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/net/intel/ice/ice_dcf.c b/drivers/net/intel/ice/ice_dcf.c
index c2b557d0da..df4212267d 100644
--- a/drivers/net/intel/ice/ice_dcf.c
+++ b/drivers/net/intel/ice/ice_dcf.c
@@ -886,11 +886,11 @@ ice_dcf_uninit_hw(struct rte_eth_dev *eth_dev, struct ice_dcf_hw *hw)
 	struct rte_intr_handle *intr_handle = pci_dev->intr_handle;
 	uint16_t i;
 
-	if (hw->vf_res->vf_cap_flags & VIRTCHNL_VF_OFFLOAD_QOS)
-		if (hw->tm_conf.committed) {
+	if (hw->vf_res->vf_cap_flags & VIRTCHNL_VF_OFFLOAD_QOS) {
+		if (hw->tm_conf.committed)
 			ice_dcf_clear_bw(hw);
-			ice_dcf_tm_conf_uninit(eth_dev);
-		}
+		ice_dcf_tm_conf_uninit(eth_dev);
+	}
 
 	ice_dcf_disable_irq0(hw);
 	rte_intr_disable(intr_handle);
-- 
2.25.1

