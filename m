Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 434DCFB44C1
	for <dpdk-dev@archiver.kernel.org>; Fri, 24 Apr 2026 07:05:49 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 63354402A2;
	Fri, 24 Apr 2026 09:05:48 +0200 (CEST)
Received: from mail-qk1-f172.google.com (mail-qk1-f172.google.com
 [209.85.222.172])
 by mails.dpdk.org (Postfix) with ESMTP id B593C40297
 for <dev@dpdk.org>; Thu, 16 Apr 2026 02:11:07 +0200 (CEST)
Received: by mail-qk1-f172.google.com with SMTP id
 af79cd13be357-8cb5c9ba82bso1141160685a.2
 for <dev@dpdk.org>; Wed, 15 Apr 2026 17:11:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1776298266; x=1776903066; darn=dpdk.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=c/NjD1e61WFQoWGGQ8nLfsj5DLYKUULjTGfqOp82Qqw=;
 b=ol8assQwqv1XSPQbsh0T/FziMiDZckH0H4CWtYoMdMZrJmbESrjiWXHaxg1DOvvKAZ
 RfDF4TgrWV8VzPXsI+/aMi+LK6h04dliyDxVkLw5RYFX4F4Um84KlZO18Dsm1gjo9Aj7
 Bz9qfq5GxhZpiAfT42E8QXtEElaF3AJZaK+Hg/TEiI1/hORg1M9WQ1fZROqx8FdRe8W9
 5z09O/hmcgvTdxKYxrkn6AhiAfdPP2DbMjnAWhnLhF25T3DO9bKowNKxxy1pwrAZyWx8
 Ldo6Ftp6ZXxUMQWEEeF/ZX0GgkQ+reLoJmSjkb2bA8JeUBeEy9F+nDBggF6U9q7R4rhd
 7Giw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1776298266; x=1776903066;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=c/NjD1e61WFQoWGGQ8nLfsj5DLYKUULjTGfqOp82Qqw=;
 b=KkKzqv0wYTyQpADEAFNVcE6WOdtCoQtj5fZ5vsG3a2IA7F1s/+jS7S/jT+1zZpupUN
 ZVCA2G+hYzVtlN0l6Hk390u2PTqDf1SA82E8IVu/HoSaTYXCUl9BXmyaXbDU5RTND5eC
 SE+PvxiXhQY3oXofLv/Wx3Scwjxjc8T/DM2l6DggivzRgDZuKlo8cu58fKf5LFk3352i
 mKu3ZO2LWxHcsZ1T0hUWmzUYaGxJv/GZP+VV5pL3OM/46wRNnMPXuVXqHKzZ1vw7NPCg
 QKEGSnC+ChtJtO9vBxm0menY2ztiF1DzbbcdjOoHHFZXJxsVn7+LJ/Rv0yFll+8OJAdf
 MS4A==
X-Gm-Message-State: AOJu0YwIISfIimZOiyt3zhyQzdKgjihgqrlj2oAXN56BtXdl3itgLnpe
 9whzrGHtNxm1TLzAr9ONjEiQ2PEKPY11nd7LeqDsn9GMue32IHpBTmyqqJZBBHgpJTg=
X-Gm-Gg: AeBDiesZp1WR80anU6iAWMeF9sv0Xi3e51g3qqgP9Y9J1oK4uj7wliMaU+/hMeUzZJD
 owIVPIDqrb1kccYLDijDk/aLQorqXOrvOHjyYy+k1P1BH0e40BCGDjFwveB3lvtHCCwSLDPeEYZ
 eokP7IYM8Bx1FY6ys+AzKfX8E8aMAkL03qopbSwVu5dcAoLU4az1xweDiOn5s45Wfo4C38GWHtq
 yj7UiB61Q4do9EYci5aF/sdvZHfUL8XP+G/laPV5g3vWjc6NfUHGevo/kN4fATezFm/VtgZarEc
 Jt/+KU3YROo18+EtRAV3X9+fQi3OikJCuu0dsJGtZUIiBp3upA0ABIv/BUQPW8L2yZhQca21AX4
 16M/ik7WYyumkTz8Le5F54qQ421kihJWTLrAwns0vbKw43yfPYEVa0nUKDBFFpq5hHoNELVekTJ
 uDRpRI6sbHOw9u/1itvaz/mC3vLws2u0l/
X-Received: by 2002:a05:620a:1987:b0:8cf:dfc9:c09c with SMTP id
 af79cd13be357-8ddccb2f697mr3424545485a.10.1776298266261; 
 Wed, 15 Apr 2026 17:11:06 -0700 (PDT)
Received: from LAPTOP-T809MHP1.home ([74.14.173.40])
 by smtp.gmail.com with ESMTPSA id
 af79cd13be357-8e4eed6ee5esm242367885a.3.2026.04.15.17.11.05
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 15 Apr 2026 17:11:05 -0700 (PDT)
From: Rayane Boussanni <rboussanni@gmail.com>
To: dev@dpdk.org
Cc: rasland@nvidia.com,
	Rayane Boussanni <rboussanni@gmail.com>
Subject: [PATCH] net/mlx5: add validation for indirect actions
Date: Wed, 15 Apr 2026 20:10:52 -0400
Message-Id: <20260416001052.2624-1-rboussanni@gmail.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Fri, 24 Apr 2026 09:05:46 +0200
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

