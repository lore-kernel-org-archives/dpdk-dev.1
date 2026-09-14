Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8734EC88E64
	for <dpdk-dev@archiver.kernel.org>; Mon, 14 Sep 2026 08:17:58 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 9D785406BA;
	Mon, 14 Sep 2026 10:17:51 +0200 (CEST)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by mails.dpdk.org (Postfix) with ESMTP id 47E9E402C4
 for <dev@dpdk.org>; Mon, 14 Sep 2026 10:17:50 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1789373869;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=UNsXg2PfLME1srkQNWKfWgpKj5Z39NoL9bhW+RoOVpA=;
 b=OjrZj+Mkel7o5coE5K4wJnWjgAJt6u6aiax2zYXjfCEMdUm7z/F4Il3WpY6zAg+dPGa171
 LUAAYR8mT3Gl/uRbqa7cxmwLHZZpwbWajSLfqgAfdfoyNQhtDLAB5RnobwtjYthLMuY/ea
 RAbXTPcCQ4rvm73eHW24AxJbExPtOXA=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-131-f5kkoBczNmqo5X2oDByY5g-1; Mon,
 14 Sep 2026 04:17:45 -0400
X-MC-Unique: f5kkoBczNmqo5X2oDByY5g-1
X-Mimecast-MFC-AGG-ID: f5kkoBczNmqo5X2oDByY5g_1789373865
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id C3C3C195BDE8; Mon, 14 Sep 2026 08:17:44 +0000 (UTC)
Received: from dmarchan.redhat.corp
 (headnet05.pony-001.prod.iad2.dc.redhat.com [10.2.32.117])
 by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 1EE5E195604D; Mon, 14 Sep 2026 08:17:42 +0000 (UTC)
From: David Marchand <david.marchand@redhat.com>
To: dev@dpdk.org
Cc: ciara.loftus@intel.com, anatoly.burakov@intel.com, rjarry@redhat.com,
 cfontain@redhat.com, Vladimir Medvedkin <vladimir.medvedkin@intel.com>
Subject: [PATCH v7 3/4] net/iavf: add a helper for sending MAC addresses to PF
Date: Mon, 14 Sep 2026 10:17:24 +0200
Message-ID: <20260914081725.1097704-3-david.marchand@redhat.com>
In-Reply-To: <20260914081725.1097704-1-david.marchand@redhat.com>
References: <20260403091836.1073484-1-david.marchand@redhat.com>
 <20260914081725.1097704-1-david.marchand@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: _ofByD0uHi5CVl5DFk6Rxo5_0FevNW70bBUq75f3o2g_1789373865
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
content-type: text/plain; charset="US-ASCII"; x-default=true
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

Rather than have multiple implementations of the same code,
define a single helper.

This is also a good place where to check if the driver is requesting too
many addresses in a single message to the PF.

Signed-off-by: David Marchand <david.marchand@redhat.com>
---
 drivers/net/intel/iavf/iavf_vchnl.c | 124 +++++++++++++---------------
 1 file changed, 56 insertions(+), 68 deletions(-)

diff --git a/drivers/net/intel/iavf/iavf_vchnl.c b/drivers/net/intel/iavf/iavf_vchnl.c
index a918db5443..decfae3182 100644
--- a/drivers/net/intel/iavf/iavf_vchnl.c
+++ b/drivers/net/intel/iavf/iavf_vchnl.c
@@ -1671,50 +1671,69 @@ iavf_config_irq_map_lv(struct iavf_adapter *adapter, uint16_t num)
 	return 0;
 }
 
