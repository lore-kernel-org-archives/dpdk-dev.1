Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C2DC6106B504
	for <dpdk-dev@archiver.kernel.org>; Wed, 25 Mar 2026 20:46:05 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 9498C42793;
	Wed, 25 Mar 2026 21:46:00 +0100 (CET)
Received: from mail-wr1-f45.google.com (mail-wr1-f45.google.com
 [209.85.221.45]) by mails.dpdk.org (Postfix) with ESMTP id 1CCA842793
 for <dev@dpdk.org>; Wed, 25 Mar 2026 21:45:57 +0100 (CET)
Received: by mail-wr1-f45.google.com with SMTP id
 ffacd0b85a97d-439c6fc2910so154482f8f.0
 for <dev@dpdk.org>; Wed, 25 Mar 2026 13:45:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1774471557; x=1775076357; darn=dpdk.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:sender:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ZqZ2pdiMt3RFZD96jxZAp9eTIZgtkiXnR3hP/erw2I4=;
 b=PE7mbmEkc4qkF1NYfXP88k5V34PDlnCu4Rr+Wz9ZIpu5alKIoukdzZcxOl2iSV0bN9
 ZgKuiyoIFC9EKOyosHBU5B29waRdBpJWt5xByrjU1MVyjFGm0Dli4BXFjesucX6xIxOb
 iiL9vlQBJV1GKztyUBTCeEMFVMiWyItj3HuEgmRTHVymrtDhaV2W6lcXcOLRqXbYzier
 ivw+/PrhQgnyz8370A1xVt+lthnkbIyJioOSJDhcl0OCwC4nCvhDRA3BUWe+7f+hXvAD
 y/6xc6TNxLEZsLGMBg04azzKV6uh+ZIvI5ghLbISmAu1AgAdQhdzx9qVwNHmn/47KAn6
 Jolw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1774471557; x=1775076357;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:sender:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=ZqZ2pdiMt3RFZD96jxZAp9eTIZgtkiXnR3hP/erw2I4=;
 b=c6MQzxiqehwhukooGqbQJb2I3HGFCdwg7l+xyLS4JouofbqXrw3MNOtVs7V24Lrl3D
 nxR6OQK2WPUWEaukpQaN6E3MF8sTbyfkNWT1MU8Co4doXBBEQl7oXFPTPSYZ+ldm0ke1
 gBcxgpecf7Pq+DmreBxw5WsL/oYUyEO1iuxzhNPgYPwozcSskgNegkfeUxcjV3SF1BM7
 gr/yfX0jW/jfR6JgUgT6J8d41BVbdZ9ApDIrBOsrXrchfisWMJbgDAi8rrhJsb75bAo1
 +Weg5b3p20/Pcs9u3hEF3GnxyM/f3KJesi0uCzFZyxTejNmsXvAcupnz4uk3zkbDtcgx
 GsMw==
X-Gm-Message-State: AOJu0YxoPk8MxP/R/b6s2fv8FZwTLy/uwiLkwZbE8Chp/9Lu5dRONSQy
 JnyXtctbxnoms/gB5Fmt2o3UKjqjsmGMDKfDEDDUBDIVZvPtTCcbBqhLRvzs4zKz
X-Gm-Gg: ATEYQzyVa+/CQ4T+9M9frDiREzswp3Ms5eFH/iEBWfkBgN611iiretwrus5M6MR4/Lt
 teME74yzXJQUx8Do8n7C93ZQmNmo77xz5Ogtuv5txaihj2ltjZMkmAGy5ytAmo0eEp0w7Rxe9B8
 VWuvi4g54XwXiBzu0RYMITMnpGm2c3emgYKQn5uHLyfLr9uizYrzWeP6JFX6YBcHbYqO98Fxggw
 QA4e6dkmRyJG1eaWDbS344aKurmK+Iil4OkVbZIh35aw6i2w0P8S6zJ5dUaAGoEG5geyj/Ke7xs
 tOvk9TO+sx7a8nfyNRM1VXM94KcL8zsZUt/HVMpZR5I4BGVHVNWfBn8DdZSp6KXlKDB5eaUQwdh
 4ySfjk0FSQHbVSocjR+9kzokbc1RuSiY/cRrrjbM2n77Z6LvUfmENNZeM2+NtmW2H/hPIB9++C5
 mI+iydBIvMB9cHxvdB
X-Received: by 2002:a5d:6449:0:b0:43b:8fa4:1953 with SMTP id
 ffacd0b85a97d-43b8fa41ab0mr3604498f8f.11.1774471556616; 
 Wed, 25 Mar 2026 13:45:56 -0700 (PDT)
Received: from freepad.. ([2a01:e0a:6f:bdf0:224a:2b64:3d43:500c])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-43b91942f24sm2558404f8f.11.2026.03.25.13.45.56
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 25 Mar 2026 13:45:56 -0700 (PDT)
Sender: Maxime Leroy <maxime.leroys@gmail.com>
From: Maxime Leroy <maxime@leroys.fr>
To: dev@dpdk.org
Cc: hemant.agrawal@nxp.com, stephen@networkplumber.org,
 Maxime Leroy <maxime@leroys.fr>, stable@dpdk.org
