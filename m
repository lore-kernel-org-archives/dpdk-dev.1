Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 66E2C606A31C
	for <dpdk-dev@archiver.kernel.org>; Thu, 26 Nov 2026 07:35:34 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id C8DD74067D;
	Thu, 26 Nov 2026 08:34:50 +0100 (CET)
Received: from out28-101.mail.aliyun.com (out28-101.mail.aliyun.com
 [115.124.28.101])
 by mails.dpdk.org (Postfix) with ESMTPS id 53E414064A
 for <dev@dpdk.org>; Thu, 26 Nov 2026 08:34:45 +0100 (CET)
X-Alimail-AntiSpam: AC=CONTINUE; BC=0.06712908|-1; CH=green;
 DM=|CONTINUE|false|; DS=CONTINUE|ham_alarm|0.019182-0.00103854-0.979779;
 FP=16094174128984986556|0|0|0|0|-1|-1|-1;
 HT=maildocker-contentspam033045038069; MF=dimon.zhao@nebula-matrix.com; NM=1;
 PH=DS; RN=4; RT=4; SR=0; TI=SMTPD_---.kAe1YtK_1795678479; 
Received: from
 dimonzhao-1.NEBULA-MATRIX.COM(mailfrom:dimon.zhao@nebula-matrix.com
 fp:SMTPD_---.kAe1YtK_1795678479 cluster:ay29) by smtp.aliyun-inc.com;
 Thu, 26 Nov 2026 15:34:39 +0800
From: Dimon Zhao <dimon.zhao@nebula-matrix.com>
To: dimon.zhao@nebula-matrix.com,
	dev@dpdk.org
Cc: Leon Yu <leon.yu@nebula-matrix.com>, Sam Chen <sam.chen@nebula-matrix.com>
Subject: [PATCH v1 05/11] net/nbl: add draco dispatch layer
Date: Thu, 26 Nov 2026 15:34:22 +0800
Message-ID: <20261126073430.3168813-6-dimon.zhao@nebula-matrix.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261126073430.3168813-1-dimon.zhao@nebula-matrix.com>
References: <20261126073430.3168813-1-dimon.zhao@nebula-matrix.com>
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
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,
	UNWANTED_LANGUAGE_BODY,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Select the NET control level for coexisting draco PFs and VFs,
and the MGT control level for non-coexisting PFs.

Use mgt_pf as the destination for mailbox requests. Draco PFs
address their own kernel PF and VFs address their owning PF.
Keep the leonis destination at function ID zero.

Add device lifecycle placeholders and keep probing disabled at
device initialization until the device layer is implemented.

Signed-off-by: Dimon Zhao <dimon.zhao@nebula-matrix.com>
---
 drivers/net/nbl/nbl_dev/nbl_dev.c |  29 ++++++++
 drivers/net/nbl/nbl_dispatch.c    | 116 ++++++++++++++++++++----------
 drivers/net/nbl/nbl_dispatch.h    |   1 +
 3 files changed, 109 insertions(+), 37 deletions(-)

diff --git a/drivers/net/nbl/nbl_dev/nbl_dev.c b/drivers/net/nbl/nbl_dev/nbl_dev.c
index d28eea0..f5880f9 100644
--- a/drivers/net/nbl/nbl_dev/nbl_dev.c
+++ b/drivers/net/nbl/nbl_dev/nbl_dev.c
@@ -1326,6 +1326,29 @@ int nbl_dev_start(void *p)
 	return 0;
 }
 
