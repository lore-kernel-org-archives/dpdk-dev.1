Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D4421109C05C
	for <dpdk-dev@archiver.kernel.org>; Wed, 25 Mar 2026 20:47:17 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id B4C1F427DC;
	Wed, 25 Mar 2026 21:46:28 +0100 (CET)
Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com
 [209.85.128.50]) by mails.dpdk.org (Postfix) with ESMTP id A2334427D7
 for <dev@dpdk.org>; Wed, 25 Mar 2026 21:46:25 +0100 (CET)
Received: by mail-wm1-f50.google.com with SMTP id
 5b1f17b1804b1-486fc4725f0so1797755e9.1
 for <dev@dpdk.org>; Wed, 25 Mar 2026 13:46:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1774471585; x=1775076385; darn=dpdk.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:sender:from:to:cc:subject:date
 :message-id:reply-to;
 bh=OSLACNInErWq7GxX2hItPCW2VcdZhaGpRi/MliGCMfE=;
 b=RWrw5pZwmw9z6XHdOssTxMthLMNxnOpOZnOrwEj2YHKT04FKwoE8OShiLDTHVVIz3R
 Sd02am6b+4zAUV2HMyj4Q95wqUcOkP9KZAq5O6wYH6OE+DEqg1uPJB0jdpFq9KfcpTib
 F0ejXNnJkx2W0hrDVGZwmw+uG1MxtNEVkh4av8mFdQG2gZICrKVjyqo9lLe6twe6+Vbe
 /wcvcN+3gsDw1DzsimEmd3qXRzM7jofEErSeLQrArsPT19kEo2xpzRxJ7Fy5U+tFLfuk
 I8M8mRyNJJ5gSOq25oeHuvfdi6WXEQVJ4LEswztByH54cTZHZJylTrKpLyZFIBGHdoBv
 B11Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1774471585; x=1775076385;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:sender:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=OSLACNInErWq7GxX2hItPCW2VcdZhaGpRi/MliGCMfE=;
 b=ant1DlrIKmQZImWEXGJUSnyxkdz0nwjvOpqm0pxUfw6pcqwJhAcmtjjb+aIDd/h4y9
 pRzPX9s7OcH79KqtGYKGanaQPXVosLClPTEIG0MI0GGmC4NV7CO9QJU8//0x/V8xsw9F
 O3B8IWy2DAAfL63nEN2isqTaGE+6qLUOmc2+jbMkkAusIi/LDzgQzSTdtMu6mH5gTBi6
 WZQijnVCZ6Qf50MrpaHPomPnkqUBd1g+JOyt2b+b7IhKfOA2KtLhhZw+IvptMLS9CvM8
 eX6xrFARvOFL9sshUcdbpPtJAhMne6YvCtjmkB8wxtyCwj5jmvYuMLnT0UQ8CmquFt0Q
 L3bw==
X-Gm-Message-State: AOJu0YwJ02MWIXjRB/5rdFmNk60GafHHgOi2CQ1QSBcPO+ExBp+obioQ
 KgAjr/vBBNuEAvct20zFiibu6VVSMFZ8QxyPvA1jrnxgT3ox7Ge9SQWo1IVkcqZb
X-Gm-Gg: ATEYQzxDsUnfdlammETv3ocVriXKOtJfjnnV6JbJc6WRDpALWXpGR6mqXdV+1q+WeIf
 jpFfnvjUfeQfghWnT2xuD2AhEk5X3nwMY9buYzWEJRYWDbJNFze9ODzZwpqxOxYGzBq48rZ7ZPu
 7xjYxhxnHybzZWYbJKT4rCi4BJSrPbNaHevmSKuTT5A0ZAflzPFHt10wMvHhAm6oT7Rmh66yHxh
 6V/cfhbZLXaYVv4rgODi4Fm/h1xrJsdynva64Aw8cQBF8W9+3iit3/MacAfuAhPwGrRYKxe+m7l
 hVt1KzA5JpbWak3V8jF35fk8hxz+ysadM2GbjzZEKBIlmgvPAc2fLy+gJSML4nY+4Gr0uKL0XI3
 50+rIGi5/gbMPCBn0N8AKmegCnLiZ1pMBg6eSbtPv2SkHK9FxeW9MrblocoSv0Jx9kSCsuPOEO/
 63+HzsBLFMf/tWwFL/
X-Received: by 2002:a05:600c:37c3:b0:485:3cef:d6ea with SMTP id
 5b1f17b1804b1-4871608eb70mr71289505e9.13.1774471585096; 
 Wed, 25 Mar 2026 13:46:25 -0700 (PDT)
Received: from freepad.. ([2a01:e0a:6f:bdf0:224a:2b64:3d43:500c])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-487173955a8sm27850295e9.32.2026.03.25.13.46.24
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 25 Mar 2026 13:46:24 -0700 (PDT)
Sender: Maxime Leroy <maxime.leroys@gmail.com>
From: Maxime Leroy <maxime@leroys.fr>
To: dev@dpdk.org
Cc: hemant.agrawal@nxp.com, stephen@networkplumber.org,
 Maxime Leroy <maxime@leroys.fr>, stable@dpdk.org
Subject: [PATCH v4 14/17] net/dpaa2: fix MAC stats DMA alloc per xstats call
Date: Wed, 25 Mar 2026 21:45:41 +0100
Message-ID: <20260325204544.101444-15-maxime@leroys.fr>
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
Acked-by: Hemant Agrawal <hemant.agrawal@nxp.com>
---
 drivers/net/dpaa2/dpaa2_ethdev.c | 65 +++++++++++++++-----------------
 1 file changed, 30 insertions(+), 35 deletions(-)

diff --git a/drivers/net/dpaa2/dpaa2_ethdev.c b/drivers/net/dpaa2/dpaa2_ethdev.c
index 18d8bf5444..9c384f6430 100644
--- a/drivers/net/dpaa2/dpaa2_ethdev.c
+++ b/drivers/net/dpaa2/dpaa2_ethdev.c
@@ -1551,6 +1551,11 @@ dpaa2_dev_close(struct rte_eth_dev *dev)
 
 	rte_free(priv->extract.qos_extract_param);
 
+	rte_free(priv->cnt_idx_dma_mem);
+	rte_free(priv->cnt_values_dma_mem);
+	priv->cnt_idx_dma_mem = NULL;
+	priv->cnt_values_dma_mem = NULL;
+
 	DPAA2_PMD_INFO("%s: netdev deleted", dev->data->name);
 	return 0;
 }
@@ -1906,7 +1911,6 @@ dpaa2_dev_xstats_get(struct rte_eth_dev *dev,
 	unsigned int i = 0, j = 0, num = RTE_DIM(dpaa2_xstats_strings);
 	struct dpaa2_dev_priv *priv = dev->data->dev_private;
 	union dpni_statistics value[13] = {};
-	struct mc_version mc_ver_info = {0};
 	struct dpni_rx_tc_policing_cfg cfg;
 	uint8_t page_id, stats_id;
 	uint64_t *cnt_values;
@@ -1977,44 +1981,24 @@ dpaa2_dev_xstats_get(struct rte_eth_dev *dev,
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
@@ -3156,6 +3140,17 @@ dpaa2_dev_init(struct rte_eth_dev *eth_dev)
 
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

