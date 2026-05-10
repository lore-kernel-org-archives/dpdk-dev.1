Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C7AAFCD37B2
	for <dpdk-dev@archiver.kernel.org>; Sun, 10 May 2026 17:03:48 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 1E3C440609;
	Sun, 10 May 2026 19:03:42 +0200 (CEST)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by mails.dpdk.org (Postfix) with ESMTP id 235DF40661
 for <dev@dpdk.org>; Sun, 10 May 2026 19:03:40 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1778432619;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=mAiqqp1CSJYHA/xnAL2SVaPqv061iOsisFAC1AQUwUQ=;
 b=T6XDpCiCHYlzaQ7RX2d7OHrzr9L+moflBkqj1vgrloxsFDXc5t7ohfvmdeUdP+xDQqzzDh
 a2/JRvqPS5DgdVW92YT4ki7oOpineIAe+17YQcy/uckSf4AYmvP7oSBopHnWsoQM9kZ7gO
 lE1AeKggqYlqTpe41+7vJNhZSxBsLwg=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-58--lr79AKQNmGLn-0Napa0aQ-1; Sun,
 10 May 2026 13:03:37 -0400
X-MC-Unique: -lr79AKQNmGLn-0Napa0aQ-1
X-Mimecast-MFC-AGG-ID: -lr79AKQNmGLn-0Napa0aQ_1778432616
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id B81F918005B2; Sun, 10 May 2026 17:03:36 +0000 (UTC)
Received: from dmarchan.lan (unknown [10.44.32.242])
 by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 9934C1955D84; Sun, 10 May 2026 17:03:34 +0000 (UTC)
From: David Marchand <david.marchand@redhat.com>
To: dev@dpdk.org
Cc: rjarry@redhat.com, cfontain@redhat.com, stable@dpdk.org,
 Vladimir Medvedkin <vladimir.medvedkin@intel.com>,
 Bruce Richardson <bruce.richardson@intel.com>
Subject: [PATCH v3 5/5] net/iavf: fix duplicate MAC addresses install
Date: Sun, 10 May 2026 19:03:05 +0200
Message-ID: <20260510170306.3406045-6-david.marchand@redhat.com>
In-Reply-To: <20260510170306.3406045-1-david.marchand@redhat.com>
References: <20260403091836.1073484-1-david.marchand@redhat.com>
 <20260510170306.3406045-1-david.marchand@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: BFzF70d37R3lF0K9hEmda52vwM3RxkW9rn7gkN28qCg_1778432616
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
 drivers/net/intel/iavf/iavf_ethdev.c | 31 ++++++++++++++++++++--------
 1 file changed, 22 insertions(+), 9 deletions(-)

diff --git a/drivers/net/intel/iavf/iavf_ethdev.c b/drivers/net/intel/iavf/iavf_ethdev.c
index edbbc34cc5..504eabebe7 100644
--- a/drivers/net/intel/iavf/iavf_ethdev.c
+++ b/drivers/net/intel/iavf/iavf_ethdev.c
@@ -126,6 +126,8 @@ static void iavf_dev_del_mac_addr(struct rte_eth_dev *dev, uint32_t index);
 static int iavf_dev_vlan_filter_set(struct rte_eth_dev *dev,
 				   uint16_t vlan_id, int on);
 static int iavf_dev_vlan_offload_set(struct rte_eth_dev *dev, int mask);
+static uint64_t iavf_get_restore_flags(struct rte_eth_dev *dev,
+				       enum rte_eth_dev_operation op);
 static int iavf_dev_rss_reta_update(struct rte_eth_dev *dev,
 				   struct rte_eth_rss_reta_entry64 *reta_conf,
 				   uint16_t reta_size);
@@ -249,6 +251,7 @@ static const struct eth_dev_ops iavf_eth_dev_ops = {
 	.tx_done_cleanup	    = iavf_dev_tx_done_cleanup,
 	.get_monitor_addr           = iavf_get_monitor_addr,
 	.tm_ops_get                 = iavf_tm_ops_get,
+	.get_restore_flags          = iavf_get_restore_flags,
 };
 
 static int
@@ -269,6 +272,13 @@ iavf_tm_ops_get(struct rte_eth_dev *dev,
 	return 0;
 }
 
+static uint64_t
+iavf_get_restore_flags(__rte_unused struct rte_eth_dev *dev,
+		       __rte_unused enum rte_eth_dev_operation op)
+{
+	return RTE_ETH_RESTORE_ALL & ~RTE_ETH_RESTORE_MAC_ADDR;
+}
+
 __rte_unused
 static int
 iavf_vfr_inprogress(struct iavf_hw *hw)
@@ -1039,15 +1049,14 @@ iavf_dev_start(struct rte_eth_dev *dev)
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
 
@@ -3144,6 +3153,10 @@ iavf_handle_hw_reset(struct rte_eth_dev *dev, bool vf_initiated_reset)
 		if (ret)
 			goto error;
 
+		/* after a VF reset, all mac addresses got flushed, restore them */
+		iavf_add_del_all_mac_addr(adapter, true);
+		iavf_add_del_mc_addr_list(adapter, vf->mc_addrs, vf->mc_addrs_num, true);
+
 		dev->data->dev_started = 1;
 	}
 	goto exit;
-- 
2.53.0

