Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DF362CD4F39
	for <dpdk-dev@archiver.kernel.org>; Thu, 14 May 2026 19:34:15 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id CE72B402B5;
	Thu, 14 May 2026 21:34:14 +0200 (CEST)
Received: from mail-qk1-f176.google.com (mail-qk1-f176.google.com
 [209.85.222.176])
 by mails.dpdk.org (Postfix) with ESMTP id 13065402AA
 for <dev@dpdk.org>; Thu, 14 May 2026 21:34:13 +0200 (CEST)
Received: by mail-qk1-f176.google.com with SMTP id
 af79cd13be357-9103019f8c4so231685985a.3
 for <dev@dpdk.org>; Thu, 14 May 2026 12:34:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1778787252; x=1779392052; darn=dpdk.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=1jdzVAKH2pzYrj1VDRosMjddlvZHDwdLh/wk9nGJLhg=;
 b=ld1MWyMOLaPsPFmQUGjlCvBgMDzWhOUEbj2N+xwUArxELlO/I67rlf1PYHpO7wV0AS
 AenpLukYTgaUVdsARI53xIPKR2DoHbeweLONZuHgvS+5XzJ4c5W8RK+K2Yy6Ztu41cFd
 tOKANG9ucuOCcKrVgf3b18rUkZosXpWM/8ZSruTYWuoeWrElRD0vaIiw44Iq781YdKAq
 jzSh6RT28sz8HfY0DE1JO013RrJv1fw+ugy7sMJXmLbL0CChLYfhR0iJkcgo5gd+u1Ci
 uufAdACbVh0xQO5U2/QpPmjscNApfKtM0JhtFI0BOdgkBvHddFYeI7iQLXadI4f2KAL8
 OU9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778787252; x=1779392052;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=1jdzVAKH2pzYrj1VDRosMjddlvZHDwdLh/wk9nGJLhg=;
 b=r1n5+pKCimIMnIm6JuAeQVPbrstcv43+kweo992YsoJzfpaFrkD2ZDVpx1DpJjTAwT
 9nexH/inJ47wGoJ/pfPjkbOkuUKvkGBpXWEZwcsH19YaKzfmH05uJZZSMexanePVUtC4
 q4qOJZxBEAA2B4BsdWK1N+MgbRzEGHeW9ePqRFUqeQgswSsvA5EYtjN1oodWdC0BsYTl
 Fw4IzSAqNhzyIUzv3eTj5mP015dmjWd0tXSWhOgoELPU2nli8e7OKiK/fE/qvp2AYcoK
 TDC5N1Vu14+f1mfN+A0VEUjQDrRu901eijfABJdmktcNSNwgThx3vg/yW8PmXg92gssW
 ylKQ==
X-Gm-Message-State: AOJu0YzUtb6RqZKF64lq4CwXLzjmNjmUNE4bcp5UqETeadArwwIU9EeI
 cTYt+8HwhFfi1uhdxebuOBEPl/7QuWU5IhS+bISGb0MF9HiyiZdWz+e5RI9NHuAu
X-Gm-Gg: Acq92OE6QRZss9kHtJay26jh4SWuWlSFwttrhjtpNc+0y7bAKVKAXhy95o+3EuGUKVx
 KW/iyUnWsueuiJQoIhQ8TciD6wI7JFY/CFZsHcbQM8okRUwJ91ioHmWaPmv3Jx7EsrYrBPMNBW5
 dvpKj3Bvyq7dhF6eomMhQL9S8AEDx4CzuvRWSD5jB4HphMFFef/cdu6xVnpj/kPFoRZ9UhKfdhI
 gQFupkuvf+geQ7BJvIWxBTjUdqXCrNHeKuQiSPOOUeGXoWBqMAkIke9I6Yp277gxNZgptlpZSxa
 J+PW40kzM0cvE+hMXEL3j+5TNcCKWMQZC1H2/apG/O4BAf6bI92DDbf6iGI7huy2DRdpBtQZCBs
 rIc+TdMWwAOircI6bS0CA5lrXcUqK9rl6X/rTKXd2HeMn1FsceR6fNBCAwRk4wWvGhBdUWqvPy7
 VAiNxk7yL88pRMhIattFCOxiKnXvnKxcIF6aF2IiNDbyGovAvcVISrXmqdbiAKnm4C7tiLjQ==
X-Received: by 2002:a05:620a:4556:b0:8e8:bedd:14b7 with SMTP id
 af79cd13be357-911cd75d7ebmr160515885a.22.1778787251741; 
 Thu, 14 May 2026 12:34:11 -0700 (PDT)
Received: from zenbook.. (modemcable122.217-70-69.static.videotron.ca.
 [69.70.217.122]) by smtp.gmail.com with ESMTPSA id
 af79cd13be357-910ba463814sm321109485a.5.2026.05.14.12.34.10
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 14 May 2026 12:34:11 -0700 (PDT)
From: Rayane Boussanni <rboussanni@gmail.com>
To: dev@dpdk.org
Cc: dsosnowski@nvidia.com, rasland@nvidia.com,
 Rayane Boussanni <rboussanni@gmail.com>
Subject: [PATCH v3] net/mlx5: add validation for indirect actions
Date: Thu, 14 May 2026 15:33:59 -0400
Message-ID: <20260514193359.195017-1-rboussanni@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260417222104.66543-1-rboussanni@gmail.com>
References: <20260417222104.66543-1-rboussanni@gmail.com>
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
to the underlying validation specialists. For indirect RSS, only the
template attributes are validated, as the RSS configuration itself is
already validated when the indirect action handle is created.

