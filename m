Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3524CCC6B16
	for <dpdk-dev@archiver.kernel.org>; Tue, 13 Oct 2026 15:09:25 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 323CA40612;
	Tue, 13 Oct 2026 17:09:24 +0200 (CEST)
Received: from pdx-out-002.esa.us-west-2.outbound.mail-perimeter.amazon.com
 (pdx-out-002.esa.us-west-2.outbound.mail-perimeter.amazon.com [44.246.1.125])
 by mails.dpdk.org (Postfix) with ESMTP id AE99A40272;
 Tue, 13 Oct 2026 17:09:22 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amazon.com; i=@amazon.com; q=dns/txt; s=amazoncorp2;
 t=1791904163; x=1823440163;
 h=from:to:cc:subject:date:message-id:mime-version;
 bh=+aNDsQBenbWddbevUaNrRVF7537GGlXZSbT88kswJKc=;
 b=EWbS1Qhr2/lDexYg4nnF+w2+T1olrKkTBKnTXXEJii7QMxsvNdgEjn5k
 V0089OkVDCtiWx1ZSZiZmMohYIvFGb6mjSC5IEs4JuXPIYC/Si6x/+jn2
 lcnnBxyVB0VcGfOL11iyrwB3mrGM6x5WHRgKKMBq7KVtUZyhCvn/2Qpjh
 c+DCoweI6da6Yt3jijAajnw9Uyz+zUX0H8QnCTAOpwPfG3DTRIr6vKxJt
 bG3ic410yMsdaPPnjRUZnP4ylSCpoo91UXjX9uiN9rqz/3+t0K95rhJnf
 VZWqT0BjIZr4eckByULpT9tNWH+ZrSPiwnYP6pltUt4v+iPVUAyr8FYkj g==;
X-CSE-ConnectionGUID: eNwRcOZAS6m28LFPkajtOA==
X-CSE-MsgGUID: WI0Qeqm9QbunywgVFViHoQ==
X-IronPort-AV: E=Sophos;i="6.27,155,1787011200"; d="scan'208";a="31142844"
Received: from ip-10-5-9-48.us-west-2.compute.internal (HELO
 smtpout.naws.us-west-2.prod.farcaster.email.amazon.dev) ([10.5.9.48])
 by internal-pdx-out-002.esa.us-west-2.outbound.mail-perimeter.amazon.com with
 ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Oct 2026 15:09:21 +0000
Received: from EX19MTAUWA002.ant.amazon.com [205.251.233.178:30880]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.1.91:2525] with
 esmtp (Farcaster)
 id 0f95d52b-7fb9-43a7-8a9d-bed82446c4e2; Tue, 13 Oct 2026 15:09:21 +0000 (UTC)
X-Farcaster-Flow-ID: 0f95d52b-7fb9-43a7-8a9d-bed82446c4e2
Received: from EX19D001UWA001.ant.amazon.com (10.13.138.214) by
 EX19MTAUWA002.ant.amazon.com (10.250.64.202) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.49;
 Tue, 13 Oct 2026 15:09:21 +0000
Received: from HFA15-CG15235BS.amazon.com (10.1.212.11) by
 EX19D001UWA001.ant.amazon.com (10.13.138.214) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.53;
 Tue, 13 Oct 2026 15:09:19 +0000
From: Shai Brandes <shaibran@amazon.com>
To: <stephen@networkplumber.org>
CC: <dev@dpdk.org>, Shai Brandes <shaibran@amazon.com>, <stable@dpdk.org>
Subject: [PATCH 06/13] net/ena/base: fix LLQ feature version sent to device
Date: Tue, 13 Oct 2026 18:09:06 +0300
Message-ID: <20261013150906.9531-1-shaibran@amazon.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.1.212.11]
X-ClientProxiedBy: EX19D031UWC003.ant.amazon.com (10.13.139.252) To
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
index 9a118394d2..d218026220 100644
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
index c4b4ea0620..e05933d6fe 100644
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

