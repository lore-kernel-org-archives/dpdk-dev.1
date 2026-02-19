Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C5705E9A04A
	for <dpdk-dev@archiver.kernel.org>; Thu, 19 Feb 2026 16:26:20 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 7F8D740DCA;
	Thu, 19 Feb 2026 17:24:00 +0100 (CET)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
 by mails.dpdk.org (Postfix) with ESMTP id 3B0694060C
 for <dev@dpdk.org>; Thu, 19 Feb 2026 17:23:45 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1771518226; x=1803054226;
 h=from:to:subject:date:message-id:in-reply-to:references:
 mime-version:content-transfer-encoding;
 bh=cmE6/LLdyKYREBdM95QoJQn4jTUfnfaMbCEtOgEo5i4=;
 b=IwyW1JuQrBY05/henUG6o7GppTdXZqhKm1dsLhtBnisdn4b+sBg5cjJZ
 9kXCv65+MDe+GeQyqHBRbFs8vCFYtM3qH0R7R5dYXRQVwLloVforAeUw8
 cKoNl1lMOlT23QJuvYIAQX9kXdXdOjP6MjHPBMNFPaC1Ad6xaOj4olgq1
 npwb0XC9dqD4NJZJjXvF7XA9r9UqQ/ouol7ONEKhzJTZO5WbyHllPwd4W
 TnB84tP4TGI9B18ooQgDIPHdTnCJm9inJNmrTQhYNw8LFA3PQC2+ZquB4
 HaVSKE/Gj6a2kdX52HVq4r247KS0S6irNY90JUnCeBsYm8YeE/kgvO4Ck Q==;
X-CSE-ConnectionGUID: pHF3dA7UQ2WUMBkWAFCA8Q==
X-CSE-MsgGUID: m/4A8PEXR7GvNc1AFhT54w==
X-IronPort-AV: E=McAfee;i="6800,10657,11706"; a="83231473"
X-IronPort-AV: E=Sophos;i="6.21,300,1763452800"; d="scan'208";a="83231473"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
 by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 19 Feb 2026 08:23:44 -0800
X-CSE-ConnectionGUID: kh0wO8nNTxq9bj1DBGRobg==
X-CSE-MsgGUID: XyovP5cxQ/K3NSRPcWo85Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,300,1763452800"; d="scan'208";a="218700001"
Received: from silpixa00401119.ir.intel.com ([10.20.224.206])
 by orviesa003.jf.intel.com with ESMTP; 19 Feb 2026 08:23:44 -0800
From: Anatoly Burakov <anatoly.burakov@intel.com>
To: dev@dpdk.org,
	Bruce Richardson <bruce.richardson@intel.com>
Subject: [PATCH v6 25/27] net/ice: avoid rte malloc in MAC address operations
Date: Thu, 19 Feb 2026 16:23:08 +0000
Message-ID: <e4a54d8ccba04f9294ba6aea47ff8115b7adb652.1771518103.git.anatoly.burakov@intel.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <cover.1771518103.git.anatoly.burakov@intel.com>
 <cover.1771518103.git.anatoly.burakov@intel.com>
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

Currently, when adding or deleting MAC addresses, we are using
rte_zmalloc followed by an immediate rte_free. This memory does not need
to be stored in hugepage memory, so replace it with stack allocation.

Signed-off-by: Anatoly Burakov <anatoly.burakov@intel.com>
Acked-by: Bruce Richardson <bruce.richardson@intel.com>
---
 drivers/net/intel/ice/ice_dcf_ethdev.c | 22 ++++++++--------------
 1 file changed, 8 insertions(+), 14 deletions(-)

diff --git a/drivers/net/intel/ice/ice_dcf_ethdev.c b/drivers/net/intel/ice/ice_dcf_ethdev.c
index 037382b336..332f1e356e 100644
--- a/drivers/net/intel/ice/ice_dcf_ethdev.c
+++ b/drivers/net/intel/ice/ice_dcf_ethdev.c
@@ -928,19 +928,14 @@ dcf_add_del_mc_addr_list(struct ice_dcf_hw *hw,
 			 struct rte_ether_addr *mc_addrs,
 			 uint32_t mc_addrs_num, bool add)
 {
-	struct virtchnl_ether_addr_list *list;
-	struct dcf_virtchnl_cmd args;
+	struct {
+		struct virtchnl_ether_addr_list list;
+		struct virtchnl_ether_addr addr[DCF_NUM_MACADDR_MAX];
+	} list_req = {0};
+	struct virtchnl_ether_addr_list *list = &list_req.list;
+	struct dcf_virtchnl_cmd args = {0};
 	uint32_t i;
-	int len, err = 0;
-
-	len = sizeof(struct virtchnl_ether_addr_list);
-	len += sizeof(struct virtchnl_ether_addr) * mc_addrs_num;
-
-	list = rte_zmalloc(NULL, len, 0);
-	if (!list) {
-		PMD_DRV_LOG(ERR, "fail to allocate memory");
-		return -ENOMEM;
-	}
+	int err = 0;
 
 	for (i = 0; i < mc_addrs_num; i++) {
 		memcpy(list->list[i].addr, mc_addrs[i].addr_bytes,
@@ -955,13 +950,12 @@ dcf_add_del_mc_addr_list(struct ice_dcf_hw *hw,
 	args.v_op = add ? VIRTCHNL_OP_ADD_ETH_ADDR :
 			VIRTCHNL_OP_DEL_ETH_ADDR;
 	args.req_msg = (uint8_t *)list;
-	args.req_msglen  = len;
+	args.req_msglen  = sizeof(list_req);
 	err = ice_dcf_execute_virtchnl_cmd(hw, &args);
 	if (err)
 		PMD_DRV_LOG(ERR, "fail to execute command %s",
 			    add ? "OP_ADD_ETHER_ADDRESS" :
 			    "OP_DEL_ETHER_ADDRESS");
-	rte_free(list);
 	return err;
 }
 
-- 
2.47.3

