Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D97BDE7E345
	for <dpdk-dev@archiver.kernel.org>; Fri,  3 Apr 2026 09:19:16 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id EE96640E32;
	Fri,  3 Apr 2026 11:19:09 +0200 (CEST)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by mails.dpdk.org (Postfix) with ESMTP id 1254340E39
 for <dev@dpdk.org>; Fri,  3 Apr 2026 11:19:07 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1775207947;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=SFo/jHSNqa/pZOqInFtHwnNp+cfk9mp9bZc4HL2j1W0=;
 b=M9qx5m7YjDX7hudvODnaPtaqN/8HqSO1ONb4dXj8DCeyGf/Lq4lJwjtv46i/KXTa+vxVti
 hdMvcqvqBtrW+IrraAEEF71rQcyepX7k21vGxIyFhShWxuTUEtCuZChxyxvCytzE3naElQ
 +41kLK7PJDQz8Jv68cnzVnn58fuhiKY=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-592-m9gt53CMPsuABgtscFLwwQ-1; Fri,
 03 Apr 2026 05:19:06 -0400
X-MC-Unique: m9gt53CMPsuABgtscFLwwQ-1
X-Mimecast-MFC-AGG-ID: m9gt53CMPsuABgtscFLwwQ_1775207945
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 582E71800561; Fri,  3 Apr 2026 09:19:05 +0000 (UTC)
Received: from dmarchan.lan (unknown [10.44.32.35])
 by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id D0BBC180035F; Fri,  3 Apr 2026 09:19:03 +0000 (UTC)
From: David Marchand <david.marchand@redhat.com>
To: dev@dpdk.org
Cc: rjarry@redhat.com, cfontain@redhat.com,
 Vladimir Medvedkin <vladimir.medvedkin@intel.com>
Subject: [PATCH 4/4] net/iavf: accept up to 32k unicast MAC addresses
Date: Fri,  3 Apr 2026 11:18:35 +0200
Message-ID: <20260403091836.1073484-5-david.marchand@redhat.com>
In-Reply-To: <20260403091836.1073484-1-david.marchand@redhat.com>
References: <20260403091836.1073484-1-david.marchand@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: AbKniEkTnK9r2JCg8a2u2bWNOEYN_91vkmVCjmyFBtU_1775207945
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
and depends on usage by other VFs on the same PF.
There is no way to figure out this limit but to try adding a mac address
and get an error from the PF driver.

Signed-off-by: David Marchand <david.marchand@redhat.com>
---
 drivers/net/intel/iavf/iavf.h        |  5 +++--
 drivers/net/intel/iavf/iavf_ethdev.c | 10 +++++-----
 drivers/net/intel/iavf/iavf_vchnl.c  |  6 +++---
 3 files changed, 11 insertions(+), 10 deletions(-)

diff --git a/drivers/net/intel/iavf/iavf.h b/drivers/net/intel/iavf/iavf.h
index 403c61e2e8..f1dede0694 100644
--- a/drivers/net/intel/iavf/iavf.h
+++ b/drivers/net/intel/iavf/iavf.h
@@ -31,7 +31,8 @@
 #define IAVF_IRQ_MAP_NUM_PER_BUF	 128
 #define IAVF_RXTX_QUEUE_CHUNKS_NUM	 2
 
-#define IAVF_NUM_MACADDR_MAX      64
+#define IAVF_UC_MACADDR_MAX      32768
+#define IAVF_MC_MACADDR_MAX      64
 
 #define IAVF_DEV_WATCHDOG_PERIOD     2000 /* microseconds, set 0 to disable*/
 
