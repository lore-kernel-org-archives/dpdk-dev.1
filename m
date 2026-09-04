Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A0F33C61DD6
	for <dpdk-dev@archiver.kernel.org>; Fri,  4 Sep 2026 12:28:19 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id D754B42FB2;
	Fri,  4 Sep 2026 14:28:16 +0200 (CEST)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by mails.dpdk.org (Postfix) with ESMTP id B770542FB1
 for <dev@dpdk.org>; Fri,  4 Sep 2026 14:28:15 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1788524895;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=CeVXE2jyaT6K+IHbn2I1KLLsMUodHoYp11+auEzWHGY=;
 b=UMkPcurAIr5tEFpfjEQHbMPaLoXWgjflz6EPSLCC4xUFVEB47621S/v1BvTXihWVQ+qkSY
 bqzOq4zBKI3g28Mc6jTKNao5kEHbSZrqIjlwnfPeEFn8M2dqErH6uF7QVV/hfsmSS/ikxe
 sCwWeipvM94JAnph593JGQF0ng80V4A=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-692-VuIRHEzTNZiyXOBrRfPsQg-1; Fri,
 04 Sep 2026 08:28:12 -0400
X-MC-Unique: VuIRHEzTNZiyXOBrRfPsQg-1
X-Mimecast-MFC-AGG-ID: VuIRHEzTNZiyXOBrRfPsQg_1788524891
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id D9A01183046D; Fri,  4 Sep 2026 12:28:10 +0000 (UTC)
Received: from dmarchan.home (headnet04.pony-001.prod.iad2.dc.redhat.com
 [10.2.32.116])
 by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 9944E180034C; Fri,  4 Sep 2026 12:28:09 +0000 (UTC)
From: David Marchand <david.marchand@redhat.com>
To: dev@dpdk.org
Cc: bruce.richardson@intel.com, stable@dpdk.org,
 Vladimir Medvedkin <vladimir.medvedkin@intel.com>
Subject: [PATCH v6 2/2] net/iavf: fix duplicate MAC addresses install
Date: Fri,  4 Sep 2026 14:28:03 +0200
Message-ID: <20260904122804.2256481-2-david.marchand@redhat.com>
In-Reply-To: <20260904122804.2256481-1-david.marchand@redhat.com>
References: <20260403091836.1073484-1-david.marchand@redhat.com>
 <20260904122804.2256481-1-david.marchand@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: ara-3Fd9ucGaCu7YobHMMJmrM-q2Fz9n1iqQoQdUqYc_1788524891
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
Changes since v4:
- rebased on next-net-intel,

Changes since v4:
- moved mac restoration in iavf_post_reset_reconfig,

---
 drivers/net/intel/iavf/iavf_ethdev.c | 27 ++++++++++++++++-----------
 1 file changed, 16 insertions(+), 11 deletions(-)

diff --git a/drivers/net/intel/iavf/iavf_ethdev.c b/drivers/net/intel/iavf/iavf_ethdev.c
index bbd1f08ff0..bec7b3b6d7 100644
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
 
@@ -3434,6 +3434,11 @@ iavf_post_reset_reconfig(struct rte_eth_dev *dev)
 	int ret = 0;
 	bool allmulti = false, allunicast = false;
 	struct iavf_adapter *adapter = IAVF_DEV_PRIVATE_TO_ADAPTER(dev->data->dev_private);
+	struct iavf_info *vf = IAVF_DEV_PRIVATE_TO_VF(dev->data->dev_private);
+
+	/* After a VF reset, all MAC addresses got flushed, restore them. */
+	iavf_add_del_all_mac_addr(adapter, true);
+	iavf_add_del_mc_addr_list(adapter, vf->mc_addrs, vf->mc_addrs_num, true);
 
 	/* Restore pre-reset unicast promiscuous and multicast promiscuous states */
 	if (dev->data->promiscuous)
-- 
2.54.0

