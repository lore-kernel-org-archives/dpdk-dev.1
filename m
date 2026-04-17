Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CA138F99C63
	for <dpdk-dev@archiver.kernel.org>; Fri, 17 Apr 2026 22:22:49 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id E3C8E402B2;
	Sat, 18 Apr 2026 00:22:48 +0200 (CEST)
Received: from mail-qt1-f175.google.com (mail-qt1-f175.google.com
 [209.85.160.175])
 by mails.dpdk.org (Postfix) with ESMTP id A6B12402B0
 for <dev@dpdk.org>; Sat, 18 Apr 2026 00:22:47 +0200 (CEST)
Received: by mail-qt1-f175.google.com with SMTP id
 d75a77b69052e-50d58c513dbso10271721cf.2
 for <dev@dpdk.org>; Fri, 17 Apr 2026 15:22:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1776464566; x=1777069366; darn=dpdk.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=pJBJUFqAFDABVXL0mpX3JQscFm2yL1q5DzopYx4oqi4=;
 b=BkFu9dPZXrBP8NpjXN7L4XruoFe68UV80tCWXNudvt+bzgOMP+XJutJ2ipS2upQhaN
 AfRp63n7NMXyyocUXT35KepoBPsd1WnR6XcDTOt8kxe3HHz4cSCTTey/01Fz5RBEoEuk
 5vo5oK1B/mv2rrxlX5hLtIgQEAmTmgR3I9ig/LOhQx5ePaee+GXfhN0BBL0qM68kCzpy
 i6c4Bw1fiBBScRUEq01A6ElMal2la57pSaDBKKFMnyl/MAHzpGC1of/gfERrHM4+URXd
 p9Uvk9lIHOmOUULsopAXTmnv4V0gB38uzF1N8sZIi0utXsTYqAYS2A+DEaBi5Fnld9SG
 XwKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1776464566; x=1777069366;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=pJBJUFqAFDABVXL0mpX3JQscFm2yL1q5DzopYx4oqi4=;
 b=RLyS00JYi/bx+wHmMUgMHQxEMTZcTokHz/nS/qS4bRYkLQj3n2S/kFXEAlXlJMu7oL
 C5PfM54OLRgcA/ZCZhV8RmPeChuEAq5kEYGVnaLGYLFR5QGmVIZ6eoHjd0d6lR11h93I
 dIs6ch2nu2DoDzfTlTmmwCWNk7ElbfTJpGJ/sryu61Ppi7DjWY3fIeerk6ZDbZWLZMgj
 x9Pa6sYciRvDdKmTkOoBbip9EyJJcRWl4guvzqM1GYIKH2snbAeViJOrZmpWhNAHYlMv
 7nfllNCwajSN5E6XahKEoLKauBme9Lw/09znezQbgvWsdyJSjHgyYsm2vllDZX1MVhb9
 sZOw==
X-Gm-Message-State: AOJu0YwqjEH++J7JR5louvnwk/DY2k/ZMwBqUczJ60Q7trf+dfumnD8L
 KokLUiMEkW8bsckL3ztM/vIK/BdYAakmZls3AnmtEBlSK3LMh1aZdENUX3l3ygmN
X-Gm-Gg: AeBDiesmsqSz4wuWfgSaDaTZnr3M+gpJvdJBf+on6XxpiHwLWfeWnbGfCY/oKXBcUts
 UWgABqSZ9i7RUTiX3lfpULJm8KCmTO4gte8vt128L3MmQH19AMwaXp6tkDv7AJIWMd+VSJqBLXd
 Ox+ebmVvcMdFugxDlReutaqQvBf/FvYo0gqrurltkS8HvoYLAPvM9HqBVBGZrihDpwGt5+0bLl7
 uOGtp3FJu4AKrBGa4lkXQvpOBm8csxXJsl6Z/hreyigzKmuE0yf9DG2ZvRUWxjQiireE2GnHetu
 YKQQRL4PUbwMQYTV3gZKgxUmGYY2W1YKCSlsFBdtp/otMQu6ejI6JIfl6fUyJCgzvBDAhhVMvGp
 stosmAGsKrDEwOhf0BWTQXfrcqK2c5l1HR6x/jY146fsShba3z5V0LLug72Ekkf389qZ5sJBWKm
 3Gg/wGAwVHxTOjKosdV++0kb6xLOsJzVLjvscb9ujDoZ4rWN0e/4iYrTTtjaFegqg5cEfCgvNZu
 t9qRgOs1EyrBJ+A9NtpqEl2a4wZ4XXVSVUGvYqE8w==
