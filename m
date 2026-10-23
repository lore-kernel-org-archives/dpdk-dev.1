Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4F80C606A31A
	for <dpdk-dev@archiver.kernel.org>; Fri, 23 Oct 2026 15:59:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=vip.163.com header.i=@vip.163.com header.a=rsa-sha256 header.s=s110527 header.b=RtvdPoVi
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 84B9C40A89;
	Fri, 23 Oct 2026 17:58:58 +0200 (CEST)
Received: from mail-m16.vip.163.com (mail-m16.vip.163.com [220.197.30.220])
 by mails.dpdk.org (Postfix) with ESMTP id 7E00E4067A
 for <dev@dpdk.org>; Fri, 23 Oct 2026 17:58:21 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=vip.163.com; s=s110527; h=From:To:Subject:Date:Message-ID:
 MIME-Version; bh=1HWeBOE6dNUPPZQEpbCcXwiJAGhSZb4ky0h6YRJoa8c=;
 b=RtvdPoVilmh/t/F9As3yvjRtUkWxjfgqQoJBXApK6p/By3M/k25qMlTuniuWUC
 FE2ALReBo/LmTJ8YXbEP1icemaLIYULLmKkpHMNTSR/nRh/tm7wFWVX+97PhgtvY
 Fr3grdluoxCaFzWhBj+/yxS1jOe6lqJ3BN3bHAjVQCQ/s=
From: Jiacheng Ye <yejiacheng4@h-partners.com>
To: dev@dpdk.org
Cc: Feifei Wang <wangfeifei40@huawei.com>,
 Thomas Monjalon <thomas@monjalon.net>,
 Anatoly Burakov <anatoly.burakov@intel.com>
Subject: [PATCH v4 18/27] net/hinic3: refactor flow rule parsing
Date: Fri, 23 Oct 2026 23:57:59 +0800
Message-ID: <20261023155809.855-19-yejiacheng4@h-partners.com>
X-Mailer: git-send-email 2.53.0.windows.2
In-Reply-To: <20261023155809.855-1-yejiacheng4@h-partners.com>
References: <20261019151930.1572-1-yejiacheng4@h-partners.com>
 <20261023155809.855-1-yejiacheng4@h-partners.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: As8vCgAnQEEUhNtqKyfqAw--.15103S20
X-Coremail-Antispam: 1Uf129KBjvAXoWDZr1kGw4fWF1fuF43uryrXrb_yoWrKr15Ko
 Z7XF4rtr1Fyr4rGw409rWIy3srX3yq9w4SvFWagwsFqa1Ut34Fyrs3XF4rA3yj93y5JrnI
 yFy8Jan8tanrX3Z8n29KB7ZKAUJUUUU8529EdanIXcx71UUUUU7v73VFW2AGmfu7bjvjm3
 AaLaJ3UbIYCTnIWIevJa73UjIFyTuYvjxUzgAwUUUUU
Sender: wff_light@vip.163.com
X-CM-SenderInfo: pziiszhljk3qxylshiywtou0bp/1tbiNRy5w2rbhBwCMAAA3I
X-BeenThere: dev@dpdk.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: DPDK patches and discussions <dev.dpdk.org>
List-Archive: <http://mails.dpdk.org/archives/dev/>
List-Post: <mailto:dev@dpdk.org>
List-Help: <mailto:dev-request@dpdk.org?subject=help>
List-Subscribe: <https://mails.dpdk.org/listinfo/dev>,
 <mailto:dev-request@dpdk.org?subject=subscribe>
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

The flow rule parser was based on a fixed hardcoded pattern table that was
hard to extend. Replace it with a simpler protocol-graph classifier, and
add IP-in-IP and Geneve tunnel patterns.

While refactoring, the parser behaviour changes in a few places: IPv4 and
VXLAN TCAM keys no longer set the vlan_flag mask, so these rules now match
tagged packets too; the STN dynamic TCAM limit is raised from 1024 to
2048; RTE_ETHER_TYPE_CNM and RTE_ETHER_TYPE_ECP are now accepted; and
rules with multiple actions are now rejected.

Signed-off-by: Jiacheng Ye <yejiacheng4@h-partners.com>
---
 doc/guides/nics/features/hinic3.ini |   2 +
 drivers/net/hinic3/hinic3_fdir.c    |  36 +-
 drivers/net/hinic3/hinic3_fdir.h    |   8 +-
 drivers/net/hinic3/hinic3_flow.c    | 585 ++++++++++++++++++++--------
 drivers/net/hinic3/hinic3_flow.h    | 196 ----------
 5 files changed, 458 insertions(+), 369 deletions(-)
 delete mode 100644 drivers/net/hinic3/hinic3_flow.h

diff --git a/doc/guides/nics/features/hinic3.ini b/doc/guides/nics/features/hinic3.ini
index 8083dc63d1..e47907aa22 100644
--- a/doc/guides/nics/features/hinic3.ini
+++ b/doc/guides/nics/features/hinic3.ini
@@ -43,12 +43,14 @@ ARMv8                = Y
 [rte_flow items]
 any                  = Y
 eth                  = P
+geneve               = Y
 icmp                 = Y
 ipv4                 = Y
 ipv6                 = Y
 tcp                  = Y
 udp                  = Y
 vxlan                = Y
+vxlan_gpe            = P
 
 [rte_flow actions]
 queue                = Y
