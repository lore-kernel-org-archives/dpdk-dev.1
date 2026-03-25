Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9FE30106B504
	for <dpdk-dev@archiver.kernel.org>; Wed, 25 Mar 2026 20:46:12 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 8036C4279A;
	Wed, 25 Mar 2026 21:46:03 +0100 (CET)
Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com
 [209.85.128.44]) by mails.dpdk.org (Postfix) with ESMTP id 0FF8542790
 for <dev@dpdk.org>; Wed, 25 Mar 2026 21:46:00 +0100 (CET)
Received: by mail-wm1-f44.google.com with SMTP id
 5b1f17b1804b1-486fba7ce4cso2977315e9.3
 for <dev@dpdk.org>; Wed, 25 Mar 2026 13:46:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1774471560; x=1775076360; darn=dpdk.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:sender:from:to:cc:subject:date
 :message-id:reply-to;
 bh=W8H59IU+bOO0iW3oM52TFVwmT1nEZNJ68bNXPPVohg8=;
 b=bnRoUh7Ju5JtbiS/u7ojoTnyX0/Je30DAAl6o37N2fEVf5HLRyyKOZbaZEAuL08qCs
 0MumHZXSBd4L0G/1fOVfvJCndcKSWf2hn3IyPk+xeDn7E7LX/9MlK9CLjkEFviMuvD4D
 ENzknSgvJwzAiCVDVcrZWUr/iS8fyYAQfSwraFf6+enIKa2AoGsYS5XYqA4KS+l8zqJH
 EXyQV0k3RrgPwiB3TRxhEfOklfwSc8wkTY6OYtS1js8h12MbujMxUtA/kdUCzaoOJjkc
 2LO5IWSqQL6RGRBqSx90H1dku6yj9DGPz6so0KORuyecWkq+r6DmHFb/KhANU+JgEHZt
 57Iw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1774471560; x=1775076360;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:sender:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=W8H59IU+bOO0iW3oM52TFVwmT1nEZNJ68bNXPPVohg8=;
 b=mglWkXVDI7Pjh25wpwWYFl+84lBt/dD5JoxP9jVnEwJNfzcFPuUZXzBoJq3VcHyXBQ
 Sr/IPOUnAAS5Z95zvRGlH8vr9sk2+LCuYrXrEfFKFMEXwfpGvplIX+kBKsOaW90/lDSu
 w/V3n1XuxJ0GoGKacPnJBY7Ita4J/aeeKHSm0FNz1CK+pdVBOOucDdYd62EiPsJ7Nd5P
 1wro12M4X4s4V1kQRKGc5Um4j0vX06OdkVPKdjb84Wj9Wj/AEkEtojpESK8ppKVHvkHZ
 E0yAKK1Yehh1ZnWNGdT2JkVjHOB6zhopCxzU/HkXzp3cWWin/iHrn1A/+MQ3myIjoYjD
 WTmg==
X-Gm-Message-State: AOJu0Yy9FojIH3cJE//+wYp9HM72g5RyF6c6QAatEeSvaIUPSl/8LIiJ
 BdFYe8T4P80hPaqyObMaL+pvSNFE/QQmgzsDmOntdUH72QMtOahx2eoaP+1yrNCP
X-Gm-Gg: ATEYQzzDx4jmphNtSTm+Hg+ZrMEVbNnd3b65PWnzbnA/T77BXP+Wsz8hvXFBjRps9n1
 hncM+W9LJrZEbupq4CC2ly+xQi48AY8ZFDxWW5/x9yfeIygLhRbKphOvukPT9tkf852EffyVjuA
 OxoUbrwO4fXglfzkZ0KFLhkkmnJAO222JHQxGC0TJOgKbgXxJRa+beHsCDfZN9iSKQPmVZRgYir
 J9iTNx92OHp5IllrmpUrQmuo6PeAOeq+mP33hE9Oa8il56kQ0qvrCbYFoX3Sdmg9s1FgJXPrAfl
 RutZCxVUbcskZtK6iISu6h3CjkLVEx8nKwWffZ53GnDoJzjc+X1ZLMB01xGGm59/r089ZZHv62g
 EK3j8x2L8Dn/sMU9NgGQp3DvpxYKHg5jfankOrRgSrs/EvSWDUzxdsrN2UiLr22zIqQNiGhObZu
 Mn83rcLDoFSIq3p3+A
X-Received: by 2002:a05:600c:1548:b0:487:716:2fa9 with SMTP id
 5b1f17b1804b1-48715ff7a16mr82257695e9.13.1774471559557; 
 Wed, 25 Mar 2026 13:45:59 -0700 (PDT)
