Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DB743C87FCB
	for <dpdk-dev@archiver.kernel.org>; Tue, 12 Aug 2025 12:42:10 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 384F6402CC;
	Tue, 12 Aug 2025 14:42:09 +0200 (CEST)
Received: from mail-pf1-f169.google.com (mail-pf1-f169.google.com
 [209.85.210.169])
 by mails.dpdk.org (Postfix) with ESMTP id DE6AE402A7
 for <dev@dpdk.org>; Tue, 12 Aug 2025 14:42:07 +0200 (CEST)
Received: by mail-pf1-f169.google.com with SMTP id
 d2e1a72fcca58-76bed310fa1so4571184b3a.2
 for <dev@dpdk.org>; Tue, 12 Aug 2025 05:42:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=uetpeshawar-edu-pk.20230601.gappssmtp.com; s=20230601; t=1755002527;
 x=1755607327; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=/32VpI40R9aC3UE3nsnUHTCkVozldm0aG1t5RnfzV1I=;
 b=vJPIcIi2znaBP/n/LSs7s6QaBIUvvDvyqFkS77KKjggN3WQgdGnDL7prtip2ANkJBr
 nGBc2JJoI6snZCQux8i5SBDwXKR1wHfsb8aJ7m8jZkrTJWCeeELezbnDTJor7Bf+GJvc
 cnvy+M+mtYq5ojQlAdmktzp7e90s5l6zafF+j62kCmyqkkz84Os+PHbpsMX69nUJHgAY
 gDcKpO0o87RViUNkGL/IOCJTXnBjyoJR2udtJRGPXv21jicVyssjRBrOeH8on8sU2EX7
 Q7l69HK4UXv7BVafYJgLwyUZAzRGQ9Xr9CBykF9JZbajEv9x5y1ZAkOfnlpwn/A99dLq
 D1IA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1755002527; x=1755607327;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=/32VpI40R9aC3UE3nsnUHTCkVozldm0aG1t5RnfzV1I=;
 b=n6Qn/KA4pS0bPLusg2cB4iiFdyk84HX7P7fxhevMnO1W/7ho/c3rme4Gu5kLMxgPFE
 x2gQAn28TCmJHjYBIsLNX5rZLIf6ztCN/1MFUWSTGzuCEySSpJCVib9BfxKoZjnLunU2
 SFyopBrn1jpVqZchAXVDOqKkivWs69y3LztZJs8xbKJ+5whgFGbqWsArVtR+z9tABJk7
 SPvb9HcBbsFveo06g/zc3zX3ZgyWZgmFoeC35Nq05/krR0m/f8HaTHwVPsAqxDshBdu8
 k+c6A1xA0wvDwEB0p6/wxwbq59Xcno461r77VcK8EPYE+dVci7TqZjxZTj3XbD15BX9r
 EopA==
X-Gm-Message-State: AOJu0Ywr6PYxp/8htGGZcc80frhqLZiaPezmapFbwhEWTCfLWlnBrIVG
 Br26GvSxqbu9s2Me9ShmQ5mnimodBdhx+zaeLQuDAxnF6BkM0VjegafWQMN10WXuF0o=
X-Gm-Gg: ASbGncs3JzkGu8GCK5ajxvMgwn0uIg9BGNMluEUEZB/vd7rpm265/292nKbzGdbuyGF
 OrSchOC5NBJwNHFfLKR8ljdupVjSctgRCQvwuSgXQmUaERl3UjiEJVX1+Tc+Pt1Cym16F8yPkU8
 EUCl2St5v0cfQfxYuzbJWSjOBiLpW4uxYzrwwcjgieGvk7YQU45nKamqzqxxAg7qQG9FQRAM0MK
 ASJjP56ZlgbThXr+mpvXoG2tfmrwBZLHQ3ZlY1zRmGp8LVRyHMaM7Qk2IM5wKoGLSO9FZQ+OBXu
 icI2oIgOw71gEWZILO0j2oFXfIN14er7obnSqHuLGKy2uETSV33o7e+FiiFVnhfyf7H2GupnUB1
 hBv7hn54pOjL8idphcbJzudub1I9FPTPMOHW1mu0xWXdaqLYA
X-Google-Smtp-Source: AGHT+IEpSdy/eQyX0lRVbNQyFbqrHzKl3khwl/AkaZsqtVkVo2qP5c9POMX32N4UUk3ixDKnWVl7rw==
X-Received: by 2002:a05:6a00:1894:b0:76b:f1c0:224b with SMTP id
 d2e1a72fcca58-76c461f593fmr23059960b3a.23.1755002526841; 
 Tue, 12 Aug 2025 05:42:06 -0700 (PDT)
Received: from localhost.localdomain ([64.62.143.197])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-76bccfbcbf0sm29442892b3a.69.2025.08.12.05.42.05
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 12 Aug 2025 05:42:06 -0700 (PDT)
From: Khadem Ullah <14pwcse1224@uetpeshawar.edu.pk>
To: Dariusz Sosnowski <dsosnowski@nvidia.com>,
 Viacheslav Ovsiienko <viacheslavo@nvidia.com>,
 Bing Zhao <bingz@nvidia.com>, Ori Kam <orika@nvidia.com>,
 Suanming Mou <suanmingm@nvidia.com>, Matan Azrad <matan@nvidia.com>
