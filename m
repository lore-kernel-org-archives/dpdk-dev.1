Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 86E69FB44C1
	for <dpdk-dev@archiver.kernel.org>; Fri, 24 Apr 2026 07:06:36 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 99B7740670;
	Fri, 24 Apr 2026 09:05:55 +0200 (CEST)
Received: from mail-ed1-f44.google.com (mail-ed1-f44.google.com
 [209.85.208.44]) by mails.dpdk.org (Postfix) with ESMTP id 6814740278
 for <dev@dpdk.org>; Mon, 20 Apr 2026 10:53:09 +0200 (CEST)
Received: by mail-ed1-f44.google.com with SMTP id
 4fb4d7f45d1cf-67482e67171so3003308a12.1
 for <dev@dpdk.org>; Mon, 20 Apr 2026 01:53:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1776675189; x=1777279989; darn=dpdk.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=/HfVU7bBGAnXZZ1rjW8AwvkZbbD858ZsJdIwlKXar3Q=;
 b=mVEtl+h5Z9ETqAbhcZHPNKFDv1GJfbJHDHgkIJlqKds9fy7H1OICGH/W2w0691Fv51
 f0UZn4ulS/vsWUrZhH61LMLmhN3dGT5H1PESBSpmWLxNpA8Fz7YiADJlqurylsvuvMRO
 OnXnm148sCnzGBnxceLcR8i5iDdzgCE620+D1K2vWTZlW54kzCtuCl6VH6NhXs/I6zYN
 rZGzE0rSvbebpkD1y+lUFXG6JI1mUUvzGM48KUSrPxnTZJEy6atnC+pJCwhnF2fJ2sXP
 euYdVYZmeRrWtzACbq/kc8UK7P9GZQL1csDIRWZjX8nrWjMp6XnWIyFoa7HaRqHk4qeu
 8MQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1776675189; x=1777279989;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=/HfVU7bBGAnXZZ1rjW8AwvkZbbD858ZsJdIwlKXar3Q=;
 b=TfQRV95ocrjzvemjnGeJW07c6d532NZScsLem26gFULx8QAVpF3N0jfiL966tojb4a
 B2gNmAdgaQdN1GWgUC4eTfFKySvz+rR6XqLFKOgrbHK+AbMX5CvJpfE57nTKriPww63c
 slEsWp0jZubE8gTMRPoL0RQEPui317rrtmxJw+pr4jQs0Ur3rYyvQKtqJTsw1lIAv8lx
 Eq6qEVmXk0wzv7CXCJ9LakFrcgIohzioRndNBV8ZZi2PHuDmoCXbtiSjMw2G2D+5gOI4
 qWcB6mML26B2mP8kLWDjXj1RqWoywjgrWBziLViXcYAeaGhvhndXnMnP4w5akfWb0Hza
 382g==
X-Gm-Message-State: AOJu0YzOyhC5b1idCzQpwWsq14lM35pk3XjtSxPYCgybKO8H5faFepiT
 +kaUNOOLxZorUwpt7kPs5iIow2KpBSZS82f0zwp9whrPk8VUat6w3IKKg0W6LgXHTXoIEA==
X-Gm-Gg: AeBDievcAuHpnGzcWxoRhc1D3HxM3giVvHXf62PiavB1Yz1FwjTmKtvfels/0iadG4j
 IO+MDCKfnGUcc4uKEl+d2HdrBx7BYp5bKoxfJiWbRYg1tAgJAbNslM5Hobhqm91RKJLpyk7xOYO
 GzejOwlTMVykd+wFHxnB528X73BaZRWK/wYqieH2Xmvz4D2pVK1Sg94ToPFGybvisCzAGLlDACC
 UfnioQubTDHk8ypc9aEvZkBPI+GT8Gj0XzdOB0dINZBSwlvW6WjjJkL0DAVmIRSTJF6S5sl3jdF
 W2jycUJb/1vGD97yT9EOKnoEOqvfglYvI0KXIiPcLIPj29YnR1m+3tpdsT/eS/2kJSrBk738+/C
 7gSU2eTnBulqkA7jSk1ia8cWPLfFl1GyUjgZiKDDI9K9qE9mfRBy/8uhBONQGb9+ARAIpICGi6Y
 QwCJktAZHAyG08J8qp7lVJY+h3VJ7KqtQevkHhj/puXgGevm+JA0aRxKHHfvLP564ayuuw03O7F
 2I=
