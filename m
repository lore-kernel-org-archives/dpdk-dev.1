Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 50B8CC5DF81
	for <dpdk-dev@archiver.kernel.org>; Thu, 20 Aug 2026 05:26:21 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 9DF3740E1D;
	Thu, 20 Aug 2026 07:25:09 +0200 (CEST)
Received: from mail-pg1-f180.google.com (mail-pg1-f180.google.com
 [209.85.215.180])
 by mails.dpdk.org (Postfix) with ESMTP id 3A4184069F
 for <dev@dpdk.org>; Thu, 20 Aug 2026 07:25:08 +0200 (CEST)
Received: by mail-pg1-f180.google.com with SMTP id
 41be03b00d2f7-cbedf318752so1084770a12.0
 for <dev@dpdk.org>; Wed, 19 Aug 2026 22:25:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20251104.gappssmtp.com; s=20251104; t=1787203507;
 x=1787808307; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=dDOzyUgF1IXfuyF4pTEVrZXTwncRw2YPwAZXuseFvXg=;
 b=o0Vkc2gwRfM/0+DFFBRExs5N6aRm5741F1mjf3IWkQKfCJApewnHb9L83YHU93exFH
 BnYruLMBx441c3q6De/zZK4go9YHz7yDdkY7msT/gBAify0H6N+pbLGsSEZ9ma2sCXpu
 bzoIRW9bN1FH3GK+doxHeJJAF7R25pwOWXE3CmESXx0a9UV9vSsy//JNCABQjgBu4skT
 TQ17yX42u9H0VQFANhOvY1WbbOp4+Wnd8YDsXglSAMID3yOpEnQYcxCFMP9Cj9c9qPMG
 yHf9aYLevnzO9ee3u5hu3AWEgTAe+kLHtnMNGBXijNVLaBhwNOOnX7ki9HnnJPbigi2X
 kfCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787203507; x=1787808307;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=dDOzyUgF1IXfuyF4pTEVrZXTwncRw2YPwAZXuseFvXg=;
 b=ad7iuw7htcoyabT4dO47EWp3167r1qpn8Ab/8V3ySK24DuyeDGCbT1pWBAvqIpzZyp
 4XIgDEBqw9UsPWPCseQyb63cije3HNYxU/mojG0shsuKrlPOf7mT4ZX13mC4hi9hfOU0
 LnChF2apJm7pZKfPzp02L5r0wuffQpjPUrhE4/FbONWWvFJGET561xwQf3BFv2D5RY5h
 H0eS41V9oawFrWF9JHD2+3Sfo7KuhbU9Oio2CcH5d1IWJ9pSH+Pju9qbRaduC0jKk8aa
 cyQ/oOdxiiJBBRL+Yg08a9wqtBBP0t5YZPF6vMhqbmrvVVMzSa6e/SfOxC0t1rHjrs0q
 UOqw==
X-Gm-Message-State: AOJu0YwGKFJgiSPvOgGOSKXw6Iqn+QsH2m6irvQtgHgTBujXN6Q22q8g
 +ZDNwMcSgWkANe2fcEhxSrbc+PYjLW+PEwQcz8xqv62+MSXOE7F2CvaA0JJyl+R/V7OwAD2c0sN
 G5JOa
X-Gm-Gg: AR+sD13wqesM8umjeP0fMrQ2+7CHIxZ86ovQx5Iwe2Ekag+8/hDwMbQ4RwLA1cVqk1T
 mFO7AmUN+iOh2+FTPOaVEPLttfI+sRiN7rBiHTYmXbovILLUt4pzcODZiapqYF8Lr5OhQ8hKfnY
 v6eb8gamXRfd8jz1X//bLqoUqpkC+qVab6IE2ENtQrD/W/FHx9FFqjvMiw9tXi/y9DIPNCGUw/+
 1im/caWOgyH+hdRCBCOPbCIbJRnmL+1V3eB1i2ZS9mnhjNBVxh0ZbWeIvz0PLHc8Su9K1nZaWrO
 dRZF9Nff2Y7xjwe36kNSzMxhKk5x2xPfiO7DYhN39pm6cBdnVQGayqkG/LWxQThUBrRpOGdRqU5
 ATOvavVYA20eRlUmcQvODpVlQ/VwaZr2txGDBT3GogSs6kmpJUA9DebpGMj2SmMuhh3tyIyR5PF
 RmmtlmpmfKWussJNDvsx2y3R+YQaDm/N3jSTL4Vp+LRLET9HNOxfSpykKqyKixyKod0jHesdgnR
 K82ss5Nrdx/RpahiDiKEKAeMMs=
