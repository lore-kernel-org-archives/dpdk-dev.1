Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 29B79F01821
	for <dpdk-dev@archiver.kernel.org>; Fri,  6 Mar 2026 10:58:56 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 08D1840E11;
	Fri,  6 Mar 2026 11:58:34 +0100 (CET)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
 by mails.dpdk.org (Postfix) with ESMTP id 55DEE40A67
 for <dev@dpdk.org>; Fri,  6 Mar 2026 11:58:31 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1772794712; x=1804330712;
 h=from:to:subject:date:message-id:in-reply-to:references:
 mime-version:content-transfer-encoding;
 bh=rSn+i0VUdWZfwRMV378f/+ZW5WCR4Gcs7oZ1RywuS0Q=;
 b=eL8P+UpiMDZK/1arDC8daQ/RO05eyc8o2z+j3M0PjunN04sQKSnlCxFV
 Wu38480whyyAld3gPaZEAIMBybb8LpX7lk6nf2cWlG0QteQYd6S3wMCD9
 4x4/AAD2oAZaKXAc/ysamzuhIP9vuZnZwWXxpUsG+Os7q+Y+VsFO8bW+P
 Pzb0JJgaBvGCo/5FGmdZexUwDMZYvJpgVRX9yYUsI/100rIgu7TKD/+I0
 p7Q2iyb0capo6lpGroq7PcDEBECkgMatijJ2hkfCreVvFMcvyl1RhSdAM
 JfByD4EqWw8JFYs195LcBMrUSpgCPxte6VGIy3b+aPFh6xd2hinx5zbnq g==;
X-CSE-ConnectionGUID: jcnmvvtySImUrifC6zrMgw==
X-CSE-MsgGUID: PJ4tB6W8SfmWnQrXY7aWhQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11720"; a="84984548"
X-IronPort-AV: E=Sophos;i="6.23,104,1770624000"; d="scan'208";a="84984548"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
 by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 06 Mar 2026 02:58:31 -0800
X-CSE-ConnectionGUID: N5nYoyfvRlKhOYVBZVuTlw==
X-CSE-MsgGUID: gzWOsEnSSzuTMNz3JwXkKQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,104,1770624000"; d="scan'208";a="215678390"
Received: from silpixa00401119.ir.intel.com ([10.20.224.206])
 by fmviesa006.fm.intel.com with ESMTP; 06 Mar 2026 02:58:30 -0800
From: Anatoly Burakov <anatoly.burakov@intel.com>
To: dev@dpdk.org,
	Vladimir Medvedkin <vladimir.medvedkin@intel.com>
Subject: [PATCH v3 3/8] net/iavf: add virtchnl interrupt enable flag
Date: Fri,  6 Mar 2026 10:58:19 +0000
Message-ID: <2a9e9fbceaf98b0f3224de5b5928477b87c033f9.1772794442.git.anatoly.burakov@intel.com>
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

For some functionality, we will need to know if the virtchnl message queue
interrupts are enabled (i.e. if the new virtchnl messages will be delivered
into an interrupt thread as opposed to having to directly poll the queue).
Add such flag and track its status during init/close.

Signed-off-by: Anatoly Burakov <anatoly.burakov@intel.com>
---
 drivers/net/intel/iavf/iavf.h        | 1 +
 drivers/net/intel/iavf/iavf_ethdev.c | 3 +++
 2 files changed, 4 insertions(+)

diff --git a/drivers/net/intel/iavf/iavf.h b/drivers/net/intel/iavf/iavf.h
index b2389e0bbd..cf98d12247 100644
--- a/drivers/net/intel/iavf/iavf.h
+++ b/drivers/net/intel/iavf/iavf.h
@@ -243,6 +243,7 @@ struct iavf_info {
 	RTE_ATOMIC(uint32_t) pend_cmd_count;
 	int cmd_retval; /* return value of the cmd response from PF */
 	uint8_t *aq_resp; /* buffer to store the adminq response from PF */
+	bool aq_intr_enabled;
 
 	/** iAVF watchdog enable */
 	bool watchdog_enabled;
diff --git a/drivers/net/intel/iavf/iavf_ethdev.c b/drivers/net/intel/iavf/iavf_ethdev.c
index e3690cce11..9fdebec0f4 100644
--- a/drivers/net/intel/iavf/iavf_ethdev.c
+++ b/drivers/net/intel/iavf/iavf_ethdev.c
@@ -2853,6 +2853,7 @@ iavf_dev_init(struct rte_eth_dev *eth_dev)
 
 	/* configure and enable device interrupt */
 	iavf_enable_irq0(hw);
+	vf->aq_intr_enabled = true;
 
 	ret = iavf_flow_init(adapter);
 	if (ret) {
@@ -2900,6 +2901,7 @@ iavf_dev_init(struct rte_eth_dev *eth_dev)
 	iavf_security_ctx_destroy(adapter);
 
 flow_init_err:
+	vf->aq_intr_enabled = false;
 	iavf_disable_irq0(hw);
 
 	if (vf->vf_res->vf_cap_flags & VIRTCHNL_VF_OFFLOAD_WB_ON_ITR) {
@@ -2975,6 +2977,7 @@ iavf_dev_close(struct rte_eth_dev *dev)
 		iavf_config_promisc(adapter, false, false);
 
 	iavf_vf_reset(hw);
+	vf->aq_intr_enabled = false;
 	iavf_shutdown_adminq(hw);
 	if (vf->vf_res->vf_cap_flags & VIRTCHNL_VF_OFFLOAD_WB_ON_ITR) {
 		/* disable uio intr before callback unregister */
-- 
2.47.3

