Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1E532CCFA00
	for <dpdk-dev@archiver.kernel.org>; Tue,  4 Nov 2025 05:29:22 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 2C883402F0;
	Tue,  4 Nov 2025 06:29:21 +0100 (CET)
Received: from mail-pf1-f176.google.com (mail-pf1-f176.google.com
 [209.85.210.176])
 by mails.dpdk.org (Postfix) with ESMTP id 00C1D4029A
 for <dev@dpdk.org>; Tue,  4 Nov 2025 06:29:19 +0100 (CET)
Received: by mail-pf1-f176.google.com with SMTP id
 d2e1a72fcca58-781206cce18so5504509b3a.0
 for <dev@dpdk.org>; Mon, 03 Nov 2025 21:29:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1762234159;
 x=1762838959; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=+0xGKvb4s3y76CRxUEFcf/y9Rl/0w7aHHiEz7NmqzZY=;
 b=GhGzbcFaiTBf2x0wujgvNumNY+sEHSAy//pFJx+Y5vxp/oLAf1DEqXy7/WnLt4oKW0
 Q8GIKABSpweNkMswawjwllnhLjbR5qlgAfbFQscp4U1fpydVuaLqNxxkF+vFDb38+Y6T
 46JL9FqgtM2JCEe0TawXeyZzILIAgl3fA5IheBPHvRNanuUuHlxrA4+yPJNKNzvDI5On
 YDUT2ImkcUr96SxzJa7IH1bp90yWSRDDmRF8zL/Uq3U4bJFgG8dObBgejACLfuJMs5p+
 nlf4/39Cz6oxTW2E2+ppY6J/PVGmR042EZzwY4njy9nYF+cQqBMXwauOgN1+9Y3WkAE1
 QdTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1762234159; x=1762838959;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=+0xGKvb4s3y76CRxUEFcf/y9Rl/0w7aHHiEz7NmqzZY=;
 b=prQBnv5mOZiAARMGM8/Zn1HBHBkpQOHZXOqWsb5hvPxl8V6QRmB2Ql19UIgd9Hmes7
 d3Mz4mfU0Rlkkq/IGwuKBL6KUb3t4GPOcov6o/goAY7sho3eJaDk4kkDlPsUtkobY2zE
 3DSbR2oYneHNDzKHc9HrK9ewBloTP5L8WZFEnS4tDRu/rUTOzj+2nBwt3jp7wmI2dH1b
 kKwHj/2q2VVDYMxJYcL4nptyhxH8LEp8nOBDA7t8UvmgL8yVI9fbI8MaKiWVZx7k14kY
 TaOTTp0eMU/AhLxVe0X5ahpGLIHuQv68Ri5UaiIQJ3Emf6Gd9uOr2HaKCfnY5rpmQyKA
 lWsA==
X-Gm-Message-State: AOJu0YwfPy6fRSgbji3wjOBcNiC0P6zeFu8nMQpegspgPPa1xj8Rk/xh
 ZnQNvaKsjLf+1H4ZGgSFBmMbXYI3dun10s/RMNd14+vWcLxL/p5Wj2ssfTCMRgCvfW5b6ju6AxI
 8Tp/y
X-Gm-Gg: ASbGncsMrhxr6pW71McHQVAUf6H+31qwAhdwmhFQ5djR7IsCgr6se1gIIicK+ZQCa95
 3rjePd2rwwRCs5MeFErgKRTs1Z3jE2XM3XhvnQ225yYq8hJ75gJP69fkQsTtYY5VqT75RBBX8Gl
 ZTju705f35/LkxONY2/Vf5uzg/x9oHq94tw+CiKORQmR9P7JppB0+0NOndbffSHCg3l3kur5IjR
 4BmdcQZpmQ1PLdjiERVcmFR3UfGMb87/tTgGU493YX8bS96AYoPYI1oVpOs7SLXPORmnSk8/fuQ
 c8lUfw6ud5mj4KUuHIbL4VugQ8WXONPJ6yqyCHei4gOpEpbxyd+Awl5EODTaScvFV72pf2qGvOM
 HcMAhEL1SRLatgSXfghytmGna8ZNvmZHmaejhQJeyc/Q5S59OdgytkYMTXqyMIuSrKdqDW8fahj
 PL3R3Tn+SAjr/zqQoWmsjqDmlhy2hgQhWV7Zg3F/U=
