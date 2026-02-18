Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 872DBE9A02C
	for <dpdk-dev@archiver.kernel.org>; Wed, 18 Feb 2026 16:05:44 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 3332740653;
	Wed, 18 Feb 2026 17:05:10 +0100 (CET)
Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com
 [209.85.128.43]) by mails.dpdk.org (Postfix) with ESMTP id 8F4114065E
 for <dev@dpdk.org>; Wed, 18 Feb 2026 17:05:07 +0100 (CET)
Received: by mail-wm1-f43.google.com with SMTP id
 5b1f17b1804b1-48371bb515eso63111555e9.1
 for <dev@dpdk.org>; Wed, 18 Feb 2026 08:05:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1771430707; x=1772035507; darn=dpdk.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:sender:from:to:cc:subject:date
 :message-id:reply-to;
 bh=BlIdN1szqrJXJt77TkRRXj0SRM7H5iV+8C+DGoKxFu0=;
 b=KH6fwofObD89wZ9Vh666l6bsFa59heB++WUH9xcxo5tEDvM2zUXPv/lsCxF8IU47a1
 UPChsc5PBiB5SukpfSXKx0B2E6D8IUsjmYDcP6l3OhvEdaa1v6hGatt2a4/ws49k/HSr
 O3RXT+UN4FEYKcVvZPTmAkfkscTN1cyPYTU01Ia0YHWMIUej7P4OdNkYii8cwS1jfMXz
 8xQwOVtXfEUoKjKQprGh0f09Q+VPACzrBAdvtDAqcC7An7yrvlZp9wUUiFcuEBBn+pEr
 scSB3wAKo9CLDO5+Wr7GnDKcAK5XJwF/XrtK879OvglTj4/+CMBimrVJzEueQngQoG5h
 TCiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1771430707; x=1772035507;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:sender:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=BlIdN1szqrJXJt77TkRRXj0SRM7H5iV+8C+DGoKxFu0=;
 b=Qm6cIvUAmExcdIxBr20SWvKms/RaXAHCPaHbMNiBHA1CeqbEaW+S3MfBP72zu7NR/G
 1aXwT3ZHFiKVZ8nrfk1/Xea9xXdkGRVPKV2cojdYlZ0WO6yMMa8L021bagVR+dNEDHAA
 c55rZ6vnY8l2eXFzcqwPFGTjGlnhA3kZQ17B0okQSqXSqVTNUKv7nx1hNlKUN+l90anO
 /v2l9ngNCgE/lUpzUcLGyqoYrp9aGSZI9Wh3Iq0776p5AaHdw1CFupwdmuDQIaVkMuaR
 1srK4SANAxFF7keA8SSjai8/qBbXlk6JndUJnocXXHvBT76xsqn9eX2BpmBmEdFvyS7O
 ysfA==
X-Gm-Message-State: AOJu0Yw+pYkDy6tRnYlxVV1NkE/vw3RAn1fDercCnTIdU/XoWueq/NXi
 9d0Xf/D7fPJKa/VEmdp86NouBbs7UY2HJVYjRVvTDnFl89MpDcITLeiC
X-Gm-Gg: AZuq6aI+/h47TTcPfdRr/2QI1XVsUXegvSkdBAiKShkKqAwX3CYGQ0I6QGfIIoGlR1V
 oSQc2ZyS++ZI+UJTLjcZINxv5QSC7mk3b5rXvN0PO6WH17BRMNVDwKV8ma5Cwkn0rLyA/fa0oyP
 +M3mwnJ5ees4mSUBPIvgzPshNZyTvZ+tOx2x+bdIpYcdaPQvmmLBO5f1uTE7EEe6FmKCa+nh4Y+
 lbqXMInBfttq+kUTGvN4CXhFF2Q+7kBTz/mSbC9d9M1l1gnTfWVicl+SV1ce2vMimo2RnTGIOxJ
 sF9ptpNQSvlxoW3LkcDUQWi+J4Ns4RqZZt5DmnHvJ42HGpje6gB7wwx0V1LGQXA0a9y1EOv89S9
 GPXR5fUM396/Ib0yrxBvOmU5+aGPL77ZwlQq3M0JXcaZ61kUPUeg1wOKZVvtt+EyS5Nc1wJoYVu
 dZ0F4IsshTpErId+X9GByvb0RU9w==
X-Received: by 2002:a05:600c:3542:b0:477:54cd:200e with SMTP id
 5b1f17b1804b1-48398a678cfmr42402165e9.1.1771430706936; 
 Wed, 18 Feb 2026 08:05:06 -0800 (PST)
Received: from freepad.iliad.local ([213.36.9.41])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4835dd0e327sm604619175e9.14.2026.02.18.08.05.06
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 18 Feb 2026 08:05:06 -0800 (PST)
Sender: Maxime Leroy <maxime.leroys@gmail.com>
From: Maxime Leroy <maxime@leroys.fr>
To: hemant.agrawal@nxp.com
Cc: dev@dpdk.org,
	Maxime Leroy <maxime@leroys.fr>