Reported-by: Dariusz Sosnowski <dsosnowski@nvidia.com>
Signed-off-by: Rayane Boussanni <rboussanni@gmail.com>
---
v3:
- Fix segfault reported by Dariusz Sosnowski when an actions template
  references an indirect RSS action. v2 called
  mlx5_hw_validate_action_rss() on the indirect path, which
  dereferences action->conf as struct rte_flow_action_rss. For indirect
  actions action->conf is an opaque action handle, not an RSS config.
  Add bool is_indirect to mlx5_hw_validate_action_rss() so the indirect
  path validates only the template attributes
  (ingress/egress/transfer).

 drivers/net/mlx5/mlx5_flow_hw.c | 36 ++++++++++++++++++++++++++++++---
 1 file changed, 33 insertions(+), 3 deletions(-)

diff --git a/drivers/net/mlx5/mlx5_flow_hw.c b/drivers/net/mlx5/mlx5_flow_hw.c
index bca5b2769e..da5eb0bc42 100644
--- a/drivers/net/mlx5/mlx5_flow_hw.c
+++ b/drivers/net/mlx5/mlx5_flow_hw.c
@@ -349,6 +349,23 @@ mlx5_flow_ct_init(struct rte_eth_dev *dev,
 static __rte_always_inline uint32_t flow_hw_tx_tag_regc_mask(struct rte_eth_dev *dev);
 static __rte_always_inline uint32_t flow_hw_tx_tag_regc_value(struct rte_eth_dev *dev);
 
+static int
+mlx5_hw_validate_action_rss(struct rte_eth_dev *dev,
+			    const struct rte_flow_action *template_action,
+			    const struct rte_flow_action *template_mask,
+			    const struct rte_flow_actions_template_attr *template_attr,
+			    uint64_t action_flags,
+			    bool is_indirect,
+			    struct rte_flow_error *error);
+
+static int
+mlx5_hw_validate_action_conntrack(struct rte_eth_dev *dev,
+				  const struct rte_flow_action *template_action,
+				  const struct rte_flow_action *template_mask,
+				  const struct rte_flow_actions_template_attr *template_attr,
+				  uint64_t action_flags,
+				  struct rte_flow_error *error);
+
 static int flow_hw_async_create_validate(struct rte_eth_dev *dev,
 					 const uint32_t queue,
 					 const struct rte_flow_template_table *table,
@@ -6604,6 +6621,8 @@ flow_hw_validate_action_meter_mark(struct rte_eth_dev *dev,
  *   Pointer to the indirect action.
  * @param[in] mask
  *   Pointer to the indirect action mask.
+ * @param[in] attr
+ *   Pointer to the action template attributes.
  * @param[in, out] action_flags
  *   Holds the actions detected until now.
  * @param[in, out] fixed_cnt
@@ -6618,6 +6637,7 @@ static int
 flow_hw_validate_action_indirect(struct rte_eth_dev *dev,
 				 const struct rte_flow_action *action,
 				 const struct rte_flow_action *mask,
+				 const struct rte_flow_actions_template_attr *attr,
 				 uint64_t *action_flags, bool *fixed_cnt,
 				 struct rte_flow_error *error)
 {
@@ -6637,11 +6657,17 @@ flow_hw_validate_action_indirect(struct rte_eth_dev *dev,
 		*action_flags |= MLX5_FLOW_ACTION_METER;
 		break;
 	case RTE_FLOW_ACTION_TYPE_RSS:
-		/* TODO: Validation logic (same as flow_hw_actions_validate) */
+		ret = mlx5_hw_validate_action_rss(dev, action, mask, attr,
+						  *action_flags, true, error);
+		if (ret < 0)
+			return ret;
 		*action_flags |= MLX5_FLOW_ACTION_RSS;
 		break;
 	case RTE_FLOW_ACTION_TYPE_CONNTRACK:
-		/* TODO: Validation logic (same as flow_hw_actions_validate) */
+		ret = mlx5_hw_validate_action_conntrack(dev, action, mask, attr,
+							*action_flags, error);
+		if (ret < 0)
+			return ret;
 		*action_flags |= MLX5_FLOW_ACTION_CT;
 		break;
 	case RTE_FLOW_ACTION_TYPE_COUNT:
@@ -7139,6 +7165,7 @@ mlx5_hw_validate_action_rss(struct rte_eth_dev *dev,
 			      const struct rte_flow_action *template_mask,
 			      const struct rte_flow_actions_template_attr *template_attr,
 			      __rte_unused uint64_t action_flags,
+			      bool is_indirect,
 			      struct rte_flow_error *error)
 {
 	struct mlx5_priv *priv = dev->data->dev_private;
@@ -7148,6 +7175,8 @@ mlx5_hw_validate_action_rss(struct rte_eth_dev *dev,
 		return rte_flow_error_set(error, EINVAL,
 					  RTE_FLOW_ERROR_TYPE_ATTR, NULL,
 					  "RSS action supported for ingress only");
+	if (is_indirect)
+		return 0;
 	if (mask != NULL)
 		return mlx5_validate_action_rss(dev, template_action, error);
 	else
@@ -7352,6 +7381,7 @@ mlx5_flow_hw_actions_validate(struct rte_eth_dev *dev,
 		case RTE_FLOW_ACTION_TYPE_INDIRECT:
 			ret = flow_hw_validate_action_indirect(dev, action,
 							       mask,
+							       attr,
 							       &action_flags,
 							       &fixed_cnt,
 							       error);
@@ -7407,7 +7437,7 @@ mlx5_flow_hw_actions_validate(struct rte_eth_dev *dev,
 		case RTE_FLOW_ACTION_TYPE_RSS:
 			ret = mlx5_hw_validate_action_rss(dev, action, mask,
 							  attr, action_flags,
-							  error);
+							  false, error);
 			if (ret)
 				return ret;
 			action_flags |= MLX5_FLOW_ACTION_RSS;
-- 
2.43.0

