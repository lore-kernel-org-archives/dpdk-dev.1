Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1D833606A319
	for <dpdk-dev@archiver.kernel.org>; Wed, 21 Oct 2026 10:31:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=QuaJbHju
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 6C90B406FF;
	Wed, 21 Oct 2026 12:31:06 +0200 (CEST)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by mails.dpdk.org (Postfix) with ESMTP id 8B3A4406FF
 for <dev@dpdk.org>; Wed, 21 Oct 2026 12:31:02 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1792578662;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=gusEQ6QoliRbWLWQr2GTudIPwSFbhfvr55sYZX1iaek=;
 b=QuaJbHjuoZWzbdUctNJuVcoYFG6JD/GckIa973hvGYmi7GT4ZnivtqnLl2sN6Qr6aWIv6l
 YcJNuR6QFZ1TORN93Z/iFVB3Itnwdm7neKFM1XKT1Ql3pIsxQsS430cDSLtPsY556fKP4u
 SsYbWGkiWAewn/dsdojCy8zGayoTAH0=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-473-tbGIQeOTOxa-2RyLDP7pkA-1; Wed,
 21 Oct 2026 10:30:58 +0000
X-MC-Unique: tbGIQeOTOxa-2RyLDP7pkA-1
X-Mimecast-MFC-AGG-ID: tbGIQeOTOxa-2RyLDP7pkA_1792578657
Received: from mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.95])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 7AEC31955F14; Wed, 21 Oct 2026 10:30:57 +0000 (UTC)
Received: from dmarchan.home (headnet04.pony-001.prod.iad2.dc.redhat.com
 [10.2.32.116])
 by mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 5C151418; Wed, 21 Oct 2026 10:30:55 +0000 (UTC)
From: David Marchand <david.marchand@redhat.com>
To: dev@dpdk.org
Cc: thomas@monjalon.net, Xingui Yang <yangxingui@huawei.com>,
 Chengwen Feng <fengchengwen@huawei.com>,
 Bruce Richardson <bruce.richardson@intel.com>
Subject: [PATCH v2 06/12] drivers/net: remove check on VMDq modes
Date: Wed, 21 Oct 2026 12:30:20 +0200
Message-ID: <20261021103027.2050351-7-david.marchand@redhat.com>
In-Reply-To: <20261021103027.2050351-1-david.marchand@redhat.com>
References: <20261016130555.1685102-1-david.marchand@redhat.com>
 <20261021103027.2050351-1-david.marchand@redhat.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.6 on 10.30.177.95
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: LXx-cc7eedETuxfOraVUOWCjT4UzOLRIcVzbDgsgM68_1792578657
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
content-type: text/plain; charset="US-ASCII"; x-default=true
X-BeenThere: dev@dpdk.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: DPDK patches and discussions <dev.dpdk.org>
List-Archive: <http://mails.dpdk.org/archives/dev/>
List-Post: <mailto:dev@dpdk.org>
List-Help: <mailto:dev-request@dpdk.org?subject=help>
List-Subscribe: <https://mails.dpdk.org/listinfo/dev>,
 <mailto:dev-request@dpdk.org?subject=subscribe>
X-Spam-Status: No, score=-16.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

ethdev now validates requests for VMDq Rx and Tx modes.
No need to validate again in the driver.

Note:
- for igb, max_vmdq_pools is already 0 for models that do not support
  VMDq, so checking the VMDq modes is unneeded,
- for i40e, the FW flag was already checked to populate max_vmdq_pools,

Signed-off-by: David Marchand <david.marchand@redhat.com>
---
 drivers/net/hns3/hns3_dcb.c          |  9 -------
 drivers/net/intel/e1000/igb_rxtx.c   | 39 ----------------------------
 drivers/net/intel/i40e/i40e_ethdev.c |  5 ----
 3 files changed, 53 deletions(-)

