Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0F22EF0182F
	for <dpdk-dev@archiver.kernel.org>; Fri,  6 Mar 2026 13:31:08 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 5DDF14111B;
	Fri,  6 Mar 2026 14:30:52 +0100 (CET)
Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com
 [209.85.128.52]) by mails.dpdk.org (Postfix) with ESMTP id 18CEC410F6
 for <dev@dpdk.org>; Fri,  6 Mar 2026 14:30:50 +0100 (CET)
Received: by mail-wm1-f52.google.com with SMTP id
 5b1f17b1804b1-483bd7354efso120780215e9.2
 for <dev@dpdk.org>; Fri, 06 Mar 2026 05:30:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1772803850; x=1773408650; darn=dpdk.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:sender:from:to:cc:subject:date
 :message-id:reply-to;
 bh=EjDdbf+eAjbLdgG/yexqas3+XFV2wX2tkLagCUlKWPs=;
 b=QpyewJ1BK9sU0ZdfQjJnpUxVODhUvZ84rMcS4Qqysg2ykVtbMAoObc5Bl1e7rI/vQU
 ceCeMzBV+LqKOpQFpnfMk9U7pDxsfaEKzVanWgtlIvB5VIQbnkat5eCokd9er0kNM/tN
 f82GrrYPlVj0/nuleW9fzJUU+b+mkUs15IZayp/eScGLqOb7ggzGlNT15HAmQzJ1F4R6
 +r9Vuf/wqte+WOzYoOvoqRNqdAA53+Eub/od21KoPxFH4OIgdhzmUi+H5PLKknm3TbLm
 2+zF+1ZCVnJfZzk5uVOPAXi2cEdDf7toi04Jkn71Bce+hdyxM9+IPtUiOinBOg5/cN4l
 xT1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1772803850; x=1773408650;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:sender:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=EjDdbf+eAjbLdgG/yexqas3+XFV2wX2tkLagCUlKWPs=;
 b=U1N8y62d/8BswaB5xrt577uNyhNM6YHxij0RnDrJJKsFZYvF8WGSZ/WTHILvJhs24L
 bIBm15goL3QTBzKm6q+UDuTrdHWjnrcbsUn42RunWo7p0E0C564c1DUYdyx9+WYN1o22
 y59gIqUhh7vqfJkyxa9j3kwSEUPkl2+ifaVUKpi9CmtjdB3QmthQks4br6NSrP/FyakU
 93E0dN/vC5QUBAxiuqBfIhzrDBSBSsUgNLw+LdwzIegy5nEmJ/hfaVWACohgOHATBFa/
 B/1+wAR5Epwnxal/JTWy3EgkhDZkXb8caDacJ9/nY9kiV4VI9H1BrKi6yzME79KaPDyJ
 cuyQ==
X-Gm-Message-State: AOJu0YybYIfW3dN4iL4/iADtr6Cyi6Wo3pjcCMxrjd1epJo4s0hHxH9o
 H+umUMdcaKvYEX39y7fEl0TAdNaGiIW4Yu4bPlOM3dmZLRhmsc/Jd/4fiJCr3j/B
X-Gm-Gg: ATEYQzxq7lA/TaeCFWJluS/dFOQQumIwubqg27cqgwb+LQIW6JIslCEpx4zZ0+mIARJ
 H0t/G52KApDRwW3gfCpgUcU0wWgRHYlh0SXNuxdiRjCxyXCxiiTmNoAVFfEAycow/6mEwJ1ATeO
 pOFXAFy/rFA0tqa507sKCla4BwGE+TQbSiMxm7IFIWM07sTECoxrmMzaO+sx2XxBGj+wupAESmd
 5rvrcu//9OK2Le6AXFsGoMoUleS9kWqTaO3o335c0MMo59fCqiaJmXWQPmmnNhJaEHELCCgkMxj
 oG/17iYterDB3cLWCSXBIVn5gD50GNUDsPLLjRpGcPK+lzP7K+EwV4hymshGdxw8FROKvVE+DA7
 kTuc2rhB5y/eiUqbwdDGR0JLwX2VHJbOSBPAtRg01DKPiizuj+t3NQtVn098zufgPaIs8VJ+PAI
 F+kOHb7JVWe1JMFskntCUjzZsiQVQ=
X-Received: by 2002:a05:600c:34d2:b0:480:4a4f:c363 with SMTP id
 5b1f17b1804b1-48526922ba2mr33253725e9.9.1772803849445; 
 Fri, 06 Mar 2026 05:30:49 -0800 (PST)
Received: from freepad.iliad.local ([213.36.9.102])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-48527681e2bsm38133125e9.5.2026.03.06.05.30.48
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 06 Mar 2026 05:30:48 -0800 (PST)
Sender: Maxime Leroy <maxime.leroys@gmail.com>
From: Maxime Leroy <maxime@leroys.fr>
To: dev@dpdk.org
Cc: hemant.agrawal@nxp.com, stephen@networkplumber.org,
 david.marchand@redhat.com, Maxime Leroy <maxime@leroys.fr>, stable@dpdk.org
