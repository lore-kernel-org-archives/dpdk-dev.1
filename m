Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 539A0CA0EDC
	for <dpdk-dev@archiver.kernel.org>; Thu, 14 Aug 2025 08:58:54 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id F2F0E41101;
	Thu, 14 Aug 2025 10:58:52 +0200 (CEST)
Received: from mail-pf1-f175.google.com (mail-pf1-f175.google.com
 [209.85.210.175])
 by mails.dpdk.org (Postfix) with ESMTP id ABFE6402A8
 for <dev@dpdk.org>; Thu, 14 Aug 2025 10:58:51 +0200 (CEST)
Received: by mail-pf1-f175.google.com with SMTP id
 d2e1a72fcca58-76e2e8e2d2dso456422b3a.1
 for <dev@dpdk.org>; Thu, 14 Aug 2025 01:58:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=uetpeshawar-edu-pk.20230601.gappssmtp.com; s=20230601; t=1755161930;
 x=1755766730; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=yvx7VWwP7DeJyFiAx2spN8dcIpJt450369G/4v6eoFw=;
 b=jD/9p8i18/6WBkmTTCnTEFhpHap04mue74CWgeCAgNTMwFJ20Ghjr6rGcWppI43Mpi
 y8CtewrCBP2dP7gKJd8YErd2qtw3a3nHkFBHndAYAAg/WYYu7hGWs1FifyuqYpW7SXGc
 yQFS0QZbLjH+eEvxbx4DXhjJfufoZVOWaJTKsHsYQzQySyfuFm/IfEXBl/Gd4o/q3h/T
 nS5jTIQv4hwpdB0VULgTLKLgL7P0oPwastzpAXZjMW5XnJaTPvugfh6P0msU5VFV1Sit
 bcd4HBoGv4/kQ73VAdBD9yiesSxzLYzZy22QEzYgRBsg27y9aFoqN/kPuKoeSagGAiea
 lPSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1755161930; x=1755766730;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=yvx7VWwP7DeJyFiAx2spN8dcIpJt450369G/4v6eoFw=;
 b=w+wp9ljR7i+X53H+4RYiIeYhRHLW3RuI83LQERzQUh8NIKbtcxWtMrxrrjXCOA8hW4
 WrAgmOJPJM5TfOwJ31DYBO7xnwuWIPee09vmZ+rWuv6tFyr3BX67LADPqf8Z0jU2aK1D
 deBTSjba6VIfzruHn/+2kVtkaPxX5kkGpAVIohQkDgQVDl2Y2URP7HxzqaxRPNSHwzPH
 +44uh3RVI+r3x88h0vG6ct55K3PVwGvhra0h0V/ty8THBTS0KTRQr+mMu6AwD58wGWbY
 vIMUMRSbtuvp9dhz1t5+PF6GJcXG+Vhf9cwTAKdAQomBFRdcxH8ca8ktqgNqC82P2wjd
 Xyfw==
X-Gm-Message-State: AOJu0YyQyOn5EPddMDqKawOsUUwNIdb8iAjuOk3A1R5WGndP+D3x0Kys
 fx1xPxMftF3NCnl102zyUbbsGfybJFqCU4cZdgGixUcFgHCb/ltbwHUCUZr8suzQik8=
X-Gm-Gg: ASbGncvcRpD9nNKNg9gsGI/lAdSRYdMfToxpcWK1LEg+4RqhpRdaNNqiSs7PDVp5zLp
 99pPFyV7+KN9D6zGlbL+nautiKdGKKZc8MmNXOY2NQa7q3CqDmYs8leo7ocXj4Zik21+bR4+Zp8
 yI+En0eqHqcxAVvki7anRA31NIR+HX49tB/XYS0iLxHnyi//CMA1TqIQxAZO3LOuk4Dmj9+t3KN
 tqk9yjZdM72KTctiKRffSdp7poCgAKsCVdvyvuJpl7c3ZHfm1UaW7fVZpcAxJyHQcd/ffbAGnem
 OPvn9dtxMZq1c0EmdRWppw55otub5tjUXs9adbTe3Xn+E294My+jUXZPX3eGf7iIA+vW1FYV7Om
 xQ3ke62nI2fqFXDndXXNfZDsLLGr8oEO3BjeotohFLK9XY9eO
X-Google-Smtp-Source: AGHT+IH5R9zW9dO7/J+0rvXgySJ8aMBzJqXMlNIYBGiq41ivK1bSd3lG2i/0Jw0kN9qftTrnTUjA4w==
X-Received: by 2002:a05:6a00:1708:b0:76b:c5bd:aec7 with SMTP id
 d2e1a72fcca58-76e2f8da93dmr3903902b3a.8.1755161930500; 
 Thu, 14 Aug 2025 01:58:50 -0700 (PDT)
