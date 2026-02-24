Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ADD1CE9B258
	for <dpdk-dev@archiver.kernel.org>; Tue, 24 Feb 2026 12:26:40 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 47DA940B9C;
	Tue, 24 Feb 2026 13:24:34 +0100 (CET)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
 by mails.dpdk.org (Postfix) with ESMTP id BDD4340656
 for <dev@dpdk.org>; Tue, 24 Feb 2026 13:24:05 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1771935846; x=1803471846;
 h=from:to:subject:date:message-id:in-reply-to:references:
 mime-version:content-transfer-encoding;
 bh=Kkb1Dkqp80lnkYbIrIcIWd6ZpxzjvrkTSdR7P4BmuoM=;
 b=W/C6R2s9wpNb/7HU1h1E5tZs1q7Qxk97iH8ObwK706/ATTDhF5cHo6Cz
 iD5G0+DsYkplItjMRMe3uwDTD/BoJYglX0zUACYTEdEvSlcunCixWazxz
 ShcBuPjfC+NmEoENOgtYy7U9+F0Goq+hrRKB/bdYQeuV7G/aS1aeBmIt0
 ZPWJptNrMVb1lKUxzsm84MhQhavWgyUab2TA/som5z/R1eecPJ/vy68sk
 ufdkahsgY8ZTUnM9feG2HV49X7Q9Q61Wrf3s3IKZN5/9rbHCdmXLoyhwA
 Upfc56LuDYS7Ue7tiJ73LrutcHZ0nGXadV+e3GVVj6qEE4ueJWrcsv9Mt A==;
X-CSE-ConnectionGUID: e9kN7LsyTo2YZmnwcGYlWw==
X-CSE-MsgGUID: FPnqreLKTHGXuO4NeJYheg==
X-IronPort-AV: E=McAfee;i="6800,10657,11710"; a="72158147"
X-IronPort-AV: E=Sophos;i="6.21,308,1763452800"; d="scan'208";a="72158147"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
 by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 24 Feb 2026 04:24:06 -0800
X-CSE-ConnectionGUID: uIemoTAITROHnYNgGoJnxg==
X-CSE-MsgGUID: LvAnBLCVS16CQst5NgwYeA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,308,1763452800"; d="scan'208";a="243854492"
Received: from silpixa00401119.ir.intel.com ([10.20.224.206])
 by fmviesa001.fm.intel.com with ESMTP; 24 Feb 2026 04:24:05 -0800
From: Anatoly Burakov <anatoly.burakov@intel.com>
To: dev@dpdk.org,
	Bruce Richardson <bruce.richardson@intel.com>
Subject: [PATCH v8 24/26] net/ice: avoid rte malloc in MAC address operations
Date: Tue, 24 Feb 2026 12:23:33 +0000
Message-ID: <c33099c07075b848167ab70d6f45b6bc07be57a1.1771935744.git.anatoly.burakov@intel.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <cover.1771935744.git.anatoly.burakov@intel.com>
 <cover.1771935744.git.anatoly.burakov@intel.com>
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
index 388495d69c..0d3599d7d0 100644
--- a/drivers/net/intel/ice/ice_dcf_ethdev.c
+++ b/drivers/net/intel/ice/ice_dcf_ethdev.c
@@ -926,19 +926,14 @@ dcf_add_del_mc_addr_list(struct ice_dcf_hw *hw,
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
@@ -953,13 +948,12 @@ dcf_add_del_mc_addr_list(struct ice_dcf_hw *hw,
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