Subject: [PATCH v3 03/17] net/dpaa2: warn on Rx descriptor limit in high perf
 mode
Date: Fri,  6 Mar 2026 14:30:21 +0100
Message-ID: <20260306133035.179709-4-maxime@leroys.fr>
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

The Rx descriptor count warning fires unconditionally when the total
exceeds 11264, but this limit only applies when the DPNI is created
with the high performance buffer option (0x80000000). When using normal
buffers, there is no such limit and the warning is
misleading noise.

Check the DPNI options to only warn when the high performance buffer
mode is active.

Fixes: 35dc25d12792 ("net/dpaa2: warn on high Rx descriptor number")
Cc: stable@dpdk.org

Signed-off-by: Maxime Leroy <maxime@leroys.fr>
Acked-by: Hemant Agrawal <hemant.agrawal@nxp.com>
---
 drivers/net/dpaa2/dpaa2_ethdev.c | 18 +++++++++++-------
 drivers/net/dpaa2/mc/fsl_dpni.h  |  6 ++++++
 2 files changed, 17 insertions(+), 7 deletions(-)

diff --git a/drivers/net/dpaa2/dpaa2_ethdev.c b/drivers/net/dpaa2/dpaa2_ethdev.c
index eb8333458e..61dcfafff6 100644
--- a/drivers/net/dpaa2/dpaa2_ethdev.c
+++ b/drivers/net/dpaa2/dpaa2_ethdev.c
@@ -74,8 +74,9 @@ int dpaa2_timestamp_dynfield_offset = -1;
 
 bool dpaa2_print_parser_result;
 
+/* Rx descriptor limit when DPNI uses high performance buffers */
 #define MAX_NB_RX_DESC		11264
-int total_nb_rx_desc;
+static int total_nb_rx_desc;
 
 int dpaa2_valid_dev;
 struct rte_mempool *dpaa2_tx_sg_pool;
@@ -904,11 +905,13 @@ dpaa2_dev_rx_queue_setup(struct rte_eth_dev *dev,
 	DPAA2_PMD_DEBUG("dev =%p, queue =%d, pool = %p, conf =%p",
 			dev, rx_queue_id, mb_pool, rx_conf);
 
-	total_nb_rx_desc += nb_rx_desc;
-	if (total_nb_rx_desc > MAX_NB_RX_DESC) {
-		DPAA2_PMD_WARN("Total nb_rx_desc exceeds %d limit. Please use Normal buffers",
-			       MAX_NB_RX_DESC);
-		DPAA2_PMD_WARN("To use Normal buffers, run 'export DPNI_NORMAL_BUF=1' before running dynamic_dpl.sh script");
+	if (priv->options & DPNI_OPT_HIGH_PERF_BUFFER) {
+		total_nb_rx_desc += nb_rx_desc;
+		if (total_nb_rx_desc > MAX_NB_RX_DESC) {
+			DPAA2_PMD_WARN("Total nb_rx_desc exceeds %d limit. Please use Normal buffers",
+				       MAX_NB_RX_DESC);
+			DPAA2_PMD_WARN("To use Normal buffers, run 'export DPNI_NORMAL_BUF=1' before running dynamic_dpl.sh script");
+		}
 	}
 
 	if (!priv->bp_list || priv->bp_list->mp != mb_pool) {
@@ -1213,7 +1216,8 @@ dpaa2_dev_rx_queue_release(struct rte_eth_dev *dev, uint16_t rx_queue_id)
 	memset(&cfg, 0, sizeof(struct dpni_queue));
 	PMD_INIT_FUNC_TRACE();
 
-	total_nb_rx_desc -= dpaa2_q->nb_desc;
+	if (priv->options & DPNI_OPT_HIGH_PERF_BUFFER)
+		total_nb_rx_desc -= dpaa2_q->nb_desc;
 
 	if (dpaa2_q->cgid != DPAA2_INVALID_CGID) {
 		options = DPNI_QUEUE_OPT_CLEAR_CGID;
diff --git a/drivers/net/dpaa2/mc/fsl_dpni.h b/drivers/net/dpaa2/mc/fsl_dpni.h
index fcc6d4726e..82d6830acc 100644
--- a/drivers/net/dpaa2/mc/fsl_dpni.h
+++ b/drivers/net/dpaa2/mc/fsl_dpni.h
@@ -121,6 +121,12 @@ struct fsl_mc_io;
  * The stashing is enabled by default.
  */
 #define DPNI_OPT_STASHING_DIS			0x002000
+/*
+ * High performance buffer mode.
+ * The total number of Rx descriptors is limited to 11264 in this mode.
+ * When not set, the DPNI uses normal buffers and has no such limit.
+ */
+#define DPNI_OPT_HIGH_PERF_BUFFER		0x80000000
 /**
  * Software sequence maximum layout size
  */
-- 
2.43.0

