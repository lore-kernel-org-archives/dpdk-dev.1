Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4C748FF8867
	for <dpdk-dev@archiver.kernel.org>; Wed, 29 Apr 2026 09:58:21 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 7A79C4027A;
	Wed, 29 Apr 2026 11:58:20 +0200 (CEST)
Received: from mail-ed1-f53.google.com (mail-ed1-f53.google.com
 [209.85.208.53]) by mails.dpdk.org (Postfix) with ESMTP id DEFC0402BC
 for <dev@dpdk.org>; Mon, 27 Apr 2026 14:32:45 +0200 (CEST)
Received: by mail-ed1-f53.google.com with SMTP id
 4fb4d7f45d1cf-671ab90fc1fso19272725a12.0
 for <dev@dpdk.org>; Mon, 27 Apr 2026 05:32:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1777293165; x=1777897965; darn=dpdk.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=4mF8W8ORI8xvLmlCAx3ro4wRzhm/oc2ASy4+YNBvKoU=;
 b=Nqk7sDW9OqBf4oZVNxamE/BjwudyUFGTaY+FwMg/e6r+vFy7/726H7WKSKKdlTnNG/
 K/uMXffLyyq8ClMevih+m//TUIWs+kZEDg7fRTVqD9hPSVcOL5lzKvKqejDwQP64qx43
 zwsuA5S6ycnOs7/XqhUBhY96sadmjgNUPqZ/bZG4fDRLGBxkaSx7gtCGCPrglGPjJHn/
 B6xgWmZZ3fCQsVTtkB57MairHv9hvSMQY2QqaW0b+Rx551/Jjcjmw6quw1yBvOeRgOl3
 3nBKjIG2sROa+xODsisa3E+UTALyst3KMZqgDXIky5wuLZA37fgHgjTJLCDRaft0Nztr
 0fJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1777293165; x=1777897965;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=4mF8W8ORI8xvLmlCAx3ro4wRzhm/oc2ASy4+YNBvKoU=;
 b=mthys00JewOSgvrtqBeMAi61WX6/BNc/B7pNKFYAGNP3UAdckQHCX9TrdN3ritAyka
 Sgnlkm9I4PGndRfApR/vBE+UHW0BkXGfGEerzN+creYqEu4pDNfOkY+OESi4w0FkedLm
 FFn+mC+CU9oEAOGBzrMVFQidk8Ic19klhU3hl36Y5eZoU32byRojExXok4uNyxRyIXhu
 Z8SlvHHzIUVQ1S8RvoVfbfuk1c/TGNoLrYo7UGQPb70Gm4F320MTt4viaulUMo+yh4J/
 Y8A0YO7V08WteHLFyrqAOj+qBg4QnoJN6m9SSZqR+RuY0x+pHnEDJO77IahOUtRuhNBA
 6jQA==
X-Gm-Message-State: AOJu0Yxzp0TwA+dXHSdehOedtZ8VrIbFmEdHUluRtQlE/cf7Nbw/qunA
 AJ/Dp3R0FcRDtCgvai51/gNobynKrgpTw00Z4toyVGZOZ2xIl7PceuuRelAGOQYKtoU=
X-Gm-Gg: AeBDieuFVGdIectACcii6P+uQ7NqYvd81wtzyekoHxgtbsvz8TGzRt7oY2+sqXigyJF
 CnjYQNbZscCyylDViw1VLVZRfpB7L8/kptRIvpiaUVqCYwSmpR+LRjcUQ8J0zxmhjRsTRHoOpbI
 7O4sW2/wVO5hBXPUjnzxld6ZKYQpSZBTKo6EhKeFSWgSF0yyvOG4z5OHwXBAoCUeYtnaJZs7GjT
 kqtDH/DXyloI99rAiShHtCG4oGOIEKF9mEAwJhOQ8sAmvKp6haeVrYSvA90BzMogyGQLM1wWi0Y
 JM/w0T+u5MqboensGnipBohiWWg8ICbXsz+mYo9A+TFqzzvysDxx5i9JDVooYo8NDE7PqhvhjIj
 6vH8Nb7WAXGZTAh0zJJZ4RsVrSmrCdD/8OE7HlhNEZZNjWFlFTvJYyUnuxGzJBxgFqJmpBXvclG
 9Arazf5BcUgrTKMV0o6BB6S9DI8X2c1v8deyTNU9tbi2M39EGJM0COw2VApl4whko24vnDkJS0J
 lI=
