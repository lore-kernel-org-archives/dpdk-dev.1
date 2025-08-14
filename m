Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 94027CA0EDC
	for <dpdk-dev@archiver.kernel.org>; Thu, 14 Aug 2025 10:16:44 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id C30E84275B;
	Thu, 14 Aug 2025 12:16:43 +0200 (CEST)
Received: from mail-pf1-f178.google.com (mail-pf1-f178.google.com
 [209.85.210.178])
 by mails.dpdk.org (Postfix) with ESMTP id E920C42707
 for <dev@dpdk.org>; Thu, 14 Aug 2025 12:16:42 +0200 (CEST)
Received: by mail-pf1-f178.google.com with SMTP id
 d2e1a72fcca58-76e2eb09041so689815b3a.3
 for <dev@dpdk.org>; Thu, 14 Aug 2025 03:16:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=uetpeshawar-edu-pk.20230601.gappssmtp.com; s=20230601; t=1755166602;
 x=1755771402; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=6nOkyCyTM6IRpl7QVt/E8pLkMlk3FKWTX9MgEKk9rE0=;
 b=15I3vXL+C2LkjAITpRNYk0rXjtrwTu8R5R6p8f/BQmUdBBgluMGST18pzf0nQVbzzO
 XrqUukLG52z9Nj2VGVE11sE0y9ui1FCWVwAak8u1d6QQT1DxHnG2BriMbbzWdSiV1urv
 Wa51ABKsgmXyMTIxgYdYAZ59aZ9aDYUEI6cImXCLbeaITVgYM1edlHAOG6Qt169l0ccZ
 dNGiFeCios0bGGWzLjWAtboYJ/pK1c6neVp8pzaS3D6nOaewb/766pZIeOE/BqsQ0D50
 io6EHDDnWDhW8RMrAYFoaSCED2AuBFDKxi2zBHzB8gv5rHlq550Kkj4pMXNb7MsfFkBT
 2lnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1755166602; x=1755771402;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=6nOkyCyTM6IRpl7QVt/E8pLkMlk3FKWTX9MgEKk9rE0=;
 b=bcbapYmmNrlBq7EAXLGRraidiXl0fBkybDYnRya/LUx3nRoXrQ/y7uN0TANxBf0+Rk
 zMypVtfESZAQDcfOB8RYHTFzffk7Hw0qoEIBJNZgyIzkjw6qLux3+TvRvRBybIhmH6L/
 jWhBfruHWxHasy2cNYcKNdreYC2JdmGRVcsd7elIbe4pdgUKl7NsKWIcMLpsNJewdpK5
 xRUWJYjoiNdBdnBurlqTUe7hsOy0HeSj3kQtlnXf8W8MnR5CnUlaCw6ke9IXnsBDeVqb
 juXy38F4c/MtMvIJhnHcszqdwP+leZKEXV4Y+axQ0hzR1J0Hy0kc0yf8RcKjXUXu25Nh
 VRcA==
X-Gm-Message-State: AOJu0YyoY9/cROUB5LwPisD4LzOFo6tYOHEfmkNHaP8DfU+T5sKxSaaz
 SPvz3xd0OSqkocH2Zz93z1sAGzkJLv6PzIKA/JluYAQ3Ot7Xvhgxv5UHnRjBcKV7XOk=
X-Gm-Gg: ASbGncu/jEIaro6ON/x5JosZNRp2QUpUgL0v6eN4GnUDUUqg7EIIDrDoI4PKJhURvLT
 AtSofyzflUv7h6AfaMCHi2Gr9Mxg6WEd6bBSPhHWrb3wVLGInA8uGAYnn9yiK4BMF6KMqSjKU0U
 oFJgwjtxaCKe0OazN7p1V3L5195/nzbLea2AcmxBqqvMch18fMbgXZtvEykFboosUsN0bVNR+3p
 9xdVPxgTRlijjm+XXVLefQhBS5cKRC8QWBr4dcCHXyJDNWkYKx1PtHH6rUPrst62oyiEsPOUKqR
 3RS3Ap5gElg//WTITkmFRKhQrawToO+6NGzLk7MPhjS0UE2V/0y5qyGSoWDQmopQMgkJTt5hjqC
 knjPuF3zYKAtnYIWQQTMTC49iZLLTNoZoNEw7ZWh0CcPG1Eq7
X-Google-Smtp-Source: AGHT+IGKmpija41Xznm1YSocvtmMtI42AGFjPMpsCUmFOUkUZvFjRjJTDCHo9v6FnMlsIUtpum0APQ==
X-Received: by 2002:a05:6a00:398b:b0:76b:e805:30e4 with SMTP id
 d2e1a72fcca58-76e3200f33dmr3711783b3a.24.1755166601953; 
 Thu, 14 Aug 2025 03:16:41 -0700 (PDT)
Received: from localhost.localdomain ([64.62.143.197])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-76c3aeb6645sm17806947b3a.8.2025.08.14.03.16.41
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 14 Aug 2025 03:16:41 -0700 (PDT)
From: Khadem Ullah <14pwcse1224@uetpeshawar.edu.pk>
To: Dariusz Sosnowski <dsosnowski@nvidia.com>,
 Viacheslav Ovsiienko <viacheslavo@nvidia.com>,
 Bing Zhao <bingz@nvidia.com>, Ori Kam <orika@nvidia.com>,
 Suanming Mou <suanmingm@nvidia.com>, Matan Azrad <matan@nvidia.com>