diff --git a/drivers/net/hinic3/hinic3_fdir.c b/drivers/net/hinic3/hinic3_fdir.c
index 95ce7cfe16..87216170aa 100644
--- a/drivers/net/hinic3/hinic3_fdir.c
+++ b/drivers/net/hinic3/hinic3_fdir.c
@@ -77,8 +77,6 @@ hinic3_fdir_tcam_ipv4_init(struct hinic3_fdir_filter *rule,
 	/* Fill type of ip. */
 	tcam_key->key_mask.ip_type = HINIC3_UINT1_MAX;
 	tcam_key->key_info.ip_type = HINIC3_FDIR_IP_TYPE_IPV4;
-	tcam_key->key_mask.vlan_flag = HINIC3_UINT1_MAX;
-	tcam_key->key_info.vlan_flag = 0;
 
 	/* Fill src IPv4. */
 	tcam_key->key_mask.sipv4_h =
@@ -101,8 +99,9 @@ hinic3_fdir_tcam_ipv4_init(struct hinic3_fdir_filter *rule,
 		HINIC3_32_LOWER_16_BITS(rule->key_spec.ipv4.dst_ip);
 }
 
-static void hinic3_fdir_ipv6_tcam_key_init_sip(struct hinic3_fdir_filter *rule,
-					       struct hinic3_tcam_key *tcam_key)
+static inline void
+hinic3_fdir_ipv6_tcam_key_init_sip(struct hinic3_fdir_filter *rule,
+				   struct hinic3_tcam_key *tcam_key)
 {
 	tcam_key->key_mask_ipv6.sipv6_key0 =
 		HINIC3_32_UPPER_16_BITS(rule->key_mask.ipv6.src_ip[0]);
@@ -138,8 +137,9 @@ static void hinic3_fdir_ipv6_tcam_key_init_sip(struct hinic3_fdir_filter *rule,
 		HINIC3_32_LOWER_16_BITS(rule->key_spec.ipv6.src_ip[0x3]);
 }
 
-static void hinic3_fdir_ipv6_tcam_key_init_dip(struct hinic3_fdir_filter *rule,
-					       struct hinic3_tcam_key *tcam_key)
+static inline void
+hinic3_fdir_ipv6_tcam_key_init_dip(struct hinic3_fdir_filter *rule,
+				   struct hinic3_tcam_key *tcam_key)
 {
 	tcam_key->key_mask_ipv6.dipv6_key0 =
 		HINIC3_32_UPPER_16_BITS(rule->key_mask.ipv6.dst_ip[0]);
@@ -175,8 +175,9 @@ static void hinic3_fdir_ipv6_tcam_key_init_dip(struct hinic3_fdir_filter *rule,
 		HINIC3_32_LOWER_16_BITS(rule->key_spec.ipv6.dst_ip[0x3]);
 }
 
-static void hinic3_fdir_ipv6_tcam_key_init(struct hinic3_fdir_filter *rule,
-					   struct hinic3_tcam_key *tcam_key)
+static void
+hinic3_fdir_ipv6_tcam_key_init(struct hinic3_fdir_filter *rule,
+			       struct hinic3_tcam_key *tcam_key)
 {
 	hinic3_fdir_ipv6_tcam_key_init_sip(rule, tcam_key);
 	hinic3_fdir_ipv6_tcam_key_init_dip(rule, tcam_key);
@@ -240,15 +241,11 @@ hinic3_fdir_tcam_notunnel_init(struct rte_eth_dev *dev,
 }
 
 static void
-hinic3_fdir_tcam_vxlan_ipv4_init(struct hinic3_fdir_filter *rule,
+hinic3_fdir_tcam_vxlan_geneve_ipv4_init(struct hinic3_fdir_filter *rule,
 				 struct hinic3_tcam_key *tcam_key)
 {
-	/* Fill type of ip. */
 	tcam_key->key_mask.ip_type = HINIC3_UINT1_MAX;
 	tcam_key->key_info.ip_type = HINIC3_FDIR_IP_TYPE_IPV4;
-	tcam_key->key_mask.vlan_flag = HINIC3_UINT1_MAX;
-	tcam_key->key_info.vlan_flag = 0;
-
 	/* Fill src ipv4. */
 	tcam_key->key_mask.sipv4_h =
 		HINIC3_32_UPPER_16_BITS(rule->key_mask.inner_ipv4.src_ip);
@@ -271,7 +268,7 @@ hinic3_fdir_tcam_vxlan_ipv4_init(struct hinic3_fdir_filter *rule,
 }
 
 static void
-hinic3_fdir_tcam_vxlan_ipv6_init(struct hinic3_fdir_filter *rule,
+hinic3_fdir_tcam_vxlan_geneve_ipv6_init(struct hinic3_fdir_filter *rule,
 				 struct hinic3_tcam_key *tcam_key)
 {
 	/* Fill type of ip. */
@@ -359,7 +356,7 @@ hinic3_fdir_tcam_ipv6_vxlan_init(struct rte_eth_dev *dev,
  * Pointer to the TCAM key.
  */
 static void
-hinic3_fdir_tcam_vxlan_init(struct rte_eth_dev *dev,
+hinic3_fdir_tcam_vxlan_geneve_init(struct rte_eth_dev *dev,
 			    struct hinic3_fdir_filter *rule,
 			    struct hinic3_tcam_key *tcam_key)
 {
@@ -416,10 +413,10 @@ hinic3_fdir_tcam_vxlan_init(struct rte_eth_dev *dev,
 					 HINIC3_UINT15_MAX;
 
 	if (rule->ip_type == HINIC3_FDIR_IP_TYPE_IPV4)
-		hinic3_fdir_tcam_vxlan_ipv4_init(rule, tcam_key);
+		hinic3_fdir_tcam_vxlan_geneve_ipv4_init(rule, tcam_key);
 
 	else if (rule->ip_type == HINIC3_FDIR_IP_TYPE_IPV6)
-		hinic3_fdir_tcam_vxlan_ipv6_init(rule, tcam_key);
+		hinic3_fdir_tcam_vxlan_geneve_ipv6_init(rule, tcam_key);
 }
 
 static void
@@ -432,7 +429,7 @@ hinic3_fdir_tcam_info_init(struct rte_eth_dev *dev,
 	if (rule->tunnel_type == HINIC3_FDIR_TUNNEL_MODE_NORMAL)
 		hinic3_fdir_tcam_notunnel_init(dev, rule, tcam_key);
 	else
-		hinic3_fdir_tcam_vxlan_init(dev, rule, tcam_key);
+		hinic3_fdir_tcam_vxlan_geneve_init(dev, rule, tcam_key);
 
 	/* Set the queue index. */
 	fdir_tcam_rule->data.qid = rule->rq_index;
@@ -841,7 +838,7 @@ hinic3_dynamic_lookup_tcam_filter(struct hinic3_nic_dev *nic_dev,
 	 * capacity of dynamic TCAM blocks.
 	 */
 	if (rule_nums >= block_cnt * HINIC3_TCAM_DYNAMIC_BLOCK_SIZE) {
-		if (block_cnt >= (HINIC3_TCAM_DYNAMIC_MAX_FILTERS /
+		if (block_cnt >= (HINIC3_TCAM_DYNAMIC_MAX_FILTERS(nic_dev) /
 				  HINIC3_TCAM_DYNAMIC_BLOCK_SIZE)) {
 			PMD_DRV_LOG(ERR,
 				"Dynamic tcam block is full, alloc failed!");
@@ -1597,6 +1594,7 @@ hinic3_flow_add_del_ethertype_filter(struct rte_eth_dev *dev,
 	/* Get dev private info. */
 	struct hinic3_nic_dev *nic_dev = HINIC3_ETH_DEV_TO_PRIVATE_NIC_DEV(dev);
 	int ret;
+
 	/* Add or remove an Ethernet type filter rule. */
 	ret = hinic3_flow_add_del_ethertype_filter_rule(dev, ethertype_filter, add);
 
diff --git a/drivers/net/hinic3/hinic3_fdir.h b/drivers/net/hinic3/hinic3_fdir.h
index 277d89d4fd..05bd9c515b 100644
--- a/drivers/net/hinic3/hinic3_fdir.h
+++ b/drivers/net/hinic3/hinic3_fdir.h
@@ -8,8 +8,13 @@
 #define HINIC3_FLOW_MAX_PATTERN_NUM 16
 
 #define HINIC3_TCAM_DYNAMIC_BLOCK_SIZE 16
+#define HINIC3_TCAM_DYNAMIC_MAX_FILTERS(nic_dev)         \
+		(HINIC3_IS_SP230_NIC(nic_dev)            \
+		? HINIC3_TCAM_DYNAMIC_MAX_FILTERS_HTN    \
+		: HINIC3_TCAM_DYNAMIC_MAX_FILTERS_STN)
 
-#define HINIC3_TCAM_DYNAMIC_MAX_FILTERS 1024
+#define HINIC3_TCAM_DYNAMIC_MAX_FILTERS_STN 2048
+#define HINIC3_TCAM_DYNAMIC_MAX_FILTERS_HTN 1024
 
 #define HINIC3_PKT_TCAM_DYNAMIC_INDEX_START(block_index) \
 	(HINIC3_TCAM_DYNAMIC_BLOCK_SIZE * (block_index))
@@ -96,6 +101,7 @@ enum hinic3_fdir_tunnel_mode {
 	HINIC3_FDIR_TUNNEL_MODE_GENEVE = 5,
 	HINIC3_FDIR_TUNNEL_MODE_NSH    = 6,
 	HINIC3_FDIR_TUNNEL_MODE_IPIP   = 7,
+	HINIC3_FDIR_TUNNEL_MODE_MAX    = 8,
 };
 
 enum hinic3_fdir_ip_type {
diff --git a/drivers/net/hinic3/hinic3_flow.c b/drivers/net/hinic3/hinic3_flow.c
index 1f686d4675..9446dccccb 100644
--- a/drivers/net/hinic3/hinic3_flow.c
+++ b/drivers/net/hinic3/hinic3_flow.c
@@ -8,7 +8,6 @@
 #include "base/hinic3_hwdev.h"
 #include "base/hinic3_nic_cfg.h"
 #include "hinic3_ethdev.h"
-#include "hinic3_flow.h"
 
 #define HINIC3_UINT8_MAX 0xff
 
@@ -19,12 +18,6 @@ typedef int (*hinic3_parse_filter_t)(struct rte_eth_dev *dev,
 				     struct rte_flow_error *error,
 				     struct hinic3_filter_t *filter);
 
-/* Indicate valid filter mode . */
-struct hinic3_valid_pattern {
-	enum rte_flow_item_type *items;
-	hinic3_parse_filter_t parse_filter;
-};
-
 static int hinic3_flow_parse_fdir_filter(struct rte_eth_dev *dev,
 					 const struct rte_flow_attr *attr,
 					 const struct rte_flow_item pattern[],
@@ -39,65 +32,12 @@ static int hinic3_flow_parse_ethertype_filter(struct rte_eth_dev *dev,
 					      struct rte_flow_error *error,
 					      struct hinic3_filter_t *filter);
 
-static int hinic3_flow_parse_fdir_vxlan_filter(struct rte_eth_dev *dev,
-					       const struct rte_flow_attr *attr,
-					       const struct rte_flow_item pattern[],
-					       const struct rte_flow_action actions[],
-					       struct rte_flow_error *error,
-					       struct hinic3_filter_t *filter);
-
-/*
- * Define a supported pattern array, including the matching patterns of
- * various network protocols and corresponding parsing functions.
- */
-static const struct hinic3_valid_pattern hinic3_supported_patterns[] = {
-	/* Support ethertype. */
-	{pattern_ethertype, hinic3_flow_parse_ethertype_filter},
-	/* Support ipv4 but not tunnel, and any field can be masked. */
-	{pattern_ipv4, hinic3_flow_parse_fdir_filter},
-	{pattern_ipv4_any, hinic3_flow_parse_fdir_filter},
-	/* Support ipv4 + l4 but not tunnel, and any field can be masked. */
-	{pattern_ipv4_udp, hinic3_flow_parse_fdir_filter},
-	{pattern_ipv4_tcp, hinic3_flow_parse_fdir_filter},
-	/* Support ipv4 + icmp not tunnel, and any field can be masked. */
-	{pattern_ipv4_icmp, hinic3_flow_parse_fdir_filter},
-
-	/* Support ipv4 + l4 but not tunnel, and any field can be masked. */
-	{pattern_ethertype_udp, hinic3_flow_parse_fdir_filter},
-	{pattern_ethertype_tcp, hinic3_flow_parse_fdir_filter},
-
-	/* Support ipv4 + vxlan + any, and any field can be masked. */
-	{pattern_ipv4_vxlan, hinic3_flow_parse_fdir_vxlan_filter},
-	/* Support ipv4 + vxlan + ipv4, and any field can be masked. */
-	{pattern_ipv4_vxlan_ipv4, hinic3_flow_parse_fdir_vxlan_filter},
-	/* Support ipv4 + vxlan + ipv4 + l4, and any field can be masked. */
-	{pattern_ipv4_vxlan_ipv4_tcp, hinic3_flow_parse_fdir_vxlan_filter},
-	{pattern_ipv4_vxlan_ipv4_udp, hinic3_flow_parse_fdir_vxlan_filter},
-	/* Support ipv4 + vxlan + ipv6, and any field can be masked. */
-	{pattern_ipv4_vxlan_ipv6, hinic3_flow_parse_fdir_vxlan_filter},
-	/* Support ipv4 + vxlan + ipv6 + l4, and any field can be masked. */
-	{pattern_ipv4_vxlan_ipv6_tcp, hinic3_flow_parse_fdir_vxlan_filter},
-	{pattern_ipv4_vxlan_ipv6_udp, hinic3_flow_parse_fdir_vxlan_filter},
-	/* Support ipv4 + vxlan + l4, and any field can be masked. */
-	{pattern_ipv4_vxlan_tcp, hinic3_flow_parse_fdir_vxlan_filter},
-	{pattern_ipv4_vxlan_udp, hinic3_flow_parse_fdir_vxlan_filter},
-	{pattern_ipv4_vxlan_any, hinic3_flow_parse_fdir_vxlan_filter},
-
-	/* Support ipv6 but not tunnel, and any field can be masked. */
-	{pattern_ipv6, hinic3_flow_parse_fdir_filter},
-	/* Support ipv6 + l4 but not tunnel, and any field can be masked. */
-	{pattern_ipv6_udp, hinic3_flow_parse_fdir_filter},
-	{pattern_ipv6_tcp, hinic3_flow_parse_fdir_filter},
-
-	/* Support ipv6 + vxlan + any, and any field can be masked. */
-	{pattern_ipv6_vxlan, hinic3_flow_parse_fdir_vxlan_filter},
-	{pattern_ipv6_vxlan_any, hinic3_flow_parse_fdir_vxlan_filter},
-
-	/* Support ipv6 + vxlan + l4, and any field can be masked. */
-	{pattern_ipv6_vxlan_tcp, hinic3_flow_parse_fdir_vxlan_filter},
-	{pattern_ipv6_vxlan_udp, hinic3_flow_parse_fdir_vxlan_filter},
-
-};
+static int hinic3_flow_parse_fdir_vxlan_geneve_filter(struct rte_eth_dev *dev,
+						      const struct rte_flow_attr *attr,
+						      const struct rte_flow_item pattern[],
+						      const struct rte_flow_action actions[],
+						      struct rte_flow_error *error,
+						      struct hinic3_filter_t *filter);
 
 static inline void
 net_addr_to_host(uint32_t *dst, const uint32_t *src, size_t len)
@@ -107,30 +47,243 @@ net_addr_to_host(uint32_t *dst, const uint32_t *src, size_t len)
 		dst[i] = rte_be_to_cpu_32(src[i]);
 }
 
-static bool
-hinic3_match_pattern(enum rte_flow_item_type *item_array,
-		     const struct rte_flow_item *pattern)
-{
-	const struct rte_flow_item *item = pattern;
+/* IPINIP and GPE are split out due to chip support differences. */
+enum hinic3_flow_filter_kind {
+	HINIC3_FLOW_KIND_ETHERTYPE,	/* [ETH]. */
+	HINIC3_FLOW_KIND_NON_TUNNEL,	/* single L3/L4 or ethertype L4. */
+	HINIC3_FLOW_KIND_VXLAN_GENEVE,	/* vxlan/geneve. */
+	HINIC3_FLOW_KIND_GPE,		/* vxlan-gpe. */
+	HINIC3_FLOW_KIND_IPINIP,	/* ip-in-ip. */
+	HINIC3_FLOW_KIND_INVALID,
+};
 
-	/* skip the first void item. */
+/*
+ * The pattern is parsed as a small protocol graph. Every supported pattern
+ * starts with ETH and then follows one of the supported encapsulation paths
+ * (plain L3/L4, tunneled, or ip-in-ip). VOID items are transparent.
+ */
+
+/* Peek at the next non-VOID item type. */
+static enum rte_flow_item_type
+hinic3_flow_next(const struct rte_flow_item *item)
+{
 	while (item->type == RTE_FLOW_ITEM_TYPE_VOID)
 		item++;
 
-	/* Find no void item. */
-	while (((*item_array == item->type) &&
-		(*item_array != RTE_FLOW_ITEM_TYPE_END)) ||
-	       (item->type == RTE_FLOW_ITEM_TYPE_VOID)) {
-		if (item->type == RTE_FLOW_ITEM_TYPE_VOID) {
-			item++;
-		} else {
-			item_array++;
-			item++;
+	return item->type;
+}
+
+/* Consume the next non-VOID item when it matches @p type. */
+static bool
+hinic3_flow_take(const struct rte_flow_item **item,
+		 enum rte_flow_item_type type)
+{
+	while ((*item)->type == RTE_FLOW_ITEM_TYPE_VOID)
+		(*item)++;
+
+	if ((*item)->type != type)
+		return false;
+
+	(*item)++;
+	return true;
+}
+
+/* Return true when only the END item remains. */
+static bool
+hinic3_flow_at_end(const struct rte_flow_item *item)
+{
+	return hinic3_flow_next(item) == RTE_FLOW_ITEM_TYPE_END;
+}
+
+/* Finish a branch, which is valid only when END is reached. */
+static enum hinic3_flow_filter_kind
+hinic3_flow_finish(const struct rte_flow_item *item,
+		   enum hinic3_flow_filter_kind kind)
+{
+	return hinic3_flow_at_end(item) ? kind : HINIC3_FLOW_KIND_INVALID;
+}
+
+/* Classify an inner L3 (IPv4/IPv6) with an optional L4, returning @p kind. */
+static enum hinic3_flow_filter_kind
+hinic3_flow_classify_inner(const struct rte_flow_item **item,
+			   enum hinic3_flow_filter_kind kind,
+			   enum rte_flow_item_type outer_ip)
+{
+	enum rte_flow_item_type next = hinic3_flow_next(*item);
+
+	if (next != RTE_FLOW_ITEM_TYPE_IPV4 &&
+	    next != RTE_FLOW_ITEM_TYPE_IPV6)
+		return HINIC3_FLOW_KIND_INVALID;
+
+	/*
+	 * An outer IPv6 plus any inner L3 does not fit in the TCAM, so only
+	 * an IPv4 outer (or no outer at all) may carry an inner L3.
+	 */
+	if (outer_ip == RTE_FLOW_ITEM_TYPE_IPV6)
+		return HINIC3_FLOW_KIND_INVALID;
+
+	hinic3_flow_take(item, next);
+
+	switch (hinic3_flow_next(*item)) {
+	case RTE_FLOW_ITEM_TYPE_END:
+		return kind;
+	case RTE_FLOW_ITEM_TYPE_TCP:
+	case RTE_FLOW_ITEM_TYPE_UDP:
+		hinic3_flow_take(item, hinic3_flow_next(*item));
+		return hinic3_flow_finish(*item, kind);
+	default:
+		return HINIC3_FLOW_KIND_INVALID;
+	}
+}
+
+/* Consume a tunnel header and classify the payload that follows it. */
+static enum hinic3_flow_filter_kind
+hinic3_flow_classify_tunnel(const struct rte_flow_item **item,
+			    enum rte_flow_item_type tunnel_type,
+			    enum rte_flow_item_type outer_ip)
+{
+	enum hinic3_flow_filter_kind kind =
+		tunnel_type == RTE_FLOW_ITEM_TYPE_VXLAN_GPE ?
+			HINIC3_FLOW_KIND_GPE : HINIC3_FLOW_KIND_VXLAN_GENEVE;
+	enum rte_flow_item_type next;
+
+	if (!hinic3_flow_take(item, tunnel_type))
+		return HINIC3_FLOW_KIND_INVALID;
+
+	next = hinic3_flow_next(*item);
+
+	/* A bare tunnel with nothing after the header is valid. */
+	if (next == RTE_FLOW_ITEM_TYPE_END)
+		return kind;
+
+	/* GPE: an optional inner ETH (which may be terminal), then an L3(+L4). */
+	if (tunnel_type == RTE_FLOW_ITEM_TYPE_VXLAN_GPE) {
+		if (next == RTE_FLOW_ITEM_TYPE_ETH) {
+			hinic3_flow_take(item, RTE_FLOW_ITEM_TYPE_ETH);
+			if (hinic3_flow_at_end(*item))
+				return kind;
+		}
+		return hinic3_flow_classify_inner(item, kind, outer_ip);
+	}
+
+	/* vxlan/geneve: a bare L4/ANY, or an inner L3(+L4). */
+	switch (next) {
+	case RTE_FLOW_ITEM_TYPE_TCP:
+	case RTE_FLOW_ITEM_TYPE_UDP:
+	case RTE_FLOW_ITEM_TYPE_ANY:
+		hinic3_flow_take(item, next);
+		return hinic3_flow_finish(*item, kind);
+	case RTE_FLOW_ITEM_TYPE_ETH:
+	case RTE_FLOW_ITEM_TYPE_IPV4:
+	case RTE_FLOW_ITEM_TYPE_IPV6:
+		if (next == RTE_FLOW_ITEM_TYPE_ETH) {
+			hinic3_flow_take(item, RTE_FLOW_ITEM_TYPE_ETH);
+			break;
+		}
+		/* Geneve accepts a bare inner L3; vxlan requires the inner ETH. */
+		if (tunnel_type != RTE_FLOW_ITEM_TYPE_GENEVE)
+			return HINIC3_FLOW_KIND_INVALID;
+		break;
+	default:
+		return HINIC3_FLOW_KIND_INVALID;
+	}
+
+	return hinic3_flow_classify_inner(item, kind, outer_ip);
+}
+
+/* Classify the payload that follows the outer L3. */
+static enum hinic3_flow_filter_kind
+hinic3_flow_classify_ip(const struct rte_flow_item **item,
+			enum rte_flow_item_type ip_type)
+{
+	enum rte_flow_item_type next = hinic3_flow_next(*item);
+
+	switch (next) {
+	case RTE_FLOW_ITEM_TYPE_END:
+		return HINIC3_FLOW_KIND_NON_TUNNEL;
+	case RTE_FLOW_ITEM_TYPE_TCP:
+		hinic3_flow_take(item, RTE_FLOW_ITEM_TYPE_TCP);
+		return hinic3_flow_finish(*item, HINIC3_FLOW_KIND_NON_TUNNEL);
+	case RTE_FLOW_ITEM_TYPE_UDP:
+		hinic3_flow_take(item, RTE_FLOW_ITEM_TYPE_UDP);
+		next = hinic3_flow_next(*item);
+		switch (next) {
+		case RTE_FLOW_ITEM_TYPE_END:
+			return HINIC3_FLOW_KIND_NON_TUNNEL;
+		case RTE_FLOW_ITEM_TYPE_VXLAN:
+		case RTE_FLOW_ITEM_TYPE_GENEVE:
+		case RTE_FLOW_ITEM_TYPE_VXLAN_GPE:
+			return hinic3_flow_classify_tunnel(item, next, ip_type);
+		default:
+			return HINIC3_FLOW_KIND_INVALID;
+		}
+	case RTE_FLOW_ITEM_TYPE_ICMP:
+	case RTE_FLOW_ITEM_TYPE_ANY:
+		/* ICMP and ANY are valid only right after an IPv4 outer. */
+		if (ip_type != RTE_FLOW_ITEM_TYPE_IPV4)
+			return HINIC3_FLOW_KIND_INVALID;
+		hinic3_flow_take(item, next);
+		return hinic3_flow_finish(*item, HINIC3_FLOW_KIND_NON_TUNNEL);
+	case RTE_FLOW_ITEM_TYPE_IPV4:
+	case RTE_FLOW_ITEM_TYPE_IPV6:
+		/* Ip-in-ip: a second L3 with an optional L4 (or ANY). */
+		hinic3_flow_take(item, next);
+		switch (hinic3_flow_next(*item)) {
+		case RTE_FLOW_ITEM_TYPE_END:
+			return HINIC3_FLOW_KIND_IPINIP;
+		case RTE_FLOW_ITEM_TYPE_TCP:
+		case RTE_FLOW_ITEM_TYPE_UDP:
+		case RTE_FLOW_ITEM_TYPE_ANY:
+			hinic3_flow_take(item, hinic3_flow_next(*item));
+			return hinic3_flow_finish(*item, HINIC3_FLOW_KIND_IPINIP);
+		default:
+			return HINIC3_FLOW_KIND_INVALID;
 		}
+	default:
+		return HINIC3_FLOW_KIND_INVALID;
 	}
+}
 
-	return (*item_array == RTE_FLOW_ITEM_TYPE_END &&
-		item->type == RTE_FLOW_ITEM_TYPE_END);
+/* Classify a pattern into one of the supported filter kinds. */
+static enum hinic3_flow_filter_kind
+hinic3_flow_classify(const struct rte_flow_item *pattern)
+{
+	const struct rte_flow_item *item = pattern;
+	enum rte_flow_item_type next;
+
+	if (!hinic3_flow_take(&item, RTE_FLOW_ITEM_TYPE_ETH))
+		return HINIC3_FLOW_KIND_INVALID;
+
+	switch (hinic3_flow_next(item)) {
+	case RTE_FLOW_ITEM_TYPE_END:
+		return HINIC3_FLOW_KIND_ETHERTYPE;
+	case RTE_FLOW_ITEM_TYPE_TCP:
+		hinic3_flow_take(&item, RTE_FLOW_ITEM_TYPE_TCP);
+		return hinic3_flow_finish(item, HINIC3_FLOW_KIND_NON_TUNNEL);
+	case RTE_FLOW_ITEM_TYPE_UDP:
+		hinic3_flow_take(&item, RTE_FLOW_ITEM_TYPE_UDP);
+		next = hinic3_flow_next(item);
+		switch (next) {
+		case RTE_FLOW_ITEM_TYPE_END:
+			return HINIC3_FLOW_KIND_NON_TUNNEL;
+		case RTE_FLOW_ITEM_TYPE_VXLAN:
+		case RTE_FLOW_ITEM_TYPE_GENEVE:
+		case RTE_FLOW_ITEM_TYPE_VXLAN_GPE:
+			/* No outer IP: pass END so classify_inner allows it. */
+			return hinic3_flow_classify_tunnel(&item, next,
+							    RTE_FLOW_ITEM_TYPE_END);
+		default:
+			return HINIC3_FLOW_KIND_INVALID;
+		}
+	case RTE_FLOW_ITEM_TYPE_IPV4:
+		hinic3_flow_take(&item, RTE_FLOW_ITEM_TYPE_IPV4);
+		return hinic3_flow_classify_ip(&item, RTE_FLOW_ITEM_TYPE_IPV4);
+	case RTE_FLOW_ITEM_TYPE_IPV6:
+		hinic3_flow_take(&item, RTE_FLOW_ITEM_TYPE_IPV6);
+		return hinic3_flow_classify_ip(&item, RTE_FLOW_ITEM_TYPE_IPV6);
+	default:
+		return HINIC3_FLOW_KIND_INVALID;
+	}
 }
 
 /**
@@ -142,20 +295,27 @@ hinic3_match_pattern(enum rte_flow_item_type *item_array,
  * Matched resolution filter. If no resolution filter is found, return NULL.
  */
 static hinic3_parse_filter_t
-hinic3_find_parse_filter_func(const struct rte_flow_item *pattern)
+hinic3_find_parse_filter_func(struct rte_eth_dev *dev,
+			      const struct rte_flow_item *pattern)
 {
-	hinic3_parse_filter_t parse_filter = NULL;
-	uint8_t i;
-	/* Traverse all supported patterns. */
-	for (i = 0; i < RTE_DIM(hinic3_supported_patterns); i++) {
-		if (hinic3_match_pattern(hinic3_supported_patterns[i].items, pattern)) {
-			parse_filter =
-				hinic3_supported_patterns[i].parse_filter;
-			break;
-		}
-	}
+	struct hinic3_nic_dev *nic_dev = HINIC3_ETH_DEV_TO_PRIVATE_NIC_DEV(dev);
 
-	return parse_filter;
+	switch (hinic3_flow_classify(pattern)) {
+	case HINIC3_FLOW_KIND_ETHERTYPE:
+		return hinic3_flow_parse_ethertype_filter;
+	case HINIC3_FLOW_KIND_NON_TUNNEL:
+		return hinic3_flow_parse_fdir_filter;
+	case HINIC3_FLOW_KIND_VXLAN_GENEVE:
+		return hinic3_flow_parse_fdir_vxlan_geneve_filter;
+	case HINIC3_FLOW_KIND_GPE:
+		return HINIC3_IS_SP620_NIC(nic_dev) ?
+		hinic3_flow_parse_fdir_vxlan_geneve_filter : NULL;
+	case HINIC3_FLOW_KIND_IPINIP:
+		return HINIC3_IS_SP620_NIC(nic_dev) ? NULL :
+		hinic3_flow_parse_fdir_vxlan_geneve_filter;
+	default:
+		return NULL;
+	}
 }
 
 /**
@@ -182,12 +342,36 @@ hinic3_flow_parse_action(struct rte_eth_dev *dev,
 	const struct rte_flow_action_queue *act_q;
 	const struct rte_flow_action *act = actions;
 
-	/* skip the first void item. */
-	while (act->type == RTE_FLOW_ACTION_TYPE_VOID)
-		act++;
+	/* Only one non-VOID action before END is supported. */
+	const struct rte_flow_action *last_act = NULL;
+	for (act = actions; act->type != RTE_FLOW_ACTION_TYPE_END; act++) {
+		if (act->type == RTE_FLOW_ACTION_TYPE_VOID)
+			continue;
+		if (last_act != NULL) {
+			rte_flow_error_set(error, EINVAL,
+					   RTE_FLOW_ERROR_TYPE_ACTION, act,
+					   "Multiple actions not supported.");
+			return -rte_errno;
+		}
+		last_act = act;
+	}
+	if (last_act == NULL) {
+		rte_flow_error_set(error, EINVAL,
+				   RTE_FLOW_ERROR_TYPE_ACTION, actions,
+				   "No valid action.");
+		return -rte_errno;
+	}
+
+	act = last_act;
 
 	switch (act->type) {
 	case RTE_FLOW_ACTION_TYPE_QUEUE:
+		if (act->conf == NULL) {
+			rte_flow_error_set(error, EINVAL,
+					   RTE_FLOW_ERROR_TYPE_ACTION,
+					   act, "Invalid action queue config.");
+			return -rte_errno;
+		}
 		act_q = (const struct rte_flow_action_queue *)act->conf;
 		filter->fdir_filter.rq_index = act_q->index;
 		if (filter->fdir_filter.rq_index >= dev->data->nb_rx_queues) {
@@ -230,6 +414,14 @@ hinic3_flow_fdir_ipv4(const struct rte_flow_item *flow_item,
 
 	mask_ipv4 = (const struct rte_flow_item_ipv4 *)flow_item->mask;
 	spec_ipv4 = (const struct rte_flow_item_ipv4 *)flow_item->spec;
+
+	filter->fdir_filter.ip_type = HINIC3_FDIR_IP_TYPE_IPV4;
+	filter->fdir_filter.tunnel_type = HINIC3_FDIR_TUNNEL_MODE_NORMAL;
+
+	/* When both L3 mask and spec are empty, return 0, then proceed to evaluate L4. */
+	if (!mask_ipv4 && !spec_ipv4)
+		return 0;
+
 	if (!mask_ipv4 || !spec_ipv4) {
 		rte_flow_error_set(error, EINVAL, RTE_FLOW_ERROR_TYPE_ITEM,
 				   flow_item,
@@ -251,9 +443,6 @@ hinic3_flow_fdir_ipv4(const struct rte_flow_item *flow_item,
 		return -rte_errno;
 	}
 
-	/* Set the filter information. */
-	filter->fdir_filter.ip_type = HINIC3_FDIR_IP_TYPE_IPV4;
-	filter->fdir_filter.tunnel_type = HINIC3_FDIR_TUNNEL_MODE_NORMAL;
 	filter->fdir_filter.key_mask.ipv4.src_ip =
 		rte_be_to_cpu_32(mask_ipv4->hdr.src_addr);
 	filter->fdir_filter.key_spec.ipv4.src_ip =
@@ -277,6 +466,14 @@ hinic3_flow_fdir_ipv6(const struct rte_flow_item *flow_item,
 
 	mask_ipv6 = (const struct rte_flow_item_ipv6 *)flow_item->mask;
 	spec_ipv6 = (const struct rte_flow_item_ipv6 *)flow_item->spec;
+
+	filter->fdir_filter.ip_type = HINIC3_FDIR_IP_TYPE_IPV6;
+	filter->fdir_filter.tunnel_type = HINIC3_FDIR_TUNNEL_MODE_NORMAL;
+
+	/* When both L3 mask and spec are empty, return 0, then proceed to evaluate L4. */
+	if (!mask_ipv6 && !spec_ipv6)
+		return 0;
+
 	if (!mask_ipv6 || !spec_ipv6) {
 		rte_flow_error_set(error, EINVAL, RTE_FLOW_ERROR_TYPE_ITEM,
 				   flow_item,
@@ -293,9 +490,6 @@ hinic3_flow_fdir_ipv6(const struct rte_flow_item *flow_item,
 		return -rte_errno;
 	}
 
-	/* Set the filter information. */
-	filter->fdir_filter.ip_type = HINIC3_FDIR_IP_TYPE_IPV6;
-	filter->fdir_filter.tunnel_type = HINIC3_FDIR_TUNNEL_MODE_NORMAL;
 	net_addr_to_host(filter->fdir_filter.key_mask.ipv6.src_ip,
 			 (const uint32_t *)mask_ipv6->hdr.src_addr.a, 4);
 	net_addr_to_host(filter->fdir_filter.key_spec.ipv6.src_ip,
@@ -639,6 +833,12 @@ hinic3_flow_parse_ethertype_pattern(__rte_unused struct rte_eth_dev *dev,
 			case RTE_ETHER_TYPE_LLDP:
 				break;
 
+			case RTE_ETHER_TYPE_CNM:
+				break;
+
+			case RTE_ETHER_TYPE_ECP:
+				break;
+
 			default:
 				rte_flow_error_set(error, EINVAL,
 						   RTE_FLOW_ERROR_TYPE_ITEM,
@@ -686,14 +886,15 @@ static int
 hinic3_flow_fdir_tunnel_ipv4(struct rte_flow_error *error,
 			     struct hinic3_filter_t *filter,
 			     const struct rte_flow_item *flow_item,
-			     enum hinic3_fdir_tunnel_mode tunnel_mode)
+			     enum hinic3_fdir_tunnel_mode *tunnel_mode)
 {
 	const struct rte_flow_item_ipv4 *spec_ipv4, *mask_ipv4;
 	mask_ipv4 = (const struct rte_flow_item_ipv4 *)flow_item->mask;
 	spec_ipv4 = (const struct rte_flow_item_ipv4 *)flow_item->spec;
 
-	if (tunnel_mode == HINIC3_FDIR_TUNNEL_MODE_NORMAL) {
+	if (*tunnel_mode == HINIC3_FDIR_TUNNEL_MODE_MAX) {
 		filter->fdir_filter.outer_ip_type = HINIC3_FDIR_IP_TYPE_IPV4;
+		*tunnel_mode = HINIC3_FDIR_TUNNEL_MODE_NORMAL;
 
 		if (!mask_ipv4 && !spec_ipv4)
 			return 0;
@@ -702,7 +903,8 @@ hinic3_flow_fdir_tunnel_ipv4(struct rte_flow_error *error,
 			rte_flow_error_set(error, EINVAL,
 					   RTE_FLOW_ERROR_TYPE_ITEM,
 					   flow_item,
-					   "Invalid fdir filter, vxlan outer ipv4 mask or spec");
+					   "Invalid fdir filter, vxlan/geneve "
+					   "outer ipv4 mask or spec");
 			return -rte_errno;
 		}
 
@@ -718,7 +920,8 @@ hinic3_flow_fdir_tunnel_ipv4(struct rte_flow_error *error,
 		    mask_ipv4->hdr.next_proto_id ||
 		    mask_ipv4->hdr.hdr_checksum) {
 			rte_flow_error_set(error, EINVAL, RTE_FLOW_ERROR_TYPE_ITEM, flow_item,
-				"Not supported by fdir filter, vxlan outer ipv4 only support src ip, dst ip");
+				"Not supported by fdir filter, vxlan/geneve outer "
+				"ipv4 only support src ip,dst ip");
 			return -rte_errno;
 		}
 
@@ -733,6 +936,10 @@ hinic3_flow_fdir_tunnel_ipv4(struct rte_flow_error *error,
 			rte_be_to_cpu_32(spec_ipv4->hdr.dst_addr);
 	} else {
 		filter->fdir_filter.ip_type = HINIC3_FDIR_IP_TYPE_IPV4;
+		if (*tunnel_mode == HINIC3_FDIR_TUNNEL_MODE_NORMAL) {
+			*tunnel_mode = HINIC3_FDIR_TUNNEL_MODE_IPIP;
+			filter->fdir_filter.tunnel_type = *tunnel_mode;
+		}
 
 		if (!mask_ipv4 && !spec_ipv4)
 			return 0;
@@ -741,7 +948,8 @@ hinic3_flow_fdir_tunnel_ipv4(struct rte_flow_error *error,
 			rte_flow_error_set(error, EINVAL,
 					   RTE_FLOW_ERROR_TYPE_ITEM,
 					   flow_item,
-					   "Invalid fdir filter, vxlan inner ipv4 mask or spec");
+					   "Invalid fdir filter, vxlan/geneve "
+					   "inner ipv4 mask or spec");
 			return -rte_errno;
 		}
 
@@ -758,7 +966,8 @@ hinic3_flow_fdir_tunnel_ipv4(struct rte_flow_error *error,
 			rte_flow_error_set(error, EINVAL,
 					   RTE_FLOW_ERROR_TYPE_ITEM,
 					   flow_item,
-					   "Not supported by fdir filter, vxlan inner ipv4 only support src ip, dst ip, proto");
+					   "Not supported by fdir filter, vxlan/geneve inner "
+					   "ipv4 only support src ip,dst ip, proto");
 			return -rte_errno;
 		}
 
@@ -783,15 +992,16 @@ static int
 hinic3_flow_fdir_tunnel_ipv6(struct rte_flow_error *error,
 			     struct hinic3_filter_t *filter,
 			     const struct rte_flow_item *flow_item,
-			     enum hinic3_fdir_tunnel_mode tunnel_mode)
+			     enum hinic3_fdir_tunnel_mode *tunnel_mode)
 {
 	const struct rte_flow_item_ipv6 *spec_ipv6, *mask_ipv6;
 
 	mask_ipv6 = (const struct rte_flow_item_ipv6 *)flow_item->mask;
 	spec_ipv6 = (const struct rte_flow_item_ipv6 *)flow_item->spec;
 
-	if (tunnel_mode == HINIC3_FDIR_TUNNEL_MODE_NORMAL) {
+	if (*tunnel_mode == HINIC3_FDIR_TUNNEL_MODE_MAX) {
 		filter->fdir_filter.outer_ip_type = HINIC3_FDIR_IP_TYPE_IPV6;
+		*tunnel_mode = HINIC3_FDIR_TUNNEL_MODE_NORMAL;
 
 		if (!mask_ipv6 && !spec_ipv6)
 			return 0;
@@ -822,7 +1032,10 @@ hinic3_flow_fdir_tunnel_ipv6(struct rte_flow_error *error,
 				 (const uint32_t *)spec_ipv6->hdr.dst_addr.a, 4);
 	} else {
 		filter->fdir_filter.ip_type = HINIC3_FDIR_IP_TYPE_IPV6;
-
+		if (*tunnel_mode == HINIC3_FDIR_TUNNEL_MODE_NORMAL) {
+			*tunnel_mode = HINIC3_FDIR_TUNNEL_MODE_IPIP;
+			filter->fdir_filter.tunnel_type = *tunnel_mode;
+		}
 		if (!mask_ipv6 && !spec_ipv6)
 			return 0;
 
@@ -869,7 +1082,8 @@ hinic3_flow_fdir_tunnel_tcp(struct rte_flow_error *error,
 	if (tunnel_mode == HINIC3_FDIR_TUNNEL_MODE_NORMAL) {
 		rte_flow_error_set(error, EINVAL, RTE_FLOW_ERROR_TYPE_ITEM,
 				   flow_item,
-				   "Not supported by fdir filter, vxlan only support inner tcp");
+				   "Not supported by fdir filter, "
+				   "vxlan/geneve only support inner tcp");
 		return -rte_errno;
 	}
 
@@ -894,7 +1108,8 @@ hinic3_flow_fdir_tunnel_tcp(struct rte_flow_error *error,
 	    mask_tcp->hdr.tcp_urp) {
 		rte_flow_error_set(error, EINVAL, RTE_FLOW_ERROR_TYPE_ITEM,
 				   flow_item,
-				   "Not supported by fdir filter, vxlan inner tcp only support src port,dst port");
+				   "Not supported by fdir filter, vxlan/geneve inner "
+				   "tcp only support src port,dst port");
 		return -rte_errno;
 	}
 
@@ -921,7 +1136,8 @@ hinic3_flow_fdir_tunnel_udp(struct rte_flow_error *error,
 	mask_udp = (const struct rte_flow_item_udp *)flow_item->mask;
 	spec_udp = (const struct rte_flow_item_udp *)flow_item->spec;
 
-	if (tunnel_mode == HINIC3_FDIR_TUNNEL_MODE_NORMAL) {
+	if (tunnel_mode == HINIC3_FDIR_TUNNEL_MODE_MAX ||
+	    tunnel_mode == HINIC3_FDIR_TUNNEL_MODE_NORMAL) {
 		/*
 		 * UDP is used to describe protocol,
 		 * spec and mask should be NULL.
@@ -942,7 +1158,8 @@ hinic3_flow_fdir_tunnel_udp(struct rte_flow_error *error,
 			rte_flow_error_set(error, EINVAL,
 					   RTE_FLOW_ERROR_TYPE_ITEM,
 					   flow_item,
-					   "Invalid fdir filter vxlan inner udp mask or spec");
+					   "Invalid fdir filter vxlan/geneve "
+					   "inner udp mask or spec");
 			return -rte_errno;
 		}
 
@@ -960,57 +1177,119 @@ hinic3_flow_fdir_tunnel_udp(struct rte_flow_error *error,
 	return 0;
 }
 
+static inline enum hinic3_fdir_tunnel_mode
+hinic3_flow_tunnel_mode(enum rte_flow_item_type type)
+{
+	switch (type) {
+	case RTE_FLOW_ITEM_TYPE_GENEVE:
+		return HINIC3_FDIR_TUNNEL_MODE_GENEVE;
+	case RTE_FLOW_ITEM_TYPE_VXLAN_GPE:
+		return HINIC3_FDIR_TUNNEL_MODE_GPE;
+	default:
+		return HINIC3_FDIR_TUNNEL_MODE_VXLAN;
+	}
+}
+
 static int
-hinic3_flow_fdir_vxlan(struct rte_flow_error *error,
-		       struct hinic3_filter_t *filter,
-		       const struct rte_flow_item *flow_item)
+hinic3_flow_fdir_vxlan_geneve(struct rte_flow_error	  *error,
+			      struct hinic3_filter_t	  *filter,
+			      enum hinic3_fdir_tunnel_mode tunnel_mode,
+			      const struct rte_flow_item  *flow_item)
 {
-	const struct rte_flow_item_vxlan *spec_vxlan, *mask_vxlan;
+	const uint8_t *vni;
+	const uint8_t *vni_mask;
 	uint32_t vxlan_vni_id = 0;
 	uint32_t vxlan_vni_id_mask = 0;
 
-	spec_vxlan = (const struct rte_flow_item_vxlan *)flow_item->spec;
-	mask_vxlan = (const struct rte_flow_item_vxlan *)flow_item->mask;
-
-	filter->fdir_filter.tunnel_type = HINIC3_FDIR_TUNNEL_MODE_VXLAN;
+	filter->fdir_filter.tunnel_type = tunnel_mode;
 
-	if (!spec_vxlan && !mask_vxlan) {
+	if (!flow_item->spec && !flow_item->mask)
 		return 0;
-	} else if (filter->fdir_filter.outer_ip_type == HINIC3_FDIR_IP_TYPE_IPV6) {
+
+	if (filter->fdir_filter.outer_ip_type == HINIC3_FDIR_IP_TYPE_IPV6) {
 		rte_flow_error_set(error, EINVAL, RTE_FLOW_ERROR_TYPE_ITEM,
 				   flow_item,
-				   "Invalid fdir filter vxlan mask or spec, ipv6 vxlan, don't support vni");
+				   "Invalid fdir filter vxlan/geneve mask or spec, "
+				   "ipv6 vxlan/geneve, don't support vni");
 		return -rte_errno;
 	}
 
-	if (!spec_vxlan || !mask_vxlan) {
+	if (!flow_item->spec || !flow_item->mask) {
 		rte_flow_error_set(error, EINVAL, RTE_FLOW_ERROR_TYPE_ITEM,
 				   flow_item,
-				   "Invalid fdir filter vxlan mask or spec");
+				   "Invalid fdir filter vxlan/geneve mask or spec");
 		return -rte_errno;
 	}
 
-	memcpy(((uint8_t *)&vxlan_vni_id + 1), spec_vxlan->vni, 3);
+	switch (tunnel_mode) {
+	case HINIC3_FDIR_TUNNEL_MODE_GENEVE: {
+		const struct rte_flow_item_geneve *spec =
+			(const struct rte_flow_item_geneve *)flow_item->spec;
+		const struct rte_flow_item_geneve *mask =
+			(const struct rte_flow_item_geneve *)flow_item->mask;
+
+		/* Only VNI is matched; option length and protocol are not. */
+		if (mask->ver_opt_len_o_c_rsvd0 || mask->protocol)
+			goto unsupported;
+		vni = spec->vni;
+		vni_mask = mask->vni;
+		break;
+	}
+	case HINIC3_FDIR_TUNNEL_MODE_GPE: {
+		const struct rte_flow_item_vxlan_gpe *spec =
+			(const struct rte_flow_item_vxlan_gpe *)flow_item->spec;
+		const struct rte_flow_item_vxlan_gpe *mask =
+			(const struct rte_flow_item_vxlan_gpe *)flow_item->mask;
+
+		/* Only VNI is matched; flags, reserved bits and protocol are not. */
+		if (mask->flags || mask->rsvd0[0] || mask->rsvd0[1] ||
+		    mask->protocol || mask->rsvd1)
+			goto unsupported;
+		vni = spec->vni;
+		vni_mask = mask->vni;
+		break;
+	}
+	default:
+		vni = ((const struct rte_flow_item_vxlan *)flow_item->spec)->vni;
+		vni_mask =
+			((const struct rte_flow_item_vxlan *)flow_item->mask)->vni;
+		break;
+	}
+
+	memcpy(((uint8_t *)&vxlan_vni_id + 1), vni, 3);
 	filter->fdir_filter.key_spec.tunnel.tunnel_id =
 		rte_be_to_cpu_32(vxlan_vni_id);
-	memcpy(((uint8_t *)&vxlan_vni_id_mask + 1), mask_vxlan->vni, 3);
+	memcpy(((uint8_t *)&vxlan_vni_id_mask + 1), vni_mask, 3);
 	filter->fdir_filter.key_mask.tunnel.tunnel_id =
 		rte_be_to_cpu_32(vxlan_vni_id_mask);
 	return 0;
+
+unsupported:
+	rte_flow_error_set(error, EINVAL, RTE_FLOW_ERROR_TYPE_ITEM, flow_item,
+			   "Not supported by fdir filter, only vni is supported");
+	return -rte_errno;
 }
 
 static int
-hinic3_flow_parse_fdir_vxlan_pattern(__rte_unused struct rte_eth_dev *dev,
-				     const struct rte_flow_item *pattern,
-				     struct rte_flow_error *error,
-				     struct hinic3_filter_t *filter)
+hinic3_flow_parse_fdir_vxlan_geneve_pattern(__rte_unused struct rte_eth_dev *dev,
+					    const struct rte_flow_item *pattern,
+					    struct rte_flow_error *error,
+					    struct hinic3_filter_t *filter)
 {
 	const struct rte_flow_item *flow_item = pattern;
-	enum hinic3_fdir_tunnel_mode tunnel_mode =
-		HINIC3_FDIR_TUNNEL_MODE_NORMAL;
+	/* Pass tunnel_mode by pointer so the inner L3 parser can promote it
+	 * to IPIP when a second IPv4/IPv6 header is recognized.
+	 */
+	enum hinic3_fdir_tunnel_mode tunnel_mode = HINIC3_FDIR_TUNNEL_MODE_MAX;
 	enum rte_flow_item_type type;
 	int err;
 
+	if (pattern == NULL) {
+		rte_flow_error_set(error, EINVAL, RTE_FLOW_ERROR_TYPE_ITEM, NULL,
+				   "Invalid pattern");
+		return -rte_errno;
+	}
+
 	/* Inner and outer ip type, set it to any by default */
 	filter->fdir_filter.ip_type = HINIC3_FDIR_IP_TYPE_ANY;
 	filter->fdir_filter.outer_ip_type = HINIC3_FDIR_IP_TYPE_ANY;
@@ -1038,14 +1317,14 @@ hinic3_flow_parse_fdir_vxlan_pattern(__rte_unused struct rte_eth_dev *dev,
 
 		case RTE_FLOW_ITEM_TYPE_IPV4:
 			err = hinic3_flow_fdir_tunnel_ipv4(error,
-				filter, flow_item, tunnel_mode);
+				filter, flow_item, &tunnel_mode);
 			if (err)
 				return -rte_errno;
 			break;
 
 		case RTE_FLOW_ITEM_TYPE_IPV6:
 			err = hinic3_flow_fdir_tunnel_ipv6(error,
-				filter, flow_item, tunnel_mode);
+				filter, flow_item, &tunnel_mode);
 			if (err)
 				return -rte_errno;
 			break;
@@ -1065,10 +1344,12 @@ hinic3_flow_parse_fdir_vxlan_pattern(__rte_unused struct rte_eth_dev *dev,
 			break;
 
 		case RTE_FLOW_ITEM_TYPE_VXLAN:
-			err = hinic3_flow_fdir_vxlan(error, filter, flow_item);
+		case RTE_FLOW_ITEM_TYPE_GENEVE:
+		case RTE_FLOW_ITEM_TYPE_VXLAN_GPE:
+			tunnel_mode = hinic3_flow_tunnel_mode(type);
+			err = hinic3_flow_fdir_vxlan_geneve(error, filter, tunnel_mode, flow_item);
 			if (err)
 				return -rte_errno;
-			tunnel_mode = HINIC3_FDIR_TUNNEL_MODE_VXLAN;
 			break;
 
 		default:
@@ -1099,16 +1380,16 @@ hinic3_flow_parse_fdir_vxlan_pattern(__rte_unused struct rte_eth_dev *dev,
  * 0 on success, non-zero on failure.
  */
 static int
-hinic3_flow_parse_fdir_vxlan_filter(struct rte_eth_dev *dev,
-				    const struct rte_flow_attr *attr,
-				    const struct rte_flow_item pattern[],
-				    const struct rte_flow_action actions[],
-				    struct rte_flow_error *error,
-				    struct hinic3_filter_t *filter)
+hinic3_flow_parse_fdir_vxlan_geneve_filter(struct rte_eth_dev *dev,
+					   const struct rte_flow_attr *attr,
+					   const struct rte_flow_item pattern[],
+					   const struct rte_flow_action actions[],
+					   struct rte_flow_error *error,
+					   struct hinic3_filter_t *filter)
 {
 	int ret;
 
-	ret = hinic3_flow_parse_fdir_vxlan_pattern(dev, pattern, error, filter);
+	ret = hinic3_flow_parse_fdir_vxlan_geneve_pattern(dev, pattern, error, filter);
 	if (ret)
 		return ret;
 
@@ -1153,6 +1434,7 @@ hinic3_flow_parse(struct rte_eth_dev *dev, const struct rte_flow_attr *attr,
 	hinic3_parse_filter_t parse_filter;
 	uint32_t pattern_num = 0;
 	int ret = 0;
+
 	/* Check whether the parameter is valid. */
 	if (!pattern || !actions || !attr) {
 		rte_flow_error_set(error, EINVAL,
@@ -1174,7 +1456,7 @@ hinic3_flow_parse(struct rte_eth_dev *dev, const struct rte_flow_attr *attr,
 	 * The corresponding filter is returned. If the filter is not found,
 	 * NULL is returned.
 	 */
-	parse_filter = hinic3_find_parse_filter_func(pattern);
+	parse_filter = hinic3_find_parse_filter_func(dev, pattern);
 	if (!parse_filter) {
 		rte_flow_error_set(error, EINVAL, RTE_FLOW_ERROR_TYPE_ITEM,
 				   pattern, "Unsupported pattern");
@@ -1303,9 +1585,7 @@ hinic3_flow_create(struct rte_eth_dev *dev, const struct rte_flow_attr *attr,
 				   NULL, "Unsupported filter type.");
 		goto free_flow;
 	}
-
 	return flow;
-
 free_flow:
 	rte_free(flow);
 	rte_free(filter_rules);
@@ -1467,7 +1747,6 @@ hinic3_flow_flush(struct rte_eth_dev *dev, struct rte_flow_error *error)
 	return ret;
 }
 
-/* Structure for managing flow table operations. */
 const struct rte_flow_ops hinic3_flow_ops = {
 	.validate = hinic3_flow_validate,
 	.create = hinic3_flow_create,
diff --git a/drivers/net/hinic3/hinic3_flow.h b/drivers/net/hinic3/hinic3_flow.h
deleted file mode 100644
index c4b38e44e7..0000000000
--- a/drivers/net/hinic3/hinic3_flow.h
+++ /dev/null
@@ -1,196 +0,0 @@
-/* SPDX-License-Identifier: BSD-3-Clause
- * Copyright(c) 2025 Huawei Technologies Co., Ltd
- */
-
-#ifndef _HINIC3_FLOW_H_
-#define _HINIC3_FLOW_H_
-
-#include <rte_flow.h>
-
-/* Indicate the type of the IPv4 ICPM matching pattern. */
-static enum rte_flow_item_type pattern_ipv4_icmp[] = {
-	RTE_FLOW_ITEM_TYPE_ETH,
-	RTE_FLOW_ITEM_TYPE_IPV4,
-	RTE_FLOW_ITEM_TYPE_ICMP,
-	RTE_FLOW_ITEM_TYPE_END,
-};
-
-/* Indicate the type of the IPv4 any protocol matching pattern. */
-static enum rte_flow_item_type pattern_ipv4_any[] = {
-	RTE_FLOW_ITEM_TYPE_ETH,
-	RTE_FLOW_ITEM_TYPE_IPV4,
-	RTE_FLOW_ITEM_TYPE_ANY,
-	RTE_FLOW_ITEM_TYPE_END,
-};
-
-/* Indicate the type of the Ether matching pattern. */
-static enum rte_flow_item_type pattern_ethertype[] = {
-	RTE_FLOW_ITEM_TYPE_ETH,
-	RTE_FLOW_ITEM_TYPE_END,
-};
-
-/* Indicate the type of the TCP matching pattern. */
-static enum rte_flow_item_type pattern_ethertype_tcp[] = {
-	RTE_FLOW_ITEM_TYPE_ETH,
-	RTE_FLOW_ITEM_TYPE_TCP,
-	RTE_FLOW_ITEM_TYPE_END,
-};
-
-/* Indicate the type of the UDP matching pattern. */
-static enum rte_flow_item_type pattern_ethertype_udp[] = {
-	RTE_FLOW_ITEM_TYPE_ETH,
-	RTE_FLOW_ITEM_TYPE_UDP,
-	RTE_FLOW_ITEM_TYPE_END,
-};
-
-/* Indicate the type of the IPv4 vxlan matching pattern. */
-static enum rte_flow_item_type pattern_ipv4_vxlan[] = {
-	RTE_FLOW_ITEM_TYPE_ETH, RTE_FLOW_ITEM_TYPE_IPV4,
-	RTE_FLOW_ITEM_TYPE_UDP, RTE_FLOW_ITEM_TYPE_VXLAN,
-	RTE_FLOW_ITEM_TYPE_END,
-};
-
-/* Indicate the type of the IPv4 vxlan any protocol matching pattern. */
-static enum rte_flow_item_type pattern_ipv4_vxlan_any[] = {
-	RTE_FLOW_ITEM_TYPE_ETH, RTE_FLOW_ITEM_TYPE_IPV4,
-	RTE_FLOW_ITEM_TYPE_UDP, RTE_FLOW_ITEM_TYPE_VXLAN,
-	RTE_FLOW_ITEM_TYPE_ANY, RTE_FLOW_ITEM_TYPE_END,
-};
-
-/* Indicate the type of the IPv4 vxlan TCP matching pattern. */
-static enum rte_flow_item_type pattern_ipv4_vxlan_tcp[] = {
-	RTE_FLOW_ITEM_TYPE_ETH, RTE_FLOW_ITEM_TYPE_IPV4,
-	RTE_FLOW_ITEM_TYPE_UDP, RTE_FLOW_ITEM_TYPE_VXLAN,
-	RTE_FLOW_ITEM_TYPE_TCP, RTE_FLOW_ITEM_TYPE_END,
-};
-
-/* Indicate the type of the IPv4 vxlan UDP matching pattern. */
-static enum rte_flow_item_type pattern_ipv4_vxlan_udp[] = {
-	RTE_FLOW_ITEM_TYPE_ETH, RTE_FLOW_ITEM_TYPE_IPV4,
-	RTE_FLOW_ITEM_TYPE_UDP, RTE_FLOW_ITEM_TYPE_VXLAN,
-	RTE_FLOW_ITEM_TYPE_UDP, RTE_FLOW_ITEM_TYPE_END,
-};
-
-/* Indicate the type of the IPv4 vxlan IPv4 matching pattern. */
-static enum rte_flow_item_type pattern_ipv4_vxlan_ipv4[] = {
-	RTE_FLOW_ITEM_TYPE_ETH, RTE_FLOW_ITEM_TYPE_IPV4,
-	RTE_FLOW_ITEM_TYPE_UDP, RTE_FLOW_ITEM_TYPE_VXLAN,
-	RTE_FLOW_ITEM_TYPE_ETH, RTE_FLOW_ITEM_TYPE_IPV4,
-	RTE_FLOW_ITEM_TYPE_END,
-};
-
-/* Indicate the type of the IPv4 vxlan IPv4 TCP matching pattern. */
-static enum rte_flow_item_type pattern_ipv4_vxlan_ipv4_tcp[] = {
-	RTE_FLOW_ITEM_TYPE_ETH, RTE_FLOW_ITEM_TYPE_IPV4,
-	RTE_FLOW_ITEM_TYPE_UDP, RTE_FLOW_ITEM_TYPE_VXLAN,
-	RTE_FLOW_ITEM_TYPE_ETH, RTE_FLOW_ITEM_TYPE_IPV4,
-	RTE_FLOW_ITEM_TYPE_TCP, RTE_FLOW_ITEM_TYPE_END,
-};
-
-/* Indicate the type of the IPv4 vxlan IPv4 UDP matching pattern. */
-static enum rte_flow_item_type pattern_ipv4_vxlan_ipv4_udp[] = {
-	RTE_FLOW_ITEM_TYPE_ETH, RTE_FLOW_ITEM_TYPE_IPV4,
-	RTE_FLOW_ITEM_TYPE_UDP, RTE_FLOW_ITEM_TYPE_VXLAN,
-	RTE_FLOW_ITEM_TYPE_ETH, RTE_FLOW_ITEM_TYPE_IPV4,
-	RTE_FLOW_ITEM_TYPE_UDP, RTE_FLOW_ITEM_TYPE_END,
-};
-
-/* Indicate the type of the IPv4 vxlan IPv6 matching pattern. */
-static enum rte_flow_item_type pattern_ipv4_vxlan_ipv6[] = {
-	RTE_FLOW_ITEM_TYPE_ETH, RTE_FLOW_ITEM_TYPE_IPV4,
-	RTE_FLOW_ITEM_TYPE_UDP, RTE_FLOW_ITEM_TYPE_VXLAN,
-	RTE_FLOW_ITEM_TYPE_ETH, RTE_FLOW_ITEM_TYPE_IPV6,
-	RTE_FLOW_ITEM_TYPE_END,
-};
-
-/* Indicate the type of the IPv4 vxlan IPv6 TCP matching pattern. */
-static enum rte_flow_item_type pattern_ipv4_vxlan_ipv6_tcp[] = {
-	RTE_FLOW_ITEM_TYPE_ETH, RTE_FLOW_ITEM_TYPE_IPV4,
-	RTE_FLOW_ITEM_TYPE_UDP, RTE_FLOW_ITEM_TYPE_VXLAN,
-	RTE_FLOW_ITEM_TYPE_ETH, RTE_FLOW_ITEM_TYPE_IPV6,
-	RTE_FLOW_ITEM_TYPE_TCP, RTE_FLOW_ITEM_TYPE_END,
-};
-
-/* Indicate the type of the IPv4 vxlan IPv6 UDP matching pattern. */
-static enum rte_flow_item_type pattern_ipv4_vxlan_ipv6_udp[] = {
-	RTE_FLOW_ITEM_TYPE_ETH, RTE_FLOW_ITEM_TYPE_IPV4,
-	RTE_FLOW_ITEM_TYPE_UDP, RTE_FLOW_ITEM_TYPE_VXLAN,
-	RTE_FLOW_ITEM_TYPE_ETH, RTE_FLOW_ITEM_TYPE_IPV6,
-	RTE_FLOW_ITEM_TYPE_UDP, RTE_FLOW_ITEM_TYPE_END,
-};
-
-/* Indicate the type of the IPv4 matching pattern. */
-static enum rte_flow_item_type pattern_ipv4[] = {
-	RTE_FLOW_ITEM_TYPE_ETH,
-	RTE_FLOW_ITEM_TYPE_IPV4,
-	RTE_FLOW_ITEM_TYPE_END,
-};
-
-/* Indicate the type of the IPv4 UDP matching pattern. */
-static enum rte_flow_item_type pattern_ipv4_udp[] = {
-	RTE_FLOW_ITEM_TYPE_ETH,
-	RTE_FLOW_ITEM_TYPE_IPV4,
-	RTE_FLOW_ITEM_TYPE_UDP,
-	RTE_FLOW_ITEM_TYPE_END,
-};
-
-/* Indicate the type of the IPv4 TCP matching pattern. */
-static enum rte_flow_item_type pattern_ipv4_tcp[] = {
-	RTE_FLOW_ITEM_TYPE_ETH,
-	RTE_FLOW_ITEM_TYPE_IPV4,
-	RTE_FLOW_ITEM_TYPE_TCP,
-	RTE_FLOW_ITEM_TYPE_END,
-};
-
-/* Indicate the type of the IPv6 matching pattern. */
-static enum rte_flow_item_type pattern_ipv6[] = {
-	RTE_FLOW_ITEM_TYPE_ETH,
-	RTE_FLOW_ITEM_TYPE_IPV6,
-	RTE_FLOW_ITEM_TYPE_END,
-};
-
-/* Indicate the type of the IPv6 UDP matching pattern. */
-static enum rte_flow_item_type pattern_ipv6_udp[] = {
-	RTE_FLOW_ITEM_TYPE_ETH,
-	RTE_FLOW_ITEM_TYPE_IPV6,
-	RTE_FLOW_ITEM_TYPE_UDP,
-	RTE_FLOW_ITEM_TYPE_END,
-};
-
-/* Indicate the type of the IPv6 TCP matching pattern. */
-static enum rte_flow_item_type pattern_ipv6_tcp[] = {
-	RTE_FLOW_ITEM_TYPE_ETH,
-	RTE_FLOW_ITEM_TYPE_IPV6,
-	RTE_FLOW_ITEM_TYPE_TCP,
-	RTE_FLOW_ITEM_TYPE_END,
-};
-
-/* Indicate the type of the IPv6 TCP matching pattern. */
-static enum rte_flow_item_type pattern_ipv6_vxlan[] = {
-	RTE_FLOW_ITEM_TYPE_ETH, RTE_FLOW_ITEM_TYPE_IPV6,
-	RTE_FLOW_ITEM_TYPE_UDP, RTE_FLOW_ITEM_TYPE_VXLAN,
-	RTE_FLOW_ITEM_TYPE_END,
-};
-
-/* Indicate the type of the IPv6 VXLAN any protocol matching pattern. */
-static enum rte_flow_item_type pattern_ipv6_vxlan_any[] = {
-	RTE_FLOW_ITEM_TYPE_ETH, RTE_FLOW_ITEM_TYPE_IPV6,
-	RTE_FLOW_ITEM_TYPE_UDP, RTE_FLOW_ITEM_TYPE_VXLAN,
-	RTE_FLOW_ITEM_TYPE_ANY, RTE_FLOW_ITEM_TYPE_END,
-};
-
-/* Indicate the type of the IPv6 VXLAN TCP matching pattern. */
-static enum rte_flow_item_type pattern_ipv6_vxlan_tcp[] = {
-	RTE_FLOW_ITEM_TYPE_ETH, RTE_FLOW_ITEM_TYPE_IPV6,
-	RTE_FLOW_ITEM_TYPE_UDP, RTE_FLOW_ITEM_TYPE_VXLAN,
-	RTE_FLOW_ITEM_TYPE_TCP, RTE_FLOW_ITEM_TYPE_END,
-};
-
-/* Indicate the type of the IPv6 VXLAN UDP matching pattern. */
-static enum rte_flow_item_type pattern_ipv6_vxlan_udp[] = {
-	RTE_FLOW_ITEM_TYPE_ETH, RTE_FLOW_ITEM_TYPE_IPV6,
-	RTE_FLOW_ITEM_TYPE_UDP, RTE_FLOW_ITEM_TYPE_VXLAN,
-	RTE_FLOW_ITEM_TYPE_UDP, RTE_FLOW_ITEM_TYPE_END,
-};
-
-#endif /**< _HINIC3_FLOW_H_ */
-- 
2.33.0

