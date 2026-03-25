Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8D68A109C05C
	for <dpdk-dev@archiver.kernel.org>; Wed, 25 Mar 2026 20:47:33 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 636D3427E4;
	Wed, 25 Mar 2026 21:46:35 +0100 (CET)
Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com
 [209.85.128.47]) by mails.dpdk.org (Postfix) with ESMTP id 9853D42799
 for <dev@dpdk.org>; Wed, 25 Mar 2026 21:46:31 +0100 (CET)
Received: by mail-wm1-f47.google.com with SMTP id
 5b1f17b1804b1-486507134e4so3620035e9.0
 for <dev@dpdk.org>; Wed, 25 Mar 2026 13:46:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1774471591; x=1775076391; darn=dpdk.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:sender:from:to:cc:subject:date
 :message-id:reply-to;
 bh=T0iznYAtC1vqz8oIHZVm8QIYfoy9cZPbiaizTt8dcAQ=;
 b=nN4Vr+BjDcoUd8bl2IItb0uNuZ14Rd7u5sR9hgLzGGAxCPTXuHL+j1OziApyTO+Ay/
 OoNQqbU1Yr5fT5fxy26oiH5VErDQW6Ag+VmPiTIdN+0upG/N2WWv5Ie4LA+5qs7HuTpk
 Uqy/EfyqYHwuKb4VgWTLvbBuSKWJBnEZ/tnxVxRhaQ9/TKhOiSpfpCD6OxVfH4kS/mMs
 f8Yj/TlcGOgr4gpQx+UrSAn8vU/4I4LX8utU1Oghqu8EClLA4KUmr/K6GmkNm0RRFeKb
 1cAW/M/qAGj7WAQJwQHp/pIwpXLBn9U0v2H6eXdMBVZtagCSYIKCSRAzPTB/h03wV2Fm
 IU9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1774471591; x=1775076391;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:sender:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=T0iznYAtC1vqz8oIHZVm8QIYfoy9cZPbiaizTt8dcAQ=;
 b=J5JbrsIjWSfYQAjtgTrXumkxtdTTswhIuclnbCv52w/oms32TV57DkR1foIHUnVAyP
 rfpYBsagZHvubLuLm0/kFxydsDlR0J7GuCycM+MSiXwZkfk/yIDlKqa3HZck3jF6Usel
 JRmE19RNcUNz5sSBRphUVXnIjOQAE2YHiLnh4WP0CDrYJci5HrFoywE48tpyNTOqEVhw
 6M+YBSVla6HS/J+/uFbXua7/6t0lGr6UlQuvSFmEl7WpbUcax7eX9gQZkyS5TZ4hQqAs
 Dx9h1ZJUIBC1caNarsekaM/P8aU7jBsXICHUW7NOwJ0YBt6Frc0yNy0EN5Q2y3WFEQUz
 x/XA==
X-Gm-Message-State: AOJu0YwkwmcjvdHvniGDlvqlo3jtSd9Y3f9qJHV+qhLkI3eGlXYaw0t9
 RafEF1DgL84G/zc91p31veU+1G3D4AsMQTE5/aeppjCmVeo2MEpmckdy/br3Aw==
X-Gm-Gg: ATEYQzzQaaFFE+woNRX5IIqIKnHM9qebqEbUQxQ+42UXy70RPLoSTbYuJQsKPW2S1Xj
 K2RnsexHD940viRKjfCmA1CszzMf+yl8f2yMPQG2yAGDAMGA6I74uYexEIhgJUdLQuCYrNljGYY
 9rw8+IVt+XjXgDMo+/cmWliBL3y1SZRUa0UZcOguCYpTGM11eE6IrHN9JGgnCMVWvaFh6S0OnWr
 ESdmI7wtJqGF2BCxysy1fyWAYje4pJD0GKrjMev6WcFE4tuIq8yHti4IhCzIR2QsnrY8BZzVfRZ
 XgIrGKLLf7j68znq45COkRi19PNJjPRmFCCjnHC0RG17olzvU5rEIbJqJKXPFwOvT0B+LMtVZm3
 v/enc5DqnoikV7gegtQD0IUoZqectzrNcCeJr3N5GkQ8FCWGVLNGBg+utMT/0MWdA3KNa0IjX0J
 QBZm5YV9N+QZILbr1F
