Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1C020F01826
	for <dpdk-dev@archiver.kernel.org>; Fri,  6 Mar 2026 10:59:32 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 0972041153;
	Fri,  6 Mar 2026 11:58:40 +0100 (CET)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
 by mails.dpdk.org (Postfix) with ESMTP id 6E91940E15
 for <dev@dpdk.org>; Fri,  6 Mar 2026 11:58:36 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1772794717; x=1804330717;
 h=from:to:subject:date:message-id:in-reply-to:references:
 mime-version:content-transfer-encoding;
 bh=1Xeqt2SgLg0XIk1xTOg5ol+kbl7+ZKvjIYllBt/hHtk=;
 b=by005QlnilAKSoPkrthRyWF7AvmhVR974lqK/eDBl2XjyT2Z6n/ZmXyW
 lVPGso6Nf1LVK8BBkQYZh2B8ODHVWQHRvEN5faTP4+ESlL6bwcdmNi9Lr
 0gnPnJGS1/e0bQRhBgVI6fyuTZt4eMekAeWnM+Ng8q9Nj2VzLAF/zKT8S
 RLvM6YRUtSfTcJcG2nhgyU/+vTZd8c3TxvAs+sU0DQWKG/zH7boWINmE8
 r36s3c6yTGhy5RVOVyX8I1JM/JSpDo55PcXAWJPZrY0qq9a5t337YM+Ym
 yZMXTsTYPG//v3j/L+cg8i5plsnnHRiCcJjX2M3Qe8sl8Az70ltp7VD7x w==;
X-CSE-ConnectionGUID: VkfWEvl6RmmY3pLFGP7lJg==
X-CSE-MsgGUID: uCEa8XjmSO6cw+kT50cInQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11720"; a="84984559"
X-IronPort-AV: E=Sophos;i="6.23,104,1770624000"; d="scan'208";a="84984559"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
 by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 06 Mar 2026 02:58:36 -0800
X-CSE-ConnectionGUID: E2I4BUchT1mITr5dAy1RgQ==
X-CSE-MsgGUID: rw/cnM/CR2me9Zwnivq/YQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,104,1770624000"; d="scan'208";a="215678412"
Received: from silpixa00401119.ir.intel.com ([10.20.224.206])
 by fmviesa006.fm.intel.com with ESMTP; 06 Mar 2026 02:58:35 -0800
From: Anatoly Burakov <anatoly.burakov@intel.com>
To: dev@dpdk.org,
	Vladimir Medvedkin <vladimir.medvedkin@intel.com>
Subject: [PATCH v3 8/8] net/iavf: embed virtchnl response buffer
Date: Fri,  6 Mar 2026 10:58:24 +0000
Message-ID: <de81dff1166f097129de104ae46a04422313179a.1772794442.git.anatoly.burakov@intel.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <cover.1772794442.git.anatoly.burakov@intel.com>
 <cover.1772794442.git.anatoly.burakov@intel.com>
References: 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-BeenThere: dev@dpdk.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: DPDK patches and discussions <dev.dpdk.org>
List-Unsubscribe: <https://mails.dpdk.org/options/dev>,
 <mailto:dev-request@dpdk.org?subject=unsubscribe>
List-Archive: <http://mails.dpdk.org/archives/dev/>
List-Post: <mailto:dev@dpdk.org>
List-Help: <mailto:dev-request@dpdk.org?subject=help>
List-Subscribe: <https://mails.dpdk.org/listinfo/dev>,
 <mailto:dev-request@dpdk.org?subject=subscribe>
Errors-To: dev-bounces@dpdk.org

There is no need to dynamically allocate this buffer separately as it is
fixed in size and is always allocated for all driver instances no matter
the configuration. Embed it in `iavf_info` struct.

