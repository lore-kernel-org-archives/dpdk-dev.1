Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 49AECE9A047
	for <dpdk-dev@archiver.kernel.org>; Wed, 18 Feb 2026 16:05:21 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 3AF62402EF;
	Wed, 18 Feb 2026 17:05:05 +0100 (CET)
Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com
 [209.85.128.44]) by mails.dpdk.org (Postfix) with ESMTP id 5574240609
 for <dev@dpdk.org>; Wed, 18 Feb 2026 17:05:03 +0100 (CET)
Received: by mail-wm1-f44.google.com with SMTP id
 5b1f17b1804b1-4836f363d0dso48940375e9.3
 for <dev@dpdk.org>; Wed, 18 Feb 2026 08:05:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1771430703; x=1772035503; darn=dpdk.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:sender:from:to:cc:subject:date
 :message-id:reply-to;
 bh=FK6GhTUUD+GyqpqHuygwDQg7n8xU1Kc/qaJJXrVcoYI=;
 b=VPS96TUqwEJ726CDV/qr2FetjpZP4ULKcnGNp1CUSaP6z75LFaSXd3eOcpciw/xxY8
 Gs9pe7JnF96UUsFJuvThRY6kYwyffMwWCw7Z4NE3Q663AmdZ/FonYoAVUvZY37163CiT
 m0k/hiTUTsSeADF4v0xWuj0/nJT93L7uQvxA164DZ6DSEs6XRvzZ35OCVRAQpCa7jZaJ
 0/c8r9VpdtPccJB5jcBFaCZoD1nRvOX8zruNmG7vKI2P1HAS8sz7QztigOeu0vLu+IdP
 TooV2P73pnimKyHMTY8khRj8a6TcWih4PByTp4tDS9Zj5JuNK6GQk5q4sQI719VH7fbl
 uhCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1771430703; x=1772035503;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:sender:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=FK6GhTUUD+GyqpqHuygwDQg7n8xU1Kc/qaJJXrVcoYI=;
 b=l5BPkKMEfbr2WbWKt/Q6/YXA7E6jgT6i8mcI7MPY8dTF+LnATvfyN67dJpwdcqGXzR
 p1+pvf014FXuVevJzI+Fc1daN5/Aeh+IIR2d9s0DDPOe9kgUpHWfJ9yWpFwQG2InRCKy
 2wuiEGmxEfcNnSsAImP9/XsV4oCMgs6QL0aEol7H3x2hW7Q5kP7kI8xI+tge7ajsfh5a
 M/I08NZWvbtW0t7NM7MWjBB0cygQM4zXl9sFx2WemMx53FRwAxSEXWNOM6mUYNsryvoM
 U3fytwf2ft3/qkEiR02uLnl9xHm04ZCzxXruvlh39rkZg7F7wkF5vmkYDCPJa4p3PKUV
 ArsA==
X-Gm-Message-State: AOJu0Yx2dFS5xKhDEZPMq3JMavBS78XoGoj+rEwkLt0c0q9wXI+tUhk/
 PLtIBXedmjPqlly+1SHqwRuvDEgY8IHdc1MpRAd/kEstn5axBJFKGe5g
X-Gm-Gg: AZuq6aIXg05QN+YOPOYd9bqltX+Y9oMbE5N1xAalszu8pV8a2rKb0kYWG7r21g1eDEG
 ZLcYXWDRcQWZeDt5kWbx+iUa4E0TJvsgQVIAN/yHbLhgYVnhQGL9whR8mxE+TZv1FokJLg2Sxay
 idkjyR3SQxJ+rtHkhw7KhlK/GZsWR6EAHNXKZfj7n81wg+yHmaP6CCAseIVrWIa56bNfm4C5SO5
 WrOfLsMYShRSFshNGGSpLeJc/SOCY9VXIVY6Qa1lnHXXy3yCXSLHmkZGgeB2atap5el/rFboTHe
 Vdljr9+ZCe3BfU/eP4hB8ZRhhGtJZbeZdu+zDp/ZsjtEU1bzK1x7IUFf/HgAKuVLPsuHNJ9mJmO
 JM52htF30nAGfzx2xeiTyjYRg4UWZ4QytMwua5P4rAYO5xRZGEE6QZ/qgaCIuS2T73MaQ0L6W5F
 iY5ipvrEWEylamxMP7Y7NwaACgLQ==
X-Received: by 2002:a05:600c:c3cc:10b0:483:8f0f:36fe with SMTP id
 5b1f17b1804b1-4838f0f371bmr94811175e9.1.1771430702696; 
 Wed, 18 Feb 2026 08:05:02 -0800 (PST)
Received: from freepad.iliad.local ([213.36.9.41])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4835dd0e327sm604619175e9.14.2026.02.18.08.05.01
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 18 Feb 2026 08:05:01 -0800 (PST)
Sender: Maxime Leroy <maxime.leroys@gmail.com>
From: Maxime Leroy <maxime@leroys.fr>
To: hemant.agrawal@nxp.com
Cc: dev@dpdk.org,
	Maxime Leroy <maxime@leroys.fr>