+#define IAVF_ETH_ADDR_PER_REQ \
+	((IAVF_AQ_BUF_SZ - sizeof(struct virtchnl_ether_addr_list)) / \
+	 sizeof(struct virtchnl_ether_addr))
+#define IAVF_ETH_ADDR_CMD_SIZE(nb_addrs) \
+	(sizeof(struct virtchnl_ether_addr_list) + sizeof(struct virtchnl_ether_addr) * (nb_addrs))
+
+static int
+iavf_send_eth_addr_list(struct iavf_adapter *adapter, const char *caller,
+		struct virtchnl_ether_addr_list *list, bool add)
+{
+	uint8_t msg_buf[IAVF_AQ_BUF_SZ] = {0};
+	struct iavf_cmd_info args;
+	int err;
+
+	if (list->num_elements > IAVF_ETH_ADDR_PER_REQ) {
+		PMD_DRV_LOG(ERR, "cannot fit this ethernet address list in a message to the PF");
+		return -EINVAL;
+	}
+
+	memset(&args, 0, sizeof(args));
+	args.ops = add ? VIRTCHNL_OP_ADD_ETH_ADDR : VIRTCHNL_OP_DEL_ETH_ADDR;
+	args.in_args = (uint8_t *)list;
+	args.in_args_size = IAVF_ETH_ADDR_CMD_SIZE(list->num_elements);
+	args.out_buffer = msg_buf;
+	args.out_size = IAVF_AQ_BUF_SZ;
+	err = iavf_execute_vf_cmd_safe(adapter, &args);
+	if (err != 0) {
+		PMD_DRV_LOG(ERR, "fail to execute command %s for %s",
+			add ? "VIRTCHNL_OP_ADD_ETH_ADDR" : "VIRTCHNL_OP_DEL_ETH_ADDR", caller);
+		return err;
+	}
+
+	PMD_DRV_LOG(DEBUG, "executed command %s for %s",
+		add ? "VIRTCHNL_OP_ADD_ETH_ADDR" : "VIRTCHNL_OP_DEL_ETH_ADDR", caller);
+
+	return 0;
+}
+
 void
 iavf_add_del_secondary_mac_addr(struct iavf_adapter *adapter, bool add)
 {
 	struct iavf_info *vf = IAVF_DEV_PRIVATE_TO_VF(adapter);
-	struct {
-		struct virtchnl_ether_addr_list list;
-		struct virtchnl_ether_addr addr[RTE_DIM(vf->mac_addrs)];
-	} list_req = {0};
-	struct virtchnl_ether_addr_list *list = &list_req.list;
-	uint8_t msg_buf[IAVF_AQ_BUF_SZ] = {0};
-	struct iavf_cmd_info args = {0};
-	int err;
-	size_t buf_len;
+	uint8_t cmd_buffer[IAVF_ETH_ADDR_CMD_SIZE(RTE_DIM(vf->mac_addrs))] = {0};
+	struct virtchnl_ether_addr_list *list;
+
+	list = (struct virtchnl_ether_addr_list *)cmd_buffer;
+	list->vsi_id = vf->vsi_res->vsi_id;
+	list->num_elements = 0;
 
 	for (unsigned int i = 1; i < RTE_DIM(vf->mac_addrs); i++) {
 		struct rte_ether_addr *addr = &vf->mac_addrs[i];
 		struct virtchnl_ether_addr *vc_addr = &list->list[list->num_elements];
 
-		/* ignore empty addresses */
-		if (rte_is_zero_ether_addr(addr))
-			continue;
-		list->num_elements++;
+		if (!rte_is_zero_ether_addr(addr)) {
+			list->num_elements++;
 
-		memcpy(vc_addr->addr, addr->addr_bytes, sizeof(addr->addr_bytes));
-		vc_addr->type = VIRTCHNL_ETHER_ADDR_EXTRA;
+			memcpy(vc_addr->addr, addr->addr_bytes, sizeof(addr->addr_bytes));
+			vc_addr->type = VIRTCHNL_ETHER_ADDR_EXTRA;
+		}
 	}
 
-	if (list->num_elements == 0)
-		return;
-
-	/* for some reason PF side checks for buffer being too big, so adjust it down */
-	buf_len = sizeof(struct virtchnl_ether_addr_list) +
-		  sizeof(struct virtchnl_ether_addr) * list->num_elements;
-
-	list->vsi_id = vf->vsi_res->vsi_id;
-	args.ops = add ? VIRTCHNL_OP_ADD_ETH_ADDR : VIRTCHNL_OP_DEL_ETH_ADDR;
-	args.in_args = (uint8_t *)list;
-	args.in_args_size = buf_len;
-	args.out_buffer = msg_buf;
-	args.out_size = IAVF_AQ_BUF_SZ;
-	err = iavf_execute_vf_cmd_safe(adapter, &args);
-	if (err)
-		PMD_DRV_LOG(ERR, "fail to execute command %s",
-				add ? "OP_ADD_ETHER_ADDRESS" : "OP_DEL_ETHER_ADDRESS");
+	if (list->num_elements != 0)
+		(void)iavf_send_eth_addr_list(adapter, __func__, list, add);
 }
 
 int
