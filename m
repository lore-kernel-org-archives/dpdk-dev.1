Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 67188606A331
	for <dpdk-dev@archiver.kernel.org>; Thu, 29 Oct 2026 16:41:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=YgK0XetX
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 3EB324068E;
	Thu, 29 Oct 2026 17:41:32 +0100 (CET)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
 by mails.dpdk.org (Postfix) with ESMTPS id BD8924067D
 for <dev@dpdk.org>; Thu, 29 Oct 2026 17:41:29 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1793292090; x=1824828090;
 h=from:to:subject:date:message-id:in-reply-to:references:
 mime-version:content-transfer-encoding;
 bh=tCfpF4kIEmk+I4PD+bwUt8YEE5ftqDKrFQDDdthsnfQ=;
 b=YgK0XetXDQpizXTMp/zH/KZ35OEaLrAy/6GFd5tgCypuI/erb78QerVV
 VSa1smS5NlKDe7wblVZ1lxXJc9JAvATTBxEbCZcDJyRwI1DKymh4iuU6k
 Pcx55JflSac+Q4VGFOs+0TrHauxvhgOfMgwJe91qSyBWyVgy++En2vxpT
 E/JgnRLXO6NofYRd41z7pe1Fmkd0bJ7+sOI0656I8FO3lFpdq26r7KOv9
 ynUIKUKDwDwO2ZO1HWE9JKADDMTA6F0ApBl2I+D+sJ7JxP5I/YuzD+C6i
 kzQ2UJ9IGiOLII5fcpnQz0N8AFCT/tBJqHpyc1jgSOipI+Z7k+PvsuyA4 A==;
X-CSE-ConnectionGUID: tU3Lh5sTTAi8VMh5lQLW+w==
X-CSE-MsgGUID: /FX4NkNJRea8dRzf8Z3+6A==
X-IronPort-AV: E=McAfee;i="6800,10657,11950"; a="1954955"
X-IronPort-AV: E=Sophos;i="6.27,184,1787036400"; 
   d="scan'208";a="1954955"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
 by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 29 Oct 2026 09:41:03 -0700
X-CSE-ConnectionGUID: Ghb6x7TJSmykt0/2xrIZwA==
X-CSE-MsgGUID: MRC214ssQX6ykLzjGpRhzA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,184,1787036400"; 
   d="scan'208";a="5280317"
Received: from silpixa00401119.ir.intel.com ([10.20.224.206])
 by orviesa009.jf.intel.com with ESMTP; 29 Oct 2026 09:41:02 -0700
From: Anatoly Burakov <anatoly.burakov@intel.com>
To: dev@dpdk.org,
	Vladimir Medvedkin <vladimir.medvedkin@intel.com>
Subject: [PATCH v1 3/4] net/ixgbe: fix SCTP FDIR rules without port masks
Date: Thu, 29 Oct 2026 16:40:57 +0000
Message-ID: <7c0e0d8c05e0c88ab479bfad98ad7e10e6e0948f.1793292050.git.anatoly.burakov@intel.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <9c545ac681db1bd835a88516322c1441951e3ed6.1793292050.git.anatoly.burakov@intel.com>
References: 
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

82599 and X540 cannot match on SCTP ports, so SCTP items with port masks
are rejected on them. However, SCTP items with a mask that does not
include ports are rejected as well.

Only reject SCTP items on such hardware if a port mask is set.

Fixes: ea0f9067b2cf ("net/ixgbe: reimplement FDIR parser")

Signed-off-by: Anatoly Burakov <anatoly.burakov@intel.com>
---
 drivers/net/intel/ixgbe/ixgbe_flow_fdir.c | 8 +++-----
 1 file changed, 3 insertions(+), 5 deletions(-)

diff --git a/drivers/net/intel/ixgbe/ixgbe_flow_fdir.c b/drivers/net/intel/ixgbe/ixgbe_flow_fdir.c
index 9c9dc8846fa..0a7e96a030d 100644
--- a/drivers/net/intel/ixgbe/ixgbe_flow_fdir.c
+++ b/drivers/net/intel/ixgbe/ixgbe_flow_fdir.c
@@ -411,11 +411,9 @@ ixgbe_validate_fdir_normal_sctp(const void *ctx,
 				"SCTP tag/cksum not supported");
 	}
 
-	/*
-	 * SCTP mask is not NULL, which means we are potentially looking at
-	 * masking SCTP ports, so check hardware support.
-	 */
-	if (!fdir_ctx->supports_sctp_ports) {
+	/* SCTP port filtering is only supported on some hardware. */
+	if (!fdir_ctx->supports_sctp_ports &&
+	    (sctp_mask->hdr.src_port || sctp_mask->hdr.dst_port)) {
 		return rte_flow_error_set(error, EINVAL,
 				RTE_FLOW_ERROR_TYPE_ITEM, item,
 				"SCTP port filtering not supported by hardware");
-- 
2.52.0

