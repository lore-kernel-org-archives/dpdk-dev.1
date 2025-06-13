Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 29F02C71135
	for <dpdk-dev@archiver.kernel.org>; Fri, 13 Jun 2025 08:42:36 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 0893542EC7;
	Fri, 13 Jun 2025 10:42:24 +0200 (CEST)
Received: from smtpbgeu2.qq.com (smtpbgeu2.qq.com [18.194.254.142])
 by mails.dpdk.org (Postfix) with ESMTP id B3B3742EAB;
 Fri, 13 Jun 2025 10:42:21 +0200 (CEST)
X-QQ-mid: esmtpsz18t1749804139tfff3106f
X-QQ-Originating-IP: LJG0zVrGSuqFY2Z6RknaY+UjQmAt8U0ruRzFxQzaAJc=
Received: from lap-jiawenwu.trustnetic.com ( [36.20.60.58])
 by bizesmtp.qq.com (ESMTP) with 
 id ; Fri, 13 Jun 2025 16:42:18 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 12298724318750162549
EX-QQ-RecipientCnt: 4
From: Jiawen Wu <jiawenwu@trustnetic.com>
To: dev@dpdk.org
Cc: zaiyuwang@trustnetic.com, Jiawen Wu <jiawenwu@trustnetic.com>,
 stable@dpdk.org
Subject: [PATCH v3 03/17] net/txgbe: fix raw pattern match for FDIR rules
Date: Fri, 13 Jun 2025 16:41:45 +0800
Message-Id: <20250613084159.22184-4-jiawenwu@trustnetic.com>
X-Mailer: git-send-email 2.21.0.windows.1
In-Reply-To: <20250613084159.22184-1-jiawenwu@trustnetic.com>
References: <00DEAE896AFE0D2D+20250606080117.183198-1-jiawenwu@trustnetic.com>
 <20250613084159.22184-1-jiawenwu@trustnetic.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: esmtpsz:trustnetic.com:qybglogicsvrgz:qybglogicsvrgz8a-1
X-QQ-XMAILINFO: NWLpwLZrMWrId6ZUgKpGb7xVu8V4xxHcGWexsQUGcE/Eey/XvvJZG127
 wu6sidjLA1migVfJRD2+SqEBBt8CHJsFk3zOQ1AdyrOZ2P9fx066eK5iQG4jwiCvbaov2iD
 GBsgu/2YkZGCI6+PXyoR72VshXSrIAjtaeQfIxcF7CLKa8j93B22UZjSlUX4PnYWQPFglAg
 wIUUtyhEoVv+9WOmvyTWOiwmB5F4gt1UqWujh3KwLAsGNCERgRvYS8/VmxlriIKa+6A0Mt4
 E9lMQWxNFQg7hboRjrxet3swL3A0Hi8klPjr3cemU9OHNHR+I0v3YL32Dtkcc2TsgaRwwSz
 dCmHIxZuafc5vrwSYHEbRb41lnkpoCJx7K77zrcRHKdoAFq2LdzDIJ0j+LaY4gyqW7QFFGL
 1Kmm1Z1p7M0vjjszmMW+Kqo2/qRk5EewFwA6k0GGXoBR+9hbnFwktxB9YbyzsOqbYOnr0Eu
 zzTImth5Wbt+EO+yy9/2dD4LnSIUfOd6Fwpk18q6liNA98AoZzFhJekHK3PSLN1N64VRaaJ
 8Z91FAsHQo+S2yMte57eRJ3gNh7tXFWLo0m0ia4+bjdHuHT0Cq9lo1vISzrax6eEawLoeLd
 y1L2l1foae5gPjMQl0Iow5Udvi3n7guDAhDb+Vfnef/lgSF0nNQNIznE3qsYzdSrJacICo9
 oJJcEOFa8ZW6VPQIkWFrL3ExLj/5aokxUYdTD6jR5nnwu/FkftWIjdkHbS15kvGecXqG8ce
 iKhYrzFJhWTHRzhnZMveOIHqfY3O/EZoGSYoqtF8IeC1InWQSsuX4PN7BE1IJtDFJmKnLzi
 PVdJEf32/tcgF4rCW838+ooZse4M+czIUDu0bDbAE9y4Tb2EErd8C0+pkY7rdBr/pLDmiEX
 RQpUwwKYNl5kb6U10Uefh9v382x82T0ehjg4Rl1hXuSWmInqlNZB5cQ0TWK3ZM5di7UvAqJ
 ylNgSaQUPagYRq9V6paw9oOrYpI0oJICrCyS2tvFfcwZwNaW7gwq21sDFRaGeoSnycZ6+/h
 R27mir1me+/e/A2G+0PmwULe1jOE4=