X-Received: by 2002:a05:6402:350b:b0:674:b8a6:2bf2 with SMTP id
 4fb4d7f45d1cf-674b8a62e19mr1986259a12.12.1776675188672; 
 Mon, 20 Apr 2026 01:53:08 -0700 (PDT)
Received: from work.cisco.com ([2001:420:44f5:1250:14a7:2a07:58ff:b5b4])
 by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-672c4d6f63fsm1884509a12.31.2026.04.20.01.53.07
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 20 Apr 2026 01:53:07 -0700 (PDT)
From: Maxime Peim <maxime.peim@gmail.com>
To: dev@dpdk.org
Cc: dsosnowski@nvidia.com, viacheslavo@nvidia.com, bingz@nvidia.com,
 orika@nvidia.com, suanmingm@nvidia.com, matan@nvidia.com
Subject: [PATCH v2] net/mlx5: prepend implicit items in sync flow creation path
Date: Mon, 20 Apr 2026 10:52:36 +0200
Message-ID: <20260420085236.2356342-1-maxime.peim@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260409185634.3996187-1-maxime.peim@gmail.com>
References: <20260409185634.3996187-1-maxime.peim@gmail.com>
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

In eSwitch mode, the async (template) flow creation path automatically
prepends implicit match items to scope flow rules to the correct
representor port:
  - Ingress: REPRESENTED_PORT item matching dev->data->port_id
  - Egress: REG_C_0 TAG item matching the port's tx tag value

The sync path (flow_hw_list_create) was missing this logic, causing all
flow rules created via the non-template API to match traffic from all
ports rather than being scoped to the specific representor.

Add the same implicit item prepending to flow_hw_list_create, right
after pattern validation and before any branching (sample/RSS/single/
prefix), mirroring the behavior of flow_hw_pattern_template_create
and flow_hw_get_rule_items. The ingress case prepends
REPRESENTED_PORT with the current port_id; the egress case prepends
MLX5_RTE_FLOW_ITEM_TYPE_TAG with REG_C_0 value/mask (skipped when
user provides an explicit SQ item).

Also fix a pre-existing bug where 'return split' on metadata split
failure returned a negative int cast to uintptr_t, which callers
would treat as a valid flow handle instead of an error.

Signed-off-by: Maxime Peim <maxime.peim@gmail.com>
---
 drivers/net/mlx5/mlx5_flow_hw.c | 76 ++++++++++++++++++++++++++++++---
 1 file changed, 71 insertions(+), 5 deletions(-)

