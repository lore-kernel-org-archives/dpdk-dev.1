Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4342BF01832
	for <dpdk-dev@archiver.kernel.org>; Fri,  6 Mar 2026 13:32:39 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 13374427C2;
	Fri,  6 Mar 2026 14:31:18 +0100 (CET)
Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com
 [209.85.128.41]) by mails.dpdk.org (Postfix) with ESMTP id D2D75427C0
 for <dev@dpdk.org>; Fri,  6 Mar 2026 14:31:15 +0100 (CET)
Received: by mail-wm1-f41.google.com with SMTP id
 5b1f17b1804b1-48334ee0aeaso76816705e9.1
 for <dev@dpdk.org>; Fri, 06 Mar 2026 05:31:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1772803875; x=1773408675; darn=dpdk.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:sender:from:to:cc:subject:date
 :message-id:reply-to;
 bh=f3fk+WpuZ5m4VfjtNRI2u/Zo34EoCraYm95oqVVMmVw=;
 b=eKHhLrcIy16QNdmzLan1MWagsK/Ci/HWvJaVaHQqe+q9Benw7WFo62JH7xEn/PYvS1
 CWEecaduP2IAJIPK9uaY6Crgj53fu7hnlsmVWgLz0EwqoWEEZv/l+PYgZjq3TY7NyD+R
 391K1mDzscI0ukHtdtCbt1NLaAW7Z2ZVH4ex5IPFjO6qGmQsqCdZk/TuLo9ZnU4Hgfes
 no7Xhpt/FCyv5TWnkXH6z7ikLGqlvCgs+JmgLKgsXS7HQEnI9aCaeRM1WtDdgjTnDwOP
 +scBGNd7uqazyQ7VmrdRGrMRJ+/S+cTFHuuv//mlPvQQmFEaLFc+Bm7Tin1cGUn71UsX
 jEwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1772803875; x=1773408675;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:sender:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=f3fk+WpuZ5m4VfjtNRI2u/Zo34EoCraYm95oqVVMmVw=;
 b=AGSSNLx7G6yNOcAf2Gy+FyCoW8JKX/yDGTUhgT2V5lEmOIMBKr18X+6Kta/hB0SrIL
 I+tvDRrNslYZZD5mPi/xLoMjRFY7VmOAiZ1OaAFlK8CsXhEtuNY1U/XJHR0PfSMGl6uK
 D/ovFGYAGEu1A2og6MCBG4y6cziaBUztWOxMleroi79QvELxVtsW3MaqD3CP0urls4v+
 InLiP4+VQKfHKf8VJkhBCBFzJKZf6qVt+8rS7C1e1NkUtAS35iesqKziiEQvw2Zz9k90
 9FHub8wk0xlarLQsIqGK4qfiH997/eb8tcc3VYZTHLNPfUz53ldry+J1VWfBK3NqZBTq
 +JeQ==
X-Gm-Message-State: AOJu0Yyzj3iWEyKUR0bf+LbGLDgAaLL5pazZlDEF8XW1TupEEUfwHQVo
 Vf4xJFjUtxmGec5NEPtMpsGe1XHP3yE19HCFv0ZQMSo3aKUMFBAArrmd6b3DnzSb
X-Gm-Gg: ATEYQzzOMbe+YOiq2gpec/fsC/SFbSouAXrOU6kZmcS9Ughjev8mVf47nD93W9ri1+c
 Zv1i587oyNq83N7ITU5XTi6EWui/W9GnfeEJ6HV4lYhLziyTLwUBg2/lW4BWH1r3dGqNezoc4lz
 pmom/6hO/JmtSyo/dXtjFNhE2qldZIunWWcCqn+Y1QVbmgGZj1xTKMKQrqr9ZTfE/pKSiMnTGqU
 CmUoKP2uGqSy0s20JWIWHt8WjMbuN5uRnzuTXSPYJLWz7sh5oNmeNKxsQ7mNXynlSyxe56vEC0G
 Pqa0Zh2S/TNjpgzMjN3hcx2D5F2GujyL6RG3iDzmcSWSkrj9izeR86isKGaTHQREO4M4W2XooY1
 Zskp+TgU0tFe7wnR1WbtKTwDeFJ0kndinrTV02RvvESOQP7N7i5xcNZ58L+NWHoKRdSwWhr6JRl
 4Z8SaZqRgObNu7c4J6URtJjwYsmpE=
X-Received: by 2002:a05:600c:64c7:b0:47a:7fdd:2906 with SMTP id
 5b1f17b1804b1-4852691ec50mr31871555e9.12.1772803875083; 
 Fri, 06 Mar 2026 05:31:15 -0800 (PST)
Received: from freepad.iliad.local ([213.36.9.102])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-485276b75eesm30756245e9.14.2026.03.06.05.31.14
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 06 Mar 2026 05:31:14 -0800 (PST)
Sender: Maxime Leroy <maxime.leroys@gmail.com>
From: Maxime Leroy <maxime@leroys.fr>
To: dev@dpdk.org
Cc: hemant.agrawal@nxp.com, stephen@networkplumber.org,
 david.marchand@redhat.com, Maxime Leroy <maxime@leroys.fr>, stable@dpdk.org
Subject: [PATCH v3 14/17] net/dpaa2: fix MAC stats DMA alloc per xstats call
Date: Fri,  6 Mar 2026 14:30:32 +0100
Message-ID: <20260306133035.179709-15-maxime@leroys.fr>
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