Subject: [PATCH v4 02/17] net/dpaa2: fix Rx error queue memory leaks
Date: Wed, 25 Mar 2026 21:45:29 +0100
Message-ID: <20260325204544.101444-3-maxime@leroys.fr>
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

The rx_err_vq is allocated separately with rte_zmalloc() in
dpaa2_alloc_rx_tx_queues(), but is never properly freed in two paths:

1. On port close: dpaa2_free_rx_tx_queues() only frees the q_storage
contents via dpaa2_queue_storage_free() — the dpaa2_queue struct itself
is never freed, leaking memory on every port close.

2. On allocation error: the fail: path frees the error queue's
   q_storage but never frees the rx_err_vq struct itself, which was
   separately allocated with rte_zmalloc(). This has been missing
   since the error queue was first introduced.

Add the missing rte_free() calls and NULL assignments in both paths.

Also replace the DPAAX_RX_ERROR_QUEUE_FLAG check with a direct
priv->rx_err_vq NULL check, which is safe because rx_err_vq is
zero-initialized and only set when the flag is active. This avoids a
NULL dereference if rx_err_vq allocation itself fails and also
simplifies the cleanup in dpaa2_free_rx_tx_queues() for consistency.

As a defensive measure, also add a NULL guard to the
dpaa2_queue_storage_free() macro to prevent NULL pointer dereference
from callers in error paths.

Fixes: 46d02eeaaeb8 ("net/dpaa2: fix queue freeing")
Fixes: 4690a6114ff6 ("net/dpaa2: enable error queues optionally")
Cc: stable@dpdk.org

Signed-off-by: Maxime Leroy <maxime@leroys.fr>
Acked-by: Hemant Agrawal <hemant.agrawal@nxp.com>
---
 drivers/bus/fslmc/portal/dpaa2_hw_pvt.h | 16 +++++++++-------
 drivers/net/dpaa2/dpaa2_ethdev.c        |  8 ++++++--
 2 files changed, 15 insertions(+), 9 deletions(-)

diff --git a/drivers/bus/fslmc/portal/dpaa2_hw_pvt.h b/drivers/bus/fslmc/portal/dpaa2_hw_pvt.h
index 10bc191645..e625a5c035 100644
--- a/drivers/bus/fslmc/portal/dpaa2_hw_pvt.h
+++ b/drivers/bus/fslmc/portal/dpaa2_hw_pvt.h
@@ -223,13 +223,15 @@ struct swp_active_dqs {
 
 #define dpaa2_queue_storage_free(q, num) \
 ({ \
-	int i; \
-	\
-	for (i = 0; i < (num); i++) { \
-		if ((q)->q_storage[i]) { \
-			dpaa2_free_dq_storage((q)->q_storage[i]); \
-			rte_free((q)->q_storage[i]); \
-			(q)->q_storage[i] = NULL; \
+	if (q) { \
+		int i; \
+		\
+		for (i = 0; i < (num); i++) { \
+			if ((q)->q_storage[i]) { \
+				dpaa2_free_dq_storage((q)->q_storage[i]); \
+				rte_free((q)->q_storage[i]); \
+				(q)->q_storage[i] = NULL; \
+			} \
 		} \
 	} \
 })
diff --git a/drivers/net/dpaa2/dpaa2_ethdev.c b/drivers/net/dpaa2/dpaa2_ethdev.c
index cef819650b..eb8333458e 100644
--- a/drivers/net/dpaa2/dpaa2_ethdev.c
+++ b/drivers/net/dpaa2/dpaa2_ethdev.c
@@ -620,9 +620,11 @@ dpaa2_alloc_rx_tx_queues(struct rte_eth_dev *dev)
 		priv->rx_vq[i--] = NULL;
 	}
 
-	if (priv->flags & DPAAX_RX_ERROR_QUEUE_FLAG) {
+	if (priv->rx_err_vq) {
 		dpaa2_q = priv->rx_err_vq;
 		dpaa2_queue_storage_free(dpaa2_q, RTE_MAX_LCORE);
+		rte_free(dpaa2_q);
+		priv->rx_err_vq = NULL;
 	}
 
 	rte_free(mc_q);
@@ -688,9 +690,11 @@ dpaa2_free_rx_tx_queues(struct rte_eth_dev *dev)
 				priv->tx_conf_vq[i] = NULL;
 			}
 		}
-		if (priv->flags & DPAAX_RX_ERROR_QUEUE_FLAG) {
+		if (priv->rx_err_vq) {
 			dpaa2_q = priv->rx_err_vq;
 			dpaa2_queue_storage_free(dpaa2_q, RTE_MAX_LCORE);
+			rte_free(dpaa2_q);
+			priv->rx_err_vq = NULL;
 		}
 
 		/*free memory for all queues (RX+TX) */
-- 
2.43.0

