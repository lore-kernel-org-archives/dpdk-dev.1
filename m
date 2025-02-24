Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0D76FC021A6
	for <dpdk-dev@archiver.kernel.org>; Mon, 24 Feb 2025 11:40:31 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id D303240E42;
	Mon, 24 Feb 2025 12:40:29 +0100 (CET)
Received: from smtp-fw-9106.amazon.com (smtp-fw-9106.amazon.com
 [207.171.188.206])
 by mails.dpdk.org (Postfix) with ESMTP id 4844640E3E
 for <dev@dpdk.org>; Mon, 24 Feb 2025 12:40:27 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
 t=1740397227; x=1771933227;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version;
 bh=nkHK4x2463l2xpnaSbebio6zFP9aaMiOEUD5rfyd/y0=;
 b=Md/Y9+2BsqT1fvfZQig6TR9rIGzVoMjLp8ZHs1t9pVt812qAkBYT7IW9
 lccskempE3OK2O1W0Bjdd7HyXsOGHRX2hR9zqre5EPVPThW4wjjpg0Twd
 sEe9XazhALIlEDAG9OuxxjTnpt9qX4ADCB/0e8s4h5kw4u3xS2T6nj44X U=;
X-IronPort-AV: E=Sophos;i="6.13,311,1732579200"; d="scan'208";a="801450435"
Received: from pdx4-co-svc-p1-lb2-vlan2.amazon.com (HELO
 smtpout.prod.us-east-1.prod.farcaster.email.amazon.dev) ([10.25.36.210])
 by smtp-border-fw-9106.sea19.amazon.com with
 ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Feb 2025 11:40:19 +0000
Received: from EX19MTAEUA001.ant.amazon.com [10.0.10.100:48996]
 by smtpin.naws.eu-west-1.prod.farcaster.email.amazon.dev [10.0.2.102:2525]
 with esmtp (Farcaster)
 id 629846b5-dd3e-4b3e-93a9-600424f0686d; Mon, 24 Feb 2025 11:40:18 +0000 (UTC)
X-Farcaster-Flow-ID: 629846b5-dd3e-4b3e-93a9-600424f0686d
Received: from EX19D007EUB004.ant.amazon.com (10.252.51.85) by
 EX19MTAEUA001.ant.amazon.com (10.252.50.50) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1544.14;
 Mon, 24 Feb 2025 11:40:18 +0000
Received: from EX19MTAUEC002.ant.amazon.com (10.252.135.146) by
 EX19D007EUB004.ant.amazon.com (10.252.51.85) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1544.14;
 Mon, 24 Feb 2025 11:40:17 +0000
Received: from email-imr-corp-prod-pdx-1box-2b-ecca39fb.us-west-2.amazon.com
 (10.43.8.6) by mail-relay.amazon.com (10.252.135.146) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id
 15.2.1544.14 via Frontend Transport; Mon, 24 Feb 2025 11:40:17 +0000
Received: from HFA15-CG15235BS.amazon.com (unknown [10.1.213.12])
 by email-imr-corp-prod-pdx-1box-2b-ecca39fb.us-west-2.amazon.com (Postfix)
 with ESMTP id 2622B801E3; Mon, 24 Feb 2025 11:40:15 +0000 (UTC)
From: <shaibran@amazon.com>
To: <ferruh.yigit@amd.com>
CC: <dev@dpdk.org>, Shai Brandes <shaibran@amazon.com>
Subject: [PATCH 1/4] net/ena/base: upgrade ena-com to the latest version
Date: Mon, 24 Feb 2025 13:40:08 +0200
Message-ID: <20250224114011.1789-2-shaibran@amazon.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20250224114011.1789-1-shaibran@amazon.com>
References: <20250224114011.1789-1-shaibran@amazon.com>
MIME-Version: 1.0
Content-Type: text/plain
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

From: Shai Brandes <shaibran@amazon.com>

This update upgrades the ena-com module to the most recent version,
which includes various cosmetic changes and the removal of obsolete
routines.

Signed-off-by: Shai Brandes <shaibran@amazon.com>
---
 drivers/net/ena/base/ena_com.c                | 24 ++++++-------------
 drivers/net/ena/base/ena_com.h                |  2 --
 .../net/ena/base/ena_defs/ena_eth_io_defs.h   |  7 +++---
 3 files changed, 11 insertions(+), 22 deletions(-)

diff --git a/drivers/net/ena/base/ena_com.c b/drivers/net/ena/base/ena_com.c
index 24bad19848..8018663e18 100644
--- a/drivers/net/ena/base/ena_com.c
+++ b/drivers/net/ena/base/ena_com.c
@@ -1799,7 +1799,9 @@ int ena_com_phc_config(struct ena_com_dev *ena_dev)
 				  ENA_ADMIN_PHC_CONFIG,
 				  ENA_ADMIN_PHC_FEATURE_VERSION_0);
 	if (unlikely(ret)) {
-		ena_trc_err(ena_dev, "Failed to get PHC feature configuration, error: %d\n", ret);
+		ena_trc_err(ena_dev,
+			    "Failed to get PHC feature configuration, error: %d\n",
+			    ret);
 		return ret;
 	}
 
