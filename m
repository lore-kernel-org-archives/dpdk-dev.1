Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5A5F8606A31D
	for <dpdk-dev@archiver.kernel.org>; Fri, 23 Oct 2026 09:32:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=V4Po+v0K
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id DD7DA4067B;
	Fri, 23 Oct 2026 11:32:45 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
 by mails.dpdk.org (Postfix) with ESMTP id 2CA064060C
 for <dev@dpdk.org>; Fri, 23 Oct 2026 11:32:43 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1792747964; x=1824283964;
 h=from:to:subject:date:message-id:in-reply-to:references:
 mime-version:content-transfer-encoding;
 bh=x8uHKbVRPA40pAO+EW8pTNS+daO1JAAP/uTc5nj8KkI=;
 b=V4Po+v0KWkTzpeuGide+V4FeLr/y8Pm57fOmByR8B4nng+BHxqUxS0Ht
 CR4pafAuX3YPHdCncs52NmYkRCS/WxTQWqSdAR/L4pJYjx+RnzvGzgEMI
 XRmyBSSUs/DcnPypMZoLHFXfrFhiyLFqTtMsWmQzYwpky21ZZbX51/HYM
 4SCimG31ayoG5ezr1e6wrbRSzDJzcxZThOHyGWeNK4A66hyakTu2Zba2D
 T/jK1rkDMlNvDKm2KpQwAVulEcJwxOAg74Qek6mknNOX9wg3WJw0s3bA1
 g2Nt0NJD/OfasCMM47HNY/WZPMbnnqp5l5Rz4kCxyNRmBQzT3rtCje/nB Q==;
X-CSE-ConnectionGUID: /SOI3HI+RMO+dCWovCPP0Q==
X-CSE-MsgGUID: fjrV0FzfTaC+NOpnfmy6wA==
X-IronPort-AV: E=McAfee;i="6800,10657,11943"; a="1498269"
X-IronPort-AV: E=Sophos;i="6.27,174,1787036400"; 
   d="scan'208";a="1498269"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
 by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 23 Oct 2026 02:32:43 -0700
X-CSE-ConnectionGUID: uzkkeJeVQVi7cXuTkLcjSQ==
X-CSE-MsgGUID: Y0cnJ462Riu4fjAXyXdUjQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,174,1787036400"; 
   d="scan'208";a="3509463"
Received: from silpixa00401119.ir.intel.com ([10.20.224.206])
 by orviesa003.jf.intel.com with ESMTP; 23 Oct 2026 02:32:42 -0700
From: Anatoly Burakov <anatoly.burakov@intel.com>
To: dev@dpdk.org, Vladimir Medvedkin <vladimir.medvedkin@intel.com>,
 Qi Zhang <qi.z.zhang@intel.com>, Qiming Yang <qiming.yang@intel.com>
Subject: [PATCH v5 03/10] net/iavf: fix false success on flow validation
Date: Fri, 23 Oct 2026 10:32:23 +0100
Message-ID: <bb42c569859c58d1e90ca4af7db6d99b6ef1dcf4.1792747917.git.anatoly.burakov@intel.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <cover.1792747916.git.anatoly.burakov@intel.com>
 <cover.1792747916.git.anatoly.burakov@intel.com>
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
Acked-by: Bruce Richardson <bruce.richardson@intel.com>
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

