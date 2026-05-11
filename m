Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1BB8FCD4F26
	for <dpdk-dev@archiver.kernel.org>; Tue, 12 May 2026 07:56:10 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 4232740662;
	Tue, 12 May 2026 09:55:53 +0200 (CEST)
Received: from mail-qt1-f175.google.com (mail-qt1-f175.google.com
 [209.85.160.175])
 by mails.dpdk.org (Postfix) with ESMTP id 829A5402D5
 for <dev@dpdk.org>; Mon, 11 May 2026 17:09:34 +0200 (CEST)
Received: by mail-qt1-f175.google.com with SMTP id
 d75a77b69052e-514ae601df2so7213961cf.0
 for <dev@dpdk.org>; Mon, 11 May 2026 08:09:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1778512174; x=1779116974; darn=dpdk.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=kubiXcWQjcKc+bEaN5BuEr0OTWtA/F/+iD1AS6uqiZo=;
 b=edtThaXAiS9h31YvzgEn7/VPzo2ut1iUHwH4IfuhqvIxXdhrU3lDbb/cuQ9qJ3LLdK
 /XqMhFu6IVf/ZjSq9LTvAy/f+9PUiUoW8RrgeqZP951u7aeksShlEpCj/lCDXVbABz1L
 5TmECvmQQscZEZ2o7pvu5ioYsE4ztMCXNS8ZVus2jtFGDiuO1mtRsfLW1pLkF+UdL2IO
 M000Jb+G+XU9+tPeQKLBX4Zui3GPtaFzHj0bQml/R1KJmvf8GMlBf2q5W2azAES9OgDy
 F6lIlE69j9Cfw+Z6YrMhiU+vuM2DXI8tPrp6LcsWXNf8ldV3jY+NuNyY23DxzvO3Pwas
 /RxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778512174; x=1779116974;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=kubiXcWQjcKc+bEaN5BuEr0OTWtA/F/+iD1AS6uqiZo=;
 b=mcZbfK7tr3JyOSfVp4LPwb3rRolbLLGqp4urP0P7TFsFQ+8HRy0mOukNBZkSYzcZ2F
 ziw9nyhIQBuyWw7npJ6NzZnwQag8IY75A9HbT4gLUrsVQQLDcb28VVcf0er6wuD5Sacg
 AT9vmctPHI2AFJ6acDN7ed2fRCGuYIgAJMEs8Vl2rOLR6+HO4tlWpZp8IxGtC8CKP61a
 9bDYzigrbOH89jzM9Zm1eLqn677MIaoHpyXGUDv444Qz1rmJSkXBxGUHsgy+yS16YQ2N
 gOzAAMOM+JcA2FNlNn0i54Whmb3NNnZJhqrv4/p8mJh5rMJowwW57LWvb4v7vfmTwav+
 9cwQ==
X-Gm-Message-State: AOJu0YwtFSLZP3RGkaApT4CJso9jRdAOdhJx4PlPUqzBPEijBdw4AZHL
 DhR5WJZmgqp6V4lKqkhxhJ5dW31LPQIWXfx7nQ8768xo8eMQcYsxT5+X16VXsasI6GB8Rg==
X-Gm-Gg: Acq92OEu+V1D9i4o6BfM6OqiQG+zEYf2x/V2zAe8w0VfWTsJcOuIH1f2g0J50znZq/J
 oN9DGV5Hmqxbar76WZGgbNvzv08minT921czbyJxiiByp7FuuVXpdbSDEzAYgJgEk8MQTtpwcRr
 y+nTWF4f4KZfjWj+LYHHDgHjD8NhYjkwdjwk64tnBkI0oOU7nnGfK3RDbx8BXQ75VK/3238wZgP
 ubSTq1Oz+H0AUnkWlrYJMK09/9fSKteLldwoCiRzvcVt+QauNBrDyxrpGCtGI9upXMtGCLZ0gBV
 99sV1XFt+A/kh8XQnOCuk7gLTA6RbhGesVKzzEbPWQgrTDtsn0PiJTKC9xwSpZ0t2+QdM2lwvqz
 N3mkkHSwbxS5uDNzOe2WTLfnA5rPszp8CahtvovHVhE/5eaWCrio6niKq4zg0ufi5cTBQ2dns8m
 LGZIBbCgzeOQqplBQBBgowJD6+lNg9lmRnAMU7rF6194AhMGQjo1rqgRFZ6u6y87w+rGm5lgfGT
 UuIUOmwy7MUXA==
X-Received: by 2002:ac8:6f1b:0:b0:50d:cd5a:577b with SMTP id
 d75a77b69052e-51461f9e471mr389629951cf.35.1778512172773; 
 Mon, 11 May 2026 08:09:32 -0700 (PDT)
Received: from work.cisco.com ([2603:5004:20a0:100a:6955:1add:67f8:6976])
 by smtp.gmail.com with ESMTPSA id
 d75a77b69052e-5148fa78723sm88069081cf.3.2026.05.11.08.09.30
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 11 May 2026 08:09:32 -0700 (PDT)
From: Maxime Peim <maxime.peim@gmail.com>
To: dev@dpdk.org
Cc: dsosnowski@nvidia.com, viacheslavo@nvidia.com, bingz@nvidia.com,
 orika@nvidia.com, suanmingm@nvidia.com, matan@nvidia.com
Subject: [PATCH v4] net/mlx5: prepend implicit items in sync flow creation path
Date: Mon, 11 May 2026 17:08:50 +0200
Message-ID: <20260511150854.1398044-1-maxime.peim@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260427123217.510662-1-maxime.peim@gmail.com>
References: <20260427123217.510662-1-maxime.peim@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Tue, 12 May 2026 09:55:49 +0200
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

v4:
  - Fix items in case splitted metadata are not needed.

 drivers/net/mlx5/mlx5_flow_hw.c | 194 ++++++++++++++++++++++----------
 1 file changed, 132 insertions(+), 62 deletions(-)

diff --git a/drivers/net/mlx5/mlx5_flow_hw.c b/drivers/net/mlx5/mlx5_flow_hw.c
index bca5b2769e..6b3fcb43a7 100644
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
@@ -14289,20 +14345,27 @@ static uintptr_t flow_hw_list_create(struct rte_eth_dev *dev,
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
+	} else if (!split) {
+		resource.suffix.items = prepend_items;
+	}
 
 	/* Update the metadata copy table - MLX5_FLOW_MREG_CP_TABLE_GROUP */
 	if (((attr->ingress && attr->group != MLX5_FLOW_MREG_CP_TABLE_GROUP) ||
@@ -14313,23 +14376,26 @@ static uintptr_t flow_hw_list_create(struct rte_eth_dev *dev,
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
@@ -14343,12 +14409,14 @@ static uintptr_t flow_hw_list_create(struct rte_eth_dev *dev,
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
@@ -14357,6 +14425,7 @@ static uintptr_t flow_hw_list_create(struct rte_eth_dev *dev,
 		flow->nt2hws->chaned_flow = 1;
 		SLIST_INSERT_AFTER(prfx_flow, flow, nt2hws->next);
 		mlx5_flow_nta_split_resource_free(dev, &resource);
+		mlx5_free(copied_items);
 		return (uintptr_t)prfx_flow;
 	}
 free:
@@ -14368,6 +14437,7 @@ static uintptr_t flow_hw_list_create(struct rte_eth_dev *dev,
 		mlx5_flow_nta_del_copy_action(dev, cpy_idx);
 	if (split > 0)
 		mlx5_flow_nta_split_resource_free(dev, &resource);
+	mlx5_free(copied_items);
 	return 0;
 }
 
-- 
2.43.0

