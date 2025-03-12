Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4342CC28B2E
	for <dpdk-dev@archiver.kernel.org>; Wed, 12 Mar 2025 23:28:20 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 09B6440E45;
	Thu, 13 Mar 2025 00:27:58 +0100 (CET)
Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com
 [209.85.214.171])
 by mails.dpdk.org (Postfix) with ESMTP id 7BDCB40E2B
 for <dev@dpdk.org>; Thu, 13 Mar 2025 00:27:54 +0100 (CET)
Received: by mail-pl1-f171.google.com with SMTP id
 d9443c01a7336-22355618fd9so7189545ad.3
 for <dev@dpdk.org>; Wed, 12 Mar 2025 16:27:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1741822073;
 x=1742426873; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=w4fA18v5wTJfeaDoXOqYsTlTmFGNBf4BQEf8LxFNkN0=;
 b=WFQx/uEFY27fmptiDBqlhK/fAEUhdS3FhL658wnfc5s7TdkDtor9eYZmoGwsqopMj/
 g1SMDbizUtnQSZp4b+/OUpLire6o66GsZERi4i28ywKTc8ApwNYjks4Upkh3IeXQ7BR3
 3qjOePV5WyDBgkPeUTqo7u4r6mFvZpCPB8SrSv4oaL7N7P6JLCYioMrGLb7/svvOL2/m
 Q7yHnzWo5b3CgzehjtdLSaYkw+kyxY03ZoWTlC2agzcnEoXWGEV5qxfZPb1pqHt9yZar
 XYYxPP5U2HHxKFnj1eSQbaKmbW8vLeBV1Gcb9Fsu72LDZjwGO+UFRTm3LZp7DKBm6ljy
 Z2EA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1741822073; x=1742426873;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=w4fA18v5wTJfeaDoXOqYsTlTmFGNBf4BQEf8LxFNkN0=;
 b=SUZkSBE2A690qKYSi4BkPbSgS6rfgLoLABPgUqUnlJLL+c8TOAWk1F2b6MgqL0F2Lg
 oELH5Y3vunFOxn930osgk5bPswD6qmCN9HJwG2au6+gOOlZPumZMLDomsMiollJCN61q
 2eH8hoL9BuwZ3GJoEzJ2M026poUOr8yakW6q4ObRG5EhCoLH35CT/ZgPUpw5SeZ6Q9+W
 JpatbrpFJOjX7MqHcNT6oSBL0aUrMgmM18U+ZH3UpwRNtSHtBGsYehq4vvdFOvcQxaDH
 wCpT8Fha/NHnFBj7Q05KKcFSUUmh1HsZ6Q/PVxJXkvbLn76HYIapie7+1Q3gYOm/z8xi
 RL8g==
X-Gm-Message-State: AOJu0YwpEnkebSmAGA1PH/sezNizgXGEkFtRhL/FJzpyiL/eQlMYoOjX
 S2tK1Ly4iYCl5YOPaGLCovnFV5c84e9WBvp+GuT9bg0hGiSbcEjy7slFzA7uEA/qMfzB86PiNUu
 m
X-Gm-Gg: ASbGncsCFZ+6YNZma0CbdeeGODKSD2Rl7pogjglRUNgUFuTh34AE1u8VN2LhiAHSnJG
 24YgDFNWzAG+eAnFpZ3rEkEpGRX+L14qYhF3gT9HpmcSI/MRHpX5KDFEI34aPA8epWnqgnpGV/d
 9fHbjbXuLN3gOUGhJqkWYDOcmVaV2BXkC/eOOfT8wm5cDoFWSjjsJqsGAos78YtqNdV+bhna0bR
 NffFzaFQDLj0yduVriamAS5x8uJF5dX1vqhOTWvnXrX1+AXSYsHxkAKfiiYeVy/lVXjNg2Mw+iK
 VSPQ5ZdDiOvtFM40GWLQE/TNk/c71zpT/nMmSyMOr0dVEpJX6K3qtvQuplTGiYgZ2zI7elKmu/N
 njQLBcYDlVL8lsbKH5ROWqw==