Cc: dev@dpdk.org, stable@dpdk.org,
 Khadem Ullah <14pwcse1224@uetpeshawar.edu.pk>
Subject: [PATCH v4] net/mlx5: fix connection tracking state item validation
Date: Thu, 14 Aug 2025 06:16:01 -0400
Message-ID: <20250814101601.3532391-1-14pwcse1224@uetpeshawar.edu.pk>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250814085831.3511020-1-14pwcse1224@uetpeshawar.edu.pk>
References: <20250814085831.3511020-1-14pwcse1224@uetpeshawar.edu.pk>
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

This patch validate a connection tracking state when matching
'conntrack is' in rte_flow rules. Since conntrack item flags
is a bitmap, then any combination of RTE_FLOW_CONNTRACK_PKT_STATE_*
flags is a valid value to match on.

This patch validate the CT state item.
Fixes: aca19061e4b96 ("net/mlx5: validate connection tracking item")
Cc: stable@dpdk.org

Signed-off-by: Khadem Ullah <14pwcse1224@uetpeshawar.edu.pk>
---
 drivers/net/mlx5/mlx5_flow.h    |  5 +++++
 drivers/net/mlx5/mlx5_flow_dv.c |  5 +++++
 drivers/net/mlx5/mlx5_flow_hw.c | 10 ++++++++++
 3 files changed, 20 insertions(+)

diff --git a/drivers/net/mlx5/mlx5_flow.h b/drivers/net/mlx5/mlx5_flow.h
index e890e732c3..ed0c1fcfd2 100644
--- a/drivers/net/mlx5/mlx5_flow.h
+++ b/drivers/net/mlx5/mlx5_flow.h
@@ -100,6 +100,11 @@ enum mlx5_indirect_type {
 #define MLX5_INDIRECT_ACT_CT_GET_IDX(index) \
 	((index) & ((1 << MLX5_INDIRECT_ACT_CT_OWNER_SHIFT) - 1))
 
+#define MLX5_FLOW_CONNTRACK_PKT_STATE_ALL \
+	(RTE_FLOW_CONNTRACK_PKT_STATE_VALID | RTE_FLOW_CONNTRACK_PKT_STATE_CHANGED | \
+	 RTE_FLOW_CONNTRACK_PKT_STATE_INVALID | RTE_FLOW_CONNTRACK_PKT_STATE_DISABLED | \
+	 RTE_FLOW_CONNTRACK_PKT_STATE_BAD)
+
 /*
  * When HW steering flow engine is used, the CT action handles are encoded in a following way:
  * - bits 31:29 - type
diff --git a/drivers/net/mlx5/mlx5_flow_dv.c b/drivers/net/mlx5/mlx5_flow_dv.c
index 7b9e5018b8..f673637e7d 100644
--- a/drivers/net/mlx5/mlx5_flow_dv.c
+++ b/drivers/net/mlx5/mlx5_flow_dv.c
@@ -3289,6 +3289,11 @@ mlx5_flow_dv_validate_item_aso_ct(struct rte_eth_dev *dev,
 						  RTE_FLOW_ERROR_TYPE_ITEM,
 						  NULL,
 						  "Conflict status bits");
+		if (spec->flags & ~MLX5_FLOW_CONNTRACK_PKT_STATE_ALL)
+			return rte_flow_error_set(error, EINVAL,
+					RTE_FLOW_ERROR_TYPE_ITEM,
+					NULL,
+					"Invalid CT item flags");
 	}
 	/* State change also needs to be considered. */
 	*item_flags |= MLX5_FLOW_LAYER_ASO_CT;
diff --git a/drivers/net/mlx5/mlx5_flow_hw.c b/drivers/net/mlx5/mlx5_flow_hw.c
index 6dc16f80d3..7b279138bc 100644
--- a/drivers/net/mlx5/mlx5_flow_hw.c
+++ b/drivers/net/mlx5/mlx5_flow_hw.c
@@ -16996,6 +16996,7 @@ flow_hw_validate_rule_pattern(struct rte_eth_dev *dev,
 		switch (items->type) {
 		const struct rte_flow_item_ethdev *ethdev;
 		const struct rte_flow_item_tx_queue *tx_queue;
+		const struct rte_flow_item_conntrack *spec;
 		struct mlx5_txq_ctrl *txq;
 
 		case RTE_FLOW_ITEM_TYPE_REPRESENTED_PORT:
@@ -17016,6 +17017,15 @@ flow_hw_validate_rule_pattern(struct rte_eth_dev *dev,
 							  RTE_FLOW_ERROR_TYPE_ITEM_SPEC, items,
 							  "Invalid Tx queue");
 			mlx5_txq_release(dev, tx_queue->tx_queue);
+			break;
+		case RTE_FLOW_ITEM_TYPE_CONNTRACK:
+			spec = items->spec;
+			if (spec->flags & ~MLX5_FLOW_CONNTRACK_PKT_STATE_ALL)
+				return rte_flow_error_set(error, EINVAL,
+						RTE_FLOW_ERROR_TYPE_ITEM,
+						NULL,
+						"Invalid CT item flags");
+			break;
 		default:
 			break;
 		}
-- 
2.43.0