X-Received: by 2002:ac8:5fd1:0:b0:50d:a4e6:997f with SMTP id
 d75a77b69052e-50e3693d58bmr75328021cf.15.1776464566409; 
 Fri, 17 Apr 2026 15:22:46 -0700 (PDT)
Received: from localhost.localdomain
 (lnsm5-montreal02-142-119-62-135.internet.virginmobile.ca. [142.119.62.135])
 by smtp.gmail.com with ESMTPSA id
 d75a77b69052e-50e3944a7a3sm21658981cf.22.2026.04.17.15.22.45
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 17 Apr 2026 15:22:45 -0700 (PDT)
From: Rayane Boussanni <rboussanni@gmail.com>
To: dev@dpdk.org
Cc: rasland@nvidia.com,
	Rayane Boussanni <rboussanni@gmail.com>
Subject: [PATCH v2] net/mlx5: add validation for indirect actions
Date: Fri, 17 Apr 2026 18:21:04 -0400
Message-Id: <20260417222104.66543-1-rboussanni@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260417150153.63149-1-rboussanni@gmail.com>
References: <20260417150153.63149-1-rboussanni@gmail.com>
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
index bca5b2769e..ec1cdbe1fa 100644
--- a/drivers/net/mlx5/mlx5_flow_hw.c
+++ b/drivers/net/mlx5/mlx5_flow_hw.c
@@ -346,6 +346,21 @@ mlx5_flow_ct_init(struct rte_eth_dev *dev,
 		  uint32_t nb_conn_tracks,
 		  uint16_t nb_queue);
 
+static int
+mlx5_hw_validate_action_rss(struct rte_eth_dev *dev,
+			    const struct rte_flow_action *action,
+			    const struct rte_flow_action *mask,
+			    const struct rte_flow_actions_template_attr *attr,
+			    uint64_t action_flags,
+			    struct rte_flow_error *error);
+static int
+mlx5_hw_validate_action_conntrack(struct rte_eth_dev *dev,
+				  const struct rte_flow_action *action,
+				  const struct rte_flow_action *mask,
+				  const struct rte_flow_actions_template_attr *attr,
+				  uint64_t action_flags,
+				  struct rte_flow_error *error);
+
 static __rte_always_inline uint32_t flow_hw_tx_tag_regc_mask(struct rte_eth_dev *dev);
 static __rte_always_inline uint32_t flow_hw_tx_tag_regc_value(struct rte_eth_dev *dev);
 
@@ -6604,6 +6619,8 @@ flow_hw_validate_action_meter_mark(struct rte_eth_dev *dev,
  *   Pointer to the indirect action.
  * @param[in] mask
  *   Pointer to the indirect action mask.
+ * @param[in] attr
+ *   Pointer to the action template attributes.
  * @param[in, out] action_flags
  *   Holds the actions detected until now.
  * @param[in, out] fixed_cnt
@@ -6618,6 +6635,7 @@ static int
 flow_hw_validate_action_indirect(struct rte_eth_dev *dev,
 				 const struct rte_flow_action *action,
 				 const struct rte_flow_action *mask,
+				 const struct rte_flow_actions_template_attr *attr,
 				 uint64_t *action_flags, bool *fixed_cnt,
 				 struct rte_flow_error *error)
 {
@@ -6637,11 +6655,17 @@ flow_hw_validate_action_indirect(struct rte_eth_dev *dev,
 		*action_flags |= MLX5_FLOW_ACTION_METER;
 		break;
 	case RTE_FLOW_ACTION_TYPE_RSS:
-		/* TODO: Validation logic (same as flow_hw_actions_validate) */
+		ret = mlx5_hw_validate_action_rss(dev, action, mask, attr,
+						  *action_flags, error);
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
@@ -7352,6 +7376,7 @@ mlx5_flow_hw_actions_validate(struct rte_eth_dev *dev,
 		case RTE_FLOW_ACTION_TYPE_INDIRECT:
 			ret = flow_hw_validate_action_indirect(dev, action,
 							       mask,
+							       attr,
 							       &action_flags,
 							       &fixed_cnt,
 							       error);
-- 
2.34.1

