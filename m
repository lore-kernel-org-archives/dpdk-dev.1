Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7A81AC88E64
	for <dpdk-dev@archiver.kernel.org>; Mon, 14 Sep 2026 08:17:51 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 75F08406BB;
	Mon, 14 Sep 2026 10:17:46 +0200 (CEST)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by mails.dpdk.org (Postfix) with ESMTP id 21503402DF
 for <dev@dpdk.org>; Mon, 14 Sep 2026 10:17:44 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1789373863;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=AeFK1KgcuHG6cph6zMJG0AZ92BG2EENe+gGjP7pJQ/E=;
 b=g6xqaNGJYyGeKqtKcVLPYZaoldOYYSRKDCCnwbGNfelsre00SwoOCYJ4i1pHeM2unClS6h
 WTKoCkMIHjPENPZebAdvEpIAtxTjKH/50cSyJ6N5yABCptmSlDRWFGL8da8Tc4QAU8N4cr
 u1AeatrOY9AabhFXKVrNWgYnEWssKJw=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-414-ilslk3R-PoqYFiEO77wiJQ-1; Mon,
 14 Sep 2026 04:17:42 -0400
X-MC-Unique: ilslk3R-PoqYFiEO77wiJQ-1
X-Mimecast-MFC-AGG-ID: ilslk3R-PoqYFiEO77wiJQ_1789373860
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id A30A918009C8; Mon, 14 Sep 2026 08:17:40 +0000 (UTC)
Received: from dmarchan.redhat.corp
 (headnet05.pony-001.prod.iad2.dc.redhat.com [10.2.32.117])
 by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 927D73003EED; Mon, 14 Sep 2026 08:17:38 +0000 (UTC)
From: David Marchand <david.marchand@redhat.com>
To: dev@dpdk.org
Cc: ciara.loftus@intel.com, anatoly.burakov@intel.com, rjarry@redhat.com,
 cfontain@redhat.com, stable@dpdk.org,
 Vladimir Medvedkin <vladimir.medvedkin@intel.com>,
 Bruce Richardson <bruce.richardson@intel.com>
Subject: [PATCH v7 2/4] net/iavf: fix duplicate MAC addresses install
Date: Mon, 14 Sep 2026 10:17:23 +0200
Message-ID: <20260914081725.1097704-2-david.marchand@redhat.com>
In-Reply-To: <20260914081725.1097704-1-david.marchand@redhat.com>
References: <20260403091836.1073484-1-david.marchand@redhat.com>
 <20260914081725.1097704-1-david.marchand@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: 5E_HguITjrecH9eIZvzRjDbmq2qi33XlzZVNondybJ0_1789373860
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

On port restart, all MAC addresses get pushed *twice* to the hardware,
once by the driver and once by the eth_dev_mac_restore() in ethdev.

On the other hand, MAC address filters are reset in the hardware
by the PF only when a VF reset is triggered.

Strictly speaking, the mac restore on port (re)start is unneeded,
if no VF reset happened, so we can announce to ethdev that no mac
restoration is needed via a get_restore_flags callback.

Then, move the mac restoration to the VF reset handler.

Fixes: 3d42086def30 ("net/iavf: preserve MAC address with i40e PF Linux driver")
Cc: stable@dpdk.org

Signed-off-by: David Marchand <david.marchand@redhat.com>
---
Changes since v6:
- renamed iavf_add_del_all_mac_addr and removed primary mac address
  handling out of this helper (avoids double primary mac installation),

Changes since v4:
- rebased on next-net-intel,

Changes since v4:
- moved mac restoration in iavf_post_reset_reconfig,

---
 drivers/net/intel/iavf/iavf.h        |  2 +-
 drivers/net/intel/iavf/iavf_ethdev.c | 30 ++++++++++++++++++----------
 drivers/net/intel/iavf/iavf_vchnl.c  | 11 +++++-----
 3 files changed, 26 insertions(+), 17 deletions(-)