X-Received: by 2002:a05:6402:5418:b0:678:a507:e81e with SMTP id
 4fb4d7f45d1cf-678a507eac3mr6931021a12.22.1777293164829; 
 Mon, 27 Apr 2026 05:32:44 -0700 (PDT)
Received: from work.cisco.com ([2001:420:44f5:1250:14a7:2a07:58ff:b5b4])
 by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-672c480e18esm7009339a12.10.2026.04.27.05.32.43
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 27 Apr 2026 05:32:44 -0700 (PDT)
From: Maxime Peim <maxime.peim@gmail.com>
To: dev@dpdk.org
Cc: dsosnowski@nvidia.com, viacheslavo@nvidia.com, bingz@nvidia.com,
 orika@nvidia.com, suanmingm@nvidia.com, matan@nvidia.com
Subject: [PATCH v3] net/mlx5: prepend implicit items in sync flow creation path
Date: Mon, 27 Apr 2026 14:32:17 +0200
Message-ID: <20260427123217.510662-1-maxime.peim@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260420085236.2356342-1-maxime.peim@gmail.com>
References: <20260420085236.2356342-1-maxime.peim@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Wed, 29 Apr 2026 11:58:18 +0200
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

Fixes: e38776c36c8a ("net/mlx5: introduce HWS for non-template flow API")
Fixes: 821a6a5cc495 ("net/mlx5: add metadata split for compatibility")
Signed-off-by: Maxime Peim <maxime.peim@gmail.com>
---
v3:
  - Factor the implicit-item prepend logic out of
    flow_hw_pattern_template_create() into a new helper
    flow_hw_adjust_pattern() and reuse it from flow_hw_list_create(),
    instead of duplicating the prepend logic inline in the sync path.
  - Zero-initialize item_flags in both callers. The validator is
    read-modify-write on item_flags (reads MLX5_FLOW_LAYER_TUNNEL on
    the first iteration), so leaving it uninitialized was UB.
  - Call __flow_hw_pattern_validate() with nt_flow=true from the sync
    path (was effectively nt_flow=false via the wrapper), restoring the
    previous behavior that skips GENEVE_OPT TLV parser validation on
    the non-template path.
  - Document flow_hw_adjust_pattern(): the dual role of the nt_flow
    parameter (template spec-left-zero vs. sync spec-filled + validator
    flag), the three-way return, and the caller's ownership of
    *copied_items across every exit path.
  - Clarify the "omitting implicit REG_C_0 match" debug log now that
    the helper runs on both the template and sync paths.
  - Add Fixes: tags for the two original commits.

 drivers/net/mlx5/mlx5_flow_hw.c | 192 +++++++++++++++++++++-----------
 1 file changed, 130 insertions(+), 62 deletions(-)

diff --git a/drivers/net/mlx5/mlx5_flow_hw.c b/drivers/net/mlx5/mlx5_flow_hw.c
index bca5b2769e..ffd7a0076f 100644
--- a/drivers/net/mlx5/mlx5_flow_hw.c
+++ b/drivers/net/mlx5/mlx5_flow_hw.c
@@ -9255,33 +9255,40 @@ pattern_template_validate(struct rte_eth_dev *dev,
 	return -ret;
 }
 
