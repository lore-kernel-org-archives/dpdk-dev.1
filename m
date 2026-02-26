Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 92BE7FCE095
	for <dpdk-dev@archiver.kernel.org>; Thu, 26 Feb 2026 14:36:20 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id E1CFB40E1F;
	Thu, 26 Feb 2026 15:34:32 +0100 (CET)
Received: from mail-wr1-f46.google.com (mail-wr1-f46.google.com
 [209.85.221.46]) by mails.dpdk.org (Postfix) with ESMTP id E09C140A7F
 for <dev@dpdk.org>; Thu, 26 Feb 2026 15:34:16 +0100 (CET)
Received: by mail-wr1-f46.google.com with SMTP id
 ffacd0b85a97d-43992e3f9b8so949495f8f.3
 for <dev@dpdk.org>; Thu, 26 Feb 2026 06:34:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1772116456; x=1772721256; darn=dpdk.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:sender:from:to:cc:subject:date
 :message-id:reply-to;
 bh=seJZX0mWE7X1tc5GqA7oCAJVTgiKK5lB6Dl7i1hcICA=;
 b=U4+tWSqYou9Lg+lxP1eY8MFHauhI9zzblTBFd/B23slxC++8Y3ZN4TZwhu2XfEsHDg
 98o5Gex6FBQkYr18QHp+OC4I4OzWvMbUtDeXjULBTsZq/aJV0ZFG3Gi4ZMHEKcbjwChk
 vOgtL3fJrLk69VyqqzJ83or8zvLSEzDwivj5nfTG9aDyntI76Bw49qCi7FiIUKi9Msyj
 xGgnu2MdjYXMJPG8rPFqPrcf4o7wiA98ZQdZLL4TVUWfb0Xq0fRmDnClHT7ASpWalC0y
 V52m/mrcU0kEsLfcwu8sdK3A3rRIotdexZtE2wUOXZJJMRXWRYPrrcADSpZ3fuj08EQo
 6+rw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1772116456; x=1772721256;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:sender:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=seJZX0mWE7X1tc5GqA7oCAJVTgiKK5lB6Dl7i1hcICA=;
 b=jHVi+xUr/UjPrEQbhYb9bDr2jlbNOWvdZ4SWcrsYrDqFKeTrd0StkDg8nKxJsH5XLS
 WMHc7zAZbPSwMEbiljhOgTUtDYuthni86FWMwBzg/ogo2AzLaxwBvQH9tCPPTIdiBfOq
 lGP8b+fFATUmIyOEY0yEkABuMs5P9VLmIR/3Awg2XEm5zDs6XGaU/s1WDLtwDsFmWAU1
 7xyvSByx97accmqQDwyANinGtwmepeTKSBS7DieMxMHbyIhYko732MchjI5XlaiRDr6n
 jJwhcG+zXv2efHr590huDZ03F6UMR3gtWaWrMP9p9DgeFDe6uiMw/10owQsEGnylkMaq
 JWpA==
X-Gm-Message-State: AOJu0Yz5T1NzRK/38Ze81SBBhpQbyEeoTnR9rc5mBT8zDj8NHe1pUr3a
 CzIecYom4J/ceyAWpuzf4TfRjtmncAfj00ZVtNQj5idDOo2oLAHDk1lGqD9TAw==
X-Gm-Gg: ATEYQzwrk0DukYKsUp6egb0mxjD0U9EfXrjFLhmL5pebhD63cVP6aSUc4gckDJWXogw
 3TBdbU8yKGk2vMekUtie3W8mGAP6COsyxz6ZBFGTpLC6v4r4lfMmM4tifZevdYosZyqhtSAz82M
 XRUsXOTCC388x6mraKfW5u0zZA+OOcJAWWz31BSHSL/kQadspkmp+UdjfWfLwH6fG4QFIYnF+cy
 uxh7MWHTlg5tZ+ZgpJ2YgiFaKF3H3B3TA555WOPsGZe8K8l4JRBYMboZh/yNUM+OzWapjPZfV5q
 2swBWTw5kyKZvwaVQIp0otHOUlFLx5pFSIWyW+S+ClvZAE4wXc3TgDjlOtFvigWSudf8s3iCI23
 8yihA0r+rqc+7CMJqtGqI/+fUiB/TTbK8W62vHN6h84Lj7FzWr1fbeAnX7Xu70tyZ2Mjo96bzbu
 +JIjsxLnohNDrj3sy9wVlIlzsi/A==
