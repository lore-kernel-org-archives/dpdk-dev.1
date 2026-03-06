Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F2CECF01832
	for <dpdk-dev@archiver.kernel.org>; Fri,  6 Mar 2026 13:32:54 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 1E2DC4278D;
	Fri,  6 Mar 2026 14:31:22 +0100 (CET)
Received: from mail-wr1-f46.google.com (mail-wr1-f46.google.com
 [209.85.221.46]) by mails.dpdk.org (Postfix) with ESMTP id 3D287427D1
 for <dev@dpdk.org>; Fri,  6 Mar 2026 14:31:20 +0100 (CET)
Received: by mail-wr1-f46.google.com with SMTP id
 ffacd0b85a97d-439af00d33cso6061960f8f.1
 for <dev@dpdk.org>; Fri, 06 Mar 2026 05:31:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1772803880; x=1773408680; darn=dpdk.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:sender:from:to:cc:subject:date
 :message-id:reply-to;
 bh=seJZX0mWE7X1tc5GqA7oCAJVTgiKK5lB6Dl7i1hcICA=;
 b=J+jWQeXHzNEWKG5Y53a2FlC7BMUd7/9GMuQCUiJNmMX1w8qEsw6BtCOBC3r0u46g44
 JFRz9lKVl5wEIsMw7wx2mta35U7TBQKoZsiLyl31P6FpHsEfSzkWDgZ6/xEZvtUoFV7E
 eTCIIPVbd3KGUDawgURpJ6hEaLiFHgzWEMEQVM0hIpGIV0wmXPcDfpIG3MDSFx6yLBvh
 BPSx4IVaM6X8z5grt/65PVkzA1tsGTcjFSI0gXSyscYmfD5/8DZdY7eo3kTXBTF3YvMX
 aRQ+MGeKLzgb0VSkqBOHpw9/mC5Ioz+VxuORVA3jTuyvmYyBmgII3EuV2PWwMNkla+0j
 l/Aw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1772803880; x=1773408680;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:sender:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=seJZX0mWE7X1tc5GqA7oCAJVTgiKK5lB6Dl7i1hcICA=;
 b=ekHeQBHbYhdhP3wpNtJdZi5Pgml//bDeN3kck4WpFqApaM9oitNQ3ivDcrMwFLecqw
 w8ugHey7He5oIXiODmtkGk6U/DgBb9jsS0c8A9vN9vd/AzNXvaWRivrL8jZSgfO4oZur
 xIT3d96LMlzsvcxDi/5syQS8RBTuDS981eA+QNhFvl17Q4geRLw7y3OCZUGMo/ekBzFn
 Ag3M8qQspXW7GpmaPhd2q/hy3qLXYoQradAge7L6crg2AT+trq8iigj0bfOTlwJ9uob2
 oNZNtTZws+32lnEEu//SfGj14wR7w6ADM4puu56203xueePeMvsb/UZfGCLUeVHxvbIx
 uhDg==
X-Gm-Message-State: AOJu0YzyEmYOAToL9GVwxo+TaJVKixi4JGN4vpMXF/24Bte0oMx8j5o/
 tfUyZBC4TjllErMPkR29RZeqhQbZyj9j+gQmogMVqq+bLkQP0A2i/heMOdcYP/Vo
X-Gm-Gg: ATEYQzwLzeBGfwnf5tvbOs7q/NJJt9aU1JHm+IEzY1vDnSBo74CM890N4xAJ2DEYafD
 BO9sqBiBaozlJkls5yVIDXuyns2DC7zuGor5y8z7vTWbZT7HEQ0wkX1HQ7z3epjSSKJ8UImztdP
 aHBKTVkUuy5jbPxiUizrdyFIsk+B3ES3eCKk+3Lztg3lxHscYAbUr7k+UTz7fU87CEaZ0767tTq
 ZskTmLR/Os7pkfyeZReg0raUcvl8yi7ptNIZL3aGYA5aCDR/lOTQllmw6dfS36oapKY29ArDkJy
 imU+oaCuYgWeyjqOkYCOrVkEH+Dh2wRjj2cabQbrKV9MP6c1+piij2TEgthtT5gmO3u5laBlVn3
 inbAj/MrrXQDI1dEuGIlRr+4aO1Q4WPR8nW9Q5+NMARTwPE3T1jpqVuoruuP9AY/gzTIWZzjLh8
 Ywto2lsffftlzcwLqqF4ibSsJ99dtpAFeX4h7rQw==
X-Received: by 2002:a5d:5d0f:0:b0:439:a95b:3c44 with SMTP id
 ffacd0b85a97d-439da8808f2mr3792492f8f.30.1772803879665; 
 Fri, 06 Mar 2026 05:31:19 -0800 (PST)
Received: from freepad.iliad.local ([213.36.9.102])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-439dae2ba66sm3280816f8f.20.2026.03.06.05.31.18
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 06 Mar 2026 05:31:19 -0800 (PST)
Sender: Maxime Leroy <maxime.leroys@gmail.com>
From: Maxime Leroy <maxime@leroys.fr>
To: dev@dpdk.org
Cc: hemant.agrawal@nxp.com, stephen@networkplumber.org,
 david.marchand@redhat.com, Maxime Leroy <maxime@leroys.fr>
Subject: [PATCH v3 16/17] net/dpaa2: add devargs to disable Rx taildrop
Date: Fri,  6 Mar 2026 14:30:34 +0100
Message-ID: <20260306133035.179709-17-maxime@leroys.fr>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260226143341.282188-1-maxime@leroys.fr>
References: <20260226143341.282188-1-maxime@leroys.fr>
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

