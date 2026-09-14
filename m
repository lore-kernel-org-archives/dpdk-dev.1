Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A80A7C88E50
	for <dpdk-dev@archiver.kernel.org>; Mon, 14 Sep 2026 08:17:45 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 609644068A;
	Mon, 14 Sep 2026 10:17:44 +0200 (CEST)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by mails.dpdk.org (Postfix) with ESMTP id 66D2A402C4
 for <dev@dpdk.org>; Mon, 14 Sep 2026 10:17:42 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1789373861;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=1JqE8X44z2IWMPmvHPjS0ifENv+x7ueoZ5LrOr4Byl4=;
 b=WGC1O+6QLVVVukEJcYUbwYqcql7jP3hx76IQXwl1DvEcyENpc1L1zBSmazOfhMCsxWmLnm
 JfEALL70dE2ptKUju3giNz4uY1vvKBIkR7SU9bPT9Ye2+m56q7lm6w105YzKzYtDbi5OWx
 8e94Ae4pOCZWspKiTnQ5a4q1/GBcQVk=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-290-PEg1uOKtPUq5o2j2r89Ttw-1; Mon,
 14 Sep 2026 04:17:37 -0400
X-MC-Unique: PEg1uOKtPUq5o2j2r89Ttw-1
X-Mimecast-MFC-AGG-ID: PEg1uOKtPUq5o2j2r89Ttw_1789373856
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id D273718052F2; Mon, 14 Sep 2026 08:17:35 +0000 (UTC)
Received: from dmarchan.redhat.corp
 (headnet05.pony-001.prod.iad2.dc.redhat.com [10.2.32.117])
 by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 78E1B1956086; Mon, 14 Sep 2026 08:17:32 +0000 (UTC)
From: David Marchand <david.marchand@redhat.com>
To: dev@dpdk.org
Cc: ciara.loftus@intel.com, anatoly.burakov@intel.com, rjarry@redhat.com,
 cfontain@redhat.com, stable@dpdk.org,
 Vladimir Medvedkin <vladimir.medvedkin@intel.com>,
 Lunyuan Cui <lunyuanx.cui@intel.com>, Jingjing Wu <jingjing.wu@intel.com>,
 Xiaolong Ye <xiaolong.ye@intel.com>
Subject: [PATCH v7 1/4] net/iavf: fix MAC addresses leak on reset
Date: Mon, 14 Sep 2026 10:17:22 +0200
Message-ID: <20260914081725.1097704-1-david.marchand@redhat.com>
In-Reply-To: <20260403091836.1073484-1-david.marchand@redhat.com>
References: <20260403091836.1073484-1-david.marchand@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: ffOClHHpYH0jwWCcaifnprNseyC_ZZugeyD-TIYyv3w_1789373856
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

When resetting, calling iavf_dev_uninit + iavf_dev_init results in
leaking the previous dev->data->mac_addrs array.
As a consequence, secondary MAC addresses are lost during a VF reset.

Move the MAC addresses array in the private iavf_info structure, along
the multicast MAC addresses.
Set/clear dev->data->mac_addrs in iavf_dev_init/iavf_dev_uninit.

Consistently use RTE_DIM() to avoid mixing with the multicast addresses
array.

Fixes: e74e1bb6280d ("net/iavf: enable port reset")
Cc: stable@dpdk.org

Signed-off-by: David Marchand <david.marchand@redhat.com>
---
 drivers/net/intel/iavf/iavf.h        |  3 +++
 drivers/net/intel/iavf/iavf_ethdev.c | 20 +++++++-------------
 drivers/net/intel/iavf/iavf_vchnl.c  | 10 +++++-----
 3 files changed, 15 insertions(+), 18 deletions(-)