diff --git a/drivers/net/mlx5/mlx5_flow_hw.c b/drivers/net/mlx5/mlx5_flow_hw.c
index bca5b2769e..21cadcc5bd 100644
--- a/drivers/net/mlx5/mlx5_flow_hw.c
+++ b/drivers/net/mlx5/mlx5_flow_hw.c
@@ -14275,6 +14275,7 @@ static uintptr_t flow_hw_list_create(struct rte_eth_dev *dev,
 	uint64_t item_flags = 0;
 	uint64_t action_flags = mlx5_flow_hw_action_flags_get(actions, &qrss, &mark,
 							 &encap_idx, &actions_n, error);
+	struct mlx5_priv *priv = dev->data->dev_private;
 	struct mlx5_flow_hw_split_resource resource = {
 		.suffix = {
 			.attr = attr,
@@ -14282,6 +14283,28 @@ static uintptr_t flow_hw_list_create(struct rte_eth_dev *dev,
 			.actions = actions,
 		},
 	};
+	struct rte_flow_item *prepend_items = NULL;
+	struct rte_flow_item_ethdev port_spec = {.port_id = dev->data->port_id};
+	struct rte_flow_item port = {
+		.type = RTE_FLOW_ITEM_TYPE_REPRESENTED_PORT,
+		.spec = &port_spec,
+		.mask = &rte_flow_item_ethdev_mask,
+	};
+	struct mlx5_rte_flow_item_tag tag_v = {
+		.id = REG_C_0,
+		.data = flow_hw_tx_tag_regc_value(dev),
+	};
+	struct mlx5_rte_flow_item_tag tag_m = {
+		.id = REG_C_0,
+		.data = flow_hw_tx_tag_regc_mask(dev),
+	};
+	struct rte_flow_item tag = {
+		.type = (enum rte_flow_item_type)MLX5_RTE_FLOW_ITEM_TYPE_TAG,
+		.spec = &tag_v,
+		.mask = &tag_m,
+		.last = NULL,
+	};
+	uint32_t nb_items;
 	struct rte_flow_error shadow_error = {0, };
 	const struct rte_flow_pattern_template_attr pattern_template_attr = {
 		.relaxed_matching = 0,
@@ -14296,13 +14319,48 @@ static uintptr_t flow_hw_list_create(struct rte_eth_dev *dev,
 	if (ret < 0)
 		return 0;
 
+	nb_items = ret;
+
+	/*
+	 * In eSwitch mode, the async (template) path automatically prepends
+	 * implicit items to scope flow rules to the correct representor port:
+	 *   - Ingress: REPRESENTED_PORT item matching dev->data->port_id
+	 *   - Egress: REG_C_0 TAG item matching the port's tx tag value
+	 * Mirror this behavior in the sync path so rules are not shared
+	 * across all eSwitch ports.
+	 */
+	if (priv->sh->config.dv_esw_en &&
+	    attr->ingress && !attr->egress && !attr->transfer) {
+		prepend_items = flow_hw_prepend_item(items, nb_items,
+						     &port, error);
+		if (!prepend_items)
+			return 0;
+		items = prepend_items;
+	} else if (priv->sh->config.dv_esw_en &&
+		   !attr->ingress && attr->egress && !attr->transfer) {
+		if (item_flags & MLX5_FLOW_ITEM_SQ) {
+			DRV_LOG(DEBUG,
+				"Port %u omitting implicit REG_C_0 match for egress "
+				"pattern template",
+				dev->data->port_id);
+			goto setup_pattern;
+		}
+		prepend_items = flow_hw_prepend_item(items, nb_items,
+						     &tag, error);
+		if (!prepend_items)
+			return 0;
+		items = prepend_items;
+	}
+setup_pattern:
 	RTE_SET_USED(encap_idx);
 	if (!error)
 		error = &shadow_error;
 	split = mlx5_flow_nta_split_metadata(dev, attr, actions, qrss, action_flags,
 					     actions_n, external, &resource, error);
-	if (split < 0)
-		return split;
+	if (split < 0) {
+		mlx5_free(prepend_items);
+		return 0;
+	}
 
 	/* Update the metadata copy table - MLX5_FLOW_MREG_CP_TABLE_GROUP */
 	if (((attr->ingress && attr->group != MLX5_FLOW_MREG_CP_TABLE_GROUP) ||
@@ -14315,8 +14373,10 @@ static uintptr_t flow_hw_list_create(struct rte_eth_dev *dev,
 	if (action_flags & MLX5_FLOW_ACTION_SAMPLE) {
 		flow = mlx5_nta_sample_flow_list_create(dev, type, attr, items, actions,
 							item_flags, action_flags, error);
-		if (flow != NULL)
+		if (flow != NULL) {
+			mlx5_free(prepend_items);
 			return (uintptr_t)flow;
+		}
 		goto free;
 	}
 	if (action_flags & MLX5_FLOW_ACTION_RSS) {
@@ -14328,8 +14388,10 @@ static uintptr_t flow_hw_list_create(struct rte_eth_dev *dev,
 		if (flow) {
 			flow->nt2hws->rix_mreg_copy = cpy_idx;
 			cpy_idx = 0;
-			if (!split)
+			if (!split) {
+				mlx5_free(prepend_items);
 				return (uintptr_t)flow;
+			}
 			goto prefix_flow;
 		}
 		goto free;
@@ -14343,8 +14405,10 @@ static uintptr_t flow_hw_list_create(struct rte_eth_dev *dev,
 	if (flow) {
 		flow->nt2hws->rix_mreg_copy = cpy_idx;
 		cpy_idx = 0;
-		if (!split)
+		if (!split) {
+			mlx5_free(prepend_items);
 			return (uintptr_t)flow;
+		}
 		/* Fall Through to prefix flow creation. */
 	}
 prefix_flow:
@@ -14357,6 +14421,7 @@ static uintptr_t flow_hw_list_create(struct rte_eth_dev *dev,
 		flow->nt2hws->chaned_flow = 1;
 		SLIST_INSERT_AFTER(prfx_flow, flow, nt2hws->next);
 		mlx5_flow_nta_split_resource_free(dev, &resource);
+		mlx5_free(prepend_items);
 		return (uintptr_t)prfx_flow;
 	}
 free:
@@ -14368,6 +14433,7 @@ static uintptr_t flow_hw_list_create(struct rte_eth_dev *dev,
 		mlx5_flow_nta_del_copy_action(dev, cpy_idx);
 	if (split > 0)
 		mlx5_flow_nta_split_resource_free(dev, &resource);
+	mlx5_free(prepend_items);
 	return 0;
 }
 
-- 
2.43.0