-/**
- * Create flow item template.
+/*
+ * Validate the user-supplied items and, in eSwitch mode, prepend the implicit
+ * scoping item so the rule/template is bound to the current representor port:
+ *   - ingress -> RTE_FLOW_ITEM_TYPE_REPRESENTED_PORT (dev->data->port_id)
+ *   - egress  -> MLX5_RTE_FLOW_ITEM_TYPE_TAG on REG_C_0 (tx vport tag),
+ *                skipped when the user already supplied an SQ item.
  *
- * @param[in] dev
- *   Pointer to the rte_eth_dev structure.
- * @param[in] attr
- *   Pointer to the item template attributes.
- * @param[in] items
- *   The template item pattern.
- * @param[out] error
- *   Pointer to error structure.
+ * @param nt_flow
+ *   Selects between the two call paths that share this helper:
+ *     false -> pattern template creation (async API). The prepended item's
+ *              spec is left zeroed so mlx5dr matches any value; the live
+ *              port_id / tx-tag value is substituted later by
+ *              flow_hw_get_rule_items() at rule-create time.
+ *     true  -> sync (non-template) flow creation. The prepended item's spec
+ *              is filled immediately with the live values, and the flag is
+ *              forwarded to __flow_hw_pattern_validate() so that validation
+ *              paths gated on nt_flow (e.g. GENEVE_OPT TLV parser creation)
+ *              take the non-template branch.
  *
- * @return
- *  Item template pointer on success, NULL otherwise and rte_errno is set.
+ * Return / ownership:
+ *   - NULL on validation or allocation failure (error populated).
+ *   - `items` unchanged when no prepending is required; *copied_items == NULL.
+ *   - A newly-allocated array otherwise; also stored in *copied_items. The
+ *     caller must mlx5_free(*copied_items) on every path (it is safe to call
+ *     with NULL). Do not free the returned pointer directly.
  */
