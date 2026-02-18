Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D198FE9A047
	for <dpdk-dev@archiver.kernel.org>; Wed, 18 Feb 2026 16:05:30 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 6358A4065C;
	Wed, 18 Feb 2026 17:05:07 +0100 (CET)
Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com
 [209.85.128.53]) by mails.dpdk.org (Postfix) with ESMTP id D58C94064E
 for <dev@dpdk.org>; Wed, 18 Feb 2026 17:05:05 +0100 (CET)
Received: by mail-wm1-f53.google.com with SMTP id
 5b1f17b1804b1-4837907f535so40888885e9.3
 for <dev@dpdk.org>; Wed, 18 Feb 2026 08:05:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1771430705; x=1772035505; darn=dpdk.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:sender:from:to:cc:subject:date
 :message-id:reply-to;
 bh=7VbjexGVv3GBtQ8M/Z+pvnTyS0PSO6taPvn/xHivmhg=;
 b=A26e1V1ZJDS4Uh4K4iWFlrFv0ttGBE/HvrMp4YllE0sJ3e/Sk3zw91vy5HjV26AiHl
 szPpBKXBw5PocQAuZsgfi6cjgOG0ufGYVlsC0zDCMWh+VLzHcM2cOqi2LNBCZwhTk3Ac
 CX5MIJEs1lZ61c8A60Ir7WP4zoEzxf4Jpngie3UuTrlAnLZsjzyypYBcBTMBBcX6h5+8
 IEHV2gIZQNA5mQYhQl6M/0OWa31CHfwlTNEe68Bm/UrcvitoYMrDMfvrIyh34oo8326g
 M0LN3Isi3VH6+NpMfelbfD0ksvj4z36TP2HA+TPaCz1KAd3Rp4H3fsws1YnQTg+uh2lF
 5fLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1771430705; x=1772035505;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:sender:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=7VbjexGVv3GBtQ8M/Z+pvnTyS0PSO6taPvn/xHivmhg=;
 b=WD4nflVrTN8Kwng5se6ngc9hgZDdqjlgZrhQ8hBQzw41oZHGoJx5klwHarCr6cepcu
 q/TpcKbk7U1sRE4a/3T4c48ShGl3ZwxdTAVu6K/vc5rYzWS2njf5GwqXloLwmOdziBN3
 d3MFhJwi5Ta51aeIOoxiLhjwfhDT5KJ8T7nxr9kk1lLIIAcfqUtFzJNI1JZKXKDaYXfX
 SczKPL9xG26iYSRVoNcX4IfZL8Rz4i60+ASXevcylJTNa68LwDSTd0yDZquqshBleMvj
 QWHgmwc+DrsY5af9uHJvkcCpIueqhkjTSJK98/BAHEWaCD8/4dWSvg9K3rCyWd9ysUbS
 NauA==
X-Gm-Message-State: AOJu0YyO5mZurMPeXHAVBWym2+xnbAK/IPtDc3axG+8glgJVlirAEra1
 IFjwVxYrQbWtV9bWcug/RqOEiJWbn2mYh8Cflw/8RW8AguoglpuhZZjV
X-Gm-Gg: AZuq6aL797VRCMCcYzzkZ8rng9n4A/TlrS/PvZJQC1F/SGkr/nPD9sTlJkpbq34Ys/p
 looGj1sF4YeD0SymHvJnKJR0rjqimHPFdlH3ksFPaWuKutNE5YyaLWRhQO7d6QcRWGoNwlZ0PEp
 aIsngDlbJ6ou1dKhcATL7438NSCSBm6eoybyxpBnCmRieQ/FM7wF4S9SLfI6tA+CnRa7c6lQ8eu
 ZIcTqG4k7vGaX4lygDMwF5DzoZRwzrdHcna4+oZ91MywgzAm3k12FNEn3UjaznzZbL76q+r+LNC
 GHGNpoSQhicRcNwOc12/NfmYnh028LGufRvu9De7voN5twj2iuP4g9+t8ii4uWzyPSVuHbIngRe
 OPeZ40WnrRHvKk/QpXKGkvbNRWX7f0si0q8mvqwl4cJMRUalyLbaOlJe9kyTxmZFMMEC5gGJWZG
 R8BRAsO78V0XaAJ9S+vcFvxeCFuw==
X-Received: by 2002:a05:600c:4ed1:b0:483:71f7:2796 with SMTP id
 5b1f17b1804b1-48379b9898cmr273799365e9.10.1771430705233; 
 Wed, 18 Feb 2026 08:05:05 -0800 (PST)
Received: from freepad.iliad.local ([213.36.9.41])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4835dd0e327sm604619175e9.14.2026.02.18.08.05.04
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 18 Feb 2026 08:05:04 -0800 (PST)
Sender: Maxime Leroy <maxime.leroys@gmail.com>
From: Maxime Leroy <maxime@leroys.fr>
To: hemant.agrawal@nxp.com
Cc: dev@dpdk.org,
	Maxime Leroy <maxime@leroys.fr>
Subject: [PATCH 04/11] net/dpaa2: fix rx error queue leak in alloc error path
Date: Wed, 18 Feb 2026 17:04:46 +0100
Message-ID: <20260218160453.142311-5-maxime@leroys.fr>
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

In dpaa2_alloc_rx_tx_queues(), the fail: path frees the error queue's
q_storage but never frees the rx_err_vq struct itself, which was
separately allocated with rte_zmalloc(). This has been missing since
the error queue was first introduced.

Also replace the DPAAX_RX_ERROR_QUEUE_FLAG check with a direct
priv->rx_err_vq NULL check, which is safe because rx_err_vq is
zero-initialized and only set when the flag is active. This avoids a
NULL dereference if rx_err_vq allocation itself fails and also
simplifies the cleanup in dpaa2_free_rx_tx_queues() for consistency.

As a defensive measure, also add a NULL guard to the
dpaa2_queue_storage_free() macro to prevent NULL pointer dereference from
callers in error paths.

Fixes: 4690a6114ff6 ("net/dpaa2: enable error queues optionally")
Signed-off-by: Maxime Leroy <maxime@leroys.fr>
---
 drivers/bus/fslmc/portal/dpaa2_hw_pvt.h | 16 +++++++++-------
 drivers/net/dpaa2/dpaa2_ethdev.c        |  8 +++++---
 2 files changed, 14 insertions(+), 10 deletions(-)

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
index 088a07eba5..61dcfafff6 100644
--- a/drivers/net/dpaa2/dpaa2_ethdev.c
+++ b/drivers/net/dpaa2/dpaa2_ethdev.c
@@ -621,9 +621,11 @@ dpaa2_alloc_rx_tx_queues(struct rte_eth_dev *dev)
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
@@ -689,10 +691,10 @@ dpaa2_free_rx_tx_queues(struct rte_eth_dev *dev)
 				priv->tx_conf_vq[i] = NULL;
 			}
 		}
-		if (priv->flags & DPAAX_RX_ERROR_QUEUE_FLAG) {
+		if (priv->rx_err_vq) {
 			dpaa2_q = priv->rx_err_vq;
 			dpaa2_queue_storage_free(dpaa2_q, RTE_MAX_LCORE);
-			rte_free(priv->rx_err_vq);
+			rte_free(dpaa2_q);
 			priv->rx_err_vq = NULL;
 		}
 
-- 
2.43.0