@@ -253,7 +254,7 @@ struct iavf_info {
 	uint32_t link_speed;
 
 	/* Multicast addrs */
-	struct rte_ether_addr mc_addrs[IAVF_NUM_MACADDR_MAX];
+	struct rte_ether_addr mc_addrs[IAVF_MC_MACADDR_MAX];
 	uint16_t mc_addrs_num;   /* Multicast mac addresses number */
 
 	struct iavf_vsi vsi;
diff --git a/drivers/net/intel/iavf/iavf_ethdev.c b/drivers/net/intel/iavf/iavf_ethdev.c
index 1eca20bc9a..c69a012d50 100644
--- a/drivers/net/intel/iavf/iavf_ethdev.c
+++ b/drivers/net/intel/iavf/iavf_ethdev.c
@@ -379,10 +379,10 @@ iavf_set_mc_addr_list(struct rte_eth_dev *dev,
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
 
@@ -1120,7 +1120,7 @@ iavf_dev_info_get(struct rte_eth_dev *dev, struct rte_eth_dev_info *dev_info)
 	dev_info->hash_key_size = vf->vf_res->rss_key_size;
 	dev_info->reta_size = vf->vf_res->rss_lut_size;
 	dev_info->flow_type_rss_offloads = IAVF_RSS_OFFLOAD_ALL;
-	dev_info->max_mac_addrs = IAVF_NUM_MACADDR_MAX;
+	dev_info->max_mac_addrs = IAVF_UC_MACADDR_MAX;
 	dev_info->dev_capa =
 		RTE_ETH_DEV_CAPA_RUNTIME_RX_QUEUE_SETUP |
 		RTE_ETH_DEV_CAPA_RUNTIME_TX_QUEUE_SETUP;
@@ -2822,11 +2822,11 @@ iavf_dev_init(struct rte_eth_dev *eth_dev)
 
 	/* copy mac addr */
 	eth_dev->data->mac_addrs = rte_zmalloc(
-		"iavf_mac", RTE_ETHER_ADDR_LEN * IAVF_NUM_MACADDR_MAX, 0);
+		"iavf_mac", RTE_ETHER_ADDR_LEN * IAVF_UC_MACADDR_MAX, 0);
 	if (!eth_dev->data->mac_addrs) {
 		PMD_INIT_LOG(ERR, "Failed to allocate %d bytes needed to"
 			     " store MAC addresses",
-			     RTE_ETHER_ADDR_LEN * IAVF_NUM_MACADDR_MAX);
+			     RTE_ETHER_ADDR_LEN * IAVF_UC_MACADDR_MAX);
 		ret = -ENOMEM;
 		goto init_vf_err;
 	}
diff --git a/drivers/net/intel/iavf/iavf_vchnl.c b/drivers/net/intel/iavf/iavf_vchnl.c
index 08dd6f2d7f..c70f2fbbc0 100644
--- a/drivers/net/intel/iavf/iavf_vchnl.c
+++ b/drivers/net/intel/iavf/iavf_vchnl.c
@@ -1442,7 +1442,7 @@ iavf_add_del_all_mac_addr(struct iavf_adapter *adapter, bool add)
 {
 	struct {
 		struct virtchnl_ether_addr_list list;
-		struct virtchnl_ether_addr addr[IAVF_NUM_MACADDR_MAX];
+		struct virtchnl_ether_addr addr[IAVF_UC_MACADDR_MAX];
 	} list_req = {0};
 	struct virtchnl_ether_addr_list *list = &list_req.list;
 	struct iavf_info *vf = IAVF_DEV_PRIVATE_TO_VF(adapter);
@@ -1450,7 +1450,7 @@ iavf_add_del_all_mac_addr(struct iavf_adapter *adapter, bool add)
 	int err, i;
 	size_t buf_len;
 
-	for (i = 0; i < IAVF_NUM_MACADDR_MAX; i++) {
+	for (i = 0; i < IAVF_UC_MACADDR_MAX; i++) {
 		struct rte_ether_addr *addr = &adapter->dev_data->mac_addrs[i];
 		struct virtchnl_ether_addr *vc_addr = &list->list[list->num_elements];
 
@@ -2060,7 +2060,7 @@ iavf_add_del_mc_addr_list(struct iavf_adapter *adapter,
 {
 	struct iavf_info *vf = IAVF_DEV_PRIVATE_TO_VF(adapter);
 	uint8_t cmd_buffer[sizeof(struct virtchnl_ether_addr_list) +
-		(IAVF_NUM_MACADDR_MAX * sizeof(struct virtchnl_ether_addr))];
+		(IAVF_MC_MACADDR_MAX * sizeof(struct virtchnl_ether_addr))];
 	struct virtchnl_ether_addr_list *list;
 	struct iavf_cmd_info args;
 	uint32_t i;
-- 
2.53.0

