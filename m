Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5ADDEE9B25B
	for <dpdk-dev@archiver.kernel.org>; Tue, 24 Feb 2026 12:26:05 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 8B1C440697;
	Tue, 24 Feb 2026 13:24:29 +0100 (CET)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
 by mails.dpdk.org (Postfix) with ESMTP id 087D340656
 for <dev@dpdk.org>; Tue, 24 Feb 2026 13:24:01 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1771935842; x=1803471842;
 h=from:to:subject:date:message-id:in-reply-to:references:
 mime-version:content-transfer-encoding;
 bh=L/7N8bXKb0D4zePeelJ4F5T0lW+E32VsBS6BHfy4TvU=;
 b=OA18LojUXwZbyQmnAV2stVTaqdQqbDUUqfBCxXkJO0oYAQMGgjlia/+o
 G9f2CL1N6+b1sAsRyVBEatFITyN4wG4om83cK0NRUYXZ/vl3wlUWzA0en
 RFLIeByB5NMk833zFuNj3ywK2NE8+Pf1olCRqqFzJFHRa4Y9ImSlqWArL
 XLhYVchzPn5fI8agoDi8ctYIDFP2m/V0dlQOmYi/untGEmg5YH1PqNyvQ
 lEAlBQOykvsLsX/4EwKnJUMW6Vr3rl3WOeccQA2AHGPp7pLUZEPBZZ7tf
 /E5irZ/E87nEPiCuKuggGqKiNMA/3Ek+avXxJtsMdag/vDDSRGFCwex8u Q==;
X-CSE-ConnectionGUID: OHCny+HZT/ajyB/wNXGnpA==
X-CSE-MsgGUID: jjLFPbRwS3yWcYETSRMdBQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11710"; a="72158140"
X-IronPort-AV: E=Sophos;i="6.21,308,1763452800"; d="scan'208";a="72158140"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
 by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 24 Feb 2026 04:24:02 -0800
X-CSE-ConnectionGUID: /WCqbFSIQ0yr5r3brLHMqA==
X-CSE-MsgGUID: 0DSGL2P9TkyPlD6YUyMuYA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,308,1763452800"; d="scan'208";a="243854478"
Received: from silpixa00401119.ir.intel.com ([10.20.224.206])
 by fmviesa001.fm.intel.com with ESMTP; 24 Feb 2026 04:24:01 -0800
From: Anatoly Burakov <anatoly.burakov@intel.com>
To: dev@dpdk.org,
	Vladimir Medvedkin <vladimir.medvedkin@intel.com>
Subject: [PATCH v8 20/26] net/iavf: avoid rte malloc in MAC address operations
Date: Tue, 24 Feb 2026 12:23:29 +0000
Message-ID: <cf3408fc6669754bdad6d22042f7a71b2d15e9df.1771935744.git.anatoly.burakov@intel.com>
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

The original code also had a loop attempting to split up sending MAC
address list into multiple virtchnl messages. However, maximum number of
MAC addresses is 64, sizeof() each MAC address is 8 bytes, and maximum
virtchnl message size is 4K, so splitting it up is actually unnecessary.
This loop has been removed.

Signed-off-by: Anatoly Burakov <anatoly.burakov@intel.com>
---
 drivers/net/intel/iavf/iavf_vchnl.c | 82 ++++++++++-------------------
 1 file changed, 29 insertions(+), 53 deletions(-)

