Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A2B8DFCE095
	for <dpdk-dev@archiver.kernel.org>; Thu, 26 Feb 2026 14:36:05 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 1202040691;
	Thu, 26 Feb 2026 15:34:31 +0100 (CET)
Received: from mail-wr1-f45.google.com (mail-wr1-f45.google.com
 [209.85.221.45]) by mails.dpdk.org (Postfix) with ESMTP id 1B3B440A6F
 for <dev@dpdk.org>; Thu, 26 Feb 2026 15:34:15 +0100 (CET)
Received: by mail-wr1-f45.google.com with SMTP id
 ffacd0b85a97d-43992e3f9b8so949467f8f.3
 for <dev@dpdk.org>; Thu, 26 Feb 2026 06:34:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1772116455; x=1772721255; darn=dpdk.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:sender:from:to:cc:subject:date
 :message-id:reply-to;
 bh=XFE+3NrIdZpjzYPzjPALZvOSWgRMVM9Gs4VkIodU6Rc=;
 b=EWOxf8HWSON6goLfhTa5qODeJqdLIjtxWadpo5KaCDnNJQSAotJH60SktnVZr3FM5A
 RuNLpFN9vkKNSrO+9KlYbAqh6fOZelVp86fipqePMdGCufqYRcpJKTV1fwDvvDq49Lg2
 BjJ/UM/WVmBHJ2ocVDnoWf4GYOSwrz3WHNEMnfdCXN+ijgerG7cg2qONkIaKZiCDtVDL
 OgSf49WDg3IKrv26QEm8BGxEGsvuy0uwNC/0iTzT2n9UFORudCycy8I2gNIUq6EJjUpA
 y+EsnRjK9zJuakn8/s5PYnHxrNdEMMLRHVRYslgeFemJ3dzKhjp/F0/hPZlfK6Bf+lN2
 Mf9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1772116455; x=1772721255;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:sender:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=XFE+3NrIdZpjzYPzjPALZvOSWgRMVM9Gs4VkIodU6Rc=;
 b=TfXZ07fB1KCzWeW5x/ucCb/5oVafnr1wfVdztuoIEV6pIf+UGRe48zOAg9HiofIKV/
 /FnK0ilE47MDrrwKba45+9dh8nVvZ24kFy1o9tDB25OZNKjUETTB1jrvjAgt8OtWhghx
 pcKAukqOZvf0vG6EP6JhiEs+9UJKPgoK6WblCTlAjnCMU+wcZnOrjg8pMxEosp+6L4VU
 dTRgnNilOzJ4+lCqpjjyriLB1Gxec0SyKK5o/j7gvutR4eoVPu/OZTAm/facITtaszeP
 1/rn2daRd5FLr9WMuCEQgIXplbzwiMEQHKx0Q659U7rtgEK15qqP8SZHQVLkpFyXN+JC
 cVNg==
X-Gm-Message-State: AOJu0YyodiNzCr0fCn+UjtKRcRlvgQwJpP+4NcTH5/QyMGPj7xaJl7xo
 2GtQtTNXIkYfYveatSNFP9EgBM3mSjP1O901dCNYatbZjeVFQasdMJT/TqmXjA==
X-Gm-Gg: ATEYQzzSz7OYm6yanknsUIvT7I/04bzpXisIJlkP08sYCEsysOVRAWUxoLY72/D2bFe
 OklRvFeS89zMV3/XroAHhntWQE4FxN63cTAN3WvyxApLQpoFSc51B/+45GcfXJTq0bjSrs4BI+W
 CtPnquiaoZF9DKeWwOkXoGRj+xIsV360DxQyPbspK2FhxtjkkFiHrTyykmsS7Eb85qQYy8TWhj7
 en8Vo8N1EErH5w5ZbRC+gYQJhTZcVL8CGWL4JfgyTPxsM929o5Uuba4Sza1o9aIdr0zmUyEx21g
 lOhT16dJoIg45UM53RM8UCIxrzhI814RXiA/4UkY3h9YiBdkXZ0KJGY4XTfNMlGt+gddn8+lg6n
 vodjHkmA8QhXlzWaRzUvC/zrIR6HjRCbXA8X1sjkfUlZxb4jTxirDrPI6+FD/eJ55blXgUnon7P
 4xcedfvSTw/Jme/+EGukKghyRFBg==
X-Received: by 2002:a05:6000:1867:b0:435:930a:658e with SMTP id
 ffacd0b85a97d-439942fdd59mr8528946f8f.53.1772116454505; 
 Thu, 26 Feb 2026 06:34:14 -0800 (PST)
Received: from freepad.iliad.local ([213.36.9.96])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4398bb96b90sm17993866f8f.9.2026.02.26.06.34.13
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 26 Feb 2026 06:34:14 -0800 (PST)
Sender: Maxime Leroy <maxime.leroys@gmail.com>
From: Maxime Leroy <maxime@leroys.fr>
To: dev@dpdk.org
Cc: hemant.agrawal@nxp.com, stephen@networkplumber.org,
 david.marchand@redhat.com, Maxime Leroy <maxime@leroys.fr>, stable@dpdk.org
Subject: [PATCH v2 14/17] net/dpaa2: fix MAC stats DMA buffer allocation per
 xstats call
Date: Thu, 26 Feb 2026 15:33:38 +0100
Message-ID: <20260226143341.282188-15-maxime@leroys.fr>
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

dpaa2_dev_mac_setup_stats() allocates and frees DMA buffers on every
xstats_get() call. This is wasteful and not thread-safe: concurrent
callers can overwrite priv pointers, leading to use-after-free. It
also does not check for allocation failure before passing IOVAs to
the MC firmware.

Move the DMA buffer allocation to dpaa2_dev_init() (only when MC
version supports MAC stats) and free them in dpaa2_dev_close(). In
xstats_get(), just check if the buffers were allocated.

Not tested, found by code review.

Fixes: d1cdef2ab5 ("net/dpaa2: add dpmac counters in xstats")
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