X-QQ-XMRINFO: M/715EihBoGSf6IYSX1iLFg=
X-QQ-RECHKSPAM: 0
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

The raw patthern is required to be two hex bytes on hardware, but it is
string in the raw item. So the length of raw spec should be 4, and the
string should be converted to the two hex bytes. And relative of raw
spec is supported to be optical.

Fixes: b973ee26747a ("net/txgbe: parse flow director filter")
Cc: stable@dpdk.org

Signed-off-by: Jiawen Wu <jiawenwu@trustnetic.com>
---
 drivers/net/txgbe/txgbe_ethdev.h |  5 ++-
 drivers/net/txgbe/txgbe_fdir.c   | 24 +++++++++++++--
 drivers/net/txgbe/txgbe_flow.c   | 53 ++++++++++++++++++++++++--------
 3 files changed, 67 insertions(+), 15 deletions(-)

diff --git a/drivers/net/txgbe/txgbe_ethdev.h b/drivers/net/txgbe/txgbe_ethdev.h
index 36d51fcbb8..0a3c634937 100644
--- a/drivers/net/txgbe/txgbe_ethdev.h
+++ b/drivers/net/txgbe/txgbe_ethdev.h
@@ -116,11 +116,13 @@ struct txgbe_fdir_rule {
 	uint32_t soft_id; /* an unique value for this rule */
 	uint8_t queue; /* assigned rx queue */
 	uint8_t flex_bytes_offset;
+	bool flex_relative;
 };
 
 struct txgbe_hw_fdir_info {
 	struct txgbe_hw_fdir_mask mask;
 	uint8_t     flex_bytes_offset;
+	bool        flex_relative;
 	uint16_t    collision;
 	uint16_t    free;
 	uint16_t    maxhash;
@@ -561,8 +563,9 @@ void txgbe_set_ivar_map(struct txgbe_hw *hw, int8_t direction,
  */
 int txgbe_fdir_configure(struct rte_eth_dev *dev);
 int txgbe_fdir_set_input_mask(struct rte_eth_dev *dev);
+uint16_t txgbe_fdir_get_flex_base(struct txgbe_fdir_rule *rule);
 int txgbe_fdir_set_flexbytes_offset(struct rte_eth_dev *dev,
-				    uint16_t offset);
+				    uint16_t offset, uint16_t flex_base);
 int txgbe_fdir_filter_program(struct rte_eth_dev *dev,
 			      struct txgbe_fdir_rule *rule,
 			      bool del, bool update);
diff --git a/drivers/net/txgbe/txgbe_fdir.c b/drivers/net/txgbe/txgbe_fdir.c
index f627ab681d..75bf30c00c 100644
--- a/drivers/net/txgbe/txgbe_fdir.c
+++ b/drivers/net/txgbe/txgbe_fdir.c
@@ -258,9 +258,24 @@ txgbe_fdir_store_input_mask(struct rte_eth_dev *dev)
 	return 0;
 }
 
