Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BD6D2606A319
	for <dpdk-dev@archiver.kernel.org>; Tue, 20 Oct 2026 09:12:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=TlE1qbKm
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 2654C4060F;
	Tue, 20 Oct 2026 11:11:46 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
 by mails.dpdk.org (Postfix) with ESMTP id 08B5940430
 for <dev@dpdk.org>; Tue, 20 Oct 2026 11:11:41 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1792487503; x=1824023503;
 h=from:to:subject:date:message-id:in-reply-to:references:
 mime-version:content-transfer-encoding;
 bh=F7uvC6jEILzMDho9nCHscOYdCTBcfNjbG/s6dmBVTE4=;
 b=TlE1qbKmkt11C0whdToFTeUMl2ToH+63BdM1u870jEtiDbvWe33Nwsuo
 NqiaXQElMc/veWUtd3LwWvGZXDovYVEotq72E+NQgCh64rLN17HLuk8RR
 XQ8HVSHkd26t4I/BgRyJf6j6po3KxgvIw5FYt/5hSOhzGzDrjud/iZJgU
 S0j95rzJDR2HJADJr2awhyDkVY+uTvKLEXId8C+ZPRKv+MYNLA+d/C6Xi
 DdFudzUXkYbDu7Ql0HcEqY7mTPQL55q0UPcOa6o8C+qv85qV8e6W6OA6a
 AcBTCq8ZQhgt9ysXGv/eHsSbnhy7ogFZTGWrxCxZcrZqbL4Eh8VbGzM9d w==;
X-CSE-ConnectionGUID: URsjPEHJSmiOjwraZqy+rg==
X-CSE-MsgGUID: jj3V3FLvThuFa6ag8eRM4w==
X-IronPort-AV: E=McAfee;i="6800,10657,11940"; a="1286808"
X-IronPort-AV: E=Sophos;i="6.27,168,1787036400"; 
   d="scan'208";a="1286808"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
 by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 20 Oct 2026 02:11:42 -0700
X-CSE-ConnectionGUID: iY9IkJVATS6O5fpq3W8vgw==
X-CSE-MsgGUID: 04GaMWZsRUu+VncAhNfFFw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,168,1787036400"; 
   d="scan'208";a="2879442"
Received: from silpixa00401119.ir.intel.com ([10.20.224.206])
 by fmviesa002.fm.intel.com with ESMTP; 20 Oct 2026 02:11:40 -0700
From: Anatoly Burakov <anatoly.burakov@intel.com>
To: dev@dpdk.org, Vladimir Medvedkin <vladimir.medvedkin@intel.com>,
 Qiming Yang <qiming.yang@intel.com>, Qi Zhang <qi.z.zhang@intel.com>
Subject: [PATCH v3 03/10] net/iavf: fix false success on flow validation
Date: Tue, 20 Oct 2026 10:11:26 +0100
Message-ID: <ac5fff52e587ecc9f3813c5656edf5d4dbc93fe6.1792487374.git.anatoly.burakov@intel.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <cover.1792487374.git.anatoly.burakov@intel.com>
 <cover.1792487374.git.anatoly.burakov@intel.com>
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
index 92ca20031c..14242e6ebb 100644
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