+static int nbl_dev_draco_init(void *adapter)
+{
+	RTE_SET_USED(adapter);
+	/* Keep probing disabled until the Draco device layer is implemented. */
+	return -ENOTSUP;
+}
+
+static void nbl_dev_draco_uninit(void *adapter)
+{
+	RTE_SET_USED(adapter);
+}
+
+static int nbl_dev_draco_start(void *adapter)
+{
+	RTE_SET_USED(adapter);
+	return 0;
+}
+
+static void nbl_dev_draco_stop(void *adapter)
+{
+	RTE_SET_USED(adapter);
+}
+
 const struct nbl_product_dev_ops nbl_product_dev_ops[NBL_PRODUCT_MAX] = {
 	[NBL_LEONIS_TYPE] = {
 		.dev_init	= nbl_dev_leonis_init,
@@ -1333,6 +1356,12 @@ const struct nbl_product_dev_ops nbl_product_dev_ops[NBL_PRODUCT_MAX] = {
 		.dev_start	= nbl_dev_leonis_start,
 		.dev_stop	= nbl_dev_leonis_stop,
 	},
+	[NBL_DRACO_TYPE] = {
+		.dev_init	= nbl_dev_draco_init,
+		.dev_uninit	= nbl_dev_draco_uninit,
+		.dev_start	= nbl_dev_draco_start,
+		.dev_stop	= nbl_dev_draco_stop,
+	},
 };
 
 const struct nbl_product_dev_ops *nbl_dev_get_product_ops(enum nbl_product_type product_type)
diff --git a/drivers/net/nbl/nbl_dispatch.c b/drivers/net/nbl/nbl_dispatch.c
index b061f79..1bca326 100644
--- a/drivers/net/nbl/nbl_dispatch.c
+++ b/drivers/net/nbl/nbl_dispatch.c
@@ -29,7 +29,8 @@ static int nbl_disp_chan_configure_msix_map_req(void *priv, u16 num_net_msix, u1
 	param.num_others_msix = num_others_msix;
 	param.msix_mask_en = net_msix_mask_en;
 
-	NBL_CHAN_SEND(chan_send, 0, NBL_CHAN_MSG_CONFIGURE_MSIX_MAP,
+	NBL_CHAN_SEND(chan_send, NBL_DISP_MGT_GET_DST_ID(disp_mgt),
+		      NBL_CHAN_MSG_CONFIGURE_MSIX_MAP,
 		      &param, sizeof(param), NULL, 0, 1);
 	return chan_ops->send_msg(NBL_DISP_MGT_TO_CHAN_PRIV(disp_mgt), &chan_send);
 }
@@ -50,7 +51,8 @@ static int nbl_disp_chan_destroy_msix_map_req(void *priv)
 	const struct nbl_channel_ops *chan_ops = NBL_DISP_MGT_TO_CHAN_OPS(disp_mgt);
 	struct nbl_chan_send_info chan_send;
 
-	NBL_CHAN_SEND(chan_send, 0, NBL_CHAN_MSG_DESTROY_MSIX_MAP, NULL, 0, NULL, 0, 1);
+	NBL_CHAN_SEND(chan_send, NBL_DISP_MGT_GET_DST_ID(disp_mgt),
+		      NBL_CHAN_MSG_DESTROY_MSIX_MAP, NULL, 0, NULL, 0, 1);
 	return chan_ops->send_msg(NBL_DISP_MGT_TO_CHAN_PRIV(disp_mgt), &chan_send);
 }
 
@@ -75,7 +77,8 @@ static int nbl_disp_chan_enable_mailbox_irq_req(void *priv, u16 vector_id, bool
 	param.vector_id = vector_id;
 	param.enable_msix = enable_msix;
 
-	NBL_CHAN_SEND(chan_send, 0, NBL_CHAN_MSG_MAILBOX_ENABLE_IRQ,
+	NBL_CHAN_SEND(chan_send, NBL_DISP_MGT_GET_DST_ID(disp_mgt),
+		      NBL_CHAN_MSG_MAILBOX_ENABLE_IRQ,
 		      &param, sizeof(param), NULL, 0, 1);
 	return chan_ops->send_msg(NBL_DISP_MGT_TO_CHAN_PRIV(disp_mgt), &chan_send);
 }
@@ -101,7 +104,8 @@ static int nbl_disp_chan_alloc_txrx_queues_req(void *priv, u16 vsi_id,
 	param.vsi_id = vsi_id;
 	param.queue_num = queue_num;
 
-	NBL_CHAN_SEND(chan_send, 0, NBL_CHAN_MSG_ALLOC_TXRX_QUEUES, &param,
+	NBL_CHAN_SEND(chan_send, NBL_DISP_MGT_GET_DST_ID(disp_mgt),
+		      NBL_CHAN_MSG_ALLOC_TXRX_QUEUES, &param,
 		      sizeof(param), &result, sizeof(result), 1);
 	chan_ops->send_msg(NBL_DISP_MGT_TO_CHAN_PRIV(disp_mgt), &chan_send);
 
@@ -125,7 +129,8 @@ static void nbl_disp_chan_free_txrx_queues_req(void *priv, u16 vsi_id)
 
 	param.vsi_id = vsi_id;
 
-	NBL_CHAN_SEND(chan_send, 0, NBL_CHAN_MSG_FREE_TXRX_QUEUES, &param,
+	NBL_CHAN_SEND(chan_send, NBL_DISP_MGT_GET_DST_ID(disp_mgt),
+		      NBL_CHAN_MSG_FREE_TXRX_QUEUES, &param,
 		      sizeof(param), NULL, 0, 1);
 	chan_ops->send_msg(NBL_DISP_MGT_TO_CHAN_PRIV(disp_mgt), &chan_send);
 }
@@ -144,7 +149,8 @@ static void nbl_disp_chan_clear_queues_req(void *priv, u16 vsi_id)
 	const struct nbl_channel_ops *chan_ops = NBL_DISP_MGT_TO_CHAN_OPS(disp_mgt);
 	struct nbl_chan_send_info chan_send = {0};
 
-	NBL_CHAN_SEND(chan_send, 0, NBL_CHAN_MSG_CLEAR_QUEUE, &vsi_id, sizeof(vsi_id),
+	NBL_CHAN_SEND(chan_send, NBL_DISP_MGT_GET_DST_ID(disp_mgt),
+		      NBL_CHAN_MSG_CLEAR_QUEUE, &vsi_id, sizeof(vsi_id),
 		      NULL, 0, 1);
 	chan_ops->send_msg(NBL_DISP_MGT_TO_CHAN_PRIV(disp_mgt), &chan_send);
 }
@@ -262,7 +268,8 @@ nbl_disp_chan_setup_queue_req(void *priv,
 	memcpy(&param.queue_param, queue_param, sizeof(param.queue_param));
 	param.is_tx = is_tx;
 
-	NBL_CHAN_SEND(chan_send, 0, NBL_CHAN_MSG_SETUP_QUEUE, &param,
+	NBL_CHAN_SEND(chan_send, NBL_DISP_MGT_GET_DST_ID(disp_mgt),
+		      NBL_CHAN_MSG_SETUP_QUEUE, &param,
 		      sizeof(param), NULL, 0, 1);
 	return chan_ops->send_msg(NBL_DISP_MGT_TO_CHAN_PRIV(disp_mgt), &chan_send);
 }
@@ -284,7 +291,8 @@ static void nbl_disp_chan_remove_all_queues_req(void *priv, u16 vsi_id)
 
 	param.vsi_id = vsi_id;
 
-	NBL_CHAN_SEND(chan_send, 0, NBL_CHAN_MSG_REMOVE_ALL_QUEUES,
+	NBL_CHAN_SEND(chan_send, NBL_DISP_MGT_GET_DST_ID(disp_mgt),
+		      NBL_CHAN_MSG_REMOVE_ALL_QUEUES,
 		      &param, sizeof(param), NULL, 0, 1);
 	chan_ops->send_msg(NBL_DISP_MGT_TO_CHAN_PRIV(disp_mgt), &chan_send);
 }
@@ -345,7 +353,8 @@ static int nbl_disp_chan_register_net_req(void *priv,
 	param.offset = register_param->offset;
 	param.stride = register_param->stride;
 
-	NBL_CHAN_SEND(chan_send, 0, NBL_CHAN_MSG_REGISTER_NET,
+	NBL_CHAN_SEND(chan_send, NBL_DISP_MGT_GET_DST_ID(disp_mgt),
+		      NBL_CHAN_MSG_REGISTER_NET,
 		      &param, sizeof(param),
 		      (void *)register_result, sizeof(*register_result), 1);
 
@@ -367,7 +376,8 @@ static int nbl_disp_chan_unregister_net_req(void *priv)
 	const struct nbl_channel_ops *chan_ops = NBL_DISP_MGT_TO_CHAN_OPS(disp_mgt);
 	struct nbl_chan_send_info chan_send;
 
-	NBL_CHAN_SEND(chan_send, 0, NBL_CHAN_MSG_UNREGISTER_NET, NULL,
+	NBL_CHAN_SEND(chan_send, NBL_DISP_MGT_GET_DST_ID(disp_mgt),
+		      NBL_CHAN_MSG_UNREGISTER_NET, NULL,
 		      0, NULL, 0, 1);
 
 	return chan_ops->send_msg(NBL_DISP_MGT_TO_CHAN_PRIV(disp_mgt),
@@ -390,7 +400,8 @@ static u16 nbl_disp_chan_get_vsi_id_req(void *priv)
 	struct nbl_chan_param_get_vsi_id result = {0};
 	struct nbl_chan_send_info chan_send;
 
-	NBL_CHAN_SEND(chan_send, 0, NBL_CHAN_MSG_GET_VSI_ID, &param,
+	NBL_CHAN_SEND(chan_send, NBL_DISP_MGT_GET_DST_ID(disp_mgt),
+		      NBL_CHAN_MSG_GET_VSI_ID, &param,
 		      sizeof(param), &result, sizeof(result), 1);
 	chan_ops->send_msg(NBL_DISP_MGT_TO_CHAN_PRIV(disp_mgt), &chan_send);
 
@@ -416,7 +427,8 @@ static void nbl_disp_chan_get_eth_id_req(void *priv, u16 vsi_id, u8 *eth_mode, u
 
 	param.vsi_id = vsi_id;
 
-	NBL_CHAN_SEND(chan_send, 0, NBL_CHAN_MSG_GET_ETH_ID,  &param, sizeof(param),
+	NBL_CHAN_SEND(chan_send, NBL_DISP_MGT_GET_DST_ID(disp_mgt),
+		      NBL_CHAN_MSG_GET_ETH_ID,  &param, sizeof(param),
 		      &result, sizeof(result), 1);
 	chan_ops->send_msg(NBL_DISP_MGT_TO_CHAN_PRIV(disp_mgt), &chan_send);
 
@@ -444,7 +456,8 @@ nbl_disp_chan_get_vsi_global_qid_req(void *priv, u16 vsi_id, u16 local_qid)
 	param.vsi_id = vsi_id;
 	param.local_qid = local_qid;
 
-	NBL_CHAN_SEND(chan_send, 0, NBL_CHAN_MSG_GET_VSI_GLOBAL_QUEUE_ID,
+	NBL_CHAN_SEND(chan_send, NBL_DISP_MGT_GET_DST_ID(disp_mgt),
+		      NBL_CHAN_MSG_GET_VSI_GLOBAL_QUEUE_ID,
 		      &param, sizeof(param), NULL, 0, 1);
 	return chan_ops->send_msg(NBL_DISP_MGT_TO_CHAN_PRIV(disp_mgt), &chan_send);
 }
@@ -467,7 +480,8 @@ static int nbl_disp_chan_setup_q2vsi_req(void *priv, u16 vsi_id)
 
 	param.vsi_id = vsi_id;
 
-	NBL_CHAN_SEND(chan_send, 0, NBL_CHAN_MSG_SETUP_Q2VSI, &param,
+	NBL_CHAN_SEND(chan_send, NBL_DISP_MGT_GET_DST_ID(disp_mgt),
+		      NBL_CHAN_MSG_SETUP_Q2VSI, &param,
 		      sizeof(param), NULL, 0, 1);
 	return chan_ops->send_msg(NBL_DISP_MGT_TO_CHAN_PRIV(disp_mgt), &chan_send);
 }
@@ -490,7 +504,8 @@ static void nbl_disp_chan_remove_q2vsi_req(void *priv, u16 vsi_id)
 
 	param.vsi_id = vsi_id;
 
-	NBL_CHAN_SEND(chan_send, 0, NBL_CHAN_MSG_REMOVE_Q2VSI, &param,
+	NBL_CHAN_SEND(chan_send, NBL_DISP_MGT_GET_DST_ID(disp_mgt),
+		      NBL_CHAN_MSG_REMOVE_Q2VSI, &param,
 		      sizeof(param), NULL, 0, 1);
 	chan_ops->send_msg(NBL_DISP_MGT_TO_CHAN_PRIV(disp_mgt), &chan_send);
 }
@@ -519,7 +534,8 @@ static int nbl_disp_chan_register_vsi2q_req(void *priv, u16 vsi_index, u16 vsi_i
 	param.queue_offset = queue_offset;
 	param.queue_num = queue_num;
 
-	NBL_CHAN_SEND(chan_send, 0, NBL_CHAN_MSG_REGISTER_VSI2Q, &param, sizeof(param),
+	NBL_CHAN_SEND(chan_send, NBL_DISP_MGT_GET_DST_ID(disp_mgt),
+		      NBL_CHAN_MSG_REGISTER_VSI2Q, &param, sizeof(param),
 		      NULL, 0, 1);
 
 	return chan_ops->send_msg(NBL_DISP_MGT_TO_CHAN_PRIV(disp_mgt), &chan_send);
@@ -543,7 +559,8 @@ static int nbl_disp_chan_setup_rss_req(void *priv, u16 vsi_id)
 
 	param.vsi_id = vsi_id;
 
-	NBL_CHAN_SEND(chan_send, 0, NBL_CHAN_MSG_SETUP_RSS, &param,
+	NBL_CHAN_SEND(chan_send, NBL_DISP_MGT_GET_DST_ID(disp_mgt),
+		      NBL_CHAN_MSG_SETUP_RSS, &param,
 		      sizeof(param), NULL, 0, 1);
 	return chan_ops->send_msg(NBL_DISP_MGT_TO_CHAN_PRIV(disp_mgt), &chan_send);
 }
@@ -566,7 +583,8 @@ static void nbl_disp_chan_remove_rss_req(void *priv, u16 vsi_id)
 
 	param.vsi_id = vsi_id;
 
-	NBL_CHAN_SEND(chan_send, 0, NBL_CHAN_MSG_REMOVE_RSS, &param,
+	NBL_CHAN_SEND(chan_send, NBL_DISP_MGT_GET_DST_ID(disp_mgt),
+		      NBL_CHAN_MSG_REMOVE_RSS, &param,
 		      sizeof(param), NULL, 0, 1);
 	chan_ops->send_msg(NBL_DISP_MGT_TO_CHAN_PRIV(disp_mgt), &chan_send);
 }
@@ -583,7 +601,8 @@ static void nbl_disp_chan_get_board_info_req(void *priv, struct nbl_board_port_i
 	const struct nbl_channel_ops *chan_ops = NBL_DISP_MGT_TO_CHAN_OPS(disp_mgt);
 	struct nbl_chan_send_info chan_send;
 
-	NBL_CHAN_SEND(chan_send, 0, NBL_CHAN_MSG_GET_BOARD_INFO, NULL,
+	NBL_CHAN_SEND(chan_send, NBL_DISP_MGT_GET_DST_ID(disp_mgt),
+		      NBL_CHAN_MSG_GET_BOARD_INFO, NULL,
 		      0, board_info, sizeof(*board_info), 1);
 	chan_ops->send_msg(NBL_DISP_MGT_TO_CHAN_PRIV(disp_mgt), &chan_send);
 }
@@ -602,7 +621,8 @@ static void nbl_disp_chan_clear_flow_req(void *priv, u16 vsi_id)
 	const struct nbl_channel_ops *chan_ops = NBL_DISP_MGT_TO_CHAN_OPS(disp_mgt);
 	struct nbl_chan_send_info chan_send = {0};
 
-	NBL_CHAN_SEND(chan_send, 0, NBL_CHAN_MSG_CLEAR_FLOW, &vsi_id, sizeof(vsi_id), NULL, 0, 1);
+	NBL_CHAN_SEND(chan_send, NBL_DISP_MGT_GET_DST_ID(disp_mgt),
+		      NBL_CHAN_MSG_CLEAR_FLOW, &vsi_id, sizeof(vsi_id), NULL, 0, 1);
 	chan_ops->send_msg(NBL_DISP_MGT_TO_CHAN_PRIV(disp_mgt), &chan_send);
 }
 
@@ -627,7 +647,8 @@ nbl_disp_chan_add_macvlan_req(void *priv, u8 *mac, u16 vlan_id, u16 vsi_id)
 	param.vlan = vlan_id;
 	param.vsi = vsi_id;
 
-	NBL_CHAN_SEND(chan_send, 0, NBL_CHAN_MSG_ADD_MACVLAN, &param, sizeof(param), NULL, 0, 1);
+	NBL_CHAN_SEND(chan_send, NBL_DISP_MGT_GET_DST_ID(disp_mgt),
+		      NBL_CHAN_MSG_ADD_MACVLAN, &param, sizeof(param), NULL, 0, 1);
 	return chan_ops->send_msg(NBL_DISP_MGT_TO_CHAN_PRIV(disp_mgt), &chan_send);
 }
 
@@ -652,7 +673,8 @@ nbl_disp_chan_del_macvlan_req(void *priv, u8 *mac, u16 vlan_id, u16 vsi_id)
 	param.vlan = vlan_id;
 	param.vsi = vsi_id;
 
-	NBL_CHAN_SEND(chan_send, 0, NBL_CHAN_MSG_DEL_MACVLAN, &param, sizeof(param), NULL, 0, 1);
+	NBL_CHAN_SEND(chan_send, NBL_DISP_MGT_GET_DST_ID(disp_mgt),
+		      NBL_CHAN_MSG_DEL_MACVLAN, &param, sizeof(param), NULL, 0, 1);
 	chan_ops->send_msg(NBL_DISP_MGT_TO_CHAN_PRIV(disp_mgt), &chan_send);
 }
 
@@ -673,7 +695,8 @@ static int nbl_disp_chan_add_multi_rule_req(void *priv, u16 vsi_id)
 
 	param.vsi = vsi_id;
 
-	NBL_CHAN_SEND(chan_send, 0, NBL_CHAN_MSG_ADD_MULTI_RULE, &param, sizeof(param), NULL, 0, 1);
+	NBL_CHAN_SEND(chan_send, NBL_DISP_MGT_GET_DST_ID(disp_mgt),
+		      NBL_CHAN_MSG_ADD_MULTI_RULE, &param, sizeof(param), NULL, 0, 1);
 	return chan_ops->send_msg(NBL_DISP_MGT_TO_CHAN_PRIV(disp_mgt), &chan_send);
 }
 
@@ -694,7 +717,8 @@ static void nbl_disp_chan_del_multi_rule_req(void *priv, u16 vsi)
 
 	param.vsi = vsi;
 
-	NBL_CHAN_SEND(chan_send, 0, NBL_CHAN_MSG_DEL_MULTI_RULE, &param, sizeof(param), NULL, 0, 1);
+	NBL_CHAN_SEND(chan_send, NBL_DISP_MGT_GET_DST_ID(disp_mgt),
+		      NBL_CHAN_MSG_DEL_MULTI_RULE, &param, sizeof(param), NULL, 0, 1);
 	chan_ops->send_msg(NBL_DISP_MGT_TO_CHAN_PRIV(disp_mgt), &chan_send);
 }
 
@@ -734,7 +758,8 @@ static int nbl_disp_chan_cfg_multi_mcast_req(void *priv, u16 vsi, u16 enable)
 
 	param.vsi = vsi;
 	param.enable = enable;
-	NBL_CHAN_SEND(chan_send, 0, NBL_CHAN_MSG_CFG_MULTI_MCAST_RULE,
+	NBL_CHAN_SEND(chan_send, NBL_DISP_MGT_GET_DST_ID(disp_mgt),
+		      NBL_CHAN_MSG_CFG_MULTI_MCAST_RULE,
 		      &param, sizeof(param), NULL, 0, 1);
 	return chan_ops->send_msg(NBL_DISP_MGT_TO_CHAN_PRIV(disp_mgt), &chan_send);
 }
@@ -757,7 +782,8 @@ static int nbl_disp_chan_cfg_dsch_req(void *priv, u16 vsi_id, bool vld)
 	param.vsi_id = vsi_id;
 	param.vld = vld;
 
-	NBL_CHAN_SEND(chan_send, 0, NBL_CHAN_MSG_CFG_DSCH, &param, sizeof(param), NULL, 0, 1);
+	NBL_CHAN_SEND(chan_send, NBL_DISP_MGT_GET_DST_ID(disp_mgt),
+		      NBL_CHAN_MSG_CFG_DSCH, &param, sizeof(param), NULL, 0, 1);
 	return chan_ops->send_msg(NBL_DISP_MGT_TO_CHAN_PRIV(disp_mgt), &chan_send);
 }
 
@@ -781,7 +807,8 @@ static int nbl_disp_chan_setup_cqs_req(void *priv, u16 vsi_id, u16 real_qps, boo
 	param.real_qps = real_qps;
 	param.rss_indir_set = rss_indir_set;
 
-	NBL_CHAN_SEND(chan_send, 0, NBL_CHAN_MSG_SETUP_CQS, &param, sizeof(param), NULL, 0, 1);
+	NBL_CHAN_SEND(chan_send, NBL_DISP_MGT_GET_DST_ID(disp_mgt),
+		      NBL_CHAN_MSG_SETUP_CQS, &param, sizeof(param), NULL, 0, 1);
 	return chan_ops->send_msg(NBL_DISP_MGT_TO_CHAN_PRIV(disp_mgt), &chan_send);
 }
 
@@ -802,7 +829,8 @@ static void nbl_disp_chan_remove_cqs_req(void *priv, u16 vsi_id)
 
 	param.vsi_id = vsi_id;
 
-	NBL_CHAN_SEND(chan_send, 0, NBL_CHAN_MSG_REMOVE_CQS, &param, sizeof(param), NULL, 0, 1);
+	NBL_CHAN_SEND(chan_send, NBL_DISP_MGT_GET_DST_ID(disp_mgt),
+		      NBL_CHAN_MSG_REMOVE_CQS, &param, sizeof(param), NULL, 0, 1);
 	chan_ops->send_msg(NBL_DISP_MGT_TO_CHAN_PRIV(disp_mgt), &chan_send);
 }
 
@@ -843,7 +871,8 @@ static void nbl_disp_chan_get_link_state_req(void *priv, u8 eth_id,
 
 	param.eth_id = eth_id;
 
-	NBL_CHAN_SEND(chan_send, 0, NBL_CHAN_MSG_GET_LINK_STATE, &param, sizeof(param),
+	NBL_CHAN_SEND(chan_send, NBL_DISP_MGT_GET_DST_ID(disp_mgt),
+		      NBL_CHAN_MSG_GET_LINK_STATE, &param, sizeof(param),
 		      eth_link_info, sizeof(*eth_link_info), 1);
 	chan_ops->send_msg(NBL_DISP_MGT_TO_CHAN_PRIV(disp_mgt), &chan_send);
 }
@@ -881,7 +910,8 @@ static int nbl_disp_chan_get_uvn_pkt_drop_stats_req(void *priv, u16 vsi_id,
 	param.vsi_id = vsi_id;
 	param.num_queues = num_queues;
 
-	NBL_CHAN_SEND(chan_send, 0, NBL_CHAN_GET_UVN_PKT_DROP_STATS,
+	NBL_CHAN_SEND(chan_send, NBL_DISP_MGT_GET_DST_ID(disp_mgt),
+		      NBL_CHAN_GET_UVN_PKT_DROP_STATS,
 		      &param, sizeof(param),
 		      uvn_stat_pkt_drop, num_queues * sizeof(*uvn_stat_pkt_drop), 1);
 	return chan_ops->send_msg(NBL_DISP_MGT_TO_CHAN_PRIV(disp_mgt), &chan_send);
@@ -906,7 +936,8 @@ static int nbl_disp_chan_get_ustore_total_pkt_drop_stats_req(void *priv, u8 eth_
 	const struct nbl_channel_ops *chan_ops = NBL_DISP_MGT_TO_CHAN_OPS(disp_mgt);
 	struct nbl_chan_send_info chan_send = {0};
 
-	NBL_CHAN_SEND(chan_send, 0, NBL_CHAN_GET_USTORE_TOTAL_PKT_DROP_STATS,
+	NBL_CHAN_SEND(chan_send, NBL_DISP_MGT_GET_DST_ID(disp_mgt),
+		      NBL_CHAN_GET_USTORE_TOTAL_PKT_DROP_STATS,
 		      &eth_id, sizeof(eth_id), ustore_stats, sizeof(*ustore_stats), 1);
 	return chan_ops->send_msg(NBL_DISP_MGT_TO_CHAN_PRIV(disp_mgt), &chan_send);
 }
@@ -990,7 +1021,8 @@ static void nbl_disp_get_private_stat_data_req(void *priv, u32 eth_id, u64 *data
 
 	param.eth_id = eth_id;
 	param.data_len = data_len;
-	NBL_CHAN_SEND(chan_send, 0, NBL_CHAN_MSG_GET_ETH_STATS, &param,
+	NBL_CHAN_SEND(chan_send, NBL_DISP_MGT_GET_DST_ID(disp_mgt),
+		      NBL_CHAN_MSG_GET_ETH_STATS, &param,
 		      sizeof(param), data, data_len, 1);
 	chan_ops->send_msg(NBL_DISP_MGT_TO_CHAN_PRIV(disp_mgt), &chan_send);
 }
@@ -1016,7 +1048,8 @@ static int nbl_disp_chan_set_mtu_req(void *priv, u16 vsi_id, u16 mtu)
 	param.mtu = mtu;
 	param.vsi_id = vsi_id;
 
-	NBL_CHAN_SEND(chan_send, 0, NBL_CHAN_MSG_MTU_SET,
+	NBL_CHAN_SEND(chan_send, NBL_DISP_MGT_GET_DST_ID(disp_mgt),
+		      NBL_CHAN_MSG_MTU_SET,
 		      &param, sizeof(param), NULL, 0, 1);
 	return chan_ops->send_msg(NBL_DISP_MGT_TO_CHAN_PRIV(disp_mgt),
 				  &chan_send);
@@ -1056,7 +1089,8 @@ static int nbl_disp_chan_set_promisc_mode_req(void *priv, u16 vsi_id, u16 mode)
 
 	param.vsi_id = vsi_id;
 	param.mode = mode;
-	NBL_CHAN_SEND(chan_send, 0, NBL_CHAN_MSG_SET_PROSISC_MODE,
+	NBL_CHAN_SEND(chan_send, NBL_DISP_MGT_GET_DST_ID(disp_mgt),
+		      NBL_CHAN_MSG_SET_PROSISC_MODE,
 		      &param, sizeof(param), NULL, 0, 1);
 	return chan_ops->send_msg(NBL_DISP_MGT_TO_CHAN_PRIV(disp_mgt),
 				  &chan_send);
@@ -1431,9 +1465,17 @@ static int nbl_disp_leonis_uninit(void *p)
 
 static int nbl_disp_draco_init(void *p)
 {
-	RTE_SET_USED(p);
-	/* Keep probing disabled until the Draco dispatch layer is implemented. */
-	return -ENOTSUP;
+	struct nbl_dispatch_mgt *disp_mgt = (struct nbl_dispatch_mgt *)p;
+	struct nbl_common_info *common = disp_mgt->common;
+	int ret;
+
+	if (common->devfd == -1 && !common->is_vf)
+		nbl_disp_setup_ctrl_lvl(disp_mgt, NBL_DISP_CTRL_LVL_MGT);
+	else
+		nbl_disp_setup_ctrl_lvl(disp_mgt, NBL_DISP_CTRL_LVL_NET);
+	ret = nbl_disp_setup_msg(disp_mgt);
+
+	return ret;
 }
 
 static int nbl_disp_draco_uninit(void *p)
diff --git a/drivers/net/nbl/nbl_dispatch.h b/drivers/net/nbl/nbl_dispatch.h
index d157276..f1675dd 100644
--- a/drivers/net/nbl/nbl_dispatch.h
+++ b/drivers/net/nbl/nbl_dispatch.h
@@ -17,6 +17,7 @@
 #define NBL_DISP_MGT_TO_DISP_OPS(disp_mgt)	(NBL_DISP_MGT_TO_DISP_OPS_TBL(disp_mgt)->ops)
 #define NBL_DISP_MGT_TO_DISP_PRIV(disp_mgt)	(NBL_DISP_MGT_TO_DISP_OPS_TBL(disp_mgt)->priv)
 #define NBL_DISP_MGT_TO_COMMON(disp_mgt)	((disp_mgt)->common)
+#define NBL_DISP_MGT_GET_DST_ID(disp_mgt)	((disp_mgt)->common->mgt_pf)
 
 struct nbl_dispatch_mgt {
 	struct nbl_resource_ops_tbl *res_ops_tbl;
-- 
2.53.0