@@ -1797,13 +1816,9 @@ int
 iavf_add_del_eth_addr(struct iavf_adapter *adapter, struct rte_ether_addr *addr,
 		     bool add, uint8_t type)
 {
-	struct virtchnl_ether_addr_list *list;
 	struct iavf_info *vf = IAVF_DEV_PRIVATE_TO_VF(adapter);
-	uint8_t msg_buf[IAVF_AQ_BUF_SZ] = {0};
-	uint8_t cmd_buffer[sizeof(struct virtchnl_ether_addr_list) +
-			   sizeof(struct virtchnl_ether_addr)];
-	struct iavf_cmd_info args;
-	int err;
+	uint8_t cmd_buffer[IAVF_ETH_ADDR_CMD_SIZE(1)] = {0};
+	struct virtchnl_ether_addr_list *list;
 
 	if (adapter->closed)
 		return -EIO;
@@ -1815,16 +1830,7 @@ iavf_add_del_eth_addr(struct iavf_adapter *adapter, struct rte_ether_addr *addr,
 	memcpy(list->list[0].addr, addr->addr_bytes,
 		   sizeof(addr->addr_bytes));
 
-	args.ops = add ? VIRTCHNL_OP_ADD_ETH_ADDR : VIRTCHNL_OP_DEL_ETH_ADDR;
-	args.in_args = cmd_buffer;
-	args.in_args_size = sizeof(cmd_buffer);
-	args.out_buffer = msg_buf;
-	args.out_size = IAVF_AQ_BUF_SZ;
-	err = iavf_execute_vf_cmd_safe(adapter, &args);
-	if (err)
-		PMD_DRV_LOG(ERR, "fail to execute command %s",
-			    add ? "OP_ADD_ETH_ADDR" :  "OP_DEL_ETH_ADDR");
-	return err;
+	return iavf_send_eth_addr_list(adapter, __func__, list, add);
 }
 
 int
@@ -2302,14 +2308,10 @@ iavf_add_del_mc_addr_list(struct iavf_adapter *adapter,
 			struct rte_ether_addr *mc_addrs,
 			uint32_t mc_addrs_num, bool add)
 {
+	uint8_t cmd_buffer[IAVF_ETH_ADDR_CMD_SIZE(IAVF_NUM_MACADDR_MAX)] = {0};
 	struct iavf_info *vf = IAVF_DEV_PRIVATE_TO_VF(adapter);
-	uint8_t msg_buf[IAVF_AQ_BUF_SZ] = {0};
-	uint8_t cmd_buffer[sizeof(struct virtchnl_ether_addr_list) +
-		(IAVF_NUM_MACADDR_MAX * sizeof(struct virtchnl_ether_addr))];
 	struct virtchnl_ether_addr_list *list;
-	struct iavf_cmd_info args;
 	uint32_t i;
-	int err;
 
 	if (mc_addrs == NULL || mc_addrs_num == 0)
 		return 0;
@@ -2330,21 +2332,7 @@ iavf_add_del_mc_addr_list(struct iavf_adapter *adapter,
 		list->list[i].type = VIRTCHNL_ETHER_ADDR_EXTRA;
 	}
 
-	args.ops = add ? VIRTCHNL_OP_ADD_ETH_ADDR : VIRTCHNL_OP_DEL_ETH_ADDR;
-	args.in_args = cmd_buffer;
-	args.in_args_size = sizeof(struct virtchnl_ether_addr_list) +
-		i * sizeof(struct virtchnl_ether_addr);
-	args.out_buffer = msg_buf;
-	args.out_size = IAVF_AQ_BUF_SZ;
-	err = iavf_execute_vf_cmd_safe(adapter, &args);
-
-	if (err) {
-		PMD_DRV_LOG(ERR, "fail to execute command %s",
-			add ? "OP_ADD_ETH_ADDR" : "OP_DEL_ETH_ADDR");
-		return err;
-	}
-
-	return 0;
+	return iavf_send_eth_addr_list(adapter, __func__, list, add);
 }
 
 int
-- 
2.54.0