@@ -1833,7 +1835,9 @@ int ena_com_phc_config(struct ena_com_dev *ena_dev)
 	set_feat_cmd.aq_common_descriptor.opcode = ENA_ADMIN_SET_FEATURE;
 	set_feat_cmd.feat_common.feature_id = ENA_ADMIN_PHC_CONFIG;
 	set_feat_cmd.u.phc.output_length = sizeof(*phc->virt_addr);
-	ret = ena_com_mem_addr_set(ena_dev, &set_feat_cmd.u.phc.output_address, phc->phys_addr);
+	ret = ena_com_mem_addr_set(ena_dev,
+				   &set_feat_cmd.u.phc.output_address,
+				   phc->phys_addr);
 	if (unlikely(ret)) {
 		ena_trc_err(ena_dev, "Failed setting PHC output address, error: %d\n", ret);
 		return ret;
@@ -2091,6 +2095,7 @@ int ena_com_admin_init(struct ena_com_dev *ena_dev,
 	admin_queue->q_depth = ENA_ADMIN_QUEUE_DEPTH;
 
 	admin_queue->bus = ena_dev->bus;
+	admin_queue->ena_dev = ena_dev;
 	admin_queue->q_dmadev = ena_dev->dmadev;
 	admin_queue->polling = false;
 	admin_queue->curr_cmd_id = 0;
@@ -2148,7 +2153,6 @@ int ena_com_admin_init(struct ena_com_dev *ena_dev,
 	if (unlikely(ret))
 		goto error;
 
-	admin_queue->ena_dev = ena_dev;
 	admin_queue->running_state = true;
 	admin_queue->is_missing_admin_interrupt = false;
 
@@ -2728,23 +2732,9 @@ int ena_com_set_dev_mtu(struct ena_com_dev *ena_dev, u32 mtu)
 	return ret;
 }
 
-int ena_com_get_offload_settings(struct ena_com_dev *ena_dev,
-				 struct ena_admin_feature_offload_desc *offload)
-{
-	int ret;
-	struct ena_admin_get_feat_resp resp;
 
-	ret = ena_com_get_feature(ena_dev, &resp,
-				  ENA_ADMIN_STATELESS_OFFLOAD_CONFIG, 0);
-	if (unlikely(ret)) {
-		ena_trc_err(ena_dev, "Failed to get offload capabilities %d\n", ret);
-		return ret;
-	}
 
-	memcpy(offload, &resp.u.offload, sizeof(resp.u.offload));
 
-	return 0;
-}
 
 int ena_com_set_hash_function(struct ena_com_dev *ena_dev)
 {
diff --git a/drivers/net/ena/base/ena_com.h b/drivers/net/ena/base/ena_com.h
index fbb0ea39ec..ce27e693c8 100644
--- a/drivers/net/ena/base/ena_com.h
+++ b/drivers/net/ena/base/ena_com.h
@@ -768,8 +768,6 @@ int ena_com_set_dev_mtu(struct ena_com_dev *ena_dev, u32 mtu);
  *
  * @return: 0 on Success and negative value otherwise.
  */
-int ena_com_get_offload_settings(struct ena_com_dev *ena_dev,
-				 struct ena_admin_feature_offload_desc *offload);
 
 /* ena_com_rss_init - Init RSS
  * @ena_dev: ENA communication layer struct
diff --git a/drivers/net/ena/base/ena_defs/ena_eth_io_defs.h b/drivers/net/ena/base/ena_defs/ena_eth_io_defs.h
index c93cd85632..4bbd1d0d9d 100644
--- a/drivers/net/ena/base/ena_defs/ena_eth_io_defs.h
+++ b/drivers/net/ena/base/ena_defs/ena_eth_io_defs.h
@@ -965,14 +965,15 @@ static inline void set_ena_eth_io_intr_reg_intr_unmask(struct ena_eth_io_intr_re
 	p->intr_control |= (val << ENA_ETH_IO_INTR_REG_INTR_UNMASK_SHIFT) & ENA_ETH_IO_INTR_REG_INTR_UNMASK_MASK;
 }
 
-static inline uint32_t get_ena_eth_io_intr_reg_no_mod_update(const struct ena_eth_io_intr_reg *p)
+static inline
+uint32_t get_ena_eth_io_intr_reg_no_moderation_update(const struct ena_eth_io_intr_reg *p)
 {
 	return (p->intr_control & ENA_ETH_IO_INTR_REG_NO_MODERATION_UPDATE_MASK) >>
 			ENA_ETH_IO_INTR_REG_NO_MODERATION_UPDATE_SHIFT;
 }
 
-static inline void set_ena_eth_io_intr_reg_no_mod_update(struct ena_eth_io_intr_reg *p,
-									     uint32_t val)
+static inline
+void set_ena_eth_io_intr_reg_no_moderation_update(struct ena_eth_io_intr_reg *p, uint32_t val)
 {
 	p->intr_control |= (val << ENA_ETH_IO_INTR_REG_NO_MODERATION_UPDATE_SHIFT) &
 			ENA_ETH_IO_INTR_REG_NO_MODERATION_UPDATE_MASK;
-- 
2.17.1