X-Received: by 2002:a05:6300:2284:b0:3b4:5ff3:45cb with SMTP id
 adf61e73a8af0-3cd00e24fb6mr20908924637.8.1787203507273; 
 Wed, 19 Aug 2026 22:25:07 -0700 (PDT)
Received: from phoenix.lan (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-327bef3bb5csm13700974eec.2.2026.08.19.22.25.04
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 19 Aug 2026 22:25:06 -0700 (PDT)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>,
 Chaoyong He <chaoyong.he@corigine.com>
Subject: [PATCH 34/61] net/nfp: replace use of rte_memcpy
Date: Wed, 19 Aug 2026 22:12:24 -0700
Message-ID: <20260820052251.1453273-35-stephen@networkplumber.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260820052251.1453273-1-stephen@networkplumber.org>
References: <20260820052251.1453273-1-stephen@networkplumber.org>
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

Don't need rte_memcpy for fixed size value.

Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
---
 drivers/net/nfp/flower/nfp_conntrack.c   |  2 +-
 drivers/net/nfp/flower/nfp_flower_flow.c | 16 ++++++++--------
 drivers/net/nfp/nfp_mtr.c                | 10 +++++-----
 3 files changed, 14 insertions(+), 14 deletions(-)

diff --git a/drivers/net/nfp/flower/nfp_conntrack.c b/drivers/net/nfp/flower/nfp_conntrack.c
index 439a1a1b0e..ebb80ae5a7 100644
--- a/drivers/net/nfp/flower/nfp_conntrack.c
+++ b/drivers/net/nfp/flower/nfp_conntrack.c
@@ -1475,7 +1475,7 @@ nfp_ct_do_flow_merge(struct nfp_ct_zone_entry *ze,
 	merge_entry->ze = ze;
 	merge_entry->pre_ct_parent = pre_ct_entry;
 	merge_entry->post_ct_parent = post_ct_entry;
-	rte_memcpy(merge_entry->cookie, new_cookie, sizeof(new_cookie));
+	memcpy(merge_entry->cookie, new_cookie, sizeof(new_cookie));
 	merge_entry->rule.items_cnt = pre_ct_entry->rule.items_cnt +
 			post_ct_entry->rule.items_cnt - cnt_same_item - 1;
 	merge_entry->rule.actions_cnt = pre_ct_entry->rule.actions_cnt +
diff --git a/drivers/net/nfp/flower/nfp_flower_flow.c b/drivers/net/nfp/flower/nfp_flower_flow.c
index ad0fe9a8ef..426fdfe71c 100644
--- a/drivers/net/nfp/flower/nfp_flower_flow.c
+++ b/drivers/net/nfp/flower/nfp_flower_flow.c
@@ -234,10 +234,10 @@ nfp_mask_id_alloc_from_driver(struct nfp_flow_priv *priv,
 		return -ENOENT;
 	}
 
-	rte_memcpy(&temp_id, &ring->buf[ring->tail], NFP_FLOWER_MASK_ELEMENT_RS);
+	memcpy(&temp_id, &ring->buf[ring->tail], NFP_FLOWER_MASK_ELEMENT_RS);
 	*mask_id = temp_id;
 
-	rte_memcpy(&ring->buf[ring->tail], &freed_id, NFP_FLOWER_MASK_ELEMENT_RS);
+	memcpy(&ring->buf[ring->tail], &freed_id, NFP_FLOWER_MASK_ELEMENT_RS);
 	ring->tail = (ring->tail + NFP_FLOWER_MASK_ELEMENT_RS) %
 			(NFP_FLOWER_MASK_ENTRY_RS * NFP_FLOWER_MASK_ELEMENT_RS);
 
@@ -256,7 +256,7 @@ nfp_mask_id_free_from_driver(struct nfp_flow_priv *priv,
 	if (CIRC_SPACE(ring->head, ring->tail, NFP_FLOWER_MASK_ENTRY_RS) == 0)
 		return -ENOBUFS;
 
-	rte_memcpy(&ring->buf[ring->head], &mask_id, NFP_FLOWER_MASK_ELEMENT_RS);
+	memcpy(&ring->buf[ring->head], &mask_id, NFP_FLOWER_MASK_ELEMENT_RS);
 	ring->head = (ring->head + NFP_FLOWER_MASK_ELEMENT_RS) %
 			(NFP_FLOWER_MASK_ENTRY_RS * NFP_FLOWER_MASK_ELEMENT_RS);
 
@@ -2929,13 +2929,13 @@ nfp_flow_action_set_mac(char *act_data,
 
 	set_mac = action->conf;
 	if (mac_src_flag) {
-		rte_memcpy(&set_eth->eth_addr[RTE_ETHER_ADDR_LEN],
-				set_mac->mac_addr, RTE_ETHER_ADDR_LEN);
+		memcpy(&set_eth->eth_addr[RTE_ETHER_ADDR_LEN],
+		       set_mac->mac_addr, RTE_ETHER_ADDR_LEN);
 		for (i = 0; i < RTE_ETHER_ADDR_LEN; i++)
 			set_eth->eth_addr_mask[RTE_ETHER_ADDR_LEN + i] = 0xff;
 	} else {
-		rte_memcpy(&set_eth->eth_addr[0],
-				set_mac->mac_addr, RTE_ETHER_ADDR_LEN);
+		memcpy(&set_eth->eth_addr[0], set_mac->mac_addr,
+		       RTE_ETHER_ADDR_LEN);
 		for (i = 0; i < RTE_ETHER_ADDR_LEN; i++)
 			set_eth->eth_addr_mask[i] = 0xff;
 	}
@@ -3011,7 +3011,7 @@ nfp_flow_action_set_ipv6(char *act_data,
 	set_ip->reserved = 0;
 
 	for (i = 0; i < 4; i++) {
-		rte_memcpy(&tmp, &set_ipv6->ipv6_addr.a[i * 4], 4);
+		memcpy(&tmp, &set_ipv6->ipv6_addr.a[i * 4], 4);
 		set_ip->ipv6[i].exact = tmp;
 		set_ip->ipv6[i].mask = RTE_BE32(0xffffffff);
 	}
diff --git a/drivers/net/nfp/nfp_mtr.c b/drivers/net/nfp/nfp_mtr.c
index 4833ebd881..8d121f1b7c 100644
--- a/drivers/net/nfp/nfp_mtr.c
+++ b/drivers/net/nfp/nfp_mtr.c
@@ -250,7 +250,7 @@ nfp_mtr_profile_mod(struct nfp_app_fw_flower *app_fw_flower,
 	struct nfp_profile_conf old_conf;
 
 	/* Get the old profile config */
-	rte_memcpy(&old_conf, &mtr_profile->conf, sizeof(old_conf));
+	memcpy(&old_conf, &mtr_profile->conf, sizeof(old_conf));
 
 	memset(&mtr_profile->conf, 0, sizeof(struct nfp_profile_conf));
 
@@ -274,7 +274,7 @@ nfp_mtr_profile_mod(struct nfp_app_fw_flower *app_fw_flower,
 	return 0;
 
 rollback:
-	rte_memcpy(&mtr_profile->conf, &old_conf, sizeof(old_conf));
+	memcpy(&mtr_profile->conf, &old_conf, sizeof(old_conf));
 
 	return ret;
 }
@@ -499,8 +499,8 @@ nfp_mtr_policy_add(struct rte_eth_dev *dev,
 	}
 
 	mtr_policy->policy_id = mtr_policy_id;
-	rte_memcpy(&mtr_policy->policy, policy,
-			sizeof(struct rte_mtr_meter_policy_params));
+	memcpy(&mtr_policy->policy, policy,
+	       sizeof(struct rte_mtr_meter_policy_params));
 
 	/* Insert policy into policy list */
 	LIST_INSERT_HEAD(&priv->policies, mtr_policy, next);
@@ -1035,7 +1035,7 @@ nfp_mtr_stats_read(struct rte_eth_dev *dev,
 	*stats_mask = mtr->stats_mask;
 
 	rte_spinlock_lock(&priv->mtr_stats_lock);
-	rte_memcpy(&curr, &mtr->mtr_stats.curr, sizeof(curr));
+	memcpy(&curr, &mtr->mtr_stats.curr, sizeof(curr));
 	rte_spinlock_unlock(&priv->mtr_stats_lock);
 
 	prev = &mtr->mtr_stats.prev;
-- 
2.53.0

