Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E7974606A888
	for <dpdk-dev@archiver.kernel.org>; Mon, 16 Nov 2026 16:10:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=ZLDEGGG8
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 0F1F340395;
	Mon, 16 Nov 2026 17:09:48 +0100 (CET)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
 by mails.dpdk.org (Postfix) with ESMTPS id B23AB40299
 for <dev@dpdk.org>; Mon, 16 Nov 2026 17:09:44 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1794845385; x=1826381385;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=yJAcDi1Uh2aFR2FC1LaTh9yoipkq9AOLm0KP2GQlyko=;
 b=ZLDEGGG8k3QN3uIWEsA211jpG8g5Xv2Jdlk7p/y7UHKtWDhvx/3Q1vRs
 MxssrDpBlJYjvRbD9+g0UvTLEY0j+mfwcxiFzePibXKePGoflGdQtG4Oy
 dEL53Ek8cCSzTbMpaY5k9u0AmPSN55xuoVxRIO6H7A4KZD6Hg+kLfPK5W
 UIzVyArKzledVh+hxQrp6ZzWT7vKHhKSLe4Mxvtvkpuhtt5z7PLM0Vfd3
 POH7AY0th226Q8a3n08nOIps0IaiwrogNvDCVn0fQtGyMbTBWzccUK/T1
 At4S3IS49m4/lgkLlcQ7AhMbKKoJFxxEyZFZLX0E1WokzxdzMYFQytBF3 w==;
X-CSE-ConnectionGUID: 3XH0BCfLSS20J0THPwbfiQ==
X-CSE-MsgGUID: D9lPLYYUR+eZ0uhTJJ7rjQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11968"; a="3481867"
X-IronPort-AV: E=Sophos;i="6.27,217,1787036400"; 
   d="scan'208";a="3481867"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
 by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 16 Nov 2026 08:09:44 -0800
X-CSE-ConnectionGUID: UmEto25XQDav1j3ypwEC5w==
X-CSE-MsgGUID: sjOPfzLGQhSX5mVFLesSQA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,217,1787036400"; 
   d="scan'208";a="9927006"
Received: from silpixa00401385.ir.intel.com ([10.20.224.226])
 by fmviesa009.fm.intel.com with ESMTP; 16 Nov 2026 08:09:43 -0800
From: Bruce Richardson <bruce.richardson@intel.com>
To: dev@dpdk.org
Cc: Bruce Richardson <bruce.richardson@intel.com>
Subject: [PATCH 27.03 6/6] net/i40e: use stack storage for function-local
 buffers
Date: Mon, 16 Nov 2026 16:09:32 +0000
Message-ID: <20261116160932.1006354-7-bruce.richardson@intel.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261116160932.1006354-1-bruce.richardson@intel.com>
References: <20261116160932.1006354-1-bruce.richardson@intel.com>
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

Rather than using malloc and free for adminq response buffers, and for
the DDP profile list buffer in testpmd commands, define them on the
stack, using RTE_DEFINE_FLEX_BYTES for those structures ending in a
variable-length array. This removes the allocation failure and cleanup
paths.

Signed-off-by: Bruce Richardson <bruce.richardson@intel.com>
---
 drivers/net/intel/i40e/i40e_ethdev.c  | 27 +++++----------------------
 drivers/net/intel/i40e/i40e_testpmd.c | 10 ++--------
 2 files changed, 7 insertions(+), 30 deletions(-)