X-Received: by 2002:a05:6000:616:b0:439:8ec1:a85b with SMTP id
 ffacd0b85a97d-439942f2d0fmr8337830f8f.47.1772116456238; 
 Thu, 26 Feb 2026 06:34:16 -0800 (PST)
Received: from freepad.iliad.local ([213.36.9.96])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4398bb96b90sm17993866f8f.9.2026.02.26.06.34.15
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 26 Feb 2026 06:34:15 -0800 (PST)
Sender: Maxime Leroy <maxime.leroys@gmail.com>
From: Maxime Leroy <maxime@leroys.fr>
To: dev@dpdk.org
Cc: hemant.agrawal@nxp.com, stephen@networkplumber.org,
 david.marchand@redhat.com, Maxime Leroy <maxime@leroys.fr>
Subject: [PATCH v2 16/17] net/dpaa2: add devargs to disable Rx taildrop
Date: Thu, 26 Feb 2026 15:33:40 +0100
Message-ID: <20260226143341.282188-17-maxime@leroys.fr>
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

Signed-off-by: Maxime Leroy <maxime@leroys.fr>
Acked-by: Hemant Agrawal <hemant.agrawal@nxp.com>
---
 drivers/net/dpaa2/dpaa2_ethdev.c | 13 ++++++++++---
 1 file changed, 10 insertions(+), 3 deletions(-)

diff --git a/drivers/net/dpaa2/dpaa2_ethdev.c b/drivers/net/dpaa2/dpaa2_ethdev.c
index a70e6895c8..d9d8ba26a9 100644
--- a/drivers/net/dpaa2/dpaa2_ethdev.c
+++ b/drivers/net/dpaa2/dpaa2_ethdev.c
@@ -34,6 +34,7 @@
 #define DRIVER_TX_CONF "drv_tx_conf"
 #define DRIVER_RX_PARSE_ERR_DROP "drv_rx_parse_drop"
 #define DRIVER_ERROR_QUEUE  "drv_err_queue"
+#define DRIVER_NO_TAILDROP  "drv_no_taildrop"
 #define CHECK_INTERVAL         100  /* 100ms */
 #define MAX_REPEAT_TIME        90   /* 9s (90 * 100ms) in total */
 
@@ -897,7 +898,6 @@ dpaa2_dev_rx_queue_setup(struct rte_eth_dev *dev,
 	dpaa2_q = priv->rx_vq[rx_queue_id];
 	dpaa2_q->mb_pool = mb_pool; /**< mbuf pool to populate RX ring. */
 	dpaa2_q->bp_array = rte_dpaa2_bpid_info;
-	dpaa2_q->nb_desc = UINT16_MAX;
 	dpaa2_q->offloads = rx_conf->offloads;
 
 	/*Get the flow id from given VQ id*/
@@ -950,11 +950,12 @@ dpaa2_dev_rx_queue_setup(struct rte_eth_dev *dev,
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
@@ -2887,6 +2888,11 @@ dpaa2_dev_init(struct rte_eth_dev *eth_dev)
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
@@ -3384,5 +3390,6 @@ RTE_PMD_REGISTER_PARAM_STRING(NET_DPAA2_PMD_DRIVER_NAME,
 		DRIVER_NO_PREFETCH_MODE "=<int>"
 		DRIVER_TX_CONF "=<int>"
 		DRIVER_RX_PARSE_ERR_DROP "=<int>"
-		DRIVER_ERROR_QUEUE "=<int>");
+		DRIVER_ERROR_QUEUE "=<int>"
+		DRIVER_NO_TAILDROP "=<int>");
 RTE_LOG_REGISTER_DEFAULT(dpaa2_logtype_pmd, NOTICE);
-- 
2.43.0