X-Google-Smtp-Source: AGHT+IHp278n7EGbHNYun5fgGM8qKOc8jF++/1L1sIqA0MYQaW+rkumr5G+/z9ROKW8Q9iZhv5qNGg==
X-Received: by 2002:a05:6a20:3d84:b0:343:8069:7568 with SMTP id
 adf61e73a8af0-34e2afa23d3mr2388682637.27.1762234159165; 
 Mon, 03 Nov 2025 21:29:19 -0800 (PST)
Received: from phoenix.lan (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-7acd3d0130asm1364095b3a.32.2025.11.03.21.29.18
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 03 Nov 2025 21:29:18 -0800 (PST)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>, jin.liu@corigine.com,
 stable@dpdk.org, Chaoyong He <chaoyong.he@corigine.com>,
 =?UTF-8?q?Niklas=20S=C3=B6derlund?= <niklas.soderlund@corigine.com>,
 Peng Zhang <peng.zhang@corigine.com>
Subject: [PATCH] net/nfp: fix use after free
Date: Mon,  3 Nov 2025 21:29:15 -0800
Message-ID: <20251104052915.270245-1-stephen@networkplumber.org>
X-Mailer: git-send-email 2.51.0
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

The code to cleanup metering was using the objects after calling
rte_free(). Fix by using LISTFOREACH_SAFE

Fixes: 2caf84a71cfd ("net/nfp: add meter options")
Cc: jin.liu@corigine.com
Cc: stable@dpdk.org

Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
---
 drivers/net/nfp/nfp_mtr.c | 19 +++++++++++++------
 1 file changed, 13 insertions(+), 6 deletions(-)

diff --git a/drivers/net/nfp/nfp_mtr.c b/drivers/net/nfp/nfp_mtr.c
index d4f2c4f2f0..4833ebd881 100644
--- a/drivers/net/nfp/nfp_mtr.c
+++ b/drivers/net/nfp/nfp_mtr.c
@@ -12,6 +12,13 @@
 #include "flower/nfp_flower_representor.h"
 #include "nfp_logs.h"
 
+#ifndef LIST_FOREACH_SAFE
+#define	LIST_FOREACH_SAFE(var, head, field, tvar)			\
+	for ((var) = LIST_FIRST((head));				\
+	    (var) && ((tvar) = LIST_NEXT((var), field), 1);		\
+	    (var) = (tvar))
+#endif
+
 #define NFP_MAX_POLICY_CNT             NFP_MAX_MTR_CNT
 #define NFP_MAX_PROFILE_CNT            NFP_MAX_MTR_CNT
 
@@ -1124,10 +1131,10 @@ nfp_mtr_priv_init(struct nfp_pf_dev *pf_dev)
 void
 nfp_mtr_priv_uninit(struct nfp_pf_dev *pf_dev)
 {
-	struct nfp_mtr *mtr;
+	struct nfp_mtr *mtr, *tmp_mtr;
 	struct nfp_mtr_priv *priv;
-	struct nfp_mtr_policy *mtr_policy;
-	struct nfp_mtr_profile *mtr_profile;
+	struct nfp_mtr_policy *mtr_policy, *tmp_policy;
+	struct nfp_mtr_profile *mtr_profile, *tmp_profile;
 	struct nfp_app_fw_flower *app_fw_flower;
 
 	app_fw_flower = NFP_PRIV_TO_APP_FW_FLOWER(pf_dev->app_fw_priv);
@@ -1135,17 +1142,17 @@ nfp_mtr_priv_uninit(struct nfp_pf_dev *pf_dev)
 
 	rte_eal_alarm_cancel(nfp_mtr_stats_request, (void *)app_fw_flower);
 
-	LIST_FOREACH(mtr, &priv->mtrs, next) {
+	LIST_FOREACH_SAFE(mtr, &priv->mtrs, next, tmp_mtr) {
 		LIST_REMOVE(mtr, next);
 		rte_free(mtr);
 	}
 
-	LIST_FOREACH(mtr_profile, &priv->profiles, next) {
+	LIST_FOREACH_SAFE(mtr_profile, &priv->profiles, next, tmp_profile) {
 		LIST_REMOVE(mtr_profile, next);
 		rte_free(mtr_profile);
 	}
 
-	LIST_FOREACH(mtr_policy, &priv->policies, next) {
+	LIST_FOREACH_SAFE(mtr_policy, &priv->policies, next, tmp_policy) {
 		LIST_REMOVE(mtr_policy, next);
 		rte_free(mtr_policy);
 	}
-- 
2.51.0