diff --git a/drivers/net/intel/i40e/i40e_ethdev.c b/drivers/net/intel/i40e/i40e_ethdev.c
index 498c5c7ec4..dde1867345 100644
--- a/drivers/net/intel/i40e/i40e_ethdev.c
+++ b/drivers/net/intel/i40e/i40e_ethdev.c
@@ -4549,18 +4549,13 @@ i40e_free_virt_mem_d(__rte_unused struct i40e_hw *hw,
 static int
 i40e_get_cap(struct i40e_hw *hw)
 {
-	struct i40e_aqc_list_capabilities_element_resp *buf;
+	struct i40e_aqc_list_capabilities_element_resp buf[I40E_MAX_CAP_ELE_NUM] = {0};
 	uint16_t len, size = 0;
 	int ret;
 
 	/* Calculate a huge enough buff for saving response data temporarily */
 	len = sizeof(struct i40e_aqc_list_capabilities_element_resp) *
 						I40E_MAX_CAP_ELE_NUM;
-	buf = rte_zmalloc("i40e", len, 0);
-	if (!buf) {
-		PMD_DRV_LOG(ERR, "Failed to allocate memory");
-		return I40E_ERR_NO_MEMORY;
-	}
 
 	/* Get, parse the capabilities and save it to hw */
 	ret = i40e_aq_discover_capabilities(hw, buf, len, &size,
@@ -4568,9 +4563,6 @@ i40e_get_cap(struct i40e_hw *hw)
 	if (ret != I40E_SUCCESS)
 		PMD_DRV_LOG(ERR, "Failed to discover capabilities");
 
-	/* Free the temporary buffer after being used */
-	rte_free(buf);
-
 	return ret;
 }
 
@@ -4775,29 +4767,23 @@ static int
 i40e_pf_get_switch_config(struct i40e_pf *pf)
 {
 	struct i40e_hw *hw = I40E_PF_TO_HW(pf);
-	struct i40e_aqc_get_switch_config_resp *switch_config;
+	RTE_DEFINE_FLEX_BYTES(struct i40e_aqc_get_switch_config_resp, switch_config,
+			I40E_AQ_LARGE_BUF);
 	struct i40e_aqc_switch_config_element_resp *element;
 	uint16_t start_seid = 0, num_reported;
 	int ret;
 
-	switch_config = (struct i40e_aqc_get_switch_config_resp *)\
-			rte_zmalloc("i40e", I40E_AQ_LARGE_BUF, 0);
-	if (!switch_config) {
-		PMD_DRV_LOG(ERR, "Failed to allocated memory");
-		return -ENOMEM;
-	}
-
 	/* Get the switch configurations */
 	ret = i40e_aq_get_switch_config(hw, switch_config,
 		I40E_AQ_LARGE_BUF, &start_seid, NULL);
 	if (ret != I40E_SUCCESS) {
 		PMD_DRV_LOG(ERR, "Failed to get switch configurations");
-		goto fail;
+		return ret;
 	}
 	num_reported = rte_le_to_cpu_16(switch_config->header.num_reported);
 	if (num_reported != 1) { /* The number should be 1 */
 		PMD_DRV_LOG(ERR, "Wrong number of switch config reported");
-		goto fail;
+		return ret;
 	}
 
 	/* Parse the switch configuration elements */
@@ -4808,9 +4794,6 @@ i40e_pf_get_switch_config(struct i40e_pf *pf)
 	} else
 		PMD_DRV_LOG(INFO, "Unknown element type");
 
-fail:
-	rte_free(switch_config);
-
 	return ret;
 }
 
diff --git a/drivers/net/intel/i40e/i40e_testpmd.c b/drivers/net/intel/i40e/i40e_testpmd.c
index 21f596297b..30ae57336e 100644
--- a/drivers/net/intel/i40e/i40e_testpmd.c
+++ b/drivers/net/intel/i40e/i40e_testpmd.c
@@ -1616,7 +1616,8 @@ cmd_ddp_get_list_parsed(__rte_unused void *parsed_result,
 	__rte_unused void *data)
 {
 	struct cmd_ddp_get_list_result *res = parsed_result;
-	struct rte_pmd_i40e_profile_list *p_list;
+	RTE_DEFINE_FLEX_BYTES(struct rte_pmd_i40e_profile_list, p_list,
+			PROFILE_INFO_SIZE * MAX_PROFILE_NUM + 4);
 	struct rte_pmd_i40e_profile_info *p_info;
 	uint32_t p_num;
 	uint32_t size;
@@ -1624,11 +1625,6 @@ cmd_ddp_get_list_parsed(__rte_unused void *parsed_result,
 	int ret = -ENOTSUP;
 
 	size = PROFILE_INFO_SIZE * MAX_PROFILE_NUM + 4;
-	p_list = (struct rte_pmd_i40e_profile_list *)malloc(size);
-	if (!p_list) {
-		fprintf(stderr, "%s: Failed to malloc buffer\n", __func__);
-		return;
-	}
 
 	if (ret == -ENOTSUP)
 		ret = rte_pmd_i40e_get_ddp_list(res->port_id,
@@ -1651,8 +1647,6 @@ cmd_ddp_get_list_parsed(__rte_unused void *parsed_result,
 		}
 	}
 
-	free(p_list);
-
 	if (ret < 0)
 		fprintf(stderr, "Failed to get ddp list\n");
 }
-- 
2.55.0