diff --git a/drivers/net/intel/iavf/iavf.h b/drivers/net/intel/iavf/iavf.h
index 1d52b3d113..34b9b4ad94 100644
--- a/drivers/net/intel/iavf/iavf.h
+++ b/drivers/net/intel/iavf/iavf.h
@@ -482,7 +482,7 @@ int iavf_add_del_vlan_v2(struct iavf_adapter *adapter, uint16_t vlanid,
 int iavf_get_vlan_offload_caps_v2(struct iavf_adapter *adapter);
 int iavf_config_irq_map(struct iavf_adapter *adapter);
 int iavf_config_irq_map_lv(struct iavf_adapter *adapter, uint16_t num);
-void iavf_add_del_all_mac_addr(struct iavf_adapter *adapter, bool add);
+void iavf_add_del_secondary_mac_addr(struct iavf_adapter *adapter, bool add);
 int iavf_dev_link_update(struct rte_eth_dev *dev,
 			__rte_unused int wait_to_complete);
 void iavf_dev_alarm_handler(void *param);
diff --git a/drivers/net/intel/iavf/iavf_ethdev.c b/drivers/net/intel/iavf/iavf_ethdev.c
index b498258d58..f7aeac8c83 100644
--- a/drivers/net/intel/iavf/iavf_ethdev.c
+++ b/drivers/net/intel/iavf/iavf_ethdev.c
@@ -292,11 +292,12 @@ iavf_get_restore_flags(__rte_unused struct rte_eth_dev *dev,
 		       __rte_unused enum rte_eth_dev_operation op)
 {
 	/*
-	 * The unicast and multicast promiscuous settings persist across a
+	 * The mac addresses, unicast and multicast promiscuous settings persist across a
 	 * stop/start; they are only cleared by a VF reset, which the driver
 	 * restores itself. So ethdev does not need to restore them on start.
 	 */
-	return RTE_ETH_RESTORE_ALL & ~(RTE_ETH_RESTORE_PROMISC |
+	return RTE_ETH_RESTORE_ALL & ~(RTE_ETH_RESTORE_MAC_ADDR |
+				       RTE_ETH_RESTORE_PROMISC |
 				       RTE_ETH_RESTORE_ALLMULTI);
 }
 
@@ -1095,15 +1096,14 @@ iavf_dev_start(struct rte_eth_dev *dev)
 		rte_intr_enable(intr_handle);
 	}
 
-	/* Set all mac addrs */
-	iavf_add_del_all_mac_addr(adapter, true);
-
-	if (!adapter->mac_primary_set)
-		adapter->mac_primary_set = true;
-
-	/* Set all multicast addresses */
-	iavf_add_del_mc_addr_list(adapter, vf->mc_addrs, vf->mc_addrs_num,
-				  true);
+	if (!adapter->mac_primary_set) {
+		if (iavf_add_del_eth_addr(adapter, &dev->data->mac_addrs[0], true,
+				VIRTCHNL_ETHER_ADDR_PRIMARY) != 0)
+			PMD_DRV_LOG(ERR, "failed to add primary MAC:" RTE_ETHER_ADDR_PRT_FMT,
+				RTE_ETHER_ADDR_BYTES(&dev->data->mac_addrs[0]));
+		else
+			adapter->mac_primary_set = true;
+	}
 
 	rte_spinlock_init(&vf->phc_time_aq_lock);
 
@@ -3428,6 +3428,14 @@ iavf_post_reset_reconfig(struct rte_eth_dev *dev)
 	int ret = 0;
 	bool allmulti = false, allunicast = false;
 	struct iavf_adapter *adapter = IAVF_DEV_PRIVATE_TO_ADAPTER(dev->data->dev_private);
+	struct iavf_info *vf = IAVF_DEV_PRIVATE_TO_VF(dev->data->dev_private);
+
+	/*
+	 * After a VF reset, all MAC addresses got flushed.
+	 * The primary MAC should have been set in iavf_dev_start, restore the rest.
+	 */
+	iavf_add_del_secondary_mac_addr(adapter, true);
+	(void)iavf_add_del_mc_addr_list(adapter, vf->mc_addrs, vf->mc_addrs_num, true);
 
 	/* Restore pre-reset unicast promiscuous and multicast promiscuous states */
 	if (dev->data->promiscuous)
diff --git a/drivers/net/intel/iavf/iavf_vchnl.c b/drivers/net/intel/iavf/iavf_vchnl.c
index df97ff2052..a918db5443 100644
--- a/drivers/net/intel/iavf/iavf_vchnl.c
+++ b/drivers/net/intel/iavf/iavf_vchnl.c
@@ -1672,7 +1672,7 @@ iavf_config_irq_map_lv(struct iavf_adapter *adapter, uint16_t num)
 }
 
 void
-iavf_add_del_all_mac_addr(struct iavf_adapter *adapter, bool add)
+iavf_add_del_secondary_mac_addr(struct iavf_adapter *adapter, bool add)
 {
 	struct iavf_info *vf = IAVF_DEV_PRIVATE_TO_VF(adapter);
 	struct {
@@ -1685,7 +1685,7 @@ iavf_add_del_all_mac_addr(struct iavf_adapter *adapter, bool add)
 	int err;
 	size_t buf_len;
 
-	for (unsigned int i = 0; i < RTE_DIM(vf->mac_addrs); i++) {
+	for (unsigned int i = 1; i < RTE_DIM(vf->mac_addrs); i++) {
 		struct rte_ether_addr *addr = &vf->mac_addrs[i];
 		struct virtchnl_ether_addr *vc_addr = &list->list[list->num_elements];
 
@@ -1695,11 +1695,12 @@ iavf_add_del_all_mac_addr(struct iavf_adapter *adapter, bool add)
 		list->num_elements++;
 
 		memcpy(vc_addr->addr, addr->addr_bytes, sizeof(addr->addr_bytes));
-		vc_addr->type = (list->num_elements == 1) ?
-				VIRTCHNL_ETHER_ADDR_PRIMARY :
-				VIRTCHNL_ETHER_ADDR_EXTRA;
+		vc_addr->type = VIRTCHNL_ETHER_ADDR_EXTRA;
 	}
 
+	if (list->num_elements == 0)
+		return;
+
 	/* for some reason PF side checks for buffer being too big, so adjust it down */
 	buf_len = sizeof(struct virtchnl_ether_addr_list) +
 		  sizeof(struct virtchnl_ether_addr) * list->num_elements;
-- 
2.54.0