Signed-off-by: Anatoly Burakov <anatoly.burakov@intel.com>
---
 drivers/net/intel/iavf/iavf.h        |  2 +-
 drivers/net/intel/iavf/iavf_ethdev.c | 13 -------------
 drivers/net/intel/iavf/iavf_vchnl.c  |  4 ----
 3 files changed, 1 insertion(+), 18 deletions(-)

diff --git a/drivers/net/intel/iavf/iavf.h b/drivers/net/intel/iavf/iavf.h
index 440376c4ca..067ebc29d0 100644
--- a/drivers/net/intel/iavf/iavf.h
+++ b/drivers/net/intel/iavf/iavf.h
@@ -242,7 +242,7 @@ struct iavf_info {
 	volatile RTE_ATOMIC(enum virtchnl_ops) pend_cmd; /* pending command not finished */
 	RTE_ATOMIC(uint32_t) pend_cmd_count;
 	int cmd_retval; /* return value of the cmd response from PF */
-	uint8_t *aq_resp; /* buffer to store the adminq response from PF */
+	uint8_t aq_resp[IAVF_AQ_BUF_SZ]; /* buffer to store the adminq response from PF */
 	bool aq_intr_enabled;
 
 	/** iAVF watchdog enable */
diff --git a/drivers/net/intel/iavf/iavf_ethdev.c b/drivers/net/intel/iavf/iavf_ethdev.c
index 9fdebec0f4..6d0306b3ac 100644
--- a/drivers/net/intel/iavf/iavf_ethdev.c
+++ b/drivers/net/intel/iavf/iavf_ethdev.c
@@ -2553,11 +2553,6 @@ iavf_init_vf(struct rte_eth_dev *dev)
 		goto err;
 	}
 
-	vf->aq_resp = rte_zmalloc("vf_aq_resp", IAVF_AQ_BUF_SZ, 0);
-	if (!vf->aq_resp) {
-		PMD_INIT_LOG(ERR, "unable to allocate vf_aq_resp memory");
-		goto err_aq;
-	}
 	if (iavf_check_api_version(adapter) != 0) {
 		PMD_INIT_LOG(ERR, "check_api version failed");
 		goto err_api;
@@ -2631,8 +2626,6 @@ iavf_init_vf(struct rte_eth_dev *dev)
 	rte_free(vf->vf_res);
 	vf->vsi_res = NULL;
 err_api:
-	rte_free(vf->aq_resp);
-err_aq:
 	iavf_shutdown_adminq(hw);
 err:
 	return -1;
@@ -2650,9 +2643,6 @@ iavf_uninit_vf(struct rte_eth_dev *dev)
 	vf->vsi_res = NULL;
 	vf->vf_res = NULL;
 
-	rte_free(vf->aq_resp);
-	vf->aq_resp = NULL;
-
 	rte_free(vf->qos_cap);
 	vf->qos_cap = NULL;
 
@@ -3009,9 +2999,6 @@ iavf_dev_close(struct rte_eth_dev *dev)
 	vf->vsi_res = NULL;
 	vf->vf_res = NULL;
 
-	rte_free(vf->aq_resp);
-	vf->aq_resp = NULL;
-
 	/*
 	 * If the VF is reset via VFLR, the device will be knocked out of bus
 	 * master mode, and the driver will fail to recover from the reset. Fix
diff --git a/drivers/net/intel/iavf/iavf_vchnl.c b/drivers/net/intel/iavf/iavf_vchnl.c
index 1e98503b31..03cb2a55d8 100644
--- a/drivers/net/intel/iavf/iavf_vchnl.c
+++ b/drivers/net/intel/iavf/iavf_vchnl.c
@@ -564,10 +564,6 @@ iavf_handle_virtchnl_msg(struct rte_eth_dev *dev)
 	int ret;
 
 	info.buf_len = IAVF_AQ_BUF_SZ;
-	if (!vf->aq_resp) {
-		PMD_DRV_LOG(ERR, "Buffer for adminq resp should not be NULL");
-		return;
-	}
 	info.msg_buf = vf->aq_resp;
 
 	pending = 1;
-- 
2.47.3

