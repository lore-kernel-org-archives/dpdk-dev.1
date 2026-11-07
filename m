Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB89D606A32E
	for <dpdk-dev@archiver.kernel.org>; Sat,  7 Nov 2026 23:57:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=FfpmNt5T
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id BB40240E44;
	Sun,  8 Nov 2026 00:57:30 +0100 (CET)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.18])
 by mails.dpdk.org (Postfix) with ESMTPS id B117D40E32;
 Sun,  8 Nov 2026 00:57:28 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1794095850; x=1825631850;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=Jx4uwcg67X3cTFuoQgmM5HAkMYlpxevUwb0FfBp71W4=;
 b=FfpmNt5TvACqmQXpx/OqG9nW+m3FudaENGz7AuUXG5kslGGwsmLvvBTZ
 O73vInm7bSakqwLjc95Ed/TGYuYdm/Cru26EsZNL/o4MlyO2P6M/0T6Ug
 8nCqCdOgTh4pZ5pl290TCtqVUJIb9lc0K5QBM/OFEe9RMDWoW1+UL7WMn
 bQNcIHF5pYReQabyJnRaJg2XU7ms403u1VWpEQ1Cxl0UH6VXF8tZnTvBV
 4T1QkIG7/JZ/19sBwyozXphHFmAKAhgVd6WawAjnkR+Tt8EPVEJmZk+Em
 MyF5GMGLvp6EV7ogGwmR73LgZa2EjC88CcmzNDaoPL9lACJSVx7ZvLP7c w==;
X-CSE-ConnectionGUID: fwO30S95Q4KEkVr2shS4ZQ==
X-CSE-MsgGUID: RjUM8dRgRA+HRf/+BmUuKw==
X-IronPort-AV: E=McAfee;i="6800,10657,11959"; a="2885089"
X-IronPort-AV: E=Sophos;i="6.27,200,1787036400"; 
   d="scan'208";a="2885089"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
 by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 07 Nov 2026 15:57:29 -0800
X-CSE-ConnectionGUID: OXS71SglQ/KqLbchElvlyg==
X-CSE-MsgGUID: BE9W5ePqRKS7o/0EZSwxPQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,200,1787036400"; 
   d="scan'208";a="7464639"
Received: from pae.iind.intel.com (HELO PAE-35.iind.intel.com) ([10.49.105.82])
 by orviesa005.jf.intel.com with ESMTP; 07 Nov 2026 15:57:27 -0800
From: Anurag Mandal <anurag.mandal@intel.com>
To: dev@dpdk.org
Cc: bruce.richardson@intel.com, anatoly.burakov@intel.com,
 Anurag Mandal <anurag.mandal@intel.com>, stable@dpdk.org
Subject: [PATCH v2 3/8] net/ice: fix DCF queue config buffer leak
Date: Sat,  7 Nov 2026 23:52:13 +0000
Message-Id: <d30ff6ff12783f5665c5ebe8e8b9a7d6cd4d2a94.1794094943.git.anurag.mandal@intel.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <cover.1794094943.git.anurag.mandal@intel.com>
References: <cover.1794094943.git.anurag.mandal@intel.com>
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

ice_dcf_configure_queues() returns -EINVAL without
freeing the virtchnl message it allocated when the
required Rx descriptor ID (RXDID) is not supported,
so the message leaks on each failed port start.

Free it before return.

Fixes: 4b0d391f0eab ("net/ice: add queue config in DCF")
Fixes: f3fddc93de16 ("net/ice: fix build with 16-byte Rx descriptor in DCF")
Cc: stable@dpdk.org

Signed-off-by: Anurag Mandal <anurag.mandal@intel.com>
Acked-by: Bruce Richardson <bruce.richardson@intel.com>
---
 drivers/net/intel/ice/ice_dcf.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/net/intel/ice/ice_dcf.c b/drivers/net/intel/ice/ice_dcf.c
index 0295ebe4fe..f94856ad9c 100644
--- a/drivers/net/intel/ice/ice_dcf.c
+++ b/drivers/net/intel/ice/ice_dcf.c
@@ -1232,6 +1232,7 @@ ice_dcf_configure_queues(struct ice_dcf_hw *hw)
 				    "Queue[%d]", vc_qp->rxq.rxdid, i);
 		} else {
 			PMD_DRV_LOG(ERR, "RXDID 16 is not supported");
+			rte_free(vc_config);
 			return -EINVAL;
 		}
 #else
@@ -1244,6 +1245,7 @@ ice_dcf_configure_queues(struct ice_dcf_hw *hw)
 					"Queue[%d]", vc_qp->rxq.rxdid, i);
 		} else {
 			PMD_DRV_LOG(ERR, "RXDID == 0 is not supported");
+			rte_free(vc_config);
 			return -EINVAL;
 		}
 #endif
-- 
2.25.1

