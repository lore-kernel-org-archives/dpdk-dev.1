Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B44EBC2A09B
	for <dpdk-dev@archiver.kernel.org>; Fri,  7 Aug 2026 13:07:04 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 98FC5402DF;
	Fri,  7 Aug 2026 15:07:03 +0200 (CEST)
Received: from mail-yw1-f180.google.com (mail-yw1-f180.google.com
 [209.85.128.180])
 by mails.dpdk.org (Postfix) with ESMTP id BA0254027E
 for <dev@dpdk.org>; Thu,  6 Aug 2026 19:26:53 +0200 (CEST)
Received: by mail-yw1-f180.google.com with SMTP id
 00721157ae682-81ed000b507so23779147b3.0
 for <dev@dpdk.org>; Thu, 06 Aug 2026 10:26:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=weka.io; s=google; t=1786037213; x=1786642013; darn=dpdk.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=9xtJf7MLPYDWVSPr7+eVIe55sJGgXemZtJDu1MyRIvY=;
 b=Kcm4DTVDUZQF8hTe7JDQ8aZTtoKOVjcvBd9+jhh0rVXSK38Nnbrqkauwn9517exoRj
 JBp47icDBDW278Y/2hqHIxjTGKULAmAU/RDp9Rr37uwN6NQxeQUmBSTw9OTpHJ4bALej
 Gt7NGR0wqpmx8sDMbhyBeR943Fdn6DsKpfFs4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786037213; x=1786642013;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=9xtJf7MLPYDWVSPr7+eVIe55sJGgXemZtJDu1MyRIvY=;
 b=rEuwhfrmxxHMqx5nzWEr8LBfXQaTw4cbzx6D+ljKSLye7FSB0r3UmPGHi3A6vGeIps
 yNkWxKh7laYJMpl25nGXo7mFUOmmR7HAruYz7x+5DR2x52+GxTYCGlwngPR9tR6vmMVR
 9xqUYikqD5NSHQCp4JEhIFyvXNDgTv2klVbi7D5MpCmGGpFyrtdF6eUSmyx9OyPhwlh+
 9kJxXsnXQ+oCH00KpQCAByDTUGy4a3x3NELQK0ax01yIutstIiGVXtd2pOpqwNvQ/KK3
 sCc47Qwx1VcAPPLJ4eUije0OEVsjBT+p2sMO3deRoXyBtB8NEsfjrgd/tYwrOD16OEiw
 r7Ig==
X-Gm-Message-State: AOJu0YyMH10nVctG+x68LJvqNjggxCfzVMgMpuetvLcwEqyi9GZ++NwX
 rZtFjV0TX1aeaky8eSTm0dgHlR1JaqR4fHs+t7HIE07AD+wJOS3MaeB7RfbhQXc4CW0e3Smjh3w
 QJPfAhUeq3z4FuSt39+XvxX30UglL4QOjO3yKM7li9fi33DcssuOWnpJxeHztpT1kRwVarVO6mM
 29FXCuAcE3a89IZUV9HhmDMuLJfIEroUXyaZBtrIH99KU=
X-Gm-Gg: AR+sD132QRu2YTldPYb9Crqjr9pY0Shf4TTInByGG9cpX4CefijIuxjncxUyATT4/gR
 ZaQ+v/ZeYqi/55rJoDHdadc72KcyANQrUMI5yn1G2TQ2XLRT5hb4fM8tmvoweoifJROYSWaqUJN
 kXnJc46jdcSuEH/38lDzGAUyQBJsY+RDc1njzhOyhVZP5qZ8K2LYwsEb8sVy06yN1LG4Vt15Zg/
 2DrAvBO8/VgvNcFxGNxDUZ7d1Ffm0V9Q04WzB6QlAgmUKO0GVKazy4PJSmax0Q93Qh8VN7B6RCR
 ZzDPiHJXFjGklQdRr3PG/KS7M0WS+y9ESdWdlxbo+f+rpJWowPK6BnOtUgjoNnudPO6ZqOvtY10
 1CV6912LXg8n+UA1vrfU0BdKHSsu+rVk1Rnc/EGa/8ZTgRjZlWkICUubCZgUq55Sr7/4NnOS/bP
 mS4UPOJOugKJ8IDXN9uPNKd8OQUthdcUeh6SObviYbmio2B37dTnDJSpBA8Di3eMW8lRZ4TPzaH
 sfXngBACRJmVdMZG1SpuxnIZ9fVQWi9CZdTumiRwQ==
