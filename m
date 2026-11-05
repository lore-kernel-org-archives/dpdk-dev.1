Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 126E6606A31B
	for <dpdk-dev@archiver.kernel.org>; Thu,  5 Nov 2026 12:33:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=CanPELYc
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 13765427A0;
	Thu,  5 Nov 2026 13:33:04 +0100 (CET)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
 by mails.dpdk.org (Postfix) with ESMTPS id 0DDBE4060F;
 Thu,  5 Nov 2026 13:33:00 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1793881981; x=1825417981;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=Vym37fI8tG0Yi/JPKEad/OLtHBTu51TDoNF+F9P44jU=;
 b=CanPELYcvokeG1dPXts2H6vQ3Mv+S61S+VNcDnjj5lzqezMIMi4wPamE
 93UCocnEk+KHz2k2O4J7zaLPwOl35X6UyVH2kRBZ9ym+d3+dQOOxwOpSX
 bWMTC21KEuPCTGyJbxFBmmJld63sa/C8thgfP+/dn+EW9gsyOz0fzSPbH
 nf3Kots2a9zKVhxQh/cwAO4V2piAEzJwSJIfl6/zlOQTKa1jrP6t7ZrYH
 x7Q7/vSPbtmOUNzE3zE6onL3PECl4vXXvDHKcVp79zzpzXMa3RNPnPLH9
 d5sSr7jDpRcTA2QM6C/YJc//HtEQanSTRLnWclpFE8Gr2xPO5ZFH9C5fH w==;
X-CSE-ConnectionGUID: C+/WCrazSaKlqZW+QkQKaQ==
X-CSE-MsgGUID: 4/qezJkkShCJw1wQw2tb9w==
X-IronPort-AV: E=McAfee;i="6800,10657,11956"; a="2556070"
X-IronPort-AV: E=Sophos;i="6.27,197,1787036400"; 
   d="scan'208";a="2556070"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
 by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 05 Nov 2026 04:32:59 -0800
X-CSE-ConnectionGUID: V8qdhmw4SZm1XqjO6pPs3A==
X-CSE-MsgGUID: z/tO7HkOQsa8n5w0Pdc2mg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,197,1787036400"; 
   d="scan'208";a="7062117"
Received: from silpixa00401177.ir.intel.com (HELO vm-icx177..)
 ([10.20.224.214])
 by orviesa006.jf.intel.com with ESMTP; 05 Nov 2026 04:32:59 -0800
From: Ciara Loftus <ciara.loftus@intel.com>
To: dev@dpdk.org
Cc: Ciara Loftus <ciara.loftus@intel.com>, stable@dpdk.org,
 Bruce Richardson <bruce.richardson@intel.com>
Subject: [PATCH v3 2/4] net/iavf: fix event handler leak on init failure
Date: Thu,  5 Nov 2026 12:32:26 +0000
Message-ID: <20261105123237.12279-3-ciara.loftus@intel.com>
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

iavf_dev_init() takes a reference on the shared event handler, but
does not release it if initialisation subsequently fails. The event
thread and its pipe are then never released.

Release the reference on these error paths. Skip it during reset
recovery, where no reference is taken.

Fixes: cb5c1b91f76f ("net/iavf: add thread for event callbacks")
Cc: stable@dpdk.org

Signed-off-by: Ciara Loftus <ciara.loftus@intel.com>
Acked-by: Bruce Richardson <bruce.richardson@intel.com>
---
 drivers/net/intel/iavf/iavf_ethdev.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/net/intel/iavf/iavf_ethdev.c b/drivers/net/intel/iavf/iavf_ethdev.c
index 47aa6ecb6f..05b90a6230 100644
--- a/drivers/net/intel/iavf/iavf_ethdev.c
+++ b/drivers/net/intel/iavf/iavf_ethdev.c
@@ -3089,6 +3089,8 @@ iavf_dev_init(struct rte_eth_dev *eth_dev)
 
 	if (iavf_init_vf(eth_dev) != 0) {
 		PMD_INIT_LOG(ERR, "Init vf failed");
+		if (!rte_atomic_load_explicit(&vf->in_reset_recovery, rte_memory_order_relaxed))
+			iavf_dev_event_handler_fini();
 		return -1;
 	}
 
@@ -3190,6 +3192,9 @@ iavf_dev_init(struct rte_eth_dev *eth_dev)
 
 	eth_dev->data->mac_addrs = NULL;
 
+	if (!rte_atomic_load_explicit(&vf->in_reset_recovery, rte_memory_order_relaxed))
+		iavf_dev_event_handler_fini();
+
 init_vf_err:
 	iavf_uninit_vf(eth_dev);
 
-- 
2.43.0

