Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 56C2CCCFA02
	for <dpdk-dev@archiver.kernel.org>; Sun,  2 Nov 2025 15:57:22 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 38E8D40650;
	Sun,  2 Nov 2025 16:57:19 +0100 (CET)
Received: from fhigh-a3-smtp.messagingengine.com
 (fhigh-a3-smtp.messagingengine.com [103.168.172.154])
 by mails.dpdk.org (Postfix) with ESMTP id D757940395;
 Sun,  2 Nov 2025 16:57:17 +0100 (CET)
Received: from phl-compute-01.internal (phl-compute-01.internal [10.202.2.41])
 by mailfhigh.phl.internal (Postfix) with ESMTP id 8B3F21400291;
 Sun,  2 Nov 2025 10:57:17 -0500 (EST)
Received: from phl-mailfrontend-01 ([10.202.2.162])
 by phl-compute-01.internal (MEProxy); Sun, 02 Nov 2025 10:57:17 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=monjalon.net; h=
 cc:cc:content-transfer-encoding:content-type:date:date:from:from
 :in-reply-to:in-reply-to:message-id:mime-version:references
 :reply-to:subject:subject:to:to; s=fm3; t=1762099037; x=
 1762185437; bh=MYSfk4SLs8eBkT1NSBHyjw7yHPuVC+0TdXjgKLvArws=; b=p
 fpiKhYa8x9f0GMZE1clBGeah+VKApyBKRtlrAA2h5WgcV2OpiRH7lTexVWwfGQmQ
 NXqbn/7rWRd2NaWgdOOh+8CwttE5MV+Wyd4cus6WjniNKKniem1ccLqvoji3XF13
 jeeYB9jTezeg1FT+rEZjCLsBEBVJR6aEHkPWbuijupbOJJxuqIZQO+uf+UjAvRTa
 YEg2npC3c96AXQ4RzEh8kamkikgByMZ7oL3SM+lxJYHV0bBJ7DUv4C1qKokRRWyV
 eDqQyHJ7I7zRmbxoB+7hBK/hKGGY5E+G6wHx6XQeV6i5LPI9r5kRtNalddNRT+O1
 UY0i6ZAHx8gtQob7c6Mmg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-transfer-encoding
 :content-type:date:date:feedback-id:feedback-id:from:from
 :in-reply-to:in-reply-to:message-id:mime-version:references
 :reply-to:subject:subject:to:to:x-me-proxy:x-me-sender
 :x-me-sender:x-sasl-enc; s=fm3; t=1762099037; x=1762185437; bh=M
 YSfk4SLs8eBkT1NSBHyjw7yHPuVC+0TdXjgKLvArws=; b=p6xQGwv2JtTBjbunU
 VMZPC/DpvlsjCvkuPpA+8VsSXV60+WXQbwayW1Lx/dpeRZAk55Io+aHVYEdTdonJ
 Hh9OgAskdeIfRAxaqd0NC3GqekVpdoWXmFSlttklkNZ+AUy0itDt17Z5vL68SwKS
 tB4ogxGPpUxneriP6IDvVQgZ6p0p+HDvksyxGUMh2nc1jubzVozCwOY93uvM9ybH
 jnAZTnowqDhOQgtfkMBJ5PQhOL3mdr9zokgOy8j3fphwA0Rr5wBkvFtY3iySEe0H
 fu9jwMT9nAhPW3HJgwE9mhry3tsrN7WWIGrA/G7jtdplIcAXFUN36mt399KbcA6Z
 +gEbw==
X-ME-Sender: <xms:XH8HabjjckIhj5RyN_vlu-7T6TliPdlVjA4czNK3NkJyiJe9nT78sA>
 <xme:XH8Hadmk1bSGoDE-RY6-bXYNX_32UtSprkiH6goMs6uwqO_oZx-DQOtzFlc187EEQ
 rH1lqq2XSgLn5IDYGOga4TNpLC6hKKtC5pfI9aKyqWPciopkxNruw>