Cc: dev@dpdk.org, stable@dpdk.org,
 Khadem Ullah <14pwcse1224@uetpeshawar.edu.pk>
Subject: [PATCH v2] net/mlx5: fix connection tracking state item validation
Date: Tue, 12 Aug 2025 08:41:50 -0400
Message-ID: <20250812124150.2915138-1-14pwcse1224@uetpeshawar.edu.pk>
X-Mailer: git-send-email 2.43.0
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
Fixes: aca19061e4b9 ('net/mlx5: validate connection tracking item')
Cc: stable@dpdk.org

Signed-off-by: Khadem Ullah <14pwcse1224@uetpeshawar.edu.pk>
---
 drivers/net/mlx5/mlx5_flow_dv.c | 12 +++++++++++-
 drivers/net/mlx5/mlx5_flow_hw.c | 17 ++++++++++++++++-
 2 files changed, 27 insertions(+), 2 deletions(-)

diff --git a/drivers/net/mlx5/mlx5_flow_dv.c b/drivers/net/mlx5/mlx5_flow_dv.c
index 7b9e5018b8..19475b931f 100644
--- a/drivers/net/mlx5/mlx5_flow_dv.c
+++ b/drivers/net/mlx5/mlx5_flow_dv.c
@@ -3271,7 +3271,7 @@ mlx5_flow_dv_validate_item_aso_ct(struct rte_eth_dev *dev,
 {
 	const struct rte_flow_item_conntrack *spec = item->spec;
 	const struct rte_flow_item_conntrack *mask = item->mask;
-	uint32_t flags;
+	uint32_t flags, flags_all;
 
 	if (*item_flags & MLX5_FLOW_LAYER_ASO_CT)
 		return rte_flow_error_set(error, EINVAL,
@@ -3289,6 +3289,16 @@ mlx5_flow_dv_validate_item_aso_ct(struct rte_eth_dev *dev,
 						  RTE_FLOW_ERROR_TYPE_ITEM,
 						  NULL,
 						  "Conflict status bits");
+		flags_all = (RTE_FLOW_CONNTRACK_PKT_STATE_VALID |
+				RTE_FLOW_CONNTRACK_PKT_STATE_CHANGED |
+				RTE_FLOW_CONNTRACK_PKT_STATE_INVALID |
+				RTE_FLOW_CONNTRACK_PKT_STATE_DISABLED |
+				RTE_FLOW_CONNTRACK_PKT_STATE_BAD);
+		if (spec->flags & ~flags_all)
+			return rte_flow_error_set(error, EINVAL,
+					RTE_FLOW_ERROR_TYPE_ITEM,
+					NULL,
+					"Invalid CT item matching \n");
 	}
 	/* State change also needs to be considered. */
 	*item_flags |= MLX5_FLOW_LAYER_ASO_CT;
diff --git a/drivers/net/mlx5/mlx5_flow_hw.c b/drivers/net/mlx5/mlx5_flow_hw.c
index 6dc16f80d3..6dbbc44819 100644
--- a/drivers/net/mlx5/mlx5_flow_hw.c
+++ b/drivers/net/mlx5/mlx5_flow_hw.c
@@ -16957,7 +16957,6 @@ flow_hw_validate_rule_pattern(struct rte_eth_dev *dev,
 {
 	const struct rte_flow_pattern_template *pt;
 	const struct rte_flow_item *pt_item;
-
 	if (pattern_template_idx >= table->nb_item_templates)
 		return rte_flow_error_set(error, EINVAL, RTE_FLOW_ERROR_TYPE_UNSPECIFIED, NULL,
 					  "Pattern template index out of range");
@@ -16996,7 +16995,9 @@ flow_hw_validate_rule_pattern(struct rte_eth_dev *dev,
 		switch (items->type) {
 		const struct rte_flow_item_ethdev *ethdev;
 		const struct rte_flow_item_tx_queue *tx_queue;
+		const struct rte_flow_item_conntrack *spec;
 		struct mlx5_txq_ctrl *txq;
+		uint32_t flags_all;
 
 		case RTE_FLOW_ITEM_TYPE_REPRESENTED_PORT:
 			ethdev = items->spec;
@@ -17016,6 +17017,20 @@ flow_hw_validate_rule_pattern(struct rte_eth_dev *dev,
 							  RTE_FLOW_ERROR_TYPE_ITEM_SPEC, items,
 							  "Invalid Tx queue");
 			mlx5_txq_release(dev, tx_queue->tx_queue);
+			break;
+		case RTE_FLOW_ITEM_TYPE_CONNTRACK:
+			spec = items->spec;
+			flags_all = (RTE_FLOW_CONNTRACK_PKT_STATE_VALID |
+					RTE_FLOW_CONNTRACK_PKT_STATE_CHANGED |
+					RTE_FLOW_CONNTRACK_PKT_STATE_INVALID |
+					RTE_FLOW_CONNTRACK_PKT_STATE_DISABLED |
+					RTE_FLOW_CONNTRACK_PKT_STATE_BAD);
+			if (spec->flags & ~flags_all)
+				return rte_flow_error_set(error, EINVAL,
+						RTE_FLOW_ERROR_TYPE_ITEM,
+						NULL,
+						"Invalid CT item matching \n");
+			break;
 		default:
 			break;
 		}
-- 
2.43.0

