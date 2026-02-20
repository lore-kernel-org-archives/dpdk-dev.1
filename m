Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 978A9C531FF
	for <dpdk-dev@archiver.kernel.org>; Fri, 20 Feb 2026 10:17:43 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id BC6B440DDD;
	Fri, 20 Feb 2026 11:15:41 +0100 (CET)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
 by mails.dpdk.org (Postfix) with ESMTP id 6D49540B9E
 for <dev@dpdk.org>; Fri, 20 Feb 2026 11:15:19 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1771582519; x=1803118519;
 h=from:to:subject:date:message-id:in-reply-to:references:
 mime-version:content-transfer-encoding;
 bh=Kkb1Dkqp80lnkYbIrIcIWd6ZpxzjvrkTSdR7P4BmuoM=;
 b=HgF+uq4El3sT8BZvRBLjot1E3ebAzUNC7MqNLFR6jeyuhQRoQJjxeOYV
 Tox9gUD9cCSullHNItfLJwjuogP68YtUbIfBlstAoxu8w7Ech838kJwlY
 bp/tMDWwEOWe/WnIJgixTZgsOAENwv+aqi2U/dN+VTv9bljmT7z9BjDiw
 BIahjOUfhN/Abxyjy+tIYAGpfN+DypLlvyZ/3Txk4LT0sT3PPZdt8kfHq
 Dk1qoZfnjTqef0FC4OPDyldsvF2nV4KXzZZ6csXePTEZX7cnHWOoP5xRn
 +ixL2R1VqYFkoRqyt1JxfRrQy80ABp688plhWsKIZa32su025NRQltdkS A==;
X-CSE-ConnectionGUID: ZeXdaQJxSrK0NO7B3HwRgA==
X-CSE-MsgGUID: Fu7kq3ayTNOCUHxma3Liyg==
X-IronPort-AV: E=McAfee;i="6800,10657,11706"; a="75283375"
X-IronPort-AV: E=Sophos;i="6.21,301,1763452800"; d="scan'208";a="75283375"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
 by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 20 Feb 2026 02:15:19 -0800
X-CSE-ConnectionGUID: rKluAv0XTH+tA0GgHckzAA==
X-CSE-MsgGUID: qZ1AcglpSpaRJ08BPaWdJQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,301,1763452800"; d="scan'208";a="214038582"
Received: from silpixa00401119.ir.intel.com ([10.20.224.206])
 by orviesa010.jf.intel.com with ESMTP; 20 Feb 2026 02:15:18 -0800
From: Anatoly Burakov <anatoly.burakov@intel.com>
To: dev@dpdk.org,
	Bruce Richardson <bruce.richardson@intel.com>
Subject: [PATCH v7 25/27] net/ice: avoid rte malloc in MAC address operations
Date: Fri, 20 Feb 2026 10:14:32 +0000
Message-ID: <077c85991988a95416261758bcc0e512dd9432e1.1771582363.git.anatoly.burakov@intel.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <cover.1771582362.git.anatoly.burakov@intel.com>
 <cover.1771582362.git.anatoly.burakov@intel.com>
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

