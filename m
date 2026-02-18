Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AF0DBE9A02C
	for <dpdk-dev@archiver.kernel.org>; Wed, 18 Feb 2026 16:05:50 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 18F9C4066C;
	Wed, 18 Feb 2026 17:05:12 +0100 (CET)
Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com
 [209.85.128.51]) by mails.dpdk.org (Postfix) with ESMTP id 6A5A040651
 for <dev@dpdk.org>; Wed, 18 Feb 2026 17:05:08 +0100 (CET)
Received: by mail-wm1-f51.google.com with SMTP id
 5b1f17b1804b1-4836d4c26d3so39999005e9.2
 for <dev@dpdk.org>; Wed, 18 Feb 2026 08:05:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1771430708; x=1772035508; darn=dpdk.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:sender:from:to:cc:subject:date
 :message-id:reply-to;
 bh=l3rNN3/IUXn93+GvPyrUhe3coHV8kr4qmyHTtRlag9M=;
 b=SwkVLH1npsvmG3GRtRoIxD0pYUyvk79+iw7JYnGezrE+T14eBkm463FdHb0glV0Wcd
 rqcSltBp4F1tKxI1N4M5ccOiaccl0r4rzFCaty5R2V60zryhWPaIEYIm3s/LaCERNUbA
 bApaZxehWbFiPbfk3t10p7r7cDOzRkYGmO3yBo9HG6t8/e9YIDANljW5LHAIuUeeDbU/
 xKlWoweYAVoRX+dXdMTKqABe/SkGy6B8TmminWmdp29TZEbzK8t8jgJ3LzsxCRU263db
 eXjOGm7HNbPkNG084kwL6AJAOO6aos+7eBIyuKfKYXZBtMROaJw0VkFlQvaH9ASmOOcb
 nKjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1771430708; x=1772035508;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:sender:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=l3rNN3/IUXn93+GvPyrUhe3coHV8kr4qmyHTtRlag9M=;
 b=iy+a1S3y1W+kBPeS2s0Gvfx0M3OhNcDGkEiPUoFYxkxOffRp87MOD+kCXxlYB3xalV
 pWO/oFFtPL33UWZ86WqISu4wM3qjUcw/ZwaABM7xYG/2ykqpe9p4Q3EHAXlaNiT4zvFi
 z0R745eCkmuE/pdaGShIfc2p/YHRX2v3mQd2iM+Q1PjYgo2uVYFKRO+JrbwyAjdXpial
 BVJ9xpq1pdlrstqaD5S2JOplyxvbu+ZS5JArjnWsy+JoqAAV/sIzt7AE8nUR4g3sdcph
 Wv9U21briVv6eaAco38xhzMeGo6xFDPzbWVkzV14Sg+pSREEmXjMaQ6cRtI2oHkPout7
 LD0Q==
X-Gm-Message-State: AOJu0YzcO013qLOidpilSI4FR+adw1otSGH6xU/lJ+aZ/erSlTclkqeR
 GGONFJYzd5gNtvj+KVxhdMA38h2sZYuyJx3py0yzZZZLGxTr9xVRl8qm
X-Gm-Gg: AZuq6aKe/x75RyjNPtuyQnuDrJjR1j1DmMRfg1ButsmyKFOAYyx3fNier+YuxBOz48q
 vZAVKdRIm84qjDt/U8YTZZvtg5vXvTtryyEPZMLHU5tvGcTw1v/aru8mK0Wp5tXJQj7DyX0H764
 tNnpVYTBxl/IBYWvO0xvLf3Jisyn/D63QvLrPWXNaOWizLz3C/dckR+pQPzRsNBTrME8PWZvkEX
 j/0sAfySLtTMPWvBHvKWWuCFPaupXPUYPFq1h7hDdBnNBMaaEiBICYlDI9oQwY8Ynsvke7b6Ywj
 0isgqqOBH0jzJvyF3uXrqS6IGvu7NPp2mPfRG/x/YbQtxZ3xEInFPQAAVVjM1bY+6sqbAeFRvSv
 bWvMjOTlBU56xiW2ggeAkYjCPGoCm1CRCeUnj9aQ+29qQ4zCS28vjfzZ49+BiB6bVnAMxtLbOa3
 YnYqJX8sp/apkPTKS5olK+4eK4Yw==
X-Received: by 2002:a05:600c:1986:b0:483:71f9:37f3 with SMTP id
 5b1f17b1804b1-483739ff8cdmr323283775e9.1.1771430707730; 
 Wed, 18 Feb 2026 08:05:07 -0800 (PST)
Received: from freepad.iliad.local ([213.36.9.41])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4835dd0e327sm604619175e9.14.2026.02.18.08.05.07
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 18 Feb 2026 08:05:07 -0800 (PST)
Sender: Maxime Leroy <maxime.leroys@gmail.com>
From: Maxime Leroy <maxime@leroys.fr>
To: hemant.agrawal@nxp.com
Cc: dev@dpdk.org,
	Maxime Leroy <maxime@leroys.fr>
