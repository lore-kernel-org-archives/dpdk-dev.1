Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 72779F01832
	for <dpdk-dev@archiver.kernel.org>; Fri,  6 Mar 2026 13:33:01 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id DC5C1427A1;
	Fri,  6 Mar 2026 14:31:23 +0100 (CET)
Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com
 [209.85.128.50]) by mails.dpdk.org (Postfix) with ESMTP id BD7B340262
 for <dev@dpdk.org>; Fri,  6 Mar 2026 14:31:22 +0100 (CET)
Received: by mail-wm1-f50.google.com with SMTP id
 5b1f17b1804b1-4836f4cbe0bso80365345e9.3
 for <dev@dpdk.org>; Fri, 06 Mar 2026 05:31:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1772803882; x=1773408682; darn=dpdk.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:sender:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ZNU24GAWD7EikpQ1S8iv4Qhop5VXf7mgFDcQDlJMdrA=;
 b=m5+PkIoAZkXq26UTfAGPQWnT7R0Wh1bqtdBI8vONyVccTj3pFv05ym1MC2pgV5rhHY
 nhZ1VQK39TI8qwH9cvO/UrAPghd8LXSqs0rVQpFfTU+eGIMZyIxZYihdK3DXhp4sQveq
 QraRBUr5P0kXIICPjRd00jN0/PslMwtgCWit9dexWtkauJke7+tPWesLAlTptVwMzryb
 wwdtImegKAgaeFhtnq8wR8sVkKIl4LdUISBEtlOqR65vFJKxDPvePcjyHOCJuSbqimMv
 gnHcbTAHHxZohxNT020zuwQD7foEGJw5cU5Nxu+TBvFwfA6pvsPTWSaj0D8BJHiYRZye
 vveQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1772803882; x=1773408682;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:sender:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=ZNU24GAWD7EikpQ1S8iv4Qhop5VXf7mgFDcQDlJMdrA=;
 b=TXO7Qne0yvlwUohCtjUB31Oxw1qYLmtwO8pUVJh2rHGLZWREQ/w+HEb/dZaG84M/Lb
 bOY81zRh5Ot64bO+9rwzyBSzmcw9fAkQTFXrz6g/09GRFx/AnlpcoBLVJdp5RZMktBeW
 PCZpuz/O0HlQjshVkWm5NTnrzjmqc3u7PCj0iSeRih+Q6rwWP/s8nXJ4u01t0I8C9CII
 miirwFF4zkQup1JJZ6O1fnZ91TPUxyI48MqWshdSPvhK07qGTCOQtTqkBmH8F7xdFEQN
 qvc+sFrt2jXVzZ83Sq49SgJbSehH92SqlxBtgO70fHisU1sEGZVGa8+mmGSHJpw8FESQ
 Hugg==
X-Gm-Message-State: AOJu0YzS2BXEOP1x7ELf/RuhpWQqrm2wsokxLBi12AzP2GAyKLPwXdEw
 fu2lsFehrRf1gmCaxRqXjU4c9Fr9VKiC8x+ZYG5dK1pfVVUkdyasu29CEUupxc/g
X-Gm-Gg: ATEYQzzEah5Cp2cNqztopxOJE1Pal1nkmj94XoHWA6RBVvoNVJcAMip+TDzCx0Irw3v
 BpX+PBqV5Ni/0LMHR81TjbHlS78C5+JzeoqMBnpu+mmwqABZgLLthOH66VT/i6EqNoviOS9uO7f
 6Dq2sx3kUbuLl46aqT/OxxcUs1MSOxEiQFQKeu8rnk5ec7a41+EkZYOx24Q4/b/s+oNhTjL+i8Z
 9+jDcsF4QH4Vdm3//92noFV7bQ1ZUYVeTOc5cMbcYuO5GdsQMyQxO81lt8FNHpCZe7zbTCRYCP9
 v3AwSFZYOtb8ZCvukLnht6hG6yAzh3jTh5MgFell/YS+56l4cKklzdlLGH3qL2MWAWoiAo7+wmk
 3N7iHRs4cAp9Hu6ngxxYVN6e/sxjP3HYaRF3bWxPFfzTavxhmXKqpnsYoGhFLZa8ClyqsAbCPqw
 9Xe5Nh1lg8ULTgqJBL0VfZNbFcS/8=
X-Received: by 2002:a05:600c:828a:b0:480:4a90:1b00 with SMTP id
 5b1f17b1804b1-48526951adbmr33577945e9.20.1772803882161; 
 Fri, 06 Mar 2026 05:31:22 -0800 (PST)
Received: from freepad.iliad.local ([213.36.9.123])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4851fb4257csm184386045e9.15.2026.03.06.05.31.21
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 06 Mar 2026 05:31:21 -0800 (PST)
Sender: Maxime Leroy <maxime.leroys@gmail.com>
From: Maxime Leroy <maxime@leroys.fr>
To: dev@dpdk.org
Cc: hemant.agrawal@nxp.com, stephen@networkplumber.org,
 david.marchand@redhat.com, Maxime Leroy <maxime@leroys.fr>
Subject: [PATCH v3 17/17] net/dpaa2: add devargs alternative for data stashing
 getenv
Date: Fri,  6 Mar 2026 14:30:35 +0100
Message-ID: <20260306133035.179709-18-maxime@leroys.fr>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260226143341.282188-1-maxime@leroys.fr>
References: <20260226143341.282188-1-maxime@leroys.fr>
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
---
 drivers/net/dpaa2/dpaa2_ethdev.c | 12 ++++++++++--
 drivers/net/dpaa2/dpaa2_ethdev.h |  3 +++
 2 files changed, 13 insertions(+), 2 deletions(-)

diff --git a/drivers/net/dpaa2/dpaa2_ethdev.c b/drivers/net/dpaa2/dpaa2_ethdev.c
index d9d8ba26a9..31fdef8598 100644
--- a/drivers/net/dpaa2/dpaa2_ethdev.c
+++ b/drivers/net/dpaa2/dpaa2_ethdev.c
@@ -35,6 +35,7 @@
 #define DRIVER_RX_PARSE_ERR_DROP "drv_rx_parse_drop"
 #define DRIVER_ERROR_QUEUE  "drv_err_queue"
 #define DRIVER_NO_TAILDROP  "drv_no_taildrop"
+#define DRIVER_NO_DATA_STASHING "drv_no_data_stashing"
 #define CHECK_INTERVAL         100  /* 100ms */
 #define MAX_REPEAT_TIME        90   /* 9s (90 * 100ms) in total */
 
@@ -929,7 +930,7 @@ dpaa2_dev_rx_queue_setup(struct rte_eth_dev *dev,
 		options |= DPNI_QUEUE_OPT_FLC;
 		cfg.flc.stash_control = true;
 		dpaa2_flc_stashing_clear_all(&cfg.flc.value);
-		if (getenv("DPAA2_DATA_STASHING_OFF")) {
+		if (priv->flags & DPAA2_DATA_STASHING_OFF) {
 			dpaa2_flc_stashing_set(DPAA2_FLC_DATA_STASHING, 0,
 				&cfg.flc.value);
 			dpaa2_q->data_stashing_off = 1;
@@ -2893,6 +2894,12 @@ dpaa2_dev_init(struct rte_eth_dev *eth_dev)
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
@@ -3391,5 +3398,6 @@ RTE_PMD_REGISTER_PARAM_STRING(NET_DPAA2_PMD_DRIVER_NAME,
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