X-Google-Smtp-Source: AGHT+IEoDGCo3gMb8yVIZ43dbmain2of9vIZgtnC6aMQHtvJ29R6dW4vRiFNzu9zMSGmEdu0+w0UGw==
X-Received: by 2002:a05:6a21:6e8a:b0:1ee:e2ac:5159 with SMTP id
 adf61e73a8af0-1f58cb438c6mr14291684637.19.1741822073507; 
 Wed, 12 Mar 2025 16:27:53 -0700 (PDT)
Received: from hermes.local (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-af56ea95651sm111917a12.73.2025.03.12.16.27.52
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 12 Mar 2025 16:27:53 -0700 (PDT)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>,
 Dariusz Sosnowski <dsosnowski@nvidia.com>,
 Viacheslav Ovsiienko <viacheslavo@nvidia.com>,
 Bing Zhao <bingz@nvidia.com>, Ori Kam <orika@nvidia.com>,
 Suanming Mou <suanmingm@nvidia.com>, Matan Azrad <matan@nvidia.com>
Subject: [RFC 5/7] net/mlx5: replace unnecessary comma operators
Date: Wed, 12 Mar 2025 16:27:02 -0700
Message-ID: <20250312232739.228295-6-stephen@networkplumber.org>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20250312232739.228295-1-stephen@networkplumber.org>
References: <20250312232739.228295-1-stephen@networkplumber.org>
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

Use of comma as statement separator is discouraged and
reported as warning by clang with -Wcomma

Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
---
 drivers/net/mlx5/linux/mlx5_os.c    |  4 ++--
 drivers/net/mlx5/linux/mlx5_verbs.c |  2 +-
 drivers/net/mlx5/mlx5_flow.c        | 12 ++++++------
 drivers/net/mlx5/mlx5_flow_dv.c     |  2 +-
 drivers/net/mlx5/mlx5_nta_split.c   |  4 ++--
 5 files changed, 12 insertions(+), 12 deletions(-)

diff --git a/drivers/net/mlx5/linux/mlx5_os.c b/drivers/net/mlx5/linux/mlx5_os.c
index 573e846ed2..5c75d25aa8 100644
--- a/drivers/net/mlx5/linux/mlx5_os.c
+++ b/drivers/net/mlx5/linux/mlx5_os.c
@@ -431,8 +431,8 @@ __mlx5_discovery_misc5_cap(struct mlx5_priv *priv)
 		DRV_LOG(INFO, "No SW steering support");
 		return;
 	}
-	dv_attr.type = IBV_FLOW_ATTR_NORMAL,
-	dv_attr.match_mask = (void *)&matcher_mask,
+	dv_attr.type = IBV_FLOW_ATTR_NORMAL;
+	dv_attr.match_mask = (void *)&matcher_mask;
 	dv_attr.match_criteria_enable =
 			(1 << MLX5_MATCH_CRITERIA_ENABLE_OUTER_BIT) |
 			(1 << MLX5_MATCH_CRITERIA_ENABLE_MISC5_BIT);
diff --git a/drivers/net/mlx5/linux/mlx5_verbs.c b/drivers/net/mlx5/linux/mlx5_verbs.c
index 454bd7c77e..10fbe08ac3 100644
--- a/drivers/net/mlx5/linux/mlx5_verbs.c
+++ b/drivers/net/mlx5/linux/mlx5_verbs.c
@@ -877,7 +877,7 @@ mlx5_txq_ibv_qp_create(struct rte_eth_dev *dev, uint16_t idx)
 	 * dev_cap.max_sge limit and will still work properly.
 	 */
 	qp_attr.cap.max_send_sge = 1;
