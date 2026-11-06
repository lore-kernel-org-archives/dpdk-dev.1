Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6084A606A338
	for <dpdk-dev@archiver.kernel.org>; Fri,  6 Nov 2026 09:40:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=C1Ej/1oN
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id C97C842D9D;
	Fri,  6 Nov 2026 10:40:29 +0100 (CET)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
 by mails.dpdk.org (Postfix) with ESMTPS id A5BBD4026A;
 Fri,  6 Nov 2026 10:40:26 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1793958027; x=1825494027;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=Vym37fI8tG0Yi/JPKEad/OLtHBTu51TDoNF+F9P44jU=;
 b=C1Ej/1oNFo53trwgs9/j1K+qtzOB4ctsZnRE2z01wFi8J3k89TYzP+/S
 l4X/B0YSHWhqoq9te2K9iB/NC9KJ9HUkyxAd55nexpwmRRcn2SyTbs1Ue
 hf0EB9J90pQc+Y/4MA/va8nUZV0TwEdNgw2iWhWtwJXwEHGnf3L4zG9d3
 ctodmEdcHhmx1WtDr5O1YQtEiYD4i3PDCyzj8JX0DC/45XLIN3nChl7y1
 g793o7DtcIpXhLwCvA6PQgzWusbnY46VdyPA9+5MT8bauQoFNVlWQ8agj
 KNtnrdKEjVaLsMzIogPgZIkPf29+llOH6/B+HMp8Qc0tzgqZmO1hQch0o g==;
X-CSE-ConnectionGUID: VNsoguvbTjG4vbpbhejtlg==
X-CSE-MsgGUID: cPDU7fPGQR6RpP771pLzOA==
X-IronPort-AV: E=McAfee;i="6800,10657,11957"; a="2808508"
X-IronPort-AV: E=Sophos;i="6.27,197,1787036400"; 
   d="scan'208";a="2808508"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
 by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 06 Nov 2026 01:40:25 -0800
X-CSE-ConnectionGUID: BhRhFAEBTNyzB8V2PTFOYA==
X-CSE-MsgGUID: Zhu8CY4UQjiVks5BJAsTlQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,197,1787036400"; 
   d="scan'208";a="7287092"
Received: from silpixa00401177.ir.intel.com (HELO vm-icx177..)
 ([10.20.224.214])
 by orviesa002.jf.intel.com with ESMTP; 06 Nov 2026 01:40:24 -0800
From: Ciara Loftus <ciara.loftus@intel.com>
To: dev@dpdk.org
Cc: Ciara Loftus <ciara.loftus@intel.com>, stable@dpdk.org,
 Bruce Richardson <bruce.richardson@intel.com>
Subject: [PATCH v4 2/4] net/iavf: fix event handler leak on init failure
Date: Fri,  6 Nov 2026 09:40:10 +0000
Message-ID: <20261106094014.28784-3-ciara.loftus@intel.com>
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

