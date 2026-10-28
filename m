Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 06AD8606A31F
	for <dpdk-dev@archiver.kernel.org>; Wed, 28 Oct 2026 09:51:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=YGfaTdpb
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id D6DB940151;
	Wed, 28 Oct 2026 10:51:42 +0100 (CET)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
 by mails.dpdk.org (Postfix) with ESMTPS id 84930400D7
 for <dev@dpdk.org>; Wed, 28 Oct 2026 10:51:40 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1793181101; x=1824717101;
 h=from:to:subject:date:message-id:mime-version:
 content-transfer-encoding;
 bh=lJQn5W/bj25byX1IYJeHqk5S5dfcaEMQwUF43ZxgyvY=;
 b=YGfaTdpbU2Yl0v0Pz3/07RkNvkai02WExbT2cxCfWss2sYoZW0X3PXQi
 K+V36/z/tkWG2Hk1DF4j2JBNTSt1e8icFjxkj7nLXHkpfT3kXNVpQFGNK
 NJ+qG1Nvv1mzVc8nK1srheh00lKg180ZTssGHiXMQIAIuKX2ddkFt9gsy
 diDLI4Wg7jUtqGL7Vmq0YF+S+jig+KnodftDUJBfxCoKvExq5pMwEx6/s
 TmvGxSMo24IuxFX97J+BPJSXqc2+uCYg/cGnB2XTsgGY8KPLEy5tVWWdM
 WjNczU9aZ+4Rn0WC81ueFEbDI5OKA7k8iGGZPGWRPIERcuEWZy27Syetk w==;
X-CSE-ConnectionGUID: dnuzxs2ZReG1lsE58EkmOw==
X-CSE-MsgGUID: VbernF3TRd6B3PnddQfv4A==
X-IronPort-AV: E=McAfee;i="6800,10657,11948"; a="1910732"
X-IronPort-AV: E=Sophos;i="6.27,182,1787036400"; 
   d="scan'208";a="1910732"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
 by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 28 Oct 2026 02:51:37 -0700
X-CSE-ConnectionGUID: v8YUeiLjRM64VuVK4Nu2xA==
X-CSE-MsgGUID: 33Mv6wcYRcewGaZB2bFn3A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,182,1787036400"; 
   d="scan'208";a="5146265"
Received: from npg-npf-wlpr-srv19.iind.intel.com ([10.190.212.201])
 by fmviesa001.fm.intel.com with ESMTP; 28 Oct 2026 02:51:35 -0700
From: Shaiq Wani <shaiq.wani@intel.com>
To: dev@dpdk.org,
	bruce.richardson@intel.com,
	aman.deep.singh@intel.com
Subject: [PATCH] net/idpf: add 400G link speed support
Date: Wed, 28 Oct 2026 15:21:32 +0530
Message-Id: <20261028095132.1110128-1-shaiq.wani@intel.com>
X-Mailer: git-send-email 2.34.1
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

The idpf PMD did not map the 400 Gbps link speed, so adapters
operating at 400G reported their link speed as "Unknown": the speed
value advertised by the device had no matching entry in
idpf_supported_speeds[] and idpf_dev_link_update() fell back to
RTE_ETH_SPEED_NUM_UNKNOWN.

Add RTE_ETH_SPEED_NUM_400G to idpf_supported_speeds[] so the driver
reports the correct 400 Gbps link speed.

Signed-off-by: Shaiq Wani <shaiq.wani@intel.com>
---
 drivers/net/intel/idpf/idpf_ethdev.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/net/intel/idpf/idpf_ethdev.c b/drivers/net/intel/idpf/idpf_ethdev.c
index e9e9781fdd..ffd602a2c6 100644
--- a/drivers/net/intel/idpf/idpf_ethdev.c
+++ b/drivers/net/intel/idpf/idpf_ethdev.c
@@ -46,7 +46,8 @@ uint32_t idpf_supported_speeds[] = {
 	RTE_ETH_SPEED_NUM_50G,
 	RTE_ETH_SPEED_NUM_56G,
 	RTE_ETH_SPEED_NUM_100G,
-	RTE_ETH_SPEED_NUM_200G
+	RTE_ETH_SPEED_NUM_200G,
+	RTE_ETH_SPEED_NUM_400G
 };
 
 static const uint64_t idpf_map_hena_rss[] = {
-- 
2.34.1