X-Received: by 2002:a05:690c:6081:b0:81e:6fd:93b4 with SMTP id
 00721157ae682-82022523c7bmr100376837b3.19.1786037212641; 
 Thu, 06 Aug 2026 10:26:52 -0700 (PDT)
Received: from rita-ruvinsky-Precision-3490.wekalab.io ([185.114.120.1])
 by smtp.gmail.com with ESMTPSA id
 00721157ae682-82013261c83sm43073417b3.18.2026.08.06.10.26.50
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 06 Aug 2026 10:26:52 -0700 (PDT)
From: Rita Ruvinsky <rita.ruvinsky@weka.io>
To: dev@dpdk.org
Cc: longli@microsoft.com, weh@microsoft.com, stephen@networkplumber.org,
 Rita Ruvinsky <rita.ruvinsky@weka.io>, stable@dpdk.org
Subject: [PATCH v2 1/2] net/mana: fix MR length truncation for chunks over 4GB
Date: Thu,  6 Aug 2026 20:26:39 +0300
Message-ID: <20260806172640.2456451-1-rita.ruvinsky@weka.io>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Fri, 07 Aug 2026 15:07:01 +0200
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

mana_range.len is a uint32_t, so a mempool chunk of 4GB or more
truncates modulo 2^32 -- exactly 4GB becomes 0, 15GB becomes 3GB.

The guard against priv->max_mr_size cannot catch this because it
compares the already-truncated value, and the device advertises
max_mr_size as UINT64_MAX. ibv_reg_mr() then fails with EINVAL on a
zero length, or silently registers a region far shorter than the pool,
so lookups for buffers past that boundary never find an MR and no Rx
WQE can be posted.

Widen the length to uint64_t through the MR path, including the
multi-process request that forwards it to the primary process.

Fixes: 0f5db3c68ba7 ("net/mana: implement memory registration")
Cc: stable@dpdk.org
Signed-off-by: Rita Ruvinsky <rita.ruvinsky@weka.io>
Reviewed-by: Long Li <longli@microsoft.com>
---
v2:
- Rebased on main; resolves the conflict with the device reset
  changes in mana.h reported by Stephen Hemminger and the Intel CI.
- Added Reviewed-by from Long Li.

 drivers/net/mana/mana.h |  4 ++--
 drivers/net/mana/mp.c   |  4 ++--
 drivers/net/mana/mr.c   | 11 ++++++-----
 3 files changed, 10 insertions(+), 9 deletions(-)

diff --git a/drivers/net/mana/mana.h b/drivers/net/mana/mana.h
index a7b301484a..79879b7626 100644
--- a/drivers/net/mana/mana.h
+++ b/drivers/net/mana/mana.h
@@ -602,7 +602,7 @@ struct mana_mp_param {
 
 	/* MANA_MP_REQ_CREATE_MR */
 	uintptr_t addr;
-	uint32_t len;
+	uint64_t len;
 };
 
 #define MANA_MP_NAME	"net_mana_mp"
@@ -611,7 +611,7 @@ int mana_mp_init_secondary(void);
 void mana_mp_uninit_primary(void);
 void mana_mp_uninit_secondary(void);
 int mana_mp_req_verbs_cmd_fd(struct rte_eth_dev *dev);