Subject: [PATCH 06/11] net/dpaa2: add devargs to disable Rx taildrop
Date: Wed, 18 Feb 2026 17:04:48 +0100
Message-ID: <20260218160453.142311-7-maxime@leroys.fr>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260218160453.142311-1-maxime@leroys.fr>
References: <20260218160453.142311-1-maxime@leroys.fr>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
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

The DPAA2_RX_TAILDROP_OFF flag was defined and checked in
dpaa2_dev_rx_queue_setup(), but never set — making the taildrop
disable path dead code.

Wire it to a new "drv_no_taildrop" devargs, following the existing
pattern (drv_loopback, drv_no_prefetch, etc.).

Also move dpaa2_q->nb_desc assignment before the taildrop if/else
so that the descriptor count is always tracked correctly, regardless
of whether taildrop is enabled or disabled.

Usage: fslmc:dpni.1,drv_no_taildrop=1

Note: the taildrop disable path has never been reachable until now
and is untested. NXP maintainers should validate this feature.

Fixes: 23d6a87ee2ea ("net/dpaa2: add support for tail drop on queue")
Signed-off-by: Maxime Leroy <maxime@leroys.fr>
---
 drivers/net/dpaa2/dpaa2_ethdev.c | 13 ++++++++++---
 1 file changed, 10 insertions(+), 3 deletions(-)

diff --git a/drivers/net/dpaa2/dpaa2_ethdev.c b/drivers/net/dpaa2/dpaa2_ethdev.c
index 3658e24dd2..578ad98b8e 100644
--- a/drivers/net/dpaa2/dpaa2_ethdev.c
+++ b/drivers/net/dpaa2/dpaa2_ethdev.c
@@ -34,6 +34,7 @@
 #define DRIVER_TX_CONF "drv_tx_conf"
 #define DRIVER_RX_PARSE_ERR_DROP "drv_rx_parse_drop"
 #define DRIVER_ERROR_QUEUE  "drv_err_queue"
+#define DRIVER_NO_TAILDROP  "drv_no_taildrop"
 #define CHECK_INTERVAL         100  /* 100ms */
 #define MAX_REPEAT_TIME        90   /* 9s (90 * 100ms) in total */
 
@@ -929,7 +930,6 @@ dpaa2_dev_rx_queue_setup(struct rte_eth_dev *dev,
 	dpaa2_q = priv->rx_vq[rx_queue_id];
 	dpaa2_q->mb_pool = mb_pool; /**< mbuf pool to populate RX ring. */
 	dpaa2_q->bp_array = rte_dpaa2_bpid_info;
-	dpaa2_q->nb_desc = UINT16_MAX;
 	dpaa2_q->offloads = rx_conf->offloads;
 
 	/*Get the flow id from given VQ id*/
@@ -982,11 +982,12 @@ dpaa2_dev_rx_queue_setup(struct rte_eth_dev *dev,
 		return ret;
 	}
 
+	dpaa2_q->nb_desc = nb_rx_desc;
+
 	if (!(priv->flags & DPAA2_RX_TAILDROP_OFF)) {
 		struct dpni_taildrop taildrop;
 
 		taildrop.enable = 1;
-		dpaa2_q->nb_desc = nb_rx_desc;
 		/* Private CGR will use tail drop length as nb_rx_desc.
 		 * for rest cases we can use standard byte based tail drop.
 		 * There is no HW restriction, but number of CGRs are limited,
@@ -2932,6 +2933,11 @@ dpaa2_dev_init(struct rte_eth_dev *eth_dev)
 		DPAA2_PMD_INFO("Rx loopback mode");
 	}
 
+	if (dpaa2_get_devargs(dev->devargs, DRIVER_NO_TAILDROP)) {
+		priv->flags |= DPAA2_RX_TAILDROP_OFF;
+		DPAA2_PMD_INFO("Rx taildrop disabled");
+	}
+
 	/* For secondary processes, the primary has done all the work */
 	if (rte_eal_process_type() != RTE_PROC_PRIMARY) {
 		/* In case of secondary, only burst and ops API need to be
@@ -3418,5 +3424,6 @@ RTE_PMD_REGISTER_PARAM_STRING(NET_DPAA2_PMD_DRIVER_NAME,
 		DRIVER_NO_PREFETCH_MODE "=<int>"
 		DRIVER_TX_CONF "=<int>"
 		DRIVER_RX_PARSE_ERR_DROP "=<int>"
-		DRIVER_ERROR_QUEUE "=<int>");
+		DRIVER_ERROR_QUEUE "=<int>"
+		DRIVER_NO_TAILDROP "=<int>");
 RTE_LOG_REGISTER_DEFAULT(dpaa2_logtype_pmd, NOTICE);
-- 
2.43.0