-static struct rte_flow_pattern_template *
-flow_hw_pattern_template_create(struct rte_eth_dev *dev,
-			     const struct rte_flow_pattern_template_attr *attr,
-			     const struct rte_flow_item items[],
-			     bool external,
-			     struct rte_flow_error *error)
+static const struct rte_flow_item *
+flow_hw_adjust_pattern(struct rte_eth_dev *dev, const struct rte_flow_pattern_template_attr *attr,
+		       bool nt_flow, const struct rte_flow_item *items, uint64_t *item_flags,
+		       uint64_t *nb_items, struct rte_flow_item **copied_items,
+		       struct rte_flow_error *error)
 {
 	struct mlx5_priv *priv = dev->data->dev_private;
-	struct rte_flow_pattern_template *it;
-	struct rte_flow_item *copied_items = NULL;
-	const struct rte_flow_item *tmpl_items;
-	uint64_t orig_item_nb, item_flags = 0;
+	struct rte_flow_item_ethdev port_spec = {.port_id = dev->data->port_id};
 	struct rte_flow_item port = {
 		.type = RTE_FLOW_ITEM_TYPE_REPRESENTED_PORT,
 		.mask = &rte_flow_item_ethdev_mask,
@@ -9298,39 +9305,89 @@ flow_hw_pattern_template_create(struct rte_eth_dev *dev,
 		.type = (enum rte_flow_item_type)MLX5_RTE_FLOW_ITEM_TYPE_TAG,
 		.spec = &tag_v,
 		.mask = &tag_m,
-		.last = NULL
+		.last = NULL,
 	};
-	int it_items_size;
-	unsigned int i = 0;
 	int rc;
 
+	if (!copied_items || !item_flags || !nb_items)
+		return NULL;
+
+	if (nt_flow) {
+		port.spec = &port_spec;
+		tag_v.data = flow_hw_tx_tag_regc_value(dev);
+	}
+
+	/*
+	 * item_flags must be zero-initialized: __flow_hw_pattern_validate()
+	 * OR-accumulates bits into it and reads it (MLX5_FLOW_LAYER_TUNNEL)
+	 * on the first iteration.
+	 */
+	*item_flags = 0;
+
 	/* Validate application items only */
-	rc = flow_hw_pattern_validate(dev, attr, items, &item_flags, error);
+	rc = __flow_hw_pattern_validate(dev, attr, items, item_flags, nt_flow, error);
 	if (rc < 0)
 		return NULL;
-	orig_item_nb = rc;
-	if (priv->sh->config.dv_esw_en &&
-	    attr->ingress && !attr->egress && !attr->transfer) {
-		copied_items = flow_hw_prepend_item(items, orig_item_nb, &port, error);
-		if (!copied_items)
+	*nb_items = rc;
+
+	if (priv->sh->config.dv_esw_en && attr->ingress && !attr->egress && !attr->transfer) {
+		*copied_items = flow_hw_prepend_item(items, *nb_items, &port, error);
+		if (!*copied_items)
 			return NULL;
-		tmpl_items = copied_items;
-	} else if (priv->sh->config.dv_esw_en &&
-		   !attr->ingress && attr->egress && !attr->transfer) {
-		if (item_flags & MLX5_FLOW_ITEM_SQ) {
-			DRV_LOG(DEBUG, "Port %u omitting implicit REG_C_0 match for egress "
-				       "pattern template", dev->data->port_id);
-			tmpl_items = items;
-			goto setup_pattern_template;
+		return *copied_items;
+	} else if (priv->sh->config.dv_esw_en && !attr->ingress && attr->egress &&
+		   !attr->transfer) {
+		if (*item_flags & MLX5_FLOW_ITEM_SQ) {
+			DRV_LOG(DEBUG,
+				"Port %u: explicit SQ item present, omitting implicit "
+				"REG_C_0 match for egress pattern",
+				dev->data->port_id);
+			return items;
 		}
-		copied_items = flow_hw_prepend_item(items, orig_item_nb, &tag, error);
-		if (!copied_items)
+		*copied_items = flow_hw_prepend_item(items, *nb_items, &tag, error);
+		if (!*copied_items)
 			return NULL;
-		tmpl_items = copied_items;
-	} else {
-		tmpl_items = items;
+		return *copied_items;
 	}
-setup_pattern_template:
+	return items;
+}
+
+/**
+ * Create flow item template.
+ *
+ * @param[in] dev
+ *   Pointer to the rte_eth_dev structure.
+ * @param[in] attr
+ *   Pointer to the item template attributes.
+ * @param[in] items
+ *   The template item pattern.
+ * @param[out] error
+ *   Pointer to error structure.
+ *
+ * @return
+ *  Item template pointer on success, NULL otherwise and rte_errno is set.
+ */
+static struct rte_flow_pattern_template *
+flow_hw_pattern_template_create(struct rte_eth_dev *dev,
+			     const struct rte_flow_pattern_template_attr *attr,
+			     const struct rte_flow_item items[],
+			     bool external,
+			     struct rte_flow_error *error)
+{
+	struct mlx5_priv *priv = dev->data->dev_private;
+	struct rte_flow_pattern_template *it;
+	struct rte_flow_item *copied_items = NULL;
+	const struct rte_flow_item *tmpl_items;
+	int it_items_size;
+	uint64_t orig_item_nb, item_flags;
+	unsigned int i = 0;
+	int rc;
+
+	tmpl_items = flow_hw_adjust_pattern(dev, attr, false, items, &orig_item_nb, &item_flags,
+					    &copied_items, error);
+	if (!tmpl_items)
+		return NULL;
+
 	it = mlx5_malloc(MLX5_MEM_ZERO, sizeof(*it), 0, SOCKET_ID_ANY);
 	if (!it) {
 		rte_flow_error_set(error, ENOMEM,
@@ -14272,7 +14329,6 @@ static uintptr_t flow_hw_list_create(struct rte_eth_dev *dev,
 	struct rte_flow_hw *prfx_flow = NULL;
 	const struct rte_flow_action *qrss = NULL;
 	const struct rte_flow_action *mark = NULL;
-	uint64_t item_flags = 0;
 	uint64_t action_flags = mlx5_flow_hw_action_flags_get(actions, &qrss, &mark,
 							 &encap_idx, &actions_n, error);
 	struct mlx5_flow_hw_split_resource resource = {
@@ -14289,20 +14345,25 @@ static uintptr_t flow_hw_list_create(struct rte_eth_dev *dev,
 		.egress = attr->egress,
 		.transfer = attr->transfer,
 	};
-
-	/* Validate application items only */
-	ret = __flow_hw_pattern_validate(dev, &pattern_template_attr, items,
-						&item_flags, true, error);
-	if (ret < 0)
-		return 0;
+	struct rte_flow_item *copied_items = NULL;
+	const struct rte_flow_item *prepend_items;
+	uint64_t orig_item_nb, item_flags;
 
 	RTE_SET_USED(encap_idx);
 	if (!error)
 		error = &shadow_error;
+
+	prepend_items = flow_hw_adjust_pattern(dev, &pattern_template_attr, true, items,
+					       &orig_item_nb, &item_flags, &copied_items, error);
+	if (!prepend_items)
+		return 0;
+
 	split = mlx5_flow_nta_split_metadata(dev, attr, actions, qrss, action_flags,
 					     actions_n, external, &resource, error);
-	if (split < 0)
-		return split;
+	if (split < 0) {
+		mlx5_free(copied_items);
+		return 0;
+	}
 
 	/* Update the metadata copy table - MLX5_FLOW_MREG_CP_TABLE_GROUP */
 	if (((attr->ingress && attr->group != MLX5_FLOW_MREG_CP_TABLE_GROUP) ||
@@ -14313,23 +14374,26 @@ static uintptr_t flow_hw_list_create(struct rte_eth_dev *dev,
 			goto free;
 	}
 	if (action_flags & MLX5_FLOW_ACTION_SAMPLE) {
-		flow = mlx5_nta_sample_flow_list_create(dev, type, attr, items, actions,
+		flow = mlx5_nta_sample_flow_list_create(dev, type, attr, prepend_items, actions,
 							item_flags, action_flags, error);
-		if (flow != NULL)
+		if (flow != NULL) {
+			mlx5_free(copied_items);
 			return (uintptr_t)flow;
+		}
 		goto free;
 	}
 	if (action_flags & MLX5_FLOW_ACTION_RSS) {
 		const struct rte_flow_action_rss
 			*rss_conf = mlx5_flow_nta_locate_rss(dev, actions, error);
-		flow = mlx5_flow_nta_handle_rss(dev, attr, items, actions, rss_conf,
-						item_flags, action_flags, external,
-						type, error);
+		flow = mlx5_flow_nta_handle_rss(dev, attr, prepend_items, actions, rss_conf,
+						item_flags, action_flags, external, type, error);
 		if (flow) {
 			flow->nt2hws->rix_mreg_copy = cpy_idx;
 			cpy_idx = 0;
-			if (!split)
+			if (!split) {
+				mlx5_free(copied_items);
 				return (uintptr_t)flow;
+			}
 			goto prefix_flow;
 		}
 		goto free;
@@ -14343,12 +14407,14 @@ static uintptr_t flow_hw_list_create(struct rte_eth_dev *dev,
 	if (flow) {
 		flow->nt2hws->rix_mreg_copy = cpy_idx;
 		cpy_idx = 0;
-		if (!split)
+		if (!split) {
+			mlx5_free(copied_items);
 			return (uintptr_t)flow;
+		}
 		/* Fall Through to prefix flow creation. */
 	}
 prefix_flow:
-	ret = mlx5_flow_hw_create_flow(dev, type, attr, items, resource.prefix.actions,
+	ret = mlx5_flow_hw_create_flow(dev, type, attr, prepend_items, resource.prefix.actions,
 				       item_flags, action_flags, external, &prfx_flow, error);
 	if (ret)
 		goto free;
@@ -14357,6 +14423,7 @@ static uintptr_t flow_hw_list_create(struct rte_eth_dev *dev,
 		flow->nt2hws->chaned_flow = 1;
 		SLIST_INSERT_AFTER(prfx_flow, flow, nt2hws->next);
 		mlx5_flow_nta_split_resource_free(dev, &resource);
+		mlx5_free(copied_items);
 		return (uintptr_t)prfx_flow;
 	}
 free:
@@ -14368,6 +14435,7 @@ static uintptr_t flow_hw_list_create(struct rte_eth_dev *dev,
 		mlx5_flow_nta_del_copy_action(dev, cpy_idx);
 	if (split > 0)
 		mlx5_flow_nta_split_resource_free(dev, &resource);
+	mlx5_free(copied_items);
 	return 0;
 }
 
-- 
2.43.0