X-ME-Received: <xmr:XH8HaUqubysF3Wi-sndzOukNa8agwdX7TEzouCMCESYGy0zDhkzlUIQHohSTZcMGcWobXpDFEmAaD1EBIgZ5Ecfy8A>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggddujeehieejucetufdoteggodetrf
 dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
 rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
 gurhephffvvefufffkofgjfhgggfestdekredtredttdenucfhrhhomhepvfhhohhmrghs
 ucfoohhnjhgrlhhonhcuoehthhhomhgrshesmhhonhhjrghlohhnrdhnvghtqeenucggtf
 frrghtthgvrhhnpedvjefhudeghedvtdeijeeigeetuedugfejueekieeltdfhteevkeeh
 hfeilefhtdenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhroh
 hmpehthhhomhgrshesmhhonhhjrghlohhnrdhnvghtpdhnsggprhgtphhtthhopedujedp
 mhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepuggvvhesughpughkrdhorhhgpdhrtg
 hpthhtohepshhtrggslhgvseguphgukhdrohhrghdprhgtphhtthhopegushhoshhnohif
 shhkihesnhhvihguihgrrdgtohhmpdhrtghpthhtohepvhhirggthhgvshhlrghvohesnh
 hvihguihgrrdgtohhmpdhrtghpthhtohepsghinhhgiiesnhhvihguihgrrdgtohhmpdhr
 tghpthhtohepohhrihhkrgesnhhvihguihgrrdgtohhmpdhrtghpthhtohepshhurghnmh
 hinhhgmhesnhhvihguihgrrdgtohhmpdhrtghpthhtohepmhgrthgrnhesnhhvihguihgr
 rdgtohhmpdhrtghpthhtohepohhlihhvihgvrhdrmhgrthiiseeifihinhgurdgtohhm
X-ME-Proxy: <xmx:XH8HaZLv4YxuGaWZXauBJGAZwqx6nKdhkaI1h6bsvhA6rWBusXxYxw>
 <xmx:XH8HaQBJBOYZP1qNSYMCOy06n1XkFMG-SDmgZM3qIsZbxjZtOPrv7A>
 <xmx:XH8Hab5gz-aZqIZj4HfBKq737D9C3ITHN2HiN4jxjtv3_IjmJDifaA>
 <xmx:XH8HacEiXlp8wfDWocMmJto9N6PnQ_RzhbfxMgkzReIoaQsoLAy06w>
 <xmx:XX8HaX6l5tVYd5mKEeVAnM7JFFh6xwXWY89yfv-dW760MYE8ADH59Krg>
Feedback-ID: i47234305:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sun,
 2 Nov 2025 10:57:14 -0500 (EST)
From: Thomas Monjalon <thomas@monjalon.net>
To: dev@dpdk.org
Cc: stable@dpdk.org, Dariusz Sosnowski <dsosnowski@nvidia.com>,
 Viacheslav Ovsiienko <viacheslavo@nvidia.com>,
 Bing Zhao <bingz@nvidia.com>, Ori Kam <orika@nvidia.com>,
 Suanming Mou <suanmingm@nvidia.com>, Matan Azrad <matan@nvidia.com>,
 Olivier Matz <olivier.matz@6wind.com>,
 Andrew Rybchenko <andrew.rybchenko@oktetlabs.ru>,
 Nelio Laranjeiro <nelio.laranjeiro@6wind.com>,
 Adrien Mazarguil <adrien.mazarguil@6wind.com>,
 Xueming Li <xuemingl@nvidia.com>, Gregory Etelson <getelson@nvidia.com>,
 Xiaoyu Min <jackmin@nvidia.com>, Mark Bloch <mbloch@nvidia.com>,
 Alex Vesker <valex@nvidia.com>
Subject: [PATCH 5/5] net/mlx5: remove useless constants
Date: Sun,  2 Nov 2025 16:53:04 +0100
Message-ID: <20251102155617.4001783-6-thomas@monjalon.net>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251102155617.4001783-1-thomas@monjalon.net>
References: <20251102155617.4001783-1-thomas@monjalon.net>
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

- MLX5_VEC_TX_CKSUM_OFFLOAD_CAP became unused when Tx metadata moved
  to a dynamic field.
- MLX5_ALARM_TIMEOUT_US became unused when reworking link status wait.
- MLX5_FLOW_SFT_HLIST_ARRAY_SIZE was never used in hash list handling.
- MLX5_FLOW_MIN_ID_POOL_SIZE and MLX5_ID_GENERATION_ARRAY_FACTOR became
  unused when the flow ID generator was replaced by ipool.
