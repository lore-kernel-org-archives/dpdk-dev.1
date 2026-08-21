Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 835D3C5DF8C
	for <dpdk-dev@archiver.kernel.org>; Fri, 21 Aug 2026 19:31:27 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 04A7140E37;
	Fri, 21 Aug 2026 21:30:25 +0200 (CEST)
Received: from mail-pg1-f180.google.com (mail-pg1-f180.google.com
 [209.85.215.180])
 by mails.dpdk.org (Postfix) with ESMTP id 45CF940BA4
 for <dev@dpdk.org>; Fri, 21 Aug 2026 21:30:24 +0200 (CEST)
Received: by mail-pg1-f180.google.com with SMTP id
 41be03b00d2f7-c9eefcf9175so1429467a12.3
 for <dev@dpdk.org>; Fri, 21 Aug 2026 12:30:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20251104.gappssmtp.com; s=20251104; t=1787340623;
 x=1787945423; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=VwPJQl1NduWwYh6XG2/EQnfGkiwzIXKNGkrpJh5wdD0=;
 b=ixWY3OjibN1Bx4SiejFs8GoCLDNi4+4sVSI/wWXYvJ/AgTDhikjXHZEu/GWRsh2zGo
 Z14Sf0EJkPssbeucexVjTWkGTKvuK2b9dpeiPDz3o69DY2yE1R5qi5kZbcq611/K2b/S
 obxSgYFmo/8Ms3JB71tCjnxGO9+cRC/QHz4D9SNT2YWr7Difojexbl6N7BoGEF0c3/Ok
 trGmGyDqJ2qlpJK9C938UuKxvLh6itZ2mt+TWxrVIOwcMvLwdeO/ln54UD7FNpZyISWb
 iN7OP+jJDCmRke7i3oZOXiwQXBlyWHifLgVXL1mJ4odGa2eM5k1r34mL6DaKhFIvGbBB
 xIbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787340623; x=1787945423;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=VwPJQl1NduWwYh6XG2/EQnfGkiwzIXKNGkrpJh5wdD0=;
 b=hbuLfYJ9RLM5BEpgeVQecdd6pa8sF5wIWSjnbGusQcfPN4Ag5EuG670qiCzUT2pxnQ
 s9Aty5/HEeUHeDfFUyxhQbLplJEvh3RgkCP5X346yEpzTF1teE1xQxP2NdissOvqdiFK
 EjM6UGGTLDMGRdk8gG6weucrphHefeEA/ve9NKxdQveGeldN3OEN5hZ6Gl0CT4ZoLaBJ
 TwtP3nlD01gYNcpoSTLwQZ2GrHw/8m+hvcrKhOB0Z44HdluP6GjgfMILNKXo0DEx1kZt
 3IdUXEuj3P7q2T3RoHLKYJ9Rk9WgHtO0hYk0Z5b1/n3p3WNKRUQHGfdcav7Jr5Pjcpi1
 QmUg==
X-Gm-Message-State: AFuF++m09tD3k9vreR7yd9GdEIP91jAG2pYqcm+FfZYj9S9beUKbVKug
 72V5y6XLoHNWMPwOmSsDyhGDbx/feW2qwgYkpEayWI0EPXJU0Rxd3CUEgi1cLhSRONtxJtNR6Hy
 HyBQFP+g=
X-Gm-Gg: AR+sD10jpzPN3Rxxc1Du/JQMPwNVKxsm9u6pqHJr/Jc86LVKu+A84kCp92W5LgPYRjD
 ANsboqXClZrKxJsT1xv7TDe2OkWv9o7WhnqwvJ/iiIpolZh25hZXQrS++79mHjc+9bnDH/tGKZH
 fqCwGOZehLt+jHfRtzikSUmU8dzks/UVyrMlwNBXT1AVaAPMTWOrjB9s56hiBjTI5R8WviwpC2M
 BjQnnZv9y3dqKTej0edFsRVC5usVYhyhZQ/9MrlNSxAteZCURhYDigVxA7ZthAjluzeg0Q7rOl+
 XuJjSaGfkolu/RgmoIwa45dRoSt5ZqK/QAD7SHY4Glh0oPXcnmHCorT9pVrLiSXvkI80Z2ZXYhB
 spehudNJV5wypLi1gG/4gS9f2MycblJvidX8BOi3ucBDQxg5jLWvnPtu3aamTDzgmp6my07vp+h
 XSuVxLAwwdoBbLJ9vrWOxx4WbH5k4AnBELxaSjN9twESGzHPorV7ViW1494gluuxjTkvVOem4Mp
 QVIGvxHKu1KAOQdpoldr6z5+tM=
X-Received: by 2002:a05:6a21:4516:b0:3b2:a809:ffe with SMTP id
 adf61e73a8af0-3cd300901e1mr18199627637.14.1787340623447; 
 Fri, 21 Aug 2026 12:30:23 -0700 (PDT)
Received: from phoenix.lan (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-cc16c6dd2f4sm1860304a12.17.2026.08.21.12.30.20
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 21 Aug 2026 12:30:23 -0700 (PDT)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>,
 Chaoyong He <chaoyong.he@corigine.com>
Subject: [PATCH v2 41/68] net/nfp: replace use of rte_memcpy
Date: Fri, 21 Aug 2026 12:24:36 -0700
Message-ID: <20260821192646.146382-42-stephen@networkplumber.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260821192646.146382-1-stephen@networkplumber.org>
References: <20260820052251.1453273-1-stephen@networkplumber.org>
 <20260821192646.146382-1-stephen@networkplumber.org>
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
index 0852d28fa7..dfc2bd25bf 100644
--- a/drivers/net/nfp/flower/nfp_conntrack.c
+++ b/drivers/net/nfp/flower/nfp_conntrack.c
@@ -1476,7 +1476,7 @@ nfp_ct_do_flow_merge(struct nfp_ct_zone_entry *ze,
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

