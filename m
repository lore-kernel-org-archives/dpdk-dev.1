Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F2D83FCE095
	for <dpdk-dev@archiver.kernel.org>; Thu, 26 Feb 2026 14:34:27 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 538114066F;
	Thu, 26 Feb 2026 15:34:10 +0100 (CET)
Received: from mail-wr1-f52.google.com (mail-wr1-f52.google.com
 [209.85.221.52]) by mails.dpdk.org (Postfix) with ESMTP id 215CB402E4
 for <dev@dpdk.org>; Thu, 26 Feb 2026 15:34:06 +0100 (CET)
Received: by mail-wr1-f52.google.com with SMTP id
 ffacd0b85a97d-436e87589e8so919580f8f.3
 for <dev@dpdk.org>; Thu, 26 Feb 2026 06:34:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1772116446; x=1772721246; darn=dpdk.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:sender:from:to:cc:subject:date
 :message-id:reply-to;
 bh=EjDdbf+eAjbLdgG/yexqas3+XFV2wX2tkLagCUlKWPs=;
 b=GehbJWpFPxurvCd8rjmKqZ/Re1/2Ty9/e+EdVHGKQmguGlsoMvJphmb0wE+4aqt0Yi
 qP6pA8eHaXfbePXDH7rW9fKXKbI7VdEvt31tDzHdGZK3tiX6k16KTOBsj7IXadSIx4tH
 UITxtSH7SO43mLaPbeXvshuF/kFXBRgVKYFBG6eSth/sb4Zl9wqWwqKny0Z1YA2SDVqu
 VBCrsUC7/dl/ZztwKkvvL02W+sSkIhGUnsemWPZCiVLQozXhX1JlVRF0dq9ZMRhiuJB3
 m0RY6U35BFdgC06zzLowcRBy9cM4kXEQHcdRjuclDQgyNC64jJ5L7twxaAgaYXegcS3O
 w0RQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1772116446; x=1772721246;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:sender:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=EjDdbf+eAjbLdgG/yexqas3+XFV2wX2tkLagCUlKWPs=;
 b=jJIi/nWiDu/m1A4dtDZVBAkmx7SDdKtUNDmjwlvAwGg6wSsXZIw6Dd1r6EAThuoEAj
 2Xw22qqI4U9LCM5iqXb6wQSHBR9Y311u2vPxja4tdPMOe5kEXZpRkvSDJNYXFXPL3ylr
 Uq+0E4V5SKjAkWZ3KohFWk0fyh1HG6E6UIg6nDB5PTBoVG50i89FPxp9ARg+ANW2wPbC
 ugmGZ1W5sOOgOsRPtRPnD1rAO6PG3G8ZDiy4eTVV4UNqEkq6yF3mMlJ/67StSb9qCTXn
 eB3hdMiMuem+SiagdceBJz5FKd36Qwtx1CgiT0OzxV9MoTri9gctPNk8fYNQVU72SrN4
 GE/w==
X-Gm-Message-State: AOJu0YwFItDbm1H6+M+4Nk8iAEuc0ht89ZibOeAQsCBTMEMAgv8U3d51
 k6XUAA5PCoXwohfYs7us025ObbQ0HLopJ/M5dE3yTz88mzBuVc5p+ZbL+iRRJQ==
X-Gm-Gg: ATEYQzxUbQsirKqdkAVYZbBkaplqLGTO2086hJ6rEBbTzJnOSS7hNvgm6AS095/nfE9
 LggFnYURCAr3KHTqdwErVBCXKya2N8SDlklF2jcCtzCXwSom1WYkUhykjkEJa0GZd7sW2e1EgJB
 6kFOBlY7CvokJ//6znS+G0EHtu0nF/Rj3puht6UHMjRYEMe3yJWPkjx3kJQIZrc/r1HxXXtyhEd
 LOfoy12B07cL6yaAEQ7TEHh7Jr8XjaulNCkLwuSwRmvdfTc1ldFp2n1eGMEeRiXSPN9iaPVXcVd
 DiMJIdNh2/Nt9SZ+RuHD1haeYeeUb97B2Nh46wI2qROGPgxh3ODiXhsV1wYwxI37/t+L3yazGau
 jat+MpzquFrZZxpJF0B1ivNR1VYa4VF2i0UiVm7XMyMm0IMQaPRHnxUoBwBasvMT1sMxT7Yje+Q
 L8+NO4KwwQl/n6iIuV2IJqKPQ3uJm11I60tB5f
X-Received: by 2002:a05:6000:24c1:b0:435:ad52:31e0 with SMTP id
 ffacd0b85a97d-4396f15b26amr38530414f8f.16.1772116445526; 
 Thu, 26 Feb 2026 06:34:05 -0800 (PST)
Received: from freepad.iliad.local ([213.36.9.96])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4398bb96b90sm17993866f8f.9.2026.02.26.06.34.04
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 26 Feb 2026 06:34:05 -0800 (PST)
Sender: Maxime Leroy <maxime.leroys@gmail.com>
From: Maxime Leroy <maxime@leroys.fr>
To: dev@dpdk.org
Cc: hemant.agrawal@nxp.com, stephen@networkplumber.org,
 david.marchand@redhat.com, Maxime Leroy <maxime@leroys.fr>, stable@dpdk.org
Subject: [PATCH v2 03/17] net/dpaa2: warn on rx descriptor limit only in high
 perf buffer mode
Date: Thu, 26 Feb 2026 15:33:27 +0100
Message-ID: <20260226143341.282188-4-maxime@leroys.fr>
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

