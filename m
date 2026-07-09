Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4840BC44508
	for <dpdk-dev@archiver.kernel.org>; Thu,  9 Jul 2026 16:03:27 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 3E37D40BA0;
	Thu,  9 Jul 2026 18:03:18 +0200 (CEST)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by mails.dpdk.org (Postfix) with ESMTP id 2DBA440B9A
 for <dev@dpdk.org>; Thu,  9 Jul 2026 18:03:16 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1783612995;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Y/alMnPOY/wErXXtnHi4k3iQV1h4vZ9W62lBQNzUjPE=;
 b=EavMQsWt0fjcgCvqhelR9Y0wEBsZsTynQQHzyxDHNQOLJkvS+wfGLmcj++axt9UcovbeG/
 ywTUwXX5TG4+cx6uAzGLMWXdFadmQk7T/95DNZ9WUbpBXzwdnqh3HdEewgkg5Lzn9yUX7A
 ynIQdFFD2aRwZ1W3HD/HOf8anuBmayg=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-439-V6S0HBZYPfCR-2xqSX6mNQ-1; Thu,
 09 Jul 2026 12:03:14 -0400
X-MC-Unique: V6S0HBZYPfCR-2xqSX6mNQ-1
X-Mimecast-MFC-AGG-ID: V6S0HBZYPfCR-2xqSX6mNQ_1783612993
Received: from mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.95])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 3899F19560A2; Thu,  9 Jul 2026 16:03:13 +0000 (UTC)
Received: from dmarchan.lan (unknown [10.44.48.202])
 by mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id B2024D6E; Thu,  9 Jul 2026 16:03:11 +0000 (UTC)
From: David Marchand <david.marchand@redhat.com>
To: dev@dpdk.org
Cc: rjarry@redhat.com, cfontain@redhat.com,
 Vladimir Medvedkin <vladimir.medvedkin@intel.com>
Subject: [PATCH v4 04/10] net/iavf: accept up to 32k unicast MAC addresses
Date: Thu,  9 Jul 2026 18:02:40 +0200
Message-ID: <20260709160247.1798575-5-david.marchand@redhat.com>
In-Reply-To: <20260709160247.1798575-1-david.marchand@redhat.com>
References: <20260403091836.1073484-1-david.marchand@redhat.com>
 <20260709160247.1798575-1-david.marchand@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.6 on 10.30.177.95
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: jO9XVnga0E6WynPndDoHos_4itqhTOiQXXx37TGzGho_1783612993
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

E810 hardware provides 32k switch lookups.
Thanks to this, it is possible to allow a lot more secondary mac
addresses than what is possible today.

In practice, the maximum number of macs available per port may be lower
and depends on usage by other (trusted?) VFs on the same PF.
There is no way to figure out this limit but to try adding a mac address
and get an error from the PF driver.

Mailbox exchanges are limited to IAVF_AQ_BUF_SZ, segment messages
accordingly.

Signed-off-by: David Marchand <david.marchand@redhat.com>
---
Changes since v2:
- added an entry in release notes,
- removed unneeded temp variable,

Changes since v1:
- fixed buffer overflow on mailbox messages during port restart/VF reset,

---
 doc/guides/rel_notes/release_26_07.rst |   5 ++
 drivers/net/intel/iavf/iavf.h          |   5 +-
 drivers/net/intel/iavf/iavf_ethdev.c   |  12 +--
 drivers/net/intel/iavf/iavf_vchnl.c    | 113 ++++++++++++++++++-------
 4 files changed, 95 insertions(+), 40 deletions(-)

diff --git a/doc/guides/rel_notes/release_26_07.rst b/doc/guides/rel_notes/release_26_07.rst
index 6b6fbe0b1a..4225bd43a0 100644
--- a/doc/guides/rel_notes/release_26_07.rst
+++ b/doc/guides/rel_notes/release_26_07.rst
@@ -259,6 +259,11 @@ New Features
   Added AGENTS.md file for AI review
   and supporting scripts to review patches and documentation.
 
+* **Updated IAVF ethernet driver.**
+
+  * Increased the maximum number of secondary unicast MAC addresses from 64 to 32k.
+    This increases a VF port memory footprint by ~192kB.
+
 
 Removed Items
 -------------
diff --git a/drivers/net/intel/iavf/iavf.h b/drivers/net/intel/iavf/iavf.h
index 293adaf6c9..47cd1d6311 100644
--- a/drivers/net/intel/iavf/iavf.h
+++ b/drivers/net/intel/iavf/iavf.h
@@ -31,7 +31,8 @@
 #define IAVF_IRQ_MAP_NUM_PER_BUF	 128
 #define IAVF_RXTX_QUEUE_CHUNKS_NUM	 2
 
-#define IAVF_NUM_MACADDR_MAX      64
+#define IAVF_UC_MACADDR_MAX      32768
+#define IAVF_MC_MACADDR_MAX      64
 
 #define IAVF_DEV_WATCHDOG_PERIOD     2000 /* microseconds, set 0 to disable*/
 