Received: from localhost.localdomain ([64.62.143.197])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-76bcce6f6eesm34185641b3a.22.2025.08.14.01.58.49
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 14 Aug 2025 01:58:50 -0700 (PDT)
From: Khadem Ullah <14pwcse1224@uetpeshawar.edu.pk>
To: Dariusz Sosnowski <dsosnowski@nvidia.com>,
 Viacheslav Ovsiienko <viacheslavo@nvidia.com>,
 Bing Zhao <bingz@nvidia.com>, Ori Kam <orika@nvidia.com>,
 Suanming Mou <suanmingm@nvidia.com>, Matan Azrad <matan@nvidia.com>
Cc: dev@dpdk.org, stable@dpdk.org,
 Khadem Ullah <14pwcse1224@uetpeshawar.edu.pk>
Subject: [PATCH v3] net/mlx5: fix connection tracking state item validation
Date: Thu, 14 Aug 2025 04:58:31 -0400
Message-ID: <20250814085831.3511020-1-14pwcse1224@uetpeshawar.edu.pk>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250812124630.2916225-1-14pwcse1224@uetpeshawar.edu.pk>
References: <20250812124630.2916225-1-14pwcse1224@uetpeshawar.edu.pk>
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
 drivers/net/mlx5/mlx5_flow.h    |  6 ++++++
 drivers/net/mlx5/mlx5_flow_dv.c |  8 +++++++-
 drivers/net/mlx5/mlx5_flow_hw.c | 12 ++++++++++++
 3 files changed, 25 insertions(+), 1 deletion(-)

diff --git a/drivers/net/mlx5/mlx5_flow.h b/drivers/net/mlx5/mlx5_flow.h
index e890e732c3..df0f1cf064 100644
--- a/drivers/net/mlx5/mlx5_flow.h
+++ b/drivers/net/mlx5/mlx5_flow.h
@@ -100,6 +100,12 @@ enum mlx5_indirect_type {
 #define MLX5_INDIRECT_ACT_CT_GET_IDX(index) \
 	((index) & ((1 << MLX5_INDIRECT_ACT_CT_OWNER_SHIFT) - 1))
 
+#define MLX5_FLOW_CONNTRACK_PKT_STATE_ALL(flags_all) \
+	(flags_all = (RTE_FLOW_CONNTRACK_PKT_STATE_VALID) | \
+	RTE_FLOW_CONNTRACK_PKT_STATE_CHANGED | \
+	RTE_FLOW_CONNTRACK_PKT_STATE_INVALID | \
+	RTE_FLOW_CONNTRACK_PKT_STATE_DISABLED | \
+	RTE_FLOW_CONNTRACK_PKT_STATE_BAD)
 /*
  * When HW steering flow engine is used, the CT action handles are encoded in a following way:
  * - bits 31:29 - type
diff --git a/drivers/net/mlx5/mlx5_flow_dv.c b/drivers/net/mlx5/mlx5_flow_dv.c
index 7b9e5018b8..7f68a4ef10 100644
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
@@ -3289,6 +3289,12 @@ mlx5_flow_dv_validate_item_aso_ct(struct rte_eth_dev *dev,
 						  RTE_FLOW_ERROR_TYPE_ITEM,
 						  NULL,
 						  "Conflict status bits");
+		MLX5_FLOW_CONNTRACK_PKT_STATE_ALL(flags_all);
+		if (spec->flags & ~flags_all)
+			return rte_flow_error_set(error, EINVAL,
+					RTE_FLOW_ERROR_TYPE_ITEM,
+					NULL,
+					"Invalid CT item flags");
 	}
 	/* State change also needs to be considered. */
 	*item_flags |= MLX5_FLOW_LAYER_ASO_CT;
diff --git a/drivers/net/mlx5/mlx5_flow_hw.c b/drivers/net/mlx5/mlx5_flow_hw.c
index 6dc16f80d3..9dd3d7325f 100644
--- a/drivers/net/mlx5/mlx5_flow_hw.c
+++ b/drivers/net/mlx5/mlx5_flow_hw.c
@@ -16996,7 +16996,9 @@ flow_hw_validate_rule_pattern(struct rte_eth_dev *dev,
 		switch (items->type) {
 		const struct rte_flow_item_ethdev *ethdev;
 		const struct rte_flow_item_tx_queue *tx_queue;
+		const struct rte_flow_item_conntrack *spec;
 		struct mlx5_txq_ctrl *txq;
+		uint32_t flags_all;
 
 		case RTE_FLOW_ITEM_TYPE_REPRESENTED_PORT:
 			ethdev = items->spec;
@@ -17016,6 +17018,16 @@ flow_hw_validate_rule_pattern(struct rte_eth_dev *dev,
 							  RTE_FLOW_ERROR_TYPE_ITEM_SPEC, items,
 							  "Invalid Tx queue");
 			mlx5_txq_release(dev, tx_queue->tx_queue);
+			break;
+		case RTE_FLOW_ITEM_TYPE_CONNTRACK:
+			spec = items->spec;
+			MLX5_FLOW_CONNTRACK_PKT_STATE_ALL(flags_all);
+			if (spec->flags & ~flags_all)
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