Subject: [PATCH 03/11] net/dpaa2: warn on rx descriptor limit only in high
 perf buffer mode
Date: Wed, 18 Feb 2026 17:04:45 +0100
Message-ID: <20260218160453.142311-4-maxime@leroys.fr>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260218160453.142311-1-maxime@leroys.fr>
References: <20260218160453.142311-1-maxime@leroys.fr>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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

The Rx descriptor count warning fires unconditionally when the total
exceeds 11264, but this limit only applies when the DPNI is created
with the high performance buffer option (0x80000000). When using normal
buffers, there is no such limit and the warning is
misleading noise.

Check the DPNI options to only warn when the high performance buffer
mode is active.

Fixes: 35dc25d12792 ("net/dpaa2: warn on high Rx descriptor number")
Signed-off-by: Maxime Leroy <maxime@leroys.fr>
---
 drivers/net/dpaa2/dpaa2_ethdev.c | 18 +++++++++++-------
 drivers/net/dpaa2/mc/fsl_dpni.h  |  6 ++++++
 2 files changed, 17 insertions(+), 7 deletions(-)

diff --git a/drivers/net/dpaa2/dpaa2_ethdev.c b/drivers/net/dpaa2/dpaa2_ethdev.c
index b75b934b17..088a07eba5 100644
--- a/drivers/net/dpaa2/dpaa2_ethdev.c
+++ b/drivers/net/dpaa2/dpaa2_ethdev.c
@@ -74,8 +74,9 @@ int dpaa2_timestamp_dynfield_offset = -1;
 
 bool dpaa2_print_parser_result;
 
+/* Rx descriptor limit when DPNI uses high performance buffers */
 #define MAX_NB_RX_DESC		11264
-int total_nb_rx_desc;
+static int total_nb_rx_desc;
 
 int dpaa2_valid_dev;
 struct rte_mempool *dpaa2_tx_sg_pool;
@@ -902,11 +903,13 @@ dpaa2_dev_rx_queue_setup(struct rte_eth_dev *dev,
 	DPAA2_PMD_DEBUG("dev =%p, queue =%d, pool = %p, conf =%p",
 			dev, rx_queue_id, mb_pool, rx_conf);
 
-	total_nb_rx_desc += nb_rx_desc;
-	if (total_nb_rx_desc > MAX_NB_RX_DESC) {
-		DPAA2_PMD_WARN("Total nb_rx_desc exceeds %d limit. Please use Normal buffers",
-			       MAX_NB_RX_DESC);
-		DPAA2_PMD_WARN("To use Normal buffers, run 'export DPNI_NORMAL_BUF=1' before running dynamic_dpl.sh script");
+	if (priv->options & DPNI_OPT_HIGH_PERF_BUFFER) {
+		total_nb_rx_desc += nb_rx_desc;
+		if (total_nb_rx_desc > MAX_NB_RX_DESC) {
+			DPAA2_PMD_WARN("Total nb_rx_desc exceeds %d limit. Please use Normal buffers",
+				       MAX_NB_RX_DESC);
+			DPAA2_PMD_WARN("To use Normal buffers, run 'export DPNI_NORMAL_BUF=1' before running dynamic_dpl.sh script");
+		}
 	}
 
 	if (!priv->bp_list || priv->bp_list->mp != mb_pool) {
@@ -1211,7 +1214,8 @@ dpaa2_dev_rx_queue_release(struct rte_eth_dev *dev, uint16_t rx_queue_id)
 	memset(&cfg, 0, sizeof(struct dpni_queue));
 	PMD_INIT_FUNC_TRACE();
 
-	total_nb_rx_desc -= dpaa2_q->nb_desc;
+	if (priv->options & DPNI_OPT_HIGH_PERF_BUFFER)
+		total_nb_rx_desc -= dpaa2_q->nb_desc;
 
 	if (dpaa2_q->cgid != DPAA2_INVALID_CGID) {
 		options = DPNI_QUEUE_OPT_CLEAR_CGID;
diff --git a/drivers/net/dpaa2/mc/fsl_dpni.h b/drivers/net/dpaa2/mc/fsl_dpni.h
index fcc6d4726e..82d6830acc 100644
--- a/drivers/net/dpaa2/mc/fsl_dpni.h
+++ b/drivers/net/dpaa2/mc/fsl_dpni.h
@@ -121,6 +121,12 @@ struct fsl_mc_io;
  * The stashing is enabled by default.
  */
 #define DPNI_OPT_STASHING_DIS			0x002000
+/*
+ * High performance buffer mode.
+ * The total number of Rx descriptors is limited to 11264 in this mode.
+ * When not set, the DPNI uses normal buffers and has no such limit.
+ */
+#define DPNI_OPT_HIGH_PERF_BUFFER		0x80000000
 /**
  * Software sequence maximum layout size
  */
-- 
2.43.0

