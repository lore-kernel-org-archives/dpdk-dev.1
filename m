Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 10F44F3ED4F
	for <dpdk-dev@archiver.kernel.org>; Sat, 11 Apr 2026 13:58:15 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 2B27D402A3;
	Sat, 11 Apr 2026 15:58:15 +0200 (CEST)
Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com
 [209.85.128.44]) by mails.dpdk.org (Postfix) with ESMTP id 3481740276
 for <dev@dpdk.org>; Thu,  9 Apr 2026 20:57:00 +0200 (CEST)
Received: by mail-wm1-f44.google.com with SMTP id
 5b1f17b1804b1-4887fd35e60so8504565e9.2
 for <dev@dpdk.org>; Thu, 09 Apr 2026 11:57:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1775761020; x=1776365820; darn=dpdk.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=Y6hlAysM/PMZpKJecuBUUIRXJ06Wsy2Bo4Zk6tjniec=;
 b=irvRWXJgwkCCQNuuHiq9EgTYccRQg7Xe9bHpX0zgB1ENgZFXapgZVcCMoSAXSagyKA
 aVDHdipUVHcMfk24eREad96h9e7dGvH9hZ/BuojEST7VGLW1P3OOOkyD5G567jcCSp5/
 YCPG4tjQ3L8yF4F/xfTfYs0RzpwpUOb6/4DeD6+UofardAQy94oD13p0+XKFCOQ+9ohc
 usM7xz4FKyGb8NxMSlWSz02PWFn1bjAKlHhU64Xuv+HGDkwJItS3RH2mYPOoNMMKmNWj
 uDkKbFU8/mUFVqQCwYh8DShtBe7/KD07Mf6sOizU5dOUL4MxEOx4o6PtvpaDZCSG/kHD
 4AvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1775761020; x=1776365820;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Y6hlAysM/PMZpKJecuBUUIRXJ06Wsy2Bo4Zk6tjniec=;
 b=FAP6WZpSbUOpxjhj/mzYFX+DUbF2hyeencZKVd2cBKcSQBV5XFohFB3aRgp7AETsc+
 i2lsuHARZPqsJ8MUrFJT+iDop0J0TQJBUlDdjEZVc8ZSgRrSPVYhzQ8Z3WOoz2i2WJuX
 wWkyMC1nIDyv8iMqJZNGGQF5FdAuTP9fonKKuI2lOteBlYYRWvESwzljGi45FBQiCFn6
 yJaMY1tbqq7zS00ipY6T33elOUFKKh5nIXAqIUHIhtTEuC8ECRFsRMlm3s/5h/Zfpk5k
 scUTRGuSt452wS5l6zsPgYAyYSvbbyE3JX5hyf2WxIyqx3zH1fw3GSwr5qUojHyL+G4Z
 RWmA==
X-Gm-Message-State: AOJu0Yw5iuUxPyteNOdjDC1GXKLgo3Yv4gevZNZp+zkzBYt/d9cjhAP7
 inCL5r4v7q6V43HXneQDqErZl3+Bx/UtiCFUlQenQRMlpzXKpIsvNkKBCT7e7EUkauRT4upo
X-Gm-Gg: AeBDievxc1ugwbJFZsI7Cf47rjPyLyAbF08XxBNRjQflxHH2j93WUWbUxCGmYhjNfhD
 IB4wIY07pHRzinJQDzsdgYd0W2vIZFTb5XkNoPg9f+N2cs2m+rTRDRnBcxllVwZumtWrcaQHUll
 vXWzA1d1QpfbtwPKOI0TBka79+AlDDuwxC4FMva6qvGQHdV5xVdTWkzsDuOnnQFNk7ZneYj1ULz
 cd0atTnK84s5uIdSr0lxeFJqYCWkJO4cCjncyJ5+A2426TsNH32z0DNzlHCXjXrAReogNpRIoAZ
 6cHUmKNMacyENUTeAid9Wuih2w/Cde2xa3PI1T0POg063kvoqi683hFUmuxPngIfOgmd5DUwx4w
 GPX22wMLqeCTEBC4V11BeSjn2nzq/HkWO/RN/iQ7Gep84YHaUahz911tWJy/ZU1XQO+kXRAKC9Y
 p1nj58PJuKOqcfymVo0AUnMgFZgR9OAdmyl5KVPmkqM3/+hKUfUjFbxZ8=
X-Received: by 2002:a05:6000:40cb:b0:43c:ef4f:79e4 with SMTP id
 ffacd0b85a97d-43d642b461cmr315662f8f.37.1775761019534; 
 Thu, 09 Apr 2026 11:56:59 -0700 (PDT)
Received: from work.lan ([2a01:e0a:906:9aa0:6e23:6cda:de77:862a])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-43d63e5d88bsm651479f8f.37.2026.04.09.11.56.58
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 09 Apr 2026 11:56:59 -0700 (PDT)
From: Maxime Peim <maxime.peim@gmail.com>
To: dev@dpdk.org
Cc: dsosnowski@nvidia.com, viacheslavo@nvidia.com, bingz@nvidia.com,
 orika@nvidia.com, suanmingm@nvidia.com, matan@nvidia.com
Subject: [PATCH] net/mlx5: prepend implicit items in sync flow creation path
Date: Thu,  9 Apr 2026 20:56:34 +0200
Message-ID: <20260409185634.3996187-1-maxime.peim@gmail.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Sat, 11 Apr 2026 15:58:13 +0200
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
 drivers/net/mlx5/mlx5_flow_hw.c | 78 ++++++++++++++++++++++++++++++---
 1 file changed, 73 insertions(+), 5 deletions(-)

diff --git a/drivers/net/mlx5/mlx5_flow_hw.c b/drivers/net/mlx5/mlx5_flow_hw.c
index bca5b2769e..d05cd2075c 100644
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
@@ -14296,13 +14319,50 @@ static uintptr_t flow_hw_list_create(struct rte_eth_dev *dev,
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
+		resource.suffix.items = items;
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
+		resource.suffix.items = items;
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
@@ -14315,8 +14375,10 @@ static uintptr_t flow_hw_list_create(struct rte_eth_dev *dev,
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
@@ -14328,8 +14390,10 @@ static uintptr_t flow_hw_list_create(struct rte_eth_dev *dev,
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
@@ -14343,8 +14407,10 @@ static uintptr_t flow_hw_list_create(struct rte_eth_dev *dev,
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
@@ -14357,6 +14423,7 @@ static uintptr_t flow_hw_list_create(struct rte_eth_dev *dev,
 		flow->nt2hws->chaned_flow = 1;
 		SLIST_INSERT_AFTER(prfx_flow, flow, nt2hws->next);
 		mlx5_flow_nta_split_resource_free(dev, &resource);
+		mlx5_free(prepend_items);
 		return (uintptr_t)prfx_flow;
 	}
 free:
@@ -14368,6 +14435,7 @@ static uintptr_t flow_hw_list_create(struct rte_eth_dev *dev,
 		mlx5_flow_nta_del_copy_action(dev, cpy_idx);
 	if (split > 0)
 		mlx5_flow_nta_split_resource_free(dev, &resource);
+	mlx5_free(prepend_items);
 	return 0;
 }
 
-- 
2.43.0