@@ -255,7 +256,7 @@ struct iavf_info {
 	uint32_t link_speed;
 
 	/* Multicast addrs */
-	struct rte_ether_addr mc_addrs[IAVF_NUM_MACADDR_MAX];
+	struct rte_ether_addr mc_addrs[IAVF_MC_MACADDR_MAX];
 	uint16_t mc_addrs_num;   /* Multicast mac addresses number */
 
 	struct iavf_vsi vsi;
diff --git a/drivers/net/intel/iavf/iavf_ethdev.c b/drivers/net/intel/iavf/iavf_ethdev.c
index 80e740ef29..179d90ec55 100644
--- a/drivers/net/intel/iavf/iavf_ethdev.c
+++ b/drivers/net/intel/iavf/iavf_ethdev.c
@@ -394,10 +394,10 @@ iavf_set_mc_addr_list(struct rte_eth_dev *dev,
 		IAVF_DEV_PRIVATE_TO_ADAPTER(dev->data->dev_private);
 	int err, ret;
 
-	if (mc_addrs_num > IAVF_NUM_MACADDR_MAX) {
+	if (mc_addrs_num > IAVF_MC_MACADDR_MAX) {
 		PMD_DRV_LOG(ERR,
 			    "can't add more than a limited number (%u) of addresses.",
-			    (uint32_t)IAVF_NUM_MACADDR_MAX);
+			    (uint32_t)IAVF_MC_MACADDR_MAX);
 		return -EINVAL;
 	}
 
@@ -1159,7 +1159,7 @@ iavf_dev_info_get(struct rte_eth_dev *dev, struct rte_eth_dev_info *dev_info)
 	dev_info->hash_key_size = vf->vf_res->rss_key_size;
 	dev_info->reta_size = vf->vf_res->rss_lut_size;
 	dev_info->flow_type_rss_offloads = IAVF_RSS_OFFLOAD_ALL;
-	dev_info->max_mac_addrs = IAVF_NUM_MACADDR_MAX;
+	dev_info->max_mac_addrs = IAVF_UC_MACADDR_MAX;
 	dev_info->dev_capa =
 		RTE_ETH_DEV_CAPA_RUNTIME_RX_QUEUE_SETUP |
 		RTE_ETH_DEV_CAPA_RUNTIME_TX_QUEUE_SETUP;
@@ -3051,12 +3051,12 @@ iavf_dev_init(struct rte_eth_dev *eth_dev)
 	iavf_set_default_ptype_table(eth_dev);
 
 	/* copy mac addr */
-	eth_dev->data->mac_addrs = rte_zmalloc(
-		"iavf_mac", RTE_ETHER_ADDR_LEN * IAVF_NUM_MACADDR_MAX, 0);
+	eth_dev->data->mac_addrs = rte_calloc("iavf_mac", IAVF_UC_MACADDR_MAX,
+		RTE_ETHER_ADDR_LEN, 0);
 	if (!eth_dev->data->mac_addrs) {
 		PMD_INIT_LOG(ERR, "Failed to allocate %d bytes needed to"
 			     " store MAC addresses",
-			     RTE_ETHER_ADDR_LEN * IAVF_NUM_MACADDR_MAX);
+			     RTE_ETHER_ADDR_LEN * IAVF_UC_MACADDR_MAX);
 		ret = -ENOMEM;
 		goto init_vf_err;
 	}
diff --git a/drivers/net/intel/iavf/iavf_vchnl.c b/drivers/net/intel/iavf/iavf_vchnl.c
index cd6e8325fc..6743183bf9 100644
--- a/drivers/net/intel/iavf/iavf_vchnl.c
+++ b/drivers/net/intel/iavf/iavf_vchnl.c
@@ -1648,49 +1648,98 @@ iavf_config_irq_map_lv(struct iavf_adapter *adapter, uint16_t num)
 	return 0;
 }
 
-void
-iavf_add_del_all_mac_addr(struct iavf_adapter *adapter, bool add)
+static int
+iavf_add_del_uc_addr_bulk(struct iavf_adapter *adapter, struct rte_ether_addr *addrs,
+			  uint32_t nb_addrs, bool add)
 {
+#define IAVF_ETH_ADDR_PER_REQ \
+	((IAVF_AQ_BUF_SZ - sizeof(struct virtchnl_ether_addr_list)) / \
+	 sizeof(struct virtchnl_ether_addr))
 	struct {
 		struct virtchnl_ether_addr_list list;
-		struct virtchnl_ether_addr addr[IAVF_NUM_MACADDR_MAX];
-	} list_req = {0};
-	struct virtchnl_ether_addr_list *list = &list_req.list;
+		struct virtchnl_ether_addr addr[IAVF_ETH_ADDR_PER_REQ];
+	} cmd_buffer;
+#undef IAVF_ETH_ADDR_PER_REQ
+	struct virtchnl_ether_addr_list *list = &cmd_buffer.list;
 	struct iavf_info *vf = IAVF_DEV_PRIVATE_TO_VF(adapter);
 	uint8_t msg_buf[IAVF_AQ_BUF_SZ] = {0};