- IS_BATCH_CNT became unused when removing a flow counter container.
- MLX5_RSSQ_DEFAULT_NUM was used in the old per-thread flow workspace.
- MLX5_FLOW_TABLE_HWS_POLICY became unused because meter is not supported
  in HWS.
- IPPROTO_MPLS became unused because MPLS over IP is not supported.
- MLX5_L4_RSS_TYPES has never been used.
- MLX5_ETHER_TYPE_FROM_HEADER was used in the first integrity item check.
- ETH_TYPE_IPV4/V6_VXLAN were never used in HWS.
- PCI_DRV_FLAGS became unused when migrating to bus-agnostic probing.
- ERRNO_SAFE was used in the old logging macros.

Fixes: 9bf26e1318e3 ("ethdev: move egress metadata to dynamic field")
Fixes: cfee94752b8f ("net/mlx5: fix link status to use wait to complete")
Fixes: f3020a331dca ("net/mlx5: optimize hash list table allocate on demand")
Fixes: 4ae8825c5085 ("net/mlx5: use indexed pool as id generator")
Fixes: 994829e695c0 ("net/mlx5: remove single counter container")
Fixes: dc7c5e0aa905 ("net/mlx5: fix flow workspace destruction")
Fixes: 645f240d1cd5 ("net/mlx5: remove unsupported flow meter action in HWS")
Fixes: 14ad99d78a46 ("net/mlx5: remove unsupported flow item MPLS over IP")
Fixes: ae67e3c43dd5 ("net/mlx5: support RSS expansion in non-template HWS setup")
Fixes: 23b0a8b298b1 ("net/mlx5: fix integrity item validation and translation")
Fixes: c55c2bf35333 ("net/mlx5/hws: add definer layer")
Fixes: a7f34989e9ad ("net/mlx5: migrate to bus-agnostic common interface")
Fixes: a170a30d22a8 ("net/mlx5: use dynamic logging")
Cc: stable@dpdk.org

Signed-off-by: Thomas Monjalon <thomas@monjalon.net>
---
 drivers/net/mlx5/hws/mlx5dr_definer.c |  2 --
 drivers/net/mlx5/mlx5.c               |  3 ---
 drivers/net/mlx5/mlx5.h               |  3 ---
 drivers/net/mlx5/mlx5_defs.h          |  6 ------
 drivers/net/mlx5/mlx5_flow.h          | 17 -----------------
 drivers/net/mlx5/mlx5_rxtx_vec.h      |  7 -------
 drivers/net/mlx5/mlx5_utils.h         |  3 ---
 drivers/net/mlx5/windows/mlx5_os.h    |  2 --
 8 files changed, 43 deletions(-)

diff --git a/drivers/net/mlx5/hws/mlx5dr_definer.c b/drivers/net/mlx5/hws/mlx5dr_definer.c
index 1c6b3e38c4..afa70bf793 100644
--- a/drivers/net/mlx5/hws/mlx5dr_definer.c
+++ b/drivers/net/mlx5/hws/mlx5dr_definer.c
@@ -9,8 +9,6 @@
 #define GTP_PDU_SC	0x85
 #define BAD_PORT	0xBAD
 #define BAD_SQN		0xBAD
-#define ETH_TYPE_IPV4_VXLAN	0x0800
-#define ETH_TYPE_IPV6_VXLAN	0x86DD
 #define UDP_VXLAN_PORT	4789
 #define UDP_VXLAN_GPE_PORT	4790
 #define UDP_GTPU_PORT	2152
diff --git a/drivers/net/mlx5/mlx5.c b/drivers/net/mlx5/mlx5.c
index b018a4f0e2..4705c30801 100644
--- a/drivers/net/mlx5/mlx5.c
+++ b/drivers/net/mlx5/mlx5.c
@@ -394,9 +394,6 @@ static const struct mlx5_indexed_pool_config mlx5_ipool_cfg[] = {
 	},
 };
 
-#define MLX5_FLOW_MIN_ID_POOL_SIZE 512
-#define MLX5_ID_GENERATION_ARRAY_FACTOR 16
-
 #define MLX5_FLOW_TABLE_HLIST_ARRAY_SIZE 1024
 
 #define MLX5_RXQ_ENH_CQE_COMP_MASK 0x80
