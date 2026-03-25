Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9DBF2109C05C
	for <dpdk-dev@archiver.kernel.org>; Wed, 25 Mar 2026 20:47:28 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 47CDC427DE;
	Wed, 25 Mar 2026 21:46:34 +0100 (CET)
Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com
 [209.85.128.52]) by mails.dpdk.org (Postfix) with ESMTP id A9D60427E1
 for <dev@dpdk.org>; Wed, 25 Mar 2026 21:46:29 +0100 (CET)
Received: by mail-wm1-f52.google.com with SMTP id
 5b1f17b1804b1-486507134e4so3619835e9.0
 for <dev@dpdk.org>; Wed, 25 Mar 2026 13:46:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1774471589; x=1775076389; darn=dpdk.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:sender:from:to:cc:subject:date
 :message-id:reply-to;
 bh=oNPOd0weeYc97LaWpo50YqIbOZEfR3NNQCsW/nfAYck=;
 b=i99p4Mz+uNLC0AVC2iO587JIrOuLrda8+5u4QYojKZL4eBaj1S9yEriiZIDz+PzZYB
 ITps6kLWw22z2lY49upCF7vC0D4zHNoPndJsWXxP9vXdHzYJJj1CBNU1fRSpVvqZXsss
 hXxkOB3PTCaW9Z8vsPXX2S+t/Eb9bMNiZwn9CFVM2pXITdsgMjVnIDB4S14yBJztmZiZ
 9R2jHxQihM1GJTWBmAVX320LiRd55nFyo16QeM/3lL6NP7ac7zq/sJ7jI7cC3+oRtCjv
 Gk3pVTFRj4WsoZ7/bRWsKTwPsw+rvo6WvNK/xdbmg3mfoChtPWsGHcbENXYz736poeCi
 +MAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1774471589; x=1775076389;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:sender:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=oNPOd0weeYc97LaWpo50YqIbOZEfR3NNQCsW/nfAYck=;
 b=DMxsYqyj4QJUSoDhxD3O6XDuDwET/4OB4fB7jE2DSN3xHOst4WPw9ZB0aNMO5Y7R4S
 R7mRApNMmeA3+/ubf5hmTRoEjV6zY6/a5+ClSdjLqUFNw2X6956HmatgBqEsx3vbNzHQ
 aTXZQEAJnuxJs5NwL3u+pOJgJP8avSJ9wnq9vGKrJgbiQuxqaobZJEodhN45G8sFCSjn
 kXPvoJativJZmg7XG/4IQrFQmixDiVru75a3mzZ6742slXzbFq9ZsCPckg/besLXjQDQ
 9nPhbB5oAtbu6fQkOiLoG5JWgX+PSZngF+Ub9gp/Qr8gGCiS3XwGnEtq9exLKi0bviKg
 Ji2A==
X-Gm-Message-State: AOJu0YxkV9wt9c+qr6WyxzIuzfVLOSQvjW+h5J4xWjB5/qmF/znVXFjf
 fnIjjKYCFnjirf3FlwgmpDM8Dr+dxbR1tX5Pn+aH5K2ym2hprwbAneJIi7Oczw==
X-Gm-Gg: ATEYQzyLyrw2IjW9q77AGJLXzn64oEuG8BD0CAvc76sSx7c+m3YGLNVx7Ihe/rtzl3k
 3RqQIdJepBCu6L24CLOn6CgD7cO2nqwChcF9fbuohNEo2zwo1NnMuMA/H5v5f71oCIQkXH2LaUt
 0K14t12vhiPfCKIpea98J9nRyUQinCfWgFtG2/mlx238mNFACxkFk9m7hhQCqDIG475eIcey1z0
 GpakQz98OhUJ7tjBrIog/1pkCL5rDp4JiDsVjXLXorNW86LBEiFliTZCWS1sXKSeLa2B3kCbqEj
 bFajQCH8j7jG3MyQ7ESe5fCix2r0btCOu9Y84y1XihokZPsF2E6R5lDwaAkIRSNmFEgfFwz3gGt
 uI/aAI86hsRHsstvNXGA4XUUQ9oPIOIa5qXCWS5vYsd7qxHulnG8ECPInJy7ijghhK03WOwUMuG
 6sL1ycFTYH1g1QCX9s
X-Received: by 2002:a05:600c:1c22:b0:480:20f1:7aa6 with SMTP id
 5b1f17b1804b1-4871604c8e1mr79421655e9.21.1774471589190; 
 Wed, 25 Mar 2026 13:46:29 -0700 (PDT)
Received: from freepad.. ([2a01:e0a:6f:bdf0:224a:2b64:3d43:500c])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-487116f1905sm160440645e9.3.2026.03.25.13.46.28
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 25 Mar 2026 13:46:28 -0700 (PDT)
Sender: Maxime Leroy <maxime.leroys@gmail.com>
From: Maxime Leroy <maxime@leroys.fr>
To: dev@dpdk.org
Cc: hemant.agrawal@nxp.com, stephen@networkplumber.org,
 Maxime Leroy <maxime@leroys.fr>
Subject: [PATCH v4 16/17] net/dpaa2: add devargs to disable Rx taildrop
Date: Wed, 25 Mar 2026 21:45:43 +0100
Message-ID: <20260325204544.101444-17-maxime@leroys.fr>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260325204544.101444-1-maxime@leroys.fr>
References: <20260306133035.179709-1-maxime@leroys.fr>
 <20260325204544.101444-1-maxime@leroys.fr>
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
index 3091077269..f128093d90 100644
--- a/drivers/net/dpaa2/dpaa2_ethdev.c
+++ b/drivers/net/dpaa2/dpaa2_ethdev.c
@@ -34,6 +34,7 @@
 #define DRIVER_TX_CONF "drv_tx_conf"
 #define DRIVER_RX_PARSE_ERR_DROP "drv_rx_parse_drop"
 #define DRIVER_ERROR_QUEUE  "drv_err_queue"
+#define DRIVER_NO_TAILDROP  "drv_no_taildrop"
 #define CHECK_INTERVAL         100  /* 100ms */
 #define MAX_REPEAT_TIME        90   /* 9s (90 * 100ms) in total */
 
@@ -899,7 +900,6 @@ dpaa2_dev_rx_queue_setup(struct rte_eth_dev *dev,
 	dpaa2_q = priv->rx_vq[rx_queue_id];
 	dpaa2_q->mb_pool = mb_pool; /**< mbuf pool to populate RX ring. */
 	dpaa2_q->bp_array = rte_dpaa2_bpid_info;
-	dpaa2_q->nb_desc = UINT16_MAX;
 	dpaa2_q->offloads = rx_conf->offloads;
 
 	/*Get the flow id from given VQ id*/
@@ -952,11 +952,12 @@ dpaa2_dev_rx_queue_setup(struct rte_eth_dev *dev,
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
@@ -2888,6 +2889,11 @@ dpaa2_dev_init(struct rte_eth_dev *eth_dev)
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
@@ -3385,5 +3391,6 @@ RTE_PMD_REGISTER_PARAM_STRING(NET_DPAA2_PMD_DRIVER_NAME,
 		DRIVER_NO_PREFETCH_MODE "=<int>"
 		DRIVER_TX_CONF "=<int>"
 		DRIVER_RX_PARSE_ERR_DROP "=<int>"
-		DRIVER_ERROR_QUEUE "=<int>");
+		DRIVER_ERROR_QUEUE "=<int>"
+		DRIVER_NO_TAILDROP "=<int>");
 RTE_LOG_REGISTER_DEFAULT(dpaa2_logtype_pmd, NOTICE);
-- 
2.43.0

