Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 55923F436B2
	for <dpdk-dev@archiver.kernel.org>; Fri, 17 Apr 2026 15:02:04 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 2CF9A402B0;
	Fri, 17 Apr 2026 17:02:03 +0200 (CEST)
Received: from mail-vk1-f179.google.com (mail-vk1-f179.google.com
 [209.85.221.179])
 by mails.dpdk.org (Postfix) with ESMTP id 2CAB1402B0
 for <dev@dpdk.org>; Fri, 17 Apr 2026 17:02:02 +0200 (CEST)
Received: by mail-vk1-f179.google.com with SMTP id
 71dfb90a1353d-56f8b51db2cso247619e0c.1
 for <dev@dpdk.org>; Fri, 17 Apr 2026 08:02:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1776438121; x=1777042921; darn=dpdk.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=c/NjD1e61WFQoWGGQ8nLfsj5DLYKUULjTGfqOp82Qqw=;
 b=ZQJlPU+bPhkYjLLOxkxG1NOnYVpf97zzkTEKlkfFwzFVPYVgwf4sr6M+hVzJrasUzA
 +41msdFK7cLewwGKIPaRA/8Tk3vGK14e+aFQ01HfiLpUfMoSq/nKPGsjdN19uns4sq/a
 lPmjidFGO9hF05DE4ezFOi4hkC3VUjs7yp4o4P1yJi92Qo5/Tzm8v9KP+bzt2w7vmxT6
 7kl+9UsLHoW+0mvEHS4rHo+7oo2bohp1/URhKEnOvhpELENyveX6yvlZGVpiQQtlQLEI
 pqMfHSO90HOXIMm8l47AIPnXBf/W39YHNVI207QBfBGQuRxG16tf6UqdSAOCHKP2qvgo
 HLDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1776438121; x=1777042921;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=c/NjD1e61WFQoWGGQ8nLfsj5DLYKUULjTGfqOp82Qqw=;
 b=c4ZeS/nhk/kn9PKkIjUM6wz5pI7LgnSAjvg6b6Cbg2hHVJv4lyGztyHFf6pavJO95M
 jsfyLxznJZuohtkCClhDeNviB+HYsqfNAxhIWtAGrt1a/UlPHstDz9gFPsNbEbcj96pK
 tcSU3/pQcu3r2gzAfaC3VW0f9wErlKR5pq8eHX3ugUNqmGG1Yrzq05k5pmZp5TZRT+G5
 ADqbYT5HwQ0/fxUGaTjMgGIo+NPeCLo9idpZqOJw6YwtMN933YsKjRHdFgEzX1/PyaNZ
 8CZ1J5Edes7GPYzac7QTjg6xZmYjCOCyGbsCh8LTnrj/hMIhZCnbHr9q7tIb35flnAWI
 cHPg==
X-Gm-Message-State: AOJu0YxsTupHxAkEI+ii7wGRxyrPOYHf020QqGSd6nWbbJ0BlOq3DxZX
 8i0rbErX87BvUkVUI43UTGcIySRaDIknmnHjVnlf5ycB+xGVXjPTRs7YlE6Q+pS5aXY=
X-Gm-Gg: AeBDieuSbm5St7nYxuiJH5QWSZAZWEm51Ef2eoVHXo+yVxw8w0TByWkv5f7yMaGy9NP
 h9YDaWV8vIe/M7Wc3bMu7LWSCNLEdiUJBKyczgrd7JQHIWCVTTfkA3szNRJhNK8M5BaoSYc1zz1
 TKmDvw6gPNwWBHW40klIyoDk7RE03lNnWej0CNVEDvyPNiolpFq3G3HNS0DKgTYBW57ixpxMwKj
 k+EUR+AKKzUgCRz6Z42I4D1ChifQ31UV4zLxIk753MxHWsUJOcjS2Jm8UiITALgq+twSKl9Quh2
 wVl2ZdhNjRbawXS2cdp+kHMycrq9bEw8fLdH67J8NRqvE7tVdm7FSjaevN0oHuyeZvuKNhJqsAF
 eAMw2rjKV1Zkr7g/mAJLhfzvmKrItVJSea6F24AaV05po1uu56tbJh7XxShNYE4VeiLiLwBfPDc
 yyptf3R4EGyLvzKNjyRN/1+Hoa4rnaIkzKMFzXRMDkg7fGc4ewBhONt7zxZz9f4cwLFhCW4MAei
 eRA9Z4nuwW5S2E2n0zVg8fx4VxEX8QU1clEIpjIxFwh
X-Received: by 2002:a05:6122:8c8a:b0:56c:ca38:ebeb with SMTP id
 71dfb90a1353d-56fa582b8cemr1743043e0c.2.1776438118975; 
 Fri, 17 Apr 2026 08:01:58 -0700 (PDT)
Received: from LAPTOP-T809MHP1.home
 (bras-base-hullpq2034w-grc-10-74-14-173-40.dsl.bell.ca. [74.14.173.40])
 by smtp.gmail.com with ESMTPSA id
 71dfb90a1353d-56fa90335e6sm1088153e0c.0.2026.04.17.08.01.57
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 17 Apr 2026 08:01:58 -0700 (PDT)
From: Rayane Boussanni <rboussanni@gmail.com>
To: dev@dpdk.org
Cc: rasland@nvidia.com,
	Rayane Boussanni <rboussanni@gmail.com>