diff --git a/drivers/net/hns3/hns3_dcb.c b/drivers/net/hns3/hns3_dcb.c
index 6d2945d9c5..e7912aebb2 100644
--- a/drivers/net/hns3/hns3_dcb.c
+++ b/drivers/net/hns3/hns3_dcb.c
@@ -1840,7 +1840,6 @@ int
 hns3_check_dev_mq_mode(struct rte_eth_dev *dev)
 {
 	enum rte_eth_rx_mq_mode rx_mq_mode = dev->data->dev_conf.rxmode.mq_mode;
-	enum rte_eth_tx_mq_mode tx_mq_mode = dev->data->dev_conf.txmode.mq_mode;
 	struct hns3_hw *hw = HNS3_DEV_PRIVATE_TO_HW(dev->data->dev_private);
 	struct hns3_adapter *hns = HNS3_DEV_HW_TO_ADAPTER(hw);
 	struct rte_eth_dcb_rx_conf *dcb_rx_conf;
@@ -1849,14 +1848,6 @@ hns3_check_dev_mq_mode(struct rte_eth_dev *dev)
 	int max_tc = 0;
 	int i;
 
-	if (((uint32_t)rx_mq_mode & RTE_ETH_MQ_RX_VMDQ_FLAG) ||
-	    (tx_mq_mode == RTE_ETH_MQ_TX_VMDQ_DCB ||
-	     tx_mq_mode == RTE_ETH_MQ_TX_VMDQ_ONLY)) {
-		hns3_err(hw, "VMDQ is not supported, rx_mq_mode = %d, tx_mq_mode = %d.",
-			 rx_mq_mode, tx_mq_mode);
-		return -EOPNOTSUPP;
-	}
-
 	dcb_rx_conf = &dev->data->dev_conf.rx_adv_conf.dcb_rx_conf;
 	dcb_tx_conf = &dev->data->dev_conf.tx_adv_conf.dcb_tx_conf;
 	if ((uint32_t)rx_mq_mode & RTE_ETH_MQ_RX_DCB_FLAG) {
diff --git a/drivers/net/intel/e1000/igb_rxtx.c b/drivers/net/intel/e1000/igb_rxtx.c
index 4fda5d57a0..ef531f1cd4 100644
--- a/drivers/net/intel/e1000/igb_rxtx.c
+++ b/drivers/net/intel/e1000/igb_rxtx.c
@@ -2113,41 +2113,6 @@ igb_rss_configure(struct rte_eth_dev *dev)
 	igb_hw_rss_hash_set(hw, &rss_conf);
 }
 
-/*
- * Check if the mac type support VMDq or not.
- * Return 1 if it supports, otherwise, return 0.
- */
-static int
-igb_is_vmdq_supported(const struct rte_eth_dev *dev)
-{
-	const struct e1000_hw *hw = E1000_DEV_PRIVATE_TO_HW(dev->data->dev_private);
-
-	switch (hw->mac.type) {
-	case e1000_82576:
-	case e1000_82580:
-	case e1000_i350:
-		return 1;
-	case e1000_82540:
-	case e1000_82541:
-	case e1000_82542:
-	case e1000_82543:
-	case e1000_82544:
-	case e1000_82545:
-	case e1000_82546:
-	case e1000_82547:
-	case e1000_82571:
-	case e1000_82572:
-	case e1000_82573:
-	case e1000_82574:
-	case e1000_82583:
-	case e1000_i210:
-	case e1000_i211:
-	default:
-		PMD_INIT_LOG(ERR, "Cannot support VMDq feature");
-		return 0;
-	}
-}
-
 static int
 igb_vmdq_rx_hw_configure(struct rte_eth_dev *dev)
 {
@@ -2161,10 +2126,6 @@ igb_vmdq_rx_hw_configure(struct rte_eth_dev *dev)
 	hw = E1000_DEV_PRIVATE_TO_HW(dev->data->dev_private);
 	cfg = &dev->data->dev_conf.rx_adv_conf.vmdq_rx_conf;
 
-	/* Check if mac type can support VMDq, return value of 0 means NOT support */
-	if (igb_is_vmdq_supported(dev) == 0)
-		return -1;
-
 	igb_rss_disable(dev);
 
 	/* RCTL: enable VLAN filter */
diff --git a/drivers/net/intel/i40e/i40e_ethdev.c b/drivers/net/intel/i40e/i40e_ethdev.c
index 41d5586403..2405d9e119 100644
--- a/drivers/net/intel/i40e/i40e_ethdev.c
+++ b/drivers/net/intel/i40e/i40e_ethdev.c
@@ -6655,11 +6655,6 @@ i40e_vmdq_setup(struct rte_eth_dev *dev)
 	 */
 	i40e_pf_disable_irq0(hw);
 
-	if ((pf->flags & I40E_FLAG_VMDQ) == 0) {
-		PMD_INIT_LOG(ERR, "FW doesn't support VMDQ");
-		return -ENOTSUP;
-	}
-
 	conf_vsis = conf->rx_adv_conf.vmdq_rx_conf.nb_queue_pools;
 	if (conf_vsis > pf->max_nb_vmdq_vsi) {
 		PMD_INIT_LOG(ERR, "VMDQ config: %u, max support:%u",
-- 
2.54.0