diff --git a/drivers/net/mlx5/mlx5.h b/drivers/net/mlx5/mlx5.h
index 07418b0922..4d9cf6b70b 100644
--- a/drivers/net/mlx5/mlx5.h
+++ b/drivers/net/mlx5/mlx5.h
@@ -509,8 +509,6 @@ struct __rte_cache_aligned mlx5_hw_q {
 #define MLX5_MAX_PENDING_QUERIES 4
 #define MLX5_CNT_MR_ALLOC_BULK 64
 #define MLX5_CNT_SHARED_OFFSET 0x80000000
-#define IS_BATCH_CNT(cnt) (((cnt) & (MLX5_CNT_SHARED_OFFSET - 1)) >= \
-			   MLX5_CNT_BATCH_OFFSET)
 #define MLX5_CNT_SIZE (sizeof(struct mlx5_flow_counter))
 #define MLX5_AGE_SIZE (sizeof(struct mlx5_age_param))
 
@@ -1259,7 +1257,6 @@ struct mlx5_flow_tbl_resource {
 #define MLX5_FLOW_TABLE_LEVEL_METER (MLX5_MAX_TABLES - 3)
 #define MLX5_FLOW_TABLE_LEVEL_POLICY (MLX5_MAX_TABLES - 4)
 #define MLX5_MAX_TABLES_EXTERNAL MLX5_FLOW_TABLE_LEVEL_POLICY
-#define MLX5_FLOW_TABLE_HWS_POLICY (MLX5_MAX_TABLES - 10)
 #define MLX5_MAX_TABLES_FDB UINT16_MAX
 #define MLX5_FLOW_TABLE_PTYPE_RSS_NUM 1024
 #define MLX5_FLOW_TABLE_PTYPE_RSS_LAST (MLX5_MAX_TABLES - 11)
diff --git a/drivers/net/mlx5/mlx5_defs.h b/drivers/net/mlx5/mlx5_defs.h
index d326fec000..b8e5122323 100644
--- a/drivers/net/mlx5/mlx5_defs.h
+++ b/drivers/net/mlx5/mlx5_defs.h
@@ -46,9 +46,6 @@
 /* Maximum number of DCS created per port. */
 #define MLX5_HWS_CNT_DCS_NUM 4
 
-/* Alarm timeout. */
-#define MLX5_ALARM_TIMEOUT_US 100000
-
 /* Maximum number of extended statistics counters. */
 #define MLX5_MAX_XSTATS 64
 
@@ -170,9 +167,6 @@
 /* Size of the hash table for tag table. */
 #define MLX5_TAGS_HLIST_ARRAY_SIZE	(1 << 15)
 
-/* Size fo the hash table for SFT table. */
-#define MLX5_FLOW_SFT_HLIST_ARRAY_SIZE	4096
-
 /* Hairpin TX/RX queue configuration parameters. */
 #define MLX5_HAIRPIN_QUEUE_STRIDE 6
 #define MLX5_HAIRPIN_JUMBO_LOG_SIZE (14 + 2)
diff --git a/drivers/net/mlx5/mlx5_flow.h b/drivers/net/mlx5/mlx5_flow.h
index ff61706054..c525516672 100644
--- a/drivers/net/mlx5/mlx5_flow.h
+++ b/drivers/net/mlx5/mlx5_flow.h
@@ -222,9 +222,6 @@ struct mlx5_mirror {
 	struct mlx5_mirror_clone clone[MLX5_MIRROR_MAX_CLONES_NUM];
 };
 
-/* Default queue number. */
-#define MLX5_RSSQ_DEFAULT_NUM 16
-
 #define MLX5_FLOW_LAYER_OUTER_L2 (1u << 0)
 #define MLX5_FLOW_LAYER_OUTER_L3_IPV4 (1u << 1)
 #define MLX5_FLOW_LAYER_OUTER_L3_IPV6 (1u << 2)
@@ -469,10 +466,6 @@ struct mlx5_mirror {
 
 #define MLX5_FLOW_XCAP_ACTIONS (MLX5_FLOW_ACTION_ENCAP | MLX5_FLOW_ACTION_DECAP)
 
-#ifndef IPPROTO_MPLS
-#define IPPROTO_MPLS 137
-#endif
-
 #define MLX5_IPV6_HDR_ECN_MASK 0x3
 #define MLX5_IPV6_HDR_DSCP_SHIFT 2
 
@@ -519,9 +512,6 @@ struct mlx5_mirror {
 	 RTE_ETH_RSS_NONFRAG_IPV4_TCP | RTE_ETH_RSS_NONFRAG_IPV4_UDP | \
 	 RTE_ETH_RSS_NONFRAG_IPV4_OTHER)
 
-/* Valid L4 RSS types */
-#define MLX5_L4_RSS_TYPES (RTE_ETH_RSS_L4_SRC_ONLY | RTE_ETH_RSS_L4_DST_ONLY)
-
 /* IBV hash source bits  for IPV4. */
 #define MLX5_IPV4_IBV_RX_HASH (IBV_RX_HASH_SRC_IPV4 | IBV_RX_HASH_DST_IPV4)
 
@@ -1898,13 +1888,6 @@ flow_hw_get_reg_id_from_ctx(void *dr_ctx, enum rte_flow_item_type type,
 		(((func) == RTE_ETH_HASH_FUNCTION_SYMMETRIC_TOEPLITZ) || \
 		 ((func) == RTE_ETH_HASH_FUNCTION_SYMMETRIC_TOEPLITZ_SORT))
 
-/* extract next protocol type from Ethernet & VLAN headers */
-#define MLX5_ETHER_TYPE_FROM_HEADER(_s, _m, _itm, _prt) do { \
-	(_prt) = ((const struct _s *)(_itm)->mask)->_m;       \
-	(_prt) &= ((const struct _s *)(_itm)->spec)->_m;      \
-	(_prt) = rte_be_to_cpu_16((_prt));                    \
-} while (0)
-
 /* array of valid combinations of RX Hash fields for RSS */
 static const uint64_t mlx5_rss_hash_fields[] = {
 	MLX5_RSS_HASH_IPV4,
diff --git a/drivers/net/mlx5/mlx5_rxtx_vec.h b/drivers/net/mlx5/mlx5_rxtx_vec.h
index 77c3f4efa0..672e301f77 100644
--- a/drivers/net/mlx5/mlx5_rxtx_vec.h
+++ b/drivers/net/mlx5/mlx5_rxtx_vec.h
@@ -13,13 +13,6 @@
 
 #include "mlx5_autoconf.h"
 
-/* HW checksum offload capabilities of vectorized Tx. */
-#define MLX5_VEC_TX_CKSUM_OFFLOAD_CAP \
-	(RTE_ETH_TX_OFFLOAD_IPV4_CKSUM | \
-	 RTE_ETH_TX_OFFLOAD_UDP_CKSUM | \
-	 RTE_ETH_TX_OFFLOAD_TCP_CKSUM | \
-	 RTE_ETH_TX_OFFLOAD_OUTER_IPV4_CKSUM)
-
 /*
  * Compile time sanity check for vectorized functions.
  */
diff --git a/drivers/net/mlx5/mlx5_utils.h b/drivers/net/mlx5/mlx5_utils.h
index c65839c5d9..95866351c2 100644
--- a/drivers/net/mlx5/mlx5_utils.h
+++ b/drivers/net/mlx5/mlx5_utils.h
@@ -22,9 +22,6 @@
 
 #include "mlx5_defs.h"
 
-/* Save and restore errno around argument evaluation. */
-#define ERRNO_SAFE(x) ((errno = (int []){ errno, ((x), 0) }[0]))
-
 extern int mlx5_logtype;
 
 #define MLX5_NET_LOG_PREFIX "mlx5_net"
diff --git a/drivers/net/mlx5/windows/mlx5_os.h b/drivers/net/mlx5/windows/mlx5_os.h
index fb7198c244..57d147bd8c 100644
--- a/drivers/net/mlx5/windows/mlx5_os.h
+++ b/drivers/net/mlx5/windows/mlx5_os.h
@@ -7,8 +7,6 @@
 
 #include "mlx5_win_ext.h"
 
-#define PCI_DRV_FLAGS 0
-
 #define MLX5_NAMESIZE MLX5_FS_NAME_MAX
 
 enum mlx5_sw_parsing_offloads {
-- 
2.51.0