diff --git a/drivers/net/intel/iavf/iavf.h b/drivers/net/intel/iavf/iavf.h
index 044de3cfd4..1d52b3d113 100644
--- a/drivers/net/intel/iavf/iavf.h
+++ b/drivers/net/intel/iavf/iavf.h
@@ -255,6 +255,9 @@ struct iavf_info {
 	bool link_up;
 	uint32_t link_speed;
 
+	/* Unicast addrs */
+	struct rte_ether_addr mac_addrs[IAVF_NUM_MACADDR_MAX];
+
 	/* Multicast addrs */
 	struct rte_ether_addr mc_addrs[IAVF_NUM_MACADDR_MAX];
 	uint16_t mc_addrs_num;   /* Multicast mac addresses number */
diff --git a/drivers/net/intel/iavf/iavf_ethdev.c b/drivers/net/intel/iavf/iavf_ethdev.c
index 2ac4dbdac4..b498258d58 100644
--- a/drivers/net/intel/iavf/iavf_ethdev.c
+++ b/drivers/net/intel/iavf/iavf_ethdev.c
@@ -1186,7 +1186,7 @@ iavf_dev_info_get(struct rte_eth_dev *dev, struct rte_eth_dev_info *dev_info)
 	dev_info->hash_key_size = vf->vf_res->rss_key_size;
 	dev_info->reta_size = vf->vf_res->rss_lut_size;
 	dev_info->flow_type_rss_offloads = IAVF_RSS_OFFLOAD_ALL;
-	dev_info->max_mac_addrs = IAVF_NUM_MACADDR_MAX;
+	dev_info->max_mac_addrs = RTE_DIM(vf->mac_addrs);
 	/*
 	 * Runtime queue setup can race with the hardware Tx rate limiter on
 	 * E810 VFs and corrupt queue state. Once a per-queue bandwidth rte_tm
@@ -3104,16 +3104,9 @@ iavf_dev_init(struct rte_eth_dev *eth_dev)
 	/* set default ptype table */
 	iavf_set_default_ptype_table(eth_dev);
 
-	/* copy mac addr */
-	eth_dev->data->mac_addrs = rte_zmalloc(
-		"iavf_mac", RTE_ETHER_ADDR_LEN * IAVF_NUM_MACADDR_MAX, 0);
-	if (!eth_dev->data->mac_addrs) {
-		PMD_INIT_LOG(ERR, "Failed to allocate %d bytes needed to"
-			     " store MAC addresses",
-			     RTE_ETHER_ADDR_LEN * IAVF_NUM_MACADDR_MAX);
-		ret = -ENOMEM;
-		goto init_vf_err;
-	}
+	/* Point at the MAC addresses array from priv */
+	eth_dev->data->mac_addrs = vf->mac_addrs;
+
 	/* If the MAC address is not configured by host,
 	 * generate a random one.
 	 */
@@ -3123,7 +3116,6 @@ iavf_dev_init(struct rte_eth_dev *eth_dev)
 	rte_ether_addr_copy((struct rte_ether_addr *)hw->mac.addr,
 			&eth_dev->data->mac_addrs[0]);
 
-
 	if (vf->vf_res->vf_cap_flags & VIRTCHNL_VF_OFFLOAD_WB_ON_ITR &&
 			/* register callback func to eal lib */
 			rte_intr_callback_register(pci_dev->intr_handle,
@@ -3199,7 +3191,6 @@ iavf_dev_init(struct rte_eth_dev *eth_dev)
 	iavf_phc_sync_alarm_stop(eth_dev);
 	rte_eal_alarm_cancel(iavf_dev_alarm_handler, eth_dev);
 
-	rte_free(eth_dev->data->mac_addrs);
 	eth_dev->data->mac_addrs = NULL;
 
 init_vf_err:
@@ -3256,6 +3247,9 @@ iavf_dev_close(struct rte_eth_dev *dev)
 
 	adapter->closed = true;
 
+	/* Clear reference to the MAC addresses in priv */
+	dev->data->mac_addrs = NULL;
+
 	/* free iAVF security device context all related resources */
 	iavf_security_ctx_destroy(adapter);
 
diff --git a/drivers/net/intel/iavf/iavf_vchnl.c b/drivers/net/intel/iavf/iavf_vchnl.c
index e3120c655d..df97ff2052 100644
--- a/drivers/net/intel/iavf/iavf_vchnl.c
+++ b/drivers/net/intel/iavf/iavf_vchnl.c
@@ -1674,19 +1674,19 @@ iavf_config_irq_map_lv(struct iavf_adapter *adapter, uint16_t num)
 void
 iavf_add_del_all_mac_addr(struct iavf_adapter *adapter, bool add)
 {
+	struct iavf_info *vf = IAVF_DEV_PRIVATE_TO_VF(adapter);
 	struct {
 		struct virtchnl_ether_addr_list list;
-		struct virtchnl_ether_addr addr[IAVF_NUM_MACADDR_MAX];
+		struct virtchnl_ether_addr addr[RTE_DIM(vf->mac_addrs)];
 	} list_req = {0};
 	struct virtchnl_ether_addr_list *list = &list_req.list;
-	struct iavf_info *vf = IAVF_DEV_PRIVATE_TO_VF(adapter);
 	uint8_t msg_buf[IAVF_AQ_BUF_SZ] = {0};
 	struct iavf_cmd_info args = {0};
-	int err, i;
+	int err;
 	size_t buf_len;
 
-	for (i = 0; i < IAVF_NUM_MACADDR_MAX; i++) {
-		struct rte_ether_addr *addr = &adapter->dev_data->mac_addrs[i];
+	for (unsigned int i = 0; i < RTE_DIM(vf->mac_addrs); i++) {
+		struct rte_ether_addr *addr = &vf->mac_addrs[i];
 		struct virtchnl_ether_addr *vc_addr = &list->list[list->num_elements];
 
 		/* ignore empty addresses */
-- 
2.54.0

