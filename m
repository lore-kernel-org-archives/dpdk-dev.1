Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E89B5606A31A
	for <dpdk-dev@archiver.kernel.org>; Fri, 23 Oct 2026 12:15:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=X1Q19+RS
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id E504640299;
	Fri, 23 Oct 2026 14:15:50 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.18])
 by mails.dpdk.org (Postfix) with ESMTP id DD6B540268
 for <dev@dpdk.org>; Fri, 23 Oct 2026 14:15:49 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1792757750; x=1824293750;
 h=from:to:subject:date:message-id:mime-version:
 content-transfer-encoding;
 bh=b2stOSQeoeKSkHidRwLLv3AzgfP9eGivBmU/PgNpeRM=;
 b=X1Q19+RSzsTSnpth0LRSADYOs0GW56fNmnXtzcINyUQ1P5yAsJut8/Jo
 pYnUjTkhH+aq5hbGj1GYGChmHihv02wUaEhDGRGaIV0Fcnm44209qcpD4
 HbuAVygTFmbgDznQEGNNDBVMb5xktWr1NBQrSGHvjd7YjggHfk9W1pHgV
 60r1woVTp+XKadulGnM49dG+6Dvr9otttDfIwWyhvC0A2AHP3oZ4SXtvW
 Mw8cXeZRg1zshTI3dXSahHoc7RgU5N/CsmezgsiBio6C8nMPtqs+BD8QK
 VYmyKiE2vtwOLnp+SMFtPG6Py5eHewRf+WaQGyaPUDKKsQ6hhY0siHP9M w==;
X-CSE-ConnectionGUID: vozSYYUBTICoYvrYJqaUAw==
X-CSE-MsgGUID: sG8vrTguTyKQkXtoY5KMLA==
X-IronPort-AV: E=McAfee;i="6800,10657,11943"; a="1521961"
X-IronPort-AV: E=Sophos;i="6.27,174,1787036400"; 
   d="scan'208";a="1521961"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
 by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 23 Oct 2026 05:15:49 -0700
X-CSE-ConnectionGUID: N/9+utOpSsqWi9jXCHSY7A==
X-CSE-MsgGUID: mkBzeyyJRY2aevskEcRtDQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,174,1787036400"; 
   d="scan'208";a="3569477"
Received: from silpixa00401119.ir.intel.com ([10.20.224.206])
 by orviesa005.jf.intel.com with ESMTP; 23 Oct 2026 05:15:48 -0700
From: Anatoly Burakov <anatoly.burakov@intel.com>
To: dev@dpdk.org
Subject: [PATCH v1 1/1] ethdev: add flow item structure size query
Date: Fri, 23 Oct 2026 13:15:46 +0100
Message-ID: <8fa05595f3596e9355dd90df7fc278b104beb20b.1792757739.git.anatoly.burakov@intel.com>
X-Mailer: git-send-email 2.52.0
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

Add RTE_FLOW_CONV_OP_ITEM_SIZE to retrieve the fixed specification
structure size for a flow item type using the existing descriptor table.

Signed-off-by: Anatoly Burakov <anatoly.burakov@intel.com>
---
 lib/ethdev/rte_flow.c | 16 ++++++++++++++++
 lib/ethdev/rte_flow.h | 18 ++++++++++++++++++
 2 files changed, 34 insertions(+)

diff --git a/lib/ethdev/rte_flow.c b/lib/ethdev/rte_flow.c
index 0ebf59165d4..1b2d263331a 100644
--- a/lib/ethdev/rte_flow.c
+++ b/lib/ethdev/rte_flow.c
@@ -1266,6 +1266,22 @@ rte_flow_conv(enum rte_flow_conv_op op,
 	case RTE_FLOW_CONV_OP_ITEM_DEFAULT_MASK_PTR:
 		ret = rte_flow_conv_item_default_mask(dst, size, src, error);
 		break;
+	case RTE_FLOW_CONV_OP_ITEM_SIZE:
+	{
+		uintptr_t type = (uintptr_t)src;
+
+		if (type >= RTE_DIM(rte_flow_desc_item) ||
+				rte_flow_desc_item[type].name == NULL) {
+			ret = rte_flow_error_set(error, EINVAL,
+					RTE_FLOW_ERROR_TYPE_UNSPECIFIED, NULL,
+					"unknown item type to retrieve the size of");
+			break;
+		}
+		if (size >= sizeof(size_t))
+			*(size_t *)dst = rte_flow_desc_item[type].size;
+		ret = sizeof(size_t);
+		break;
+	}
 	default:
 		ret = rte_flow_error_set
 		(error, ENOTSUP, RTE_FLOW_ERROR_TYPE_UNSPECIFIED, NULL,
diff --git a/lib/ethdev/rte_flow.h b/lib/ethdev/rte_flow.h
index df8101e4395..3d6a56f51e3 100644
--- a/lib/ethdev/rte_flow.h
+++ b/lib/ethdev/rte_flow.h
@@ -4426,6 +4426,24 @@ enum rte_flow_conv_op {
 	 *   @code const void ** @endcode
 	 */
 	RTE_FLOW_CONV_OP_ITEM_DEFAULT_MASK_PTR,
+
+	/**
+	 * Retrieve the fixed size of an item specification structure.
+	 *
+	 * Writes the size of rte_flow_item_{name} to @p dst, or zero for
+	 * known item types without a specification structure. Does not include
+	 * variable-length or externally referenced data (for example, RAW
+	 * pattern bytes). Unknown and PMD-private item types return an error.
+	 *
+	 * No output is written if @p size is smaller than sizeof(size_t).
+	 * The return value is sizeof(size_t), not the item structure size.
+	 *
+	 * - @p src type:
+	 *   @code (const void *)(uintptr_t)enum rte_flow_item_type @endcode
+	 * - @p dst type:
+	 *   @code size_t * @endcode
+	 */
+	RTE_FLOW_CONV_OP_ITEM_SIZE,
 };
 
 /**
-- 
2.52.0

