Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6837A606A319
	for <dpdk-dev@archiver.kernel.org>; Wed, 21 Oct 2026 14:26:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=Tk6Kxn87
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 242DB40679;
	Wed, 21 Oct 2026 16:26:18 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
 by mails.dpdk.org (Postfix) with ESMTP id 6338D40615
 for <dev@dpdk.org>; Wed, 21 Oct 2026 16:26:13 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1792592774; x=1824128774;
 h=from:to:subject:date:message-id:in-reply-to:references:
 mime-version:content-transfer-encoding;
 bh=0MSyY7AZpoj2Zhpc+A+wlyQAEQM/Hi2D3Jp3GDAbejs=;
 b=Tk6Kxn87WXR8rzRhaAhUOXyEISbB5fFNnGJtdLKG0v9QpllmJLqzEgGq
 hD7LoIjCb+k5IkMFON/X+hMrbWzCZ2PcJ3uNcTYDOB7dVZiTIr2dojO2d
 PAMva35KHkfpQDP+rbP62AzDELnMlu8d0czZe0aRrACZE/nLg7yNYd7oZ
 N8PBYBJauLRJuB66SE3BmHNkWIjQJDO7K3jB78u8uOApfYjZ/8Em4F6Bu
 77UnHW1w6g2Njfjqw6GwxVy+EqoipOBHL7PDwP1pYAh1TGEeIX5BN872h
 ZajhSK/756Frl1P+aE0Il2nIxkQ2MeLQUj/0FGt3XpT557kh6bg0gWfU8 w==;
X-CSE-ConnectionGUID: +QjK/yxbRmKUGve/+eYpiQ==
X-CSE-MsgGUID: WDc25DhIQEGV3lDP2d/v3w==
X-IronPort-AV: E=McAfee;i="6800,10657,11942"; a="1192902"
X-IronPort-AV: E=Sophos;i="6.27,170,1787036400"; 
   d="scan'208";a="1192902"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
 by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 21 Oct 2026 07:26:13 -0700
X-CSE-ConnectionGUID: NogG3EPUR867kKkkmrbVoQ==
X-CSE-MsgGUID: yZAmjbstR5mqt2ebnKUtgg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,170,1787036400"; 
   d="scan'208";a="3570503"
Received: from silpixa00401119.ir.intel.com ([10.20.224.206])
 by fmviesa010.fm.intel.com with ESMTP; 21 Oct 2026 07:26:12 -0700
From: Anatoly Burakov <anatoly.burakov@intel.com>
To: dev@dpdk.org, Vladimir Medvedkin <vladimir.medvedkin@intel.com>,
 Qiming Yang <qiming.yang@intel.com>, Qi Zhang <qi.z.zhang@intel.com>
Subject: [PATCH v4 03/10] net/iavf: fix false success on flow validation
Date: Wed, 21 Oct 2026 15:25:43 +0100
Message-ID: <d541e9890b27dfc0b2d524d46133ddbfe3523cdb.1792592724.git.anatoly.burakov@intel.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <cover.1792592724.git.anatoly.burakov@intel.com>
 <cover.1792592724.git.anatoly.burakov@intel.com>
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
X-Spam-Status: No, score=-19.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

`iavf_parse_engine_validate()` sets an error when validation fails, but
then returns the engine pointer. `iavf_flow_process_filter()` treats a
non-NULL engine as success, so `rte_flow_validate()` can accept an
invalid flow.

Return `NULL` on validation failure and return the engine only after
validation succeeds.

Fixes: ff2d0c345c3b ("net/iavf: support generic flow API")
Cc: stable@dpdk.org

Signed-off-by: Anatoly Burakov <anatoly.burakov@intel.com>
---
 drivers/net/intel/iavf/iavf_generic_flow.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/net/intel/iavf/iavf_generic_flow.c b/drivers/net/intel/iavf/iavf_generic_flow.c
index 92ca20031c0..14242e6ebbb 100644
--- a/drivers/net/intel/iavf/iavf_generic_flow.c
+++ b/drivers/net/intel/iavf/iavf_generic_flow.c
@@ -2134,10 +2134,11 @@ iavf_parse_engine_validate(struct iavf_adapter *ad,
 			rte_flow_error_set(error, EINVAL,
 				RTE_FLOW_ERROR_TYPE_HANDLE,
 				NULL, "Validation failed");
-			break;
+			return NULL;
 		}
+		return engine;
 	}
-	return engine;
+	return NULL;
 }
 
 
-- 
2.52.0