+uint16_t
+txgbe_fdir_get_flex_base(struct txgbe_fdir_rule *rule)
+{
+	if (!rule->flex_relative)
+		return TXGBE_FDIRFLEXCFG_BASE_MAC;
+
+	if (rule->input.flow_type & TXGBE_ATR_L4TYPE_MASK)
+		return TXGBE_FDIRFLEXCFG_BASE_PAY;
+
+	if (rule->input.flow_type & TXGBE_ATR_L3TYPE_MASK)
+		return TXGBE_FDIRFLEXCFG_BASE_L3;
+
+	return TXGBE_FDIRFLEXCFG_BASE_L2;
+}
+
 int
 txgbe_fdir_set_flexbytes_offset(struct rte_eth_dev *dev,
-				uint16_t offset)
+				uint16_t offset, uint16_t flex_base)
 {
 	struct txgbe_hw *hw = TXGBE_DEV_HW(dev);
 	int i;
@@ -268,7 +283,7 @@ txgbe_fdir_set_flexbytes_offset(struct rte_eth_dev *dev,
 	for (i = 0; i < 64; i++) {
 		uint32_t flexreg, flex;
 		flexreg = rd32(hw, TXGBE_FDIRFLEXCFG(i / 4));
-		flex = TXGBE_FDIRFLEXCFG_BASE_MAC;
+		flex = flex_base;
 		flex |= TXGBE_FDIRFLEXCFG_OFST(offset / 2);
 		flexreg &= ~(TXGBE_FDIRFLEXCFG_ALL(~0UL, i % 4));
 		flexreg |= TXGBE_FDIRFLEXCFG_ALL(flex, i % 4);
@@ -910,6 +925,11 @@ txgbe_fdir_flush(struct rte_eth_dev *dev)
 	info->add = 0;
 	info->remove = 0;
 
+	memset(&info->mask, 0, sizeof(struct txgbe_hw_fdir_mask));
+	info->mask_added = false;
+	info->flex_relative = false;
+	info->flex_bytes_offset = 0;
+
 	return ret;
 }
 
diff --git a/drivers/net/txgbe/txgbe_flow.c b/drivers/net/txgbe/txgbe_flow.c
index 269f0b54e3..8670c3e1d7 100644
--- a/drivers/net/txgbe/txgbe_flow.c
+++ b/drivers/net/txgbe/txgbe_flow.c
@@ -2066,6 +2066,8 @@ txgbe_parse_fdir_filter_normal(struct rte_eth_dev *dev __rte_unused,
 
 	/* Get the flex byte info */
 	if (item->type == RTE_FLOW_ITEM_TYPE_RAW) {
+		uint16_t pattern = 0;
+
 		/* Not supported last point for range*/
 		if (item->last) {
 			rte_flow_error_set(error, EINVAL,
@@ -2082,6 +2084,7 @@ txgbe_parse_fdir_filter_normal(struct rte_eth_dev *dev __rte_unused,
 			return -rte_errno;
 		}
 
+		rule->b_mask = TRUE;
 		raw_mask = item->mask;
 
 		/* check mask */
@@ -2098,19 +2101,21 @@ txgbe_parse_fdir_filter_normal(struct rte_eth_dev *dev __rte_unused,
 			return -rte_errno;
 		}
 
+		rule->b_spec = TRUE;
 		raw_spec = item->spec;
 
 		/* check spec */
-		if (raw_spec->relative != 0 ||
-		    raw_spec->search != 0 ||
+		if (raw_spec->search != 0 ||
 		    raw_spec->reserved != 0 ||
 		    raw_spec->offset > TXGBE_MAX_FLX_SOURCE_OFF ||
 		    raw_spec->offset % 2 ||
 		    raw_spec->limit != 0 ||
-		    raw_spec->length != 2 ||
+		    raw_spec->length != 4 ||
 		    /* pattern can't be 0xffff */
 		    (raw_spec->pattern[0] == 0xff &&
-		     raw_spec->pattern[1] == 0xff)) {
+		     raw_spec->pattern[1] == 0xff &&
+		     raw_spec->pattern[2] == 0xff &&
+		     raw_spec->pattern[3] == 0xff)) {
 			memset(rule, 0, sizeof(struct txgbe_fdir_rule));
 			rte_flow_error_set(error, EINVAL,
 				RTE_FLOW_ERROR_TYPE_ITEM,
@@ -2120,7 +2125,9 @@ txgbe_parse_fdir_filter_normal(struct rte_eth_dev *dev __rte_unused,
 
 		/* check pattern mask */
 		if (raw_mask->pattern[0] != 0xff ||
-		    raw_mask->pattern[1] != 0xff) {
+		    raw_mask->pattern[1] != 0xff ||
+		    raw_mask->pattern[2] != 0xff ||
+		    raw_mask->pattern[3] != 0xff) {
 			memset(rule, 0, sizeof(struct txgbe_fdir_rule));
 			rte_flow_error_set(error, EINVAL,
 				RTE_FLOW_ERROR_TYPE_ITEM,
@@ -2129,10 +2136,19 @@ txgbe_parse_fdir_filter_normal(struct rte_eth_dev *dev __rte_unused,
 		}
 
 		rule->mask.flex_bytes_mask = 0xffff;
-		rule->input.flex_bytes =
-			(((uint16_t)raw_spec->pattern[1]) << 8) |
-			raw_spec->pattern[0];
+		/* Convert pattern string to hex bytes */
+		if (sscanf((const char *)raw_spec->pattern, "%hx", &pattern) != 1) {
+			memset(rule, 0, sizeof(struct txgbe_fdir_rule));
+			rte_flow_error_set(error, EINVAL,
+				RTE_FLOW_ERROR_TYPE_ITEM,
+				item, "Failed to parse raw pattern");
+			return -rte_errno;
+		}
+		rule->input.flex_bytes = (pattern & 0x00FF) << 8;
+		rule->input.flex_bytes |= (pattern & 0xFF00) >> 8;
+
 		rule->flex_bytes_offset = raw_spec->offset;
+		rule->flex_relative = raw_spec->relative;
 	}
 
 	if (item->type != RTE_FLOW_ITEM_TYPE_END) {
@@ -2836,10 +2852,16 @@ txgbe_flow_create(struct rte_eth_dev *dev,
 				fdir_info->mask = fdir_rule.mask;
 				fdir_info->flex_bytes_offset =
 					fdir_rule.flex_bytes_offset;
+				fdir_info->flex_relative = fdir_rule.flex_relative;
+
+				if (fdir_rule.mask.flex_bytes_mask) {
+					uint16_t flex_base;
 
-				if (fdir_rule.mask.flex_bytes_mask)
+					flex_base = txgbe_fdir_get_flex_base(&fdir_rule);
 					txgbe_fdir_set_flexbytes_offset(dev,
-						fdir_rule.flex_bytes_offset);
+									fdir_rule.flex_bytes_offset,
+									flex_base);
+				}
 
 				ret = txgbe_fdir_set_input_mask(dev);
 				if (ret)
@@ -2861,7 +2883,9 @@ txgbe_flow_create(struct rte_eth_dev *dev,
 				}
 
 				if (fdir_info->flex_bytes_offset !=
-						fdir_rule.flex_bytes_offset)
+				    fdir_rule.flex_bytes_offset ||
+				    fdir_info->flex_relative !=
+				    fdir_rule.flex_relative)
 					goto out;
 			}
 		}
@@ -3089,8 +3113,13 @@ txgbe_flow_destroy(struct rte_eth_dev *dev,
 			TAILQ_REMOVE(&filter_fdir_list,
 				fdir_rule_ptr, entries);
 			rte_free(fdir_rule_ptr);
-			if (TAILQ_EMPTY(&filter_fdir_list))
+			if (TAILQ_EMPTY(&filter_fdir_list)) {
+				memset(&fdir_info->mask, 0,
+					sizeof(struct txgbe_hw_fdir_mask));
 				fdir_info->mask_added = false;
+				fdir_info->flex_relative = false;
+				fdir_info->flex_bytes_offset = 0;
+			}
 		}
 		break;
 	case RTE_ETH_FILTER_L2_TUNNEL:
-- 
2.48.1

