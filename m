Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BC809FCE095
	for <dpdk-dev@archiver.kernel.org>; Thu, 26 Feb 2026 14:36:27 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id C69BB40E24;
	Thu, 26 Feb 2026 15:34:33 +0100 (CET)
Received: from mail-wr1-f50.google.com (mail-wr1-f50.google.com
 [209.85.221.50]) by mails.dpdk.org (Postfix) with ESMTP id 8C05840B8C
 for <dev@dpdk.org>; Thu, 26 Feb 2026 15:34:17 +0100 (CET)
Received: by mail-wr1-f50.google.com with SMTP id
 ffacd0b85a97d-43987b97701so638918f8f.3
 for <dev@dpdk.org>; Thu, 26 Feb 2026 06:34:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1772116457; x=1772721257; darn=dpdk.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:sender:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ZNU24GAWD7EikpQ1S8iv4Qhop5VXf7mgFDcQDlJMdrA=;
 b=iNUp5DkWDQf58j6vsNW64psEUz02E4fRGLPJReB8f+nUmI86n3/P0KadhNYnB57XE2
 FKBjKGGPIm494uKLIHbVYt/ZYew3L5mQiRTTJGF/cJDY0AWBXc6mHFUkn8BwXn3bUGDS
 dZYaqkfrGMEeiKHs+PTf42NSw+ZVs9tBHAbTFIk/AsDnvEBz3G64xiePZMydu5GTNOWR
 /OZ4reOmHKHJswNnFhzj9WYy4LFoT3UqMRtJA4C32Q7gwEsnoohbnWb7AIKqGcsugeqY
 d0Xs2HHlDkb1fN6tFH7wGQC9L7O/Dd/brTGNu5pBvYxmIwcdhFEvfdMt/YHu39eo1/ey
 bs4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1772116457; x=1772721257;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:sender:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=ZNU24GAWD7EikpQ1S8iv4Qhop5VXf7mgFDcQDlJMdrA=;
 b=Maq/DBW/uKzATrSYMON8pkIw3vsExn1Rkc19LbXGN+KXjiDcUBKDYCQuzhTooY1K3z
 qzF5o1Ry3lw6MVc+uD7aoQgtNDhWJ0yiMcXPvisL8yU2YDuUoyeORCJiajcTEQTUvt4P
 rPP0V5D+YY+91mtYGYClvwBQEr6QTq+/dNwRIRCbcg4+1B24vyBuWvijJZgl8U39Jc/J
 ZKW1twB7sswyxJ41ldLUnjHlW8gRyc21+MpXp6AbHg9VOdpayK/8dKLF9gQZFGafqUCI
 8eubYMOwvXEl8pH4iA55bUPmHWS5Ev9UVZn8qKpAvyUyBfTsWO9ApGK49+dGKdzGtzdN
 +kbg==
X-Gm-Message-State: AOJu0YyjMleGL9nlXwUxXDyQCuaMgooG9q4NHvYPAzlzCVIHqVPr6IBU
 MHCEnckvWz18N0HaOIGNC4I60O4UEW97/tkOO+uu87hGjUuhFLZFLeH6US1nUg==
X-Gm-Gg: ATEYQzxEps8NlKtswiMZT1acVnQPOj1FVR8IFW9v7ATILG3vHP84+T4V9X5PEzGGeqo
 5hV/6G+xWzX5k/0ILnp9yxdhVe9+mK86PcWXqKx3JoMdEX1hXWWmOrLmdTVhD9fAgfKInrjECkD
 Q9j25hyLlZp3q0tje2d1b3nLsvIqOM1HpO/pwE5oclXxcgyATxdonRJ7w+Xhd4HlrbNXzaZ/sec
 y7AkgP1Var+j3oF2+P7pINidHq3PYsMvt1P9pnKJIyJ/5EfAWdmRsX3PdhpdFOJs0FcCYNm85QN
 Zduhmu/7iLKB9XmHsddE6pTOpgqAN/+AMS+btiYRiu2PmceWxLcNr85qaCTCPJteQRjbhf0Zwcg
 gza/yW5lJoapReqHiCn/4A38sqZyzugPimx4rUeaXfY5tGFPy9Ts/3fiYlANaNSVfleNo3SVXJ+
 4qmnUG/8Ma59Ejx7+K5jwbDKpbzA==
X-Received: by 2002:a05:6000:228a:b0:435:b7ca:7521 with SMTP id
 ffacd0b85a97d-439942aba6fmr8323752f8f.15.1772116457045; 
 Thu, 26 Feb 2026 06:34:17 -0800 (PST)
Received: from freepad.iliad.local ([213.36.9.96])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4398bb96b90sm17993866f8f.9.2026.02.26.06.34.16
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 26 Feb 2026 06:34:16 -0800 (PST)
Sender: Maxime Leroy <maxime.leroys@gmail.com>
From: Maxime Leroy <maxime@leroys.fr>
To: dev@dpdk.org
Cc: hemant.agrawal@nxp.com, stephen@networkplumber.org,
 david.marchand@redhat.com, Maxime Leroy <maxime@leroys.fr>
Subject: [PATCH v2 17/17] net/dpaa2: add devargs alternative for data stashing
 getenv
Date: Thu, 26 Feb 2026 15:33:41 +0100
Message-ID: <20260226143341.282188-18-maxime@leroys.fr>
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

