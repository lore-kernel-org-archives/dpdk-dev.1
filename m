Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7A982CA0EC4
	for <dpdk-dev@archiver.kernel.org>; Tue, 12 Aug 2025 12:46:52 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id A4169402A7;
	Tue, 12 Aug 2025 14:46:51 +0200 (CEST)
Received: from mail-pf1-f178.google.com (mail-pf1-f178.google.com
 [209.85.210.178])
 by mails.dpdk.org (Postfix) with ESMTP id ED44740270
 for <dev@dpdk.org>; Tue, 12 Aug 2025 14:46:49 +0200 (CEST)
Received: by mail-pf1-f178.google.com with SMTP id
 d2e1a72fcca58-73c17c770a7so6752520b3a.2
 for <dev@dpdk.org>; Tue, 12 Aug 2025 05:46:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=uetpeshawar-edu-pk.20230601.gappssmtp.com; s=20230601; t=1755002809;
 x=1755607609; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=/32VpI40R9aC3UE3nsnUHTCkVozldm0aG1t5RnfzV1I=;
 b=lpzeywfXQ1MZmz5W9i/wT4nAdqxh+j0ro/2DyIUCiOTxP1Cy/DWG1QOzU3uyMESK6N
 lH98bLcTfJDFo0EcCeVh6XtWEFN16iLov82rRh0gU7w2ZjezmeVyWqAFdWYJ55qjt6WZ
 LCrfj9+TO9/KzrTdQT1ISKrJXMeqAL3y9tFoLMqNZnH597yAZo6s3llWK4ZSdqKLetUe
 te1xSYoInUBJlrOf2mTsyA4qpsgA6oqD2j/AGZm5RJV7qteZyotcKT7Sf+2jBOX5YeQr
 UYaFcmc7kOpTH1itr4Au5DjhDtuxXLyMLc44voWiFw+wEoQA1OoCzj9KYYIq72MtmYsY
 7iMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1755002809; x=1755607609;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=/32VpI40R9aC3UE3nsnUHTCkVozldm0aG1t5RnfzV1I=;
 b=tl4jPvCw9Dz50KBS9VzBI+Z6PDO0L6Q/A+oLCK2LNGQbC5xmBQibAGd3Oh/0JRgZUR
 qxcrfy3zkV/d5mJ5wO0f0bvOT0ZMr0qdiir872jkFNJ8Koe89N2giBBNTMS5OYhk9wb1
 p37PLIHYCR9jrNinhzCYs+m1eBZxR++mUunQxH85HlAcvOnqrxeZ9bOFEWz9flMGiVee
 iFfNwiFE/DhJ5loLLoBKm0gkbAKWXobYfO9kj1hPC9srB33bIm55ClxXxTB7wUyTfCr5
 M0bFP13/Lz2Mn9Bt2apSITsyofa/SiS5L3RmOR9QHVZ6wJcwSjY4kaztfI2UnYOk5BNt
 kqDQ==
X-Gm-Message-State: AOJu0YxMLTX6p6aaHcCvG8H5ScHdtZq+T1ebxU8mhcnwfdHa/I2JT9JS
 w7O4I2OGa/l6Lb0uk2sVQOKBB0/qNVvvO7ndCCaAg0ohKuOroxAIqm+xEFtlcoMuTDM=
X-Gm-Gg: ASbGncvZq08s8FJgy4VJTVuwrO+07dxY4/WK/9uaugud2akIR9ZMRgqV2+zVGxCQIzh
 PeQ0qyjVDZunyyaSdL5krZ2G35ZvRQJ8SDjNG4m0j8AYxx+cRf863zs4XAiMqg+TqAaa6ChBfvO
 bynHO5c1i7waUD8xUzLGa3YxkYoNcGbd7M19iyf1KF3KBdnImfdhleefL8pu0wwThJ/V4j3h9e/
 +1JoiI86iNJ8wgSSetA2bqMMxhukwf6dNUn1K9HexLcUrkk+m0qJLB+nOHxSCKK/uOGADB0rAD1
 xTZPFxfEY4H9vH6mnZECGcNaoZRBLJmADnEy4Jm5xiEpE1L/X7pQW285SiP2WDssdDu69FgmmyB
 kDNWis1PRybtOAG0qH2qGszK+0UfuIm4j8rGRQJzOsmD5cuUy
X-Google-Smtp-Source: AGHT+IHNheQGXlIO9vXIpQ+hZm8P+i3qORZjeNvVKentxXHZ1DWB0PRbNB3bXT5+iloAo2hxwOLsEQ==
X-Received: by 2002:a05:6a00:14cc:b0:748:f750:14c6 with SMTP id
 d2e1a72fcca58-76c4615bd8cmr24057238b3a.14.1755002808947; 
 Tue, 12 Aug 2025 05:46:48 -0700 (PDT)
Received: from localhost.localdomain ([64.62.143.197])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-76bd6aacc4fsm28221285b3a.118.2025.08.12.05.46.48
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 12 Aug 2025 05:46:48 -0700 (PDT)
From: Khadem Ullah <14pwcse1224@uetpeshawar.edu.pk>
To: Dariusz Sosnowski <dsosnowski@nvidia.com>,
 Viacheslav Ovsiienko <viacheslavo@nvidia.com>,
 Bing Zhao <bingz@nvidia.com>, Ori Kam <orika@nvidia.com>,
 Suanming Mou <suanmingm@nvidia.com>, Matan Azrad <matan@nvidia.com>
Cc: dev@dpdk.org, stable@dpdk.org,
 Khadem Ullah <14pwcse1224@uetpeshawar.edu.pk>
Subject: [PATCH v2] net/mlx5: fix connection tracking state item validation
Date: Tue, 12 Aug 2025 08:46:30 -0400
Message-ID: <20250812124630.2916225-1-14pwcse1224@uetpeshawar.edu.pk>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250805132318.480413-1-14pwcse1224@uetpeshawar.edu.pk>
References: <20250805132318.480413-1-14pwcse1224@uetpeshawar.edu.pk>
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

