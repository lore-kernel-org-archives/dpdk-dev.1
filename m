Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 00C2FF3C995
	for <dpdk-dev@archiver.kernel.org>; Tue, 24 Feb 2026 15:17:11 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 52FAB40B92;
	Tue, 24 Feb 2026 16:15:20 +0100 (CET)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
 by mails.dpdk.org (Postfix) with ESMTP id 3AECA4027F
 for <dev@dpdk.org>; Tue, 24 Feb 2026 16:14:59 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1771946099; x=1803482099;
 h=from:to:subject:date:message-id:in-reply-to:references:
 mime-version:content-transfer-encoding;
 bh=+8nKMAKkIVgfnKiwBhBmGA/cRbCv/5fFBB4ZfwMLKck=;
 b=nvwhAUXoKiun0nUsgPNQpBEx2dLhVHUpDVeZPR5N7LSSMopE9MMiVutk
 9nAcp8xv7Oql4+ocCYdKEF3Ku7TeMnC6QVVOH+WojIG9+0Ruj0sQzQEMK
 ItNSyrcsdV6JHt3lNN4y7fJ6c0GGxA1l+n3kuGgKiHVP2oJPxaceNJMHR
 aKk6cUCmNqAAr7ZDd1Hb7BCESySIVp7ipmMXC51HHSYm7Zu8drF3a3TU1
 JRdMPJXZs8I5uwBPQYcX6UsxRIjc/F1I+RbAZGEHrBFmdldCauQ7r9mZ2
 WilKAusqoayKf4QsbrgwqjEUJfGX0qHngC8gDNtMXcSxvKQDtVPQWRRCg g==;
X-CSE-ConnectionGUID: 2cBJrj13TSOJPnIKVS/zEQ==
X-CSE-MsgGUID: 8W0zpd/UTI2CcxtUkJd6pg==
X-IronPort-AV: E=McAfee;i="6800,10657,11711"; a="84056274"
X-IronPort-AV: E=Sophos;i="6.21,308,1763452800"; d="scan'208";a="84056274"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
 by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 24 Feb 2026 07:14:59 -0800
X-CSE-ConnectionGUID: P5XaErXmRT+waGVeHFI0Yg==
X-CSE-MsgGUID: +zO7lsVNRamv0gg2S3ugPA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,308,1763452800"; d="scan'208";a="220526218"
Received: from silpixa00401119.ir.intel.com ([10.20.224.206])
 by fmviesa005.fm.intel.com with ESMTP; 24 Feb 2026 07:14:58 -0800
From: Anatoly Burakov <anatoly.burakov@intel.com>
To: dev@dpdk.org,
	Vladimir Medvedkin <vladimir.medvedkin@intel.com>
Subject: [PATCH v9 20/26] net/iavf: avoid rte malloc in MAC address operations
Date: Tue, 24 Feb 2026 15:14:25 +0000
Message-ID: <c05e1cd7b3ddc0bc4896125e9c3d5b803daf7204.1771945933.git.anatoly.burakov@intel.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <cover.1771945933.git.anatoly.burakov@intel.com>
 <cover.1771945933.git.anatoly.burakov@intel.com>
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
 drivers/net/intel/iavf/iavf_vchnl.c | 88 ++++++++++++-----------------
 1 file changed, 35 insertions(+), 53 deletions(-)

diff --git a/drivers/net/intel/iavf/iavf_vchnl.c b/drivers/net/intel/iavf/iavf_vchnl.c
index 55986ef909..e27d68fd9f 100644
--- a/drivers/net/intel/iavf/iavf_vchnl.c
+++ b/drivers/net/intel/iavf/iavf_vchnl.c
@@ -1380,63 +1380,45 @@ iavf_config_irq_map_lv(struct iavf_adapter *adapter, uint16_t num,
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
+	size_t buf_len;
 
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
+
+	/* for some reason PF side checks for buffer being too big, so adjust it down */
+	buf_len = sizeof(struct virtchnl_ether_addr_list) +
+		  sizeof(struct virtchnl_ether_addr) * list->num_elements;
+
+	list->vsi_id = vf->vsi_res->vsi_id;
+	args.ops = add ? VIRTCHNL_OP_ADD_ETH_ADDR : VIRTCHNL_OP_DEL_ETH_ADDR;
+	args.in_args = (uint8_t *)list;
+	args.in_args_size = buf_len;
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