dpaa2_dev_mac_setup_stats() allocates and frees DMA buffers on every
xstats_get() call. This is wasteful and not thread-safe: concurrent
callers can overwrite priv pointers, leading to use-after-free. It
also does not check for allocation failure before passing IOVAs to
the MC firmware.

Move the DMA buffer allocation to dpaa2_dev_init() (only when MC
version supports MAC stats) and free them in dpaa2_dev_close(). In
xstats_get(), just check if the buffers were allocated.

Not tested, found by code review.

Fixes: d1cdef2ab592 ("net/dpaa2: add dpmac counters in xstats")
Cc: stable@dpdk.org

Reported-by: Stephen Hemminger <stephen@networkplumber.org>
Signed-off-by: Maxime Leroy <maxime@leroys.fr>
---
 drivers/net/dpaa2/dpaa2_ethdev.c | 65 +++++++++++++++-----------------
 1 file changed, 30 insertions(+), 35 deletions(-)

diff --git a/drivers/net/dpaa2/dpaa2_ethdev.c b/drivers/net/dpaa2/dpaa2_ethdev.c
index 3875164794..d5e30ce5fb 100644
--- a/drivers/net/dpaa2/dpaa2_ethdev.c
+++ b/drivers/net/dpaa2/dpaa2_ethdev.c
@@ -1550,6 +1550,11 @@ dpaa2_dev_close(struct rte_eth_dev *dev)
 
 	rte_free(priv->extract.qos_extract_param);
 
+	rte_free(priv->cnt_idx_dma_mem);
+	rte_free(priv->cnt_values_dma_mem);
+	priv->cnt_idx_dma_mem = NULL;
+	priv->cnt_values_dma_mem = NULL;
+
 	DPAA2_PMD_INFO("%s: netdev deleted", dev->data->name);
 	return 0;
 }
@@ -1905,7 +1910,6 @@ dpaa2_dev_xstats_get(struct rte_eth_dev *dev,
 	unsigned int i = 0, j = 0, num = RTE_DIM(dpaa2_xstats_strings);
 	struct dpaa2_dev_priv *priv = dev->data->dev_private;
 	union dpni_statistics value[13] = {};
-	struct mc_version mc_ver_info = {0};
 	struct dpni_rx_tc_policing_cfg cfg;
 	uint8_t page_id, stats_id;
 	uint64_t *cnt_values;
@@ -1976,44 +1980,24 @@ dpaa2_dev_xstats_get(struct rte_eth_dev *dev,
 		i++;
 	}
 
-	if (mc_get_version(dpni, CMD_PRI_LOW, &mc_ver_info))
-		DPAA2_PMD_WARN("Unable to obtain MC version");
-
-	/* mac_statistics supported on MC version > 10.39.0 */
-	if (mc_ver_info.major >= MC_VER_MAJOR &&
-	    mc_ver_info.minor >= MC_VER_MINOR &&
-	    mc_ver_info.revision > 0) {
-		dpaa2_dev_mac_setup_stats(dev);
-		retcode = dpni_get_mac_statistics(dpni, CMD_PRI_LOW, priv->token,
-						  priv->cnt_idx_iova,
-						  priv->cnt_values_iova,
-						  DPAA2_MAC_NUM_STATS);
-		if (retcode) {
-			while (i >= (num - DPAA2_MAC_NUM_STATS) && i < num) {
-				xstats[i].id = i;
-				xstats[i].value = 0;
-				i++;
-			}
-		}
-		if (!retcode) {
-			cnt_values = priv->cnt_values_dma_mem;
-			while (i >= (num - DPAA2_MAC_NUM_STATS) && i < num) {
-				/* mac counters value */
-				xstats[i].id = i;
-				xstats[i].value = rte_le_to_cpu_64(*cnt_values++);
-				i++;
-			}
-		}
-		rte_free(priv->cnt_values_dma_mem);
-		rte_free(priv->cnt_idx_dma_mem);
-		priv->cnt_idx_dma_mem = NULL;
-		priv->cnt_values_dma_mem = NULL;
-	} else {
+	if (priv->cnt_idx_dma_mem &&
+	    !dpni_get_mac_statistics(dpni, CMD_PRI_LOW, priv->token,
+				    priv->cnt_idx_iova,
+				    priv->cnt_values_iova,
+				    DPAA2_MAC_NUM_STATS)) {
+		cnt_values = priv->cnt_values_dma_mem;
 		while (i >= (num - DPAA2_MAC_NUM_STATS) && i < num) {
 			xstats[i].id = i;
-			xstats[i].value = 0;
+			xstats[i].value = rte_le_to_cpu_64(*cnt_values++);
 			i++;
 		}
+		return i;
+	}
+
+	while (i >= (num - DPAA2_MAC_NUM_STATS) && i < num) {
+		xstats[i].id = i;
+		xstats[i].value = 0;
+		i++;
 	}
 
 	return i;
@@ -3155,6 +3139,17 @@ dpaa2_dev_init(struct rte_eth_dev *eth_dev)
 
 	priv->speed_capa = dpaa2_dev_get_speed_capability(eth_dev);
 
+	/* mac_statistics supported on MC version > 10.39.0 */
+	{
+		struct mc_version mc_ver_info = {0};
+
+		if (!mc_get_version(dpni_dev, CMD_PRI_LOW, &mc_ver_info) &&
+		    mc_ver_info.major >= MC_VER_MAJOR &&
+		    mc_ver_info.minor >= MC_VER_MINOR &&
+		    mc_ver_info.revision > 0)
+			dpaa2_dev_mac_setup_stats(eth_dev);
+	}
+
 	return 0;
 init_err:
 	dpaa2_dev_close(eth_dev);
-- 
2.43.0

