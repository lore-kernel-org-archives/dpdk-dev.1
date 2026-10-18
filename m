Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 34E6DCCF2C4
	for <dpdk-dev@archiver.kernel.org>; Sun, 18 Oct 2026 06:38:59 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 65C9F40679;
	Sun, 18 Oct 2026 08:38:58 +0200 (CEST)
Received: from pdx-out-012.esa.us-west-2.outbound.mail-perimeter.amazon.com
 (pdx-out-012.esa.us-west-2.outbound.mail-perimeter.amazon.com
 [35.162.73.231])
 by mails.dpdk.org (Postfix) with ESMTP id 91B6940679;
 Sun, 18 Oct 2026 08:38:56 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amazon.com; i=@amazon.com; q=dns/txt; s=amazoncorp2;
 t=1792305537; x=1823841537;
 h=from:to:cc:subject:date:message-id:mime-version;
 bh=IRzamKK9yxhT3Lc0gjbcUXpHLamlJDCg0pGIfbmkikI=;
 b=raiJVOFIwCP+tfHXVJjNYSmD5hwuXWGIVsPcqOVfD9icl+ZzWXFs9paw
 OOv41/OFWuxUpUDHm9w9yQf2IByhcVCl9Lhvc9+yTn0nkIz+CaetS+KRt
 SpPebn1xAarugDF9RWVPDx5oKLYj2ztp3CO/4bAtseTbDz9XkttBOREd+
 J0E4aMtL67zm/poKT21iBJYaPna6VzoSrEFfOnyVTexsVJqM1tCDaIBa7
 fUDrg/sPbBKaFT7Ooj+8A4INJbnzG16IgIMfF1GKuwT9WQOQnt9fLTP5F
 7JHHTziQ+RBLxx1cn/CZxxn2szIOhRBJT90kUz1nR6Czx9hRPyJZHxceh Q==;
X-CSE-ConnectionGUID: R4Kor/CRSmmt0PPx//ETmw==
X-CSE-MsgGUID: nvA+5u29S8yEZWtk8+aqeA==
X-IronPort-AV: E=Sophos;i="6.27,165,1787011200"; d="scan'208";a="31366721"
Received: from ip-10-5-9-48.us-west-2.compute.internal (HELO
 smtpout.naws.us-west-2.prod.farcaster.email.amazon.dev) ([10.5.9.48])
 by internal-pdx-out-012.esa.us-west-2.outbound.mail-perimeter.amazon.com with
 ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Oct 2026 06:38:53 +0000
Received: from EX19MTAUWA002.ant.amazon.com [205.251.233.178:3135]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.11.104:2525]
 with esmtp (Farcaster)
 id f8ffc386-e8ee-4d5b-8de6-e915c68b419b; Sun, 18 Oct 2026 06:38:53 +0000 (UTC)
X-Farcaster-Flow-ID: f8ffc386-e8ee-4d5b-8de6-e915c68b419b
Received: from EX19D001UWA001.ant.amazon.com (10.13.138.214) by
 EX19MTAUWA002.ant.amazon.com (10.250.64.202) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.49;
 Sun, 18 Oct 2026 06:38:52 +0000
Received: from HFA15-CG15235BS.amazon.com (10.1.212.8) by
 EX19D001UWA001.ant.amazon.com (10.13.138.214) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.53;
 Sun, 18 Oct 2026 06:38:51 +0000
From: Shai Brandes <shaibran@amazon.com>
To: <stephen@networkplumber.org>
CC: <dev@dpdk.org>, Shai Brandes <shaibran@amazon.com>, <stable@dpdk.org>
Subject: [PATCH v2 06/13] net/ena/base: fix LLQ feature version sent to device
Date: Sun, 18 Oct 2026 09:38:42 +0300
Message-ID: <20261018063842.1263-1-shaibran@amazon.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.1.212.8]
X-ClientProxiedBy: EX19D031UWC001.ant.amazon.com (10.13.139.241) To
 EX19D001UWA001.ant.amazon.com (10.13.138.214)
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

During LLQ configuration the driver reads the supported LLQ
feature version from the device with a GET feature command, but
leaves the feature_version field zeroed in the subsequent SET
feature command.

The device therefore never learns which LLQ version the driver
negotiated, and falls back to interpreting the configuration
according to the base version regardless of what the driver
actually agreed to, which can lead to a Tx descriptor layout
mismatch between driver and device.

Store the feature version reported in the GET response and echo
it back in the SET command so the negotiated version is
communicated to the device.

Fixes: b68309be44c0 ("net/ena/base: update communication layer for the ENAv2")
Cc: stable@dpdk.org

Signed-off-by: Shai Brandes <shaibran@amazon.com>
---
 drivers/net/ena/base/ena_com.c | 4 ++++
 drivers/net/ena/base/ena_com.h | 1 +
 2 files changed, 5 insertions(+)

diff --git a/drivers/net/ena/base/ena_com.c b/drivers/net/ena/base/ena_com.c
index e9b9de21cb..d3f1063b6c 100644
--- a/drivers/net/ena/base/ena_com.c
+++ b/drivers/net/ena/base/ena_com.c
@@ -784,6 +784,8 @@ static int ena_com_set_llq(struct ena_com_dev *ena_dev)
 		BIT(ENA_ADMIN_DISABLE_META_CACHING) |
 		BIT(ENA_ADMIN_LIMIT_TX_BURST);
 
+	cmd.feat_common.feature_version = llq_info->feature_version;
+
 	ret = ena_com_execute_admin_command_no_resp(admin_queue,
 						    (struct ena_admin_aq_entry *)&cmd,
 						    sizeof(cmd));
@@ -805,6 +807,8 @@ static int ena_com_config_llq_info(struct ena_com_dev *ena_dev,
 
 	memset(llq_info, 0, sizeof(*llq_info));
 
+	llq_info->feature_version = llq_features->feature_version;
+
 	supported_feat = llq_features->header_location_ctrl_supported;
 
 	if (likely(supported_feat & llq_default_cfg->llq_header_location)) {
diff --git a/drivers/net/ena/base/ena_com.h b/drivers/net/ena/base/ena_com.h
index c62fecdef2..7884d0dfc3 100644
--- a/drivers/net/ena/base/ena_com.h
+++ b/drivers/net/ena/base/ena_com.h
@@ -93,6 +93,7 @@ struct ena_com_llq_info {
 	u16 descs_per_entry;
 	u16 max_entries_in_tx_burst;
 	bool disable_meta_caching;
+	u8 feature_version;
 };
 
 struct ena_com_io_cq {
-- 
2.17.1