-	qp_attr.qp_type = IBV_QPT_RAW_PACKET,
+	qp_attr.qp_type = IBV_QPT_RAW_PACKET;
 	/* Do *NOT* enable this, completions events are managed per Tx burst. */
 	qp_attr.sq_sig_all = 0;
 	qp_attr.pd = priv->sh->cdev->pd;
diff --git a/drivers/net/mlx5/mlx5_flow.c b/drivers/net/mlx5/mlx5_flow.c
index f8b3e504b3..602993b8f7 100644
--- a/drivers/net/mlx5/mlx5_flow.c
+++ b/drivers/net/mlx5/mlx5_flow.c
@@ -11108,12 +11108,12 @@ flow_tunnel_add_default_miss(struct rte_eth_dev *dev,
 				(error, ENOMEM,
 				RTE_FLOW_ERROR_TYPE_ACTION_CONF,
 				NULL, "invalid default miss RSS");
-		ctx->action_rss.func = RTE_ETH_HASH_FUNCTION_DEFAULT,
-		ctx->action_rss.level = 0,
-		ctx->action_rss.types = priv->rss_conf.rss_hf,
-		ctx->action_rss.key_len = priv->rss_conf.rss_key_len,
-		ctx->action_rss.queue_num = priv->reta_idx_n,
-		ctx->action_rss.key = priv->rss_conf.rss_key,
+		ctx->action_rss.func = RTE_ETH_HASH_FUNCTION_DEFAULT;
+		ctx->action_rss.level = 0;
+		ctx->action_rss.types = priv->rss_conf.rss_hf;
+		ctx->action_rss.key_len = priv->rss_conf.rss_key_len;
+		ctx->action_rss.queue_num = priv->reta_idx_n;
+		ctx->action_rss.key = priv->rss_conf.rss_key;
 		ctx->action_rss.queue = ctx->queue;
 		if (!priv->reta_idx_n || !priv->rxqs_n)
 			return rte_flow_error_set
diff --git a/drivers/net/mlx5/mlx5_flow_dv.c b/drivers/net/mlx5/mlx5_flow_dv.c
index 61d3101ce8..ad1f5fc124 100644
--- a/drivers/net/mlx5/mlx5_flow_dv.c
+++ b/drivers/net/mlx5/mlx5_flow_dv.c
@@ -18804,7 +18804,7 @@ flow_dv_create_mtr_tbls(struct rte_eth_dev *dev,
 			}
 		}
 		/* Create default matcher in drop table. */
-		matcher.tbl = mtrmng->drop_tbl[domain],
+		matcher.tbl = mtrmng->drop_tbl[domain];
 		tbl_data = container_of(mtrmng->drop_tbl[domain],
 				struct mlx5_flow_tbl_data_entry, tbl);
 		if (!mtrmng->def_matcher[domain]) {
diff --git a/drivers/net/mlx5/mlx5_nta_split.c b/drivers/net/mlx5/mlx5_nta_split.c
index 6a85ab7fd1..c95da56d72 100644
--- a/drivers/net/mlx5/mlx5_nta_split.c
+++ b/drivers/net/mlx5/mlx5_nta_split.c
@@ -345,8 +345,8 @@ flow_nta_mreg_create_cb(void *tool_ctx, void *cb_ctx)
 	/* (match REG 'tag') or all. */
 	items[1].type = RTE_FLOW_ITEM_TYPE_END;
 	/* (Mark) or void + copy to Rx meta + jump to the MREG_ACT_TABLE_GROUP. */
-	actions[1].type = RTE_FLOW_ACTION_TYPE_MODIFY_FIELD,
-	actions[1].conf = &rx_meta,
+	actions[1].type = RTE_FLOW_ACTION_TYPE_MODIFY_FIELD;
+	actions[1].conf = &rx_meta;
 	actions[2].type = RTE_FLOW_ACTION_TYPE_JUMP;
 	actions[2].conf = &jump;
 	actions[3].type = RTE_FLOW_ACTION_TYPE_END;
-- 
2.47.2

