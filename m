Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 45F816078855
	for <dpdk-dev@archiver.kernel.org>; Mon, 19 Oct 2026 15:06:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=cnDW+Lqe
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 615CD4068E;
	Mon, 19 Oct 2026 17:06:40 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
 by mails.dpdk.org (Postfix) with ESMTP id 0461A40663
 for <dev@dpdk.org>; Mon, 19 Oct 2026 17:06:36 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1792422398; x=1823958398;
 h=from:to:subject:date:message-id:in-reply-to:references:
 mime-version:content-transfer-encoding;
 bh=F7uvC6jEILzMDho9nCHscOYdCTBcfNjbG/s6dmBVTE4=;
 b=cnDW+LqeY/B1//GpJ/KbfbS5Oc3F9zQa5uHvwPVnJ5KPWGFwakVDI4lC
 8KO+NRAW9BiyMNoHf9Ma0dhC+D2ngbTAhAxn1zBC91AUgE2t/BY4UrCYb
 DWPJdJNc4+IRCQAo6FChh3sm4DBeqT+K4nkgM+fXwB3Ev3NMMmtgpWT9f
 6BDFlkFHm4XcCNQx+AQ32aSgn/RpVvIHBEe3QRGOjGI4psApse2ZQV282
 BOBvyNzx9wfl7uPLwP2W6yym5VMLG+D4jxgQbGxJ8wprfVXR596PaKG7n
 +xb/HUldwPAblRFXfgvvJvmCKaT51XmMeRDrwdqWpi6adHocwyoxXXzfU w==;
X-CSE-ConnectionGUID: UiZMG/XWRXiExNXlD5acYQ==
X-CSE-MsgGUID: Un5IryiRSZuKQSbFZBZELg==
X-IronPort-AV: E=McAfee;i="6800,10657,11940"; a="1132168"
X-IronPort-AV: E=Sophos;i="6.27,167,1787036400"; 
   d="scan'208";a="1132168"
Received: from fmviesa012.fm.intel.com ([10.60.135.152])
 by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 19 Oct 2026 08:06:37 -0700
X-CSE-ConnectionGUID: /4Fx6GePTyKRfRP/RZGFRQ==
X-CSE-MsgGUID: nH7VcZBRSVSFmCCe26LW6A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,167,1787036400"; 
   d="scan'208";a="4319731"
Received: from silpixa00401119.ir.intel.com ([10.20.224.206])
 by fmviesa012.fm.intel.com with ESMTP; 19 Oct 2026 08:06:35 -0700
From: Anatoly Burakov <anatoly.burakov@intel.com>
To: dev@dpdk.org, Vladimir Medvedkin <vladimir.medvedkin@intel.com>,
 Qi Zhang <qi.z.zhang@intel.com>, Qiming Yang <qiming.yang@intel.com>
Subject: [PATCH v2 3/9] net/iavf: fix false success on flow validation
Date: Mon, 19 Oct 2026 16:06:22 +0100
Message-ID: <a12aab9adf244a6e2b754c82e71ac5fa33ca7baf.1792422213.git.anatoly.burakov@intel.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <cover.1792422213.git.anatoly.burakov@intel.com>
 <cover.1792422213.git.anatoly.burakov@intel.com>
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
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_BLOCKED,RCVD_IN_ZEN_BLOCKED_OPENDNS,SPF_HELO_NONE,
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

