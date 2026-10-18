Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 06695CCF2C9
	for <dpdk-dev@archiver.kernel.org>; Sun, 18 Oct 2026 09:51:20 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 39CA840693;
	Sun, 18 Oct 2026 11:51:20 +0200 (CEST)
Received: from pdx-out-001.esa.us-west-2.outbound.mail-perimeter.amazon.com
 (pdx-out-001.esa.us-west-2.outbound.mail-perimeter.amazon.com
 [44.245.243.92])
 by mails.dpdk.org (Postfix) with ESMTP id 75C9640276;
 Sun, 18 Oct 2026 11:51:18 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amazon.com; i=@amazon.com; q=dns/txt; s=amazoncorp2;
 t=1792317078; x=1823853078;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version;
 bh=IRzamKK9yxhT3Lc0gjbcUXpHLamlJDCg0pGIfbmkikI=;
 b=LfI4XOb6O5ud7HkHgciZlNqW5m5xYZejNtQfATvBg4vwb1IC8yYuzYvb
 bDdiBF1I0fEgpGNcVZDjZiYznZyhaWXo4KdwMIILGrLzL0GUmWmNNS2r4
 IAYMhvNw6o32rHTxCGgpKBWTnnlk4j1ZlXWQ7rilW/qDR44S29s2Ej7x7
 f01TevcF9Hu99gFHSfXztoE4dLgEwW+C1aqyOWARVSKh/Z0O3Ly0kMPzl
 hz01PE5R+ao8WL4/45Lkl3gK3WGQhiRGi8MUv7SmGKHI3030Far3Vjk1F
 RvSC33FEa3A6I4119G58QA3lO+LYJWZ0OT1BNRKZx+jyGeC7tVpeYGDg1 Q==;
X-CSE-ConnectionGUID: qn3X/r0FQI+isKPUuBVYCw==
X-CSE-MsgGUID: M+CQ0YEiQPy6tAYhDdg2JA==
X-IronPort-AV: E=Sophos;i="6.27,165,1787011200"; d="scan'208";a="31076689"
Received: from ip-10-5-12-219.us-west-2.compute.internal (HELO
 smtpout.naws.us-west-2.prod.farcaster.email.amazon.dev) ([10.5.12.219])
 by internal-pdx-out-001.esa.us-west-2.outbound.mail-perimeter.amazon.com with
 ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Oct 2026 09:51:15 +0000
Received: from EX19MTAUWC001.ant.amazon.com [205.251.233.53:11542]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.22.5:2525] with
 esmtp (Farcaster)
 id 075e7594-b818-4def-8bc6-e4b40cf331b4; Sun, 18 Oct 2026 09:51:15 +0000 (UTC)
X-Farcaster-Flow-ID: 075e7594-b818-4def-8bc6-e4b40cf331b4
Received: from EX19D001UWA001.ant.amazon.com (10.13.138.214) by
 EX19MTAUWC001.ant.amazon.com (10.250.64.174) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.49;
 Sun, 18 Oct 2026 09:51:14 +0000
Received: from HFA15-CG15235BS.amazon.com (10.1.212.8) by
 EX19D001UWA001.ant.amazon.com (10.13.138.214) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.53;
 Sun, 18 Oct 2026 09:51:13 +0000
From: Shai Brandes <shaibran@amazon.com>
To: <stephen@networkplumber.org>
CC: <dev@dpdk.org>, Shai Brandes <shaibran@amazon.com>, <stable@dpdk.org>
Subject: [PATCH v3 06/13] net/ena/base: fix LLQ feature version sent to device
Date: Sun, 18 Oct 2026 12:51:04 +0300
Message-ID: <77d5d73d0a172a5d0023174bfb0f052e600593c3.1792312030.git.shaibran@amazon.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <cover.1792312029.git.shaibran@amazon.com>
References: <20261018063606.973-1-shaibran@amazon.com>
 <cover.1792312029.git.shaibran@amazon.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.1.212.8]
X-ClientProxiedBy: EX19D031UWC004.ant.amazon.com (10.13.139.246) To
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