-int mana_mp_req_mr_create(struct mana_priv *priv, uintptr_t addr, uint32_t len);
+int mana_mp_req_mr_create(struct mana_priv *priv, uintptr_t addr, uint64_t len);
 int mana_map_doorbell_secondary(struct rte_eth_dev *eth_dev, int fd);
 
 int mana_mp_req_on_rxtx(struct rte_eth_dev *dev, enum mana_mp_req_type type);
diff --git a/drivers/net/mana/mp.c b/drivers/net/mana/mp.c
index 1670f1ea9c..f278bcdce5 100644
--- a/drivers/net/mana/mp.c
+++ b/drivers/net/mana/mp.c
@@ -20,7 +20,7 @@ extern struct mana_shared_data *mana_shared_data;
  * Process MR request from secondary process.
  */
 static int
-mana_mp_mr_create(struct mana_priv *priv, uintptr_t addr, uint32_t len)
+mana_mp_mr_create(struct mana_priv *priv, uintptr_t addr, uint64_t len)
 {
 	struct ibv_mr *ibv_mr;
 	int ret;
@@ -331,7 +331,7 @@ mana_mp_req_verbs_cmd_fd(struct rte_eth_dev *dev)
  * Request the primary process to register a MR.
  */
 int
-mana_mp_req_mr_create(struct mana_priv *priv, uintptr_t addr, uint32_t len)
+mana_mp_req_mr_create(struct mana_priv *priv, uintptr_t addr, uint64_t len)
 {
 	struct rte_mp_msg mp_req = {0};
 	struct rte_mp_msg *mp_res;
diff --git a/drivers/net/mana/mr.c b/drivers/net/mana/mr.c
index 8914f4cf04..0ce1a76ed5 100644
--- a/drivers/net/mana/mr.c
+++ b/drivers/net/mana/mr.c
@@ -13,7 +13,8 @@
 struct mana_range {
 	uintptr_t	start;
 	uintptr_t	end;
-	uint32_t	len;
+	/* 64-bit: a mempool chunk can be 4GB or more, which overflows uint32_t. */
+	uint64_t	len;
 };
 
 void
@@ -47,13 +48,13 @@ mana_new_pmd_mr(struct mana_mr_btree *local_tree, struct mana_priv *priv,
 
 	for (i = 0; i < pool->nb_mem_chunks; i++) {
 		if (ranges[i].len > priv->max_mr_size) {
-			DP_LOG(ERR, "memory chunk size %u exceeding max MR",
+			DP_LOG(ERR, "memory chunk size %" PRIu64 " exceeding max MR",
 			       ranges[i].len);
 			return -ENOMEM;
 		}
 
 		DP_LOG(DEBUG,
-		       "registering memory chunk start 0x%" PRIxPTR " len %u",
+		       "registering memory chunk start 0x%" PRIxPTR " len %" PRIu64,
 		       ranges[i].start, ranges[i].len);
 
 		if (rte_eal_process_type() == RTE_PROC_SECONDARY) {
@@ -62,7 +63,7 @@ mana_new_pmd_mr(struct mana_mr_btree *local_tree, struct mana_priv *priv,
 						    ranges[i].len);
 			if (ret) {
 				DP_LOG(ERR,
-				       "MR failed start 0x%" PRIxPTR " len %u",
+				       "MR failed start 0x%" PRIxPTR " len %" PRIu64,
 				       ranges[i].start, ranges[i].len);
 				return ret;
 			}
@@ -98,7 +99,7 @@ mana_new_pmd_mr(struct mana_mr_btree *local_tree, struct mana_priv *priv,
 				return ret;
 			}
 		} else {
-			DP_LOG(ERR, "MR failed at 0x%" PRIxPTR " len %u",
+			DP_LOG(ERR, "MR failed at 0x%" PRIxPTR " len %" PRIu64,
 			       ranges[i].start, ranges[i].len);
 			return -errno;
 		}
-- 
2.43.0