Subject: [PATCH] net/mlx5: add validation for indirect actions
Date: Fri, 17 Apr 2026 11:01:53 -0400
Message-Id: <20260417150153.63149-1-rboussanni@gmail.com>
X-Mailer: git-send-email 2.34.1
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

This patch implements missing validation logic for RSS and Connection
Tracking (ConnTrack) indirect actions in the Hardware Steering (HWS)
flow engine.

Previously, these actions were accepted without being validated
against hardware capabilities, which could lead to unexpected behavior
when applying flow rules. The specialist validation functions
(mlx5_hw_validate_action_rss and mlx5_hw_validate_action_conntrack)
already existed but were not wired up to the indirect action handler.

The signature of flow_hw_validate_action_indirect was updated to
include the actions template attributes (attr), allowing it to pass
the necessary traffic direction context (ingress/egress/transfer)
to the underlying validation specialists.

Signed-off-by: Rayane Boussanni <rboussanni@gmail.com>
---
 drivers/net/mlx5/mlx5_flow_hw.c | 29 +++++++++++++++++++++++++++--
 1 file changed, 27 insertions(+), 2 deletions(-)

diff --git a/drivers/net/mlx5/mlx5_flow_hw.c b/drivers/net/mlx5/mlx5_flow_hw.c
index bca5b2769e..fc5d59be98 100644
--- a/drivers/net/mlx5/mlx5_flow_hw.c
+++ b/drivers/net/mlx5/mlx5_flow_hw.c
@@ -346,6 +346,21 @@ mlx5_flow_ct_init(struct rte_eth_dev *dev,
 		  uint32_t nb_conn_tracks,
 		  uint16_t nb_queue);
 
+static int
+mlx5_hw_validate_action_rss(struct rte_eth_dev *dev,
+				       const struct rte_flow_action *action,
+				       const struct rte_flow_action *mask,
+				       const struct rte_flow_actions_template_attr *attr,
+				       uint64_t action_flags,
+				       struct rte_flow_error *error);
+static int
+mlx5_hw_validate_action_conntrack(struct rte_eth_dev *dev,
+					     const struct rte_flow_action *action,
+					     const struct rte_flow_action *mask,
+					     const struct rte_flow_actions_template_attr *attr,
+					     uint64_t action_flags,
+					     struct rte_flow_error *error);
+
 static __rte_always_inline uint32_t flow_hw_tx_tag_regc_mask(struct rte_eth_dev *dev);
 static __rte_always_inline uint32_t flow_hw_tx_tag_regc_value(struct rte_eth_dev *dev);
 
@@ -6595,6 +6610,7 @@ flow_hw_validate_action_meter_mark(struct rte_eth_dev *dev,
 	return 0;
 }
 
+
 /**
  * Validate indirect action.
  *
@@ -6604,6 +6620,8 @@ flow_hw_validate_action_meter_mark(struct rte_eth_dev *dev,
  *   Pointer to the indirect action.
  * @param[in] mask
  *   Pointer to the indirect action mask.
+ * @param[in] attr
+ *   Pointer to the action template attributes.
  * @param[in, out] action_flags
  *   Holds the actions detected until now.
  * @param[in, out] fixed_cnt
@@ -6618,6 +6636,7 @@ static int
 flow_hw_validate_action_indirect(struct rte_eth_dev *dev,
 				 const struct rte_flow_action *action,
 				 const struct rte_flow_action *mask,
+				 const struct rte_flow_actions_template_attr *attr,
 				 uint64_t *action_flags, bool *fixed_cnt,
 				 struct rte_flow_error *error)
 {
@@ -6637,11 +6656,16 @@ flow_hw_validate_action_indirect(struct rte_eth_dev *dev,
 		*action_flags |= MLX5_FLOW_ACTION_METER;
 		break;
 	case RTE_FLOW_ACTION_TYPE_RSS:
-		/* TODO: Validation logic (same as flow_hw_actions_validate) */
+		ret = mlx5_hw_validate_action_rss(dev, action, mask, attr, *action_flags, error);
+		if (ret < 0)
+			return ret;
 		*action_flags |= MLX5_FLOW_ACTION_RSS;
 		break;
 	case RTE_FLOW_ACTION_TYPE_CONNTRACK:
-		/* TODO: Validation logic (same as flow_hw_actions_validate) */
+		ret = mlx5_hw_validate_action_conntrack(dev, action, mask, attr,
+							 *action_flags, error);
+		if (ret < 0)
+			return ret;
 		*action_flags |= MLX5_FLOW_ACTION_CT;
 		break;
 	case RTE_FLOW_ACTION_TYPE_COUNT:
@@ -7352,6 +7376,7 @@ mlx5_flow_hw_actions_validate(struct rte_eth_dev *dev,
 		case RTE_FLOW_ACTION_TYPE_INDIRECT:
 			ret = flow_hw_validate_action_indirect(dev, action,
 							       mask,
+								   attr,
 							       &action_flags,
 							       &fixed_cnt,
 							       error);
-- 
2.34.1