diff --git a/drivers/net/intel/iavf/iavf_vchnl.c b/drivers/net/intel/iavf/iavf_vchnl.c
index 55986ef909..f44dc7e7be 100644
--- a/drivers/net/intel/iavf/iavf_vchnl.c
+++ b/drivers/net/intel/iavf/iavf_vchnl.c
@@ -1380,63 +1380,39 @@ iavf_config_irq_map_lv(struct iavf_adapter *adapter, uint16_t num,
 void
 iavf_add_del_all_mac_addr(struct iavf_adapter *adapter, bool add)
 {
-	struct virtchnl_ether_addr_list *list;
+	struct {
+		struct virtchnl_ether_addr_list list;
+		struct virtchnl_ether_addr addr[IAVF_NUM_MACADDR_MAX];
+	} list_req = {0};
+	struct virtchnl_ether_addr_list *list = &list_req.list;
 	struct iavf_info *vf = IAVF_DEV_PRIVATE_TO_VF(adapter);
-	struct rte_ether_addr *addr;
-	struct iavf_cmd_info args;
-	int len, err, i, j;
-	int next_begin = 0;
-	int begin = 0;
+	struct iavf_cmd_info args = {0};
+	int err, i;
 
-	do {
-		j = 0;
-		len = sizeof(struct virtchnl_ether_addr_list);
-		for (i = begin; i < IAVF_NUM_MACADDR_MAX; i++, next_begin++) {
-			addr = &adapter->dev_data->mac_addrs[i];
-			if (rte_is_zero_ether_addr(addr))
-				continue;
-			len += sizeof(struct virtchnl_ether_addr);
-			if (len >= IAVF_AQ_BUF_SZ) {
-				next_begin = i + 1;
-				break;
-			}
-		}
+	for (i = 0; i < IAVF_NUM_MACADDR_MAX; i++) {
+		struct rte_ether_addr *addr = &adapter->dev_data->mac_addrs[i];
+		struct virtchnl_ether_addr *vc_addr = &list->list[list->num_elements];
 
-		list = rte_zmalloc("iavf_del_mac_buffer", len, 0);
-		if (!list) {
-			PMD_DRV_LOG(ERR, "fail to allocate memory");
-			return;
-		}
+		/* ignore empty addresses */
+		if (rte_is_zero_ether_addr(addr))
+			continue;
+		list->num_elements++;
 
-		for (i = begin; i < next_begin; i++) {
-			addr = &adapter->dev_data->mac_addrs[i];
-			if (rte_is_zero_ether_addr(addr))
-				continue;
-			rte_memcpy(list->list[j].addr, addr->addr_bytes,
-				   sizeof(addr->addr_bytes));
-			list->list[j].type = (j == 0 ?
-					      VIRTCHNL_ETHER_ADDR_PRIMARY :
-					      VIRTCHNL_ETHER_ADDR_EXTRA);
-			PMD_DRV_LOG(DEBUG, "add/rm mac:" RTE_ETHER_ADDR_PRT_FMT,
-				    RTE_ETHER_ADDR_BYTES(addr));
-			j++;
-		}
-		list->vsi_id = vf->vsi_res->vsi_id;
-		list->num_elements = j;
-		args.ops = add ? VIRTCHNL_OP_ADD_ETH_ADDR :
-			   VIRTCHNL_OP_DEL_ETH_ADDR;
-		args.in_args = (uint8_t *)list;
-		args.in_args_size = len;
-		args.out_buffer = vf->aq_resp;
-		args.out_size = IAVF_AQ_BUF_SZ;
-		err = iavf_execute_vf_cmd_safe(adapter, &args, 0);
-		if (err)
-			PMD_DRV_LOG(ERR, "fail to execute command %s",
-				    add ? "OP_ADD_ETHER_ADDRESS" :
-				    "OP_DEL_ETHER_ADDRESS");
-		rte_free(list);
-		begin = next_begin;
-	} while (begin < IAVF_NUM_MACADDR_MAX);
+		memcpy(vc_addr->addr, addr->addr_bytes, sizeof(addr->addr_bytes));
+		vc_addr->type = (list->num_elements == 1) ?
+				VIRTCHNL_ETHER_ADDR_PRIMARY :
+				VIRTCHNL_ETHER_ADDR_EXTRA;
+	}
+	list->vsi_id = vf->vsi_res->vsi_id;
+	args.ops = add ? VIRTCHNL_OP_ADD_ETH_ADDR : VIRTCHNL_OP_DEL_ETH_ADDR;
+	args.in_args = (uint8_t *)list;
+	args.in_args_size = sizeof(list_req);
+	args.out_buffer = vf->aq_resp;
+	args.out_size = IAVF_AQ_BUF_SZ;
+	err = iavf_execute_vf_cmd_safe(adapter, &args, 0);
+	if (err)
+		PMD_DRV_LOG(ERR, "fail to execute command %s",
+				add ? "OP_ADD_ETHER_ADDRESS" : "OP_DEL_ETHER_ADDRESS");
 }
 
 int
-- 
2.47.3