-	struct iavf_cmd_info args = {0};
-	int err, i;
-	size_t buf_len;
 
-	for (i = 0; i < IAVF_NUM_MACADDR_MAX; i++) {
-		struct rte_ether_addr *addr = &adapter->dev_data->mac_addrs[i];
-		struct virtchnl_ether_addr *vc_addr = &list->list[list->num_elements];
+	for (uint32_t i = 0; i < nb_addrs; i++) {
+		struct iavf_cmd_info args;
+		uint32_t batch;
+		int err;
 
-		/* ignore empty addresses */
-		if (rte_is_zero_ether_addr(addr))
-			continue;
+		batch = i % RTE_DIM(cmd_buffer.addr);
+
+		if (batch == 0) {
+			memset(&cmd_buffer, 0, sizeof(cmd_buffer));
+			list->vsi_id = vf->vsi_res->vsi_id;
+			list->num_elements = 0;
+		}
+
+		rte_memcpy(list->list[batch].addr, addrs[i].addr_bytes,
+			   sizeof(list->list[batch].addr));
+		list->list[batch].type = VIRTCHNL_ETHER_ADDR_EXTRA;
 		list->num_elements++;
 
-		memcpy(vc_addr->addr, addr->addr_bytes, sizeof(addr->addr_bytes));
-		vc_addr->type = (list->num_elements == 1) ?
-				VIRTCHNL_ETHER_ADDR_PRIMARY :
-				VIRTCHNL_ETHER_ADDR_EXTRA;
+		if (batch != RTE_DIM(cmd_buffer.addr) - 1 && i != nb_addrs - 1)
+			continue;
+
+		memset(&args, 0, sizeof(args));
+		args.ops = add ? VIRTCHNL_OP_ADD_ETH_ADDR : VIRTCHNL_OP_DEL_ETH_ADDR;
+		args.in_args = (uint8_t *)list;
+		args.in_args_size = sizeof(struct virtchnl_ether_addr_list) +
+			sizeof(struct virtchnl_ether_addr) * list->num_elements;
+		args.out_buffer = msg_buf;
+		args.out_size = IAVF_AQ_BUF_SZ;
+		err = iavf_execute_vf_cmd_safe(adapter, &args);
+		if (err != 0) {
+			PMD_DRV_LOG(ERR, "fail to execute command %s for %u macs",
+				add ? "VIRTCHNL_OP_ADD_ETH_ADDR" : "VIRTCHNL_OP_DEL_ETH_ADDR",
+				list->num_elements);
+			return err;
+		}
+
+		PMD_DRV_LOG(DEBUG, "executed command %s for %u macs",
+			add ? "VIRTCHNL_OP_ADD_ETH_ADDR" : "VIRTCHNL_OP_DEL_ETH_ADDR",
+			list->num_elements);
 	}
 
-	/* for some reason PF side checks for buffer being too big, so adjust it down */
-	buf_len = sizeof(struct virtchnl_ether_addr_list) +
-		  sizeof(struct virtchnl_ether_addr) * list->num_elements;
+	return 0;
+}
 
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
+void
+iavf_add_del_all_mac_addr(struct iavf_adapter *adapter, bool add)
+{
+	int start = -1;
+	int i;
+
+	/* Handle primary address (index 0) separately */
+	if (!rte_is_zero_ether_addr(&adapter->dev_data->mac_addrs[0]))
+		iavf_add_del_eth_addr(adapter, &adapter->dev_data->mac_addrs[0], add,
+			VIRTCHNL_ETHER_ADDR_PRIMARY);
+
+	/* Process secondary addresses in contiguous blocks */
+	for (i = 1; i < IAVF_UC_MACADDR_MAX; i++) {
+		struct rte_ether_addr *addr = &adapter->dev_data->mac_addrs[i];
+
+		if (!rte_is_zero_ether_addr(addr)) {
+			if (start == -1)
+				start = i;
+			continue;
+		}
+
+		if (start != -1) {
+			iavf_add_del_uc_addr_bulk(adapter, &adapter->dev_data->mac_addrs[start],
+				i - start, add);
+			start = -1;
+		}
+	}
+
+	if (start != -1) {
+		iavf_add_del_uc_addr_bulk(adapter, &adapter->dev_data->mac_addrs[start],
+			i - start, add);
+	}
 }
 
 int
@@ -2281,7 +2330,7 @@ iavf_add_del_mc_addr_list(struct iavf_adapter *adapter,
 	struct iavf_info *vf = IAVF_DEV_PRIVATE_TO_VF(adapter);
 	uint8_t msg_buf[IAVF_AQ_BUF_SZ] = {0};
 	uint8_t cmd_buffer[sizeof(struct virtchnl_ether_addr_list) +
-		(IAVF_NUM_MACADDR_MAX * sizeof(struct virtchnl_ether_addr))];
+		(IAVF_MC_MACADDR_MAX * sizeof(struct virtchnl_ether_addr))];
 	struct virtchnl_ether_addr_list *list;
 	struct iavf_cmd_info args;
 	uint32_t i;
-- 
2.54.0