Subject: [PATCH 07/11] net/dpaa2: replace data stashing getenv with devargs
Date: Wed, 18 Feb 2026 17:04:49 +0100
Message-ID: <20260218160453.142311-8-maxime@leroys.fr>
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

Replace the getenv("DPAA2_DATA_STASHING_OFF") call with a proper
devargs option "drv_no_data_stashing", aligned with the existing
DPDK devargs pattern used by drv_loopback, drv_no_prefetch, etc.

  fslmc:dpni.1,drv_no_data_stashing=1

Fixes: c794f2cab6cc ("net/dpaa2: support FLC stashing")
Signed-off-by: Maxime Leroy <maxime@leroys.fr>
---
 drivers/net/dpaa2/dpaa2_ethdev.c | 11 +++++++++--
 drivers/net/dpaa2/dpaa2_ethdev.h |  3 +++
 2 files changed, 12 insertions(+), 2 deletions(-)

diff --git a/drivers/net/dpaa2/dpaa2_ethdev.c b/drivers/net/dpaa2/dpaa2_ethdev.c
index 578ad98b8e..0a68365de2 100644
--- a/drivers/net/dpaa2/dpaa2_ethdev.c
+++ b/drivers/net/dpaa2/dpaa2_ethdev.c
@@ -35,6 +35,7 @@
 #define DRIVER_RX_PARSE_ERR_DROP "drv_rx_parse_drop"
 #define DRIVER_ERROR_QUEUE  "drv_err_queue"
 #define DRIVER_NO_TAILDROP  "drv_no_taildrop"
+#define DRIVER_NO_DATA_STASHING "drv_no_data_stashing"
 #define CHECK_INTERVAL         100  /* 100ms */
 #define MAX_REPEAT_TIME        90   /* 9s (90 * 100ms) in total */
 
@@ -961,7 +962,7 @@ dpaa2_dev_rx_queue_setup(struct rte_eth_dev *dev,
 		options |= DPNI_QUEUE_OPT_FLC;
 		cfg.flc.stash_control = true;
 		dpaa2_flc_stashing_clear_all(&cfg.flc.value);
-		if (getenv("DPAA2_DATA_STASHING_OFF")) {
+		if (priv->flags & DPAA2_DATA_STASHING_OFF) {
 			dpaa2_flc_stashing_set(DPAA2_FLC_DATA_STASHING, 0,
 				&cfg.flc.value);
 			dpaa2_q->data_stashing_off = 1;
@@ -2938,6 +2939,11 @@ dpaa2_dev_init(struct rte_eth_dev *eth_dev)
 		DPAA2_PMD_INFO("Rx taildrop disabled");
 	}
 
+	if (dpaa2_get_devargs(dev->devargs, DRIVER_NO_DATA_STASHING)) {
+		priv->flags |= DPAA2_DATA_STASHING_OFF;
+		DPAA2_PMD_INFO("Data stashing disabled");
+	}
+
 	/* For secondary processes, the primary has done all the work */
 	if (rte_eal_process_type() != RTE_PROC_PRIMARY) {
 		/* In case of secondary, only burst and ops API need to be
@@ -3425,5 +3431,6 @@ RTE_PMD_REGISTER_PARAM_STRING(NET_DPAA2_PMD_DRIVER_NAME,
 		DRIVER_TX_CONF "=<int>"
 		DRIVER_RX_PARSE_ERR_DROP "=<int>"
 		DRIVER_ERROR_QUEUE "=<int>"
-		DRIVER_NO_TAILDROP "=<int>");
+		DRIVER_NO_TAILDROP "=<int>"
+		DRIVER_NO_DATA_STASHING "=<int>");
 RTE_LOG_REGISTER_DEFAULT(dpaa2_logtype_pmd, NOTICE);
diff --git a/drivers/net/dpaa2/dpaa2_ethdev.h b/drivers/net/dpaa2/dpaa2_ethdev.h
index 86b3022ddb..4da47a543a 100644
--- a/drivers/net/dpaa2/dpaa2_ethdev.h
+++ b/drivers/net/dpaa2/dpaa2_ethdev.h
@@ -97,6 +97,9 @@
  */
 #define DPAA2_TX_DYNAMIC_CONF_ENABLE	RTE_BIT32(9)
 
+/* Disable data stashing (prefetch of packet data into CPU cache) */
+#define DPAA2_DATA_STASHING_OFF		RTE_BIT32(10)
+
 #define DPAAX_RX_ERROR_QUEUE_FLAG	RTE_BIT32(11)
 
 /* DPDMUX index for DPMAC */
-- 
2.43.0