X-Received: by 2002:a05:600c:190e:b0:483:7903:c3b1 with SMTP id
 5b1f17b1804b1-4871604c856mr72955655e9.20.1774471591111; 
 Wed, 25 Mar 2026 13:46:31 -0700 (PDT)
Received: from freepad.. ([2a01:e0a:6f:bdf0:224a:2b64:3d43:500c])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4871fb333fbsm11420985e9.3.2026.03.25.13.46.30
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 25 Mar 2026 13:46:30 -0700 (PDT)
Sender: Maxime Leroy <maxime.leroys@gmail.com>
From: Maxime Leroy <maxime@leroys.fr>
To: dev@dpdk.org
Cc: hemant.agrawal@nxp.com, stephen@networkplumber.org,
 Maxime Leroy <maxime@leroys.fr>
Subject: [PATCH v4 17/17] net/dpaa2: add devargs alternative for data stashing
 getenv
Date: Wed, 25 Mar 2026 21:45:44 +0100
Message-ID: <20260325204544.101444-18-maxime@leroys.fr>
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

The DPAA2_DATA_STASHING_OFF environment variable is used by customers
to dynamically disable data stashing without rebuilding their
application. Add a devargs option "drv_no_data_stashing" as an
alternative, consistent with the existing devargs pattern (drv_loopback,
drv_no_prefetch, drv_no_taildrop), while keeping the getenv for
backward compatibility.

Move the check from dpaa2_dev_rx_queue_setup() to dpaa2_dev_init(),
consistent with how other driver flags are handled.

Signed-off-by: Maxime Leroy <maxime@leroys.fr>
Acked-by: Hemant Agrawal <hemant.agrawal@nxp.com>
---
 drivers/net/dpaa2/dpaa2_ethdev.c | 12 ++++++++++--
 drivers/net/dpaa2/dpaa2_ethdev.h |  3 +++
 2 files changed, 13 insertions(+), 2 deletions(-)

diff --git a/drivers/net/dpaa2/dpaa2_ethdev.c b/drivers/net/dpaa2/dpaa2_ethdev.c
index f128093d90..9cc81f7a47 100644
--- a/drivers/net/dpaa2/dpaa2_ethdev.c
+++ b/drivers/net/dpaa2/dpaa2_ethdev.c
@@ -35,6 +35,7 @@
 #define DRIVER_RX_PARSE_ERR_DROP "drv_rx_parse_drop"
 #define DRIVER_ERROR_QUEUE  "drv_err_queue"
 #define DRIVER_NO_TAILDROP  "drv_no_taildrop"
+#define DRIVER_NO_DATA_STASHING "drv_no_data_stashing"
 #define CHECK_INTERVAL         100  /* 100ms */
 #define MAX_REPEAT_TIME        90   /* 9s (90 * 100ms) in total */
 
@@ -931,7 +932,7 @@ dpaa2_dev_rx_queue_setup(struct rte_eth_dev *dev,
 		options |= DPNI_QUEUE_OPT_FLC;
 		cfg.flc.stash_control = true;
 		dpaa2_flc_stashing_clear_all(&cfg.flc.value);
-		if (getenv("DPAA2_DATA_STASHING_OFF")) {
+		if (priv->flags & DPAA2_DATA_STASHING_OFF) {
 			dpaa2_flc_stashing_set(DPAA2_FLC_DATA_STASHING, 0,
 				&cfg.flc.value);
 			dpaa2_q->data_stashing_off = 1;
@@ -2894,6 +2895,12 @@ dpaa2_dev_init(struct rte_eth_dev *eth_dev)
 		DPAA2_PMD_INFO("Rx taildrop disabled");
 	}
 
+	if (dpaa2_get_devargs(dev->devargs, DRIVER_NO_DATA_STASHING) ||
+	    getenv("DPAA2_DATA_STASHING_OFF")) {
+		priv->flags |= DPAA2_DATA_STASHING_OFF;
+		DPAA2_PMD_INFO("Data stashing disabled");
+	}
+
 	/* For secondary processes, the primary has done all the work */
 	if (rte_eal_process_type() != RTE_PROC_PRIMARY) {
 		/* In case of secondary, only burst and ops API need to be
@@ -3392,5 +3399,6 @@ RTE_PMD_REGISTER_PARAM_STRING(NET_DPAA2_PMD_DRIVER_NAME,
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