Received: from freepad.. ([2a01:e0a:6f:bdf0:224a:2b64:3d43:500c])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-43b919dfb54sm2557445f8f.31.2026.03.25.13.45.58
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 25 Mar 2026 13:45:59 -0700 (PDT)
Sender: Maxime Leroy <maxime.leroys@gmail.com>
From: Maxime Leroy <maxime@leroys.fr>
To: dev@dpdk.org
Cc: hemant.agrawal@nxp.com, stephen@networkplumber.org,
 Maxime Leroy <maxime@leroys.fr>, stable@dpdk.org
Subject: [PATCH v4 03/17] net/dpaa2: warn on Rx descriptor limit in high perf
 mode
Date: Wed, 25 Mar 2026 21:45:30 +0100
Message-ID: <20260325204544.101444-4-maxime@leroys.fr>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260325204544.101444-1-maxime@leroys.fr>
References: <20260306133035.179709-1-maxime@leroys.fr>
 <20260325204544.101444-1-maxime@leroys.fr>
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
Cc: stable@dpdk.org

Signed-off-by: Maxime Leroy <maxime@leroys.fr>
Acked-by: Hemant Agrawal <hemant.agrawal@nxp.com>
---
 drivers/net/dpaa2/dpaa2_ethdev.c | 17 +++++++++++------
 drivers/net/dpaa2/mc/fsl_dpni.h  |  6 ++++++
 2 files changed, 17 insertions(+), 6 deletions(-)

diff --git a/drivers/net/dpaa2/dpaa2_ethdev.c b/drivers/net/dpaa2/dpaa2_ethdev.c
index eb8333458e..605c75ad70 100644
--- a/drivers/net/dpaa2/dpaa2_ethdev.c
+++ b/drivers/net/dpaa2/dpaa2_ethdev.c
@@ -74,8 +74,9 @@ int dpaa2_timestamp_dynfield_offset = -1;
 
 bool dpaa2_print_parser_result;
 
-#define MAX_NB_RX_DESC		11264
-int total_nb_rx_desc;
+/* Rx descriptor limit when DPNI loads PFDRs in PEB */
+#define MAX_NB_RX_DESC_IN_PEB	11264
+static int total_nb_rx_desc;
 
 int dpaa2_valid_dev;
 struct rte_mempool *dpaa2_tx_sg_pool;
@@ -905,10 +906,14 @@ dpaa2_dev_rx_queue_setup(struct rte_eth_dev *dev,
 			dev, rx_queue_id, mb_pool, rx_conf);
 
 	total_nb_rx_desc += nb_rx_desc;
-	if (total_nb_rx_desc > MAX_NB_RX_DESC) {
-		DPAA2_PMD_WARN("Total nb_rx_desc exceeds %d limit. Please use Normal buffers",
-			       MAX_NB_RX_DESC);
-		DPAA2_PMD_WARN("To use Normal buffers, run 'export DPNI_NORMAL_BUF=1' before running dynamic_dpl.sh script");
+	if (total_nb_rx_desc > MAX_NB_RX_DESC_IN_PEB &&
+	    (priv->options & DPNI_OPT_V1_PFDR_IN_PEB)) {
+		DPAA2_PMD_WARN("RX descriptor exceeds limit(%d) to load PFDR in PEB",
+			       MAX_NB_RX_DESC_IN_PEB);
+		DPAA2_PMD_WARN("Suggest removing 0x%08x from DPNI creating options(0x%08x)",
+			       DPNI_OPT_V1_PFDR_IN_PEB, priv->options);
+		DPAA2_PMD_WARN("Or reduce RX descriptor number(%d) per queue",
+			       nb_rx_desc);
 	}
 
 	if (!priv->bp_list || priv->bp_list->mp != mb_pool) {
diff --git a/drivers/net/dpaa2/mc/fsl_dpni.h b/drivers/net/dpaa2/mc/fsl_dpni.h
index fcc6d4726e..42d633eaf8 100644
--- a/drivers/net/dpaa2/mc/fsl_dpni.h
+++ b/drivers/net/dpaa2/mc/fsl_dpni.h
@@ -121,6 +121,12 @@ struct fsl_mc_io;
  * The stashing is enabled by default.
  */
 #define DPNI_OPT_STASHING_DIS			0x002000
+/*
+ * PFDR in PEB mode (v1 layout).
+ * The total number of Rx descriptors is limited to 11264 in this mode.
+ * When not set, PFDRs are stored in DDR and there is no such limit.
+ */
+#define DPNI_OPT_V1_PFDR_IN_PEB		0x80000000
 /**
  * Software sequence maximum layout size
  */
-- 
2.43.0

