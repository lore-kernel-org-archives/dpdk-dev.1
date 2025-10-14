Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 39B1ACCD184
	for <dpdk-dev@archiver.kernel.org>; Tue, 14 Oct 2025 07:21:04 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 711B240684;
	Tue, 14 Oct 2025 09:20:15 +0200 (CEST)
Received: from inva020.nxp.com (inva020.nxp.com [92.121.34.13])
 by mails.dpdk.org (Postfix) with ESMTP id 75EC4402A0;
 Tue, 14 Oct 2025 08:00:48 +0200 (CEST)
Received: from inva020.nxp.com (localhost [127.0.0.1])
 by inva020.eu-rdc02.nxp.com (Postfix) with ESMTP id 5740A1A1BE3;
 Tue, 14 Oct 2025 08:00:48 +0200 (CEST)
Received: from aprdc01srsp001v.ap-rdc01.nxp.com
 (aprdc01srsp001v.ap-rdc01.nxp.com [165.114.16.16])
 by inva020.eu-rdc02.nxp.com (Postfix) with ESMTP id 2759D1A1BD2;
 Tue, 14 Oct 2025 08:00:48 +0200 (CEST)
Received: from lsv031405.swis.in-blr01.nxp.com
 (lsv031405.swis.in-blr01.nxp.com [92.120.147.93])
 by aprdc01srsp001v.ap-rdc01.nxp.com (Postfix) with ESMTP id 963011800086;
 Tue, 14 Oct 2025 14:00:47 +0800 (+08)
From: Prashant Gupta <prashant.gupta_3@nxp.com>
To: dev@dpdk.org,
	stephen@networkplumber.org,
	david.marchand@redhat.com
Cc: stable@dpdk.org,
	Jun Yang <jun.yang@nxp.com>
Subject: [PATCH 06/15] net/dpaa2: fix flow rule's resizing issue
Date: Tue, 14 Oct 2025 11:30:36 +0530
Message-ID: <20251014060045.1304694-7-prashant.gupta_3@nxp.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20251014060045.1304694-1-prashant.gupta_3@nxp.com>
References: <20251014060045.1304694-1-prashant.gupta_3@nxp.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Virus-Scanned: ClamAV using ClamSMTP
X-Mailman-Approved-At: Tue, 14 Oct 2025 09:20:04 +0200
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

From: Jun Yang <jun.yang@nxp.com>

Appending new extract need resize the flow's rule.
The rule's size should start from new extract's position plus
it's size unless the position is less than rule's original size.

Fixes: 56c1817d532e ("net/dpaa2: refactor flow engine")
Cc: stable@dpdk.org

Signed-off-by: Jun Yang <jun.yang@nxp.com>
---
 drivers/net/dpaa2/dpaa2_flow.c | 123 ++++++++++++++++++++++++++-------
 1 file changed, 97 insertions(+), 26 deletions(-)

diff --git a/drivers/net/dpaa2/dpaa2_flow.c b/drivers/net/dpaa2/dpaa2_flow.c
index 299c50dcdf..2e44bff766 100644
--- a/drivers/net/dpaa2/dpaa2_flow.c
+++ b/drivers/net/dpaa2/dpaa2_flow.c
@@ -630,42 +630,42 @@ dpaa2_flow_rule_insert_hole(struct dpaa2_dev_flow *flow,
 	int offset, int size,
 	enum dpaa2_flow_dist_type dist_type)
 {
-	int end;
-
 	if (dist_type & DPAA2_FLOW_QOS_TYPE) {
-		end = flow->qos_rule_size;
-		if (end > offset) {
+		if (offset < flow->qos_rule_size) {
 			memmove(flow->qos_key_addr + offset + size,
 					flow->qos_key_addr + offset,
-					end - offset);
+					flow->qos_rule_size - offset);
 			memset(flow->qos_key_addr + offset,
 					0, size);
 
 			memmove(flow->qos_mask_addr + offset + size,
 					flow->qos_mask_addr + offset,
-					end - offset);
+					flow->qos_rule_size - offset);
 			memset(flow->qos_mask_addr + offset,
 					0, size);
+			flow->qos_rule_size += size;
+		} else {
+			flow->qos_rule_size = offset + size;
 		}
-		flow->qos_rule_size += size;
 	}
 
 	if (dist_type & DPAA2_FLOW_FS_TYPE) {
-		end = flow->fs_rule_size;
-		if (end > offset) {
+		if (offset < flow->fs_rule_size) {
 			memmove(flow->fs_key_addr + offset + size,
 					flow->fs_key_addr + offset,
-					end - offset);
+					flow->fs_rule_size - offset);
 			memset(flow->fs_key_addr + offset,
 					0, size);
 
 			memmove(flow->fs_mask_addr + offset + size,
 					flow->fs_mask_addr + offset,
-					end - offset);
+					flow->fs_rule_size - offset);
 			memset(flow->fs_mask_addr + offset,
 					0, size);
+			flow->fs_rule_size += size;
+		} else {
+			flow->fs_rule_size = offset + size;
 		}
-		flow->fs_rule_size += size;
 	}
 
 	return 0;
@@ -1485,8 +1485,9 @@ dpaa2_flow_faf_add_rule(struct dpaa2_dev_priv *priv,
 		mask_addr = flow->qos_mask_addr + offset;
 
 		if (!(*key_addr) &&
-			key_profile->ip_addr_type == IP_NONE_ADDR_EXTRACT)
-			flow->qos_rule_size++;
+			key_profile->ip_addr_type == IP_NONE_ADDR_EXTRACT &&
+			offset >= flow->qos_rule_size)
+			flow->qos_rule_size = offset + sizeof(uint8_t);
 
 		*key_addr |=  (1 << faf_bit_in_byte);
 		*mask_addr |=  (1 << faf_bit_in_byte);
@@ -1507,8 +1508,9 @@ dpaa2_flow_faf_add_rule(struct dpaa2_dev_priv *priv,
 		mask_addr = flow->fs_mask_addr + offset;
 
 		if (!(*key_addr) &&
-			key_profile->ip_addr_type == IP_NONE_ADDR_EXTRACT)
-			flow->fs_rule_size++;
+			key_profile->ip_addr_type == IP_NONE_ADDR_EXTRACT &&
+			offset >= flow->fs_rule_size)
+			flow->fs_rule_size = offset + sizeof(uint8_t);
 
 		*key_addr |=  (1 << faf_bit_in_byte);
 		*mask_addr |=  (1 << faf_bit_in_byte);
@@ -1526,6 +1528,7 @@ dpaa2_flow_pr_rule_data_set(struct dpaa2_dev_flow *flow,
 {
 	int offset;
 	uint32_t pr_field = pr_offset << 16 | pr_size;
+	char offset_info[64], size_info[64], rule_size_info[64];
 
 	offset = dpaa2_flow_extract_key_offset(key_profile,
 			DPAA2_PR_KEY, NET_PROT_NONE, pr_field);
@@ -1534,19 +1537,43 @@ dpaa2_flow_pr_rule_data_set(struct dpaa2_dev_flow *flow,
 			pr_offset, pr_size);
 		return -EINVAL;
 	}
+	sprintf(offset_info, "offset(%d)", offset);
+	sprintf(size_info, "size(%d)", pr_size);
 
 	if (dist_type & DPAA2_FLOW_QOS_TYPE) {
+		sprintf(rule_size_info, "qos rule size(%d)",
+			flow->qos_rule_size);
 		memcpy((flow->qos_key_addr + offset), key, pr_size);
 		memcpy((flow->qos_mask_addr + offset), mask, pr_size);
-		if (key_profile->ip_addr_type == IP_NONE_ADDR_EXTRACT)
-			flow->qos_rule_size = offset + pr_size;
+		if (key_profile->ip_addr_type == IP_NONE_ADDR_EXTRACT) {
+			if (offset >= flow->qos_rule_size) {
+				flow->qos_rule_size = offset + pr_size;
+			} else if ((offset + pr_size) > flow->qos_rule_size) {
+				DPAA2_PMD_ERR("%s < %s, but %s + %s > %s",
+					offset_info, rule_size_info,
+					offset_info, size_info,
+					rule_size_info);
+				return -EINVAL;
+			}
+		}
 	}
 
 	if (dist_type & DPAA2_FLOW_FS_TYPE) {
+		sprintf(rule_size_info, "fs rule size(%d)",
+			flow->fs_rule_size);
 		memcpy((flow->fs_key_addr + offset), key, pr_size);
 		memcpy((flow->fs_mask_addr + offset), mask, pr_size);
-		if (key_profile->ip_addr_type == IP_NONE_ADDR_EXTRACT)
-			flow->fs_rule_size = offset + pr_size;
+		if (key_profile->ip_addr_type == IP_NONE_ADDR_EXTRACT) {
+			if (offset >= flow->fs_rule_size) {
+				flow->fs_rule_size = offset + pr_size;
+			} else if ((offset + pr_size) > flow->fs_rule_size) {
+				DPAA2_PMD_ERR("%s < %s, but %s + %s > %s",
+					offset_info, rule_size_info,
+					offset_info, size_info,
+					rule_size_info);
+				return -EINVAL;
+			}
+		}
 	}
 
 	return 0;
@@ -1560,6 +1587,7 @@ dpaa2_flow_hdr_rule_data_set(struct dpaa2_dev_flow *flow,
 	enum dpaa2_flow_dist_type dist_type)
 {
 	int offset;
+	char offset_info[64], size_info[64], rule_size_info[64];
 
 	if (dpaa2_flow_ip_address_extract(prot, field)) {
 		DPAA2_PMD_ERR("%s only for none IP address extract",
@@ -1574,19 +1602,41 @@ dpaa2_flow_hdr_rule_data_set(struct dpaa2_dev_flow *flow,
 			prot, field);
 		return -EINVAL;
 	}
+	sprintf(offset_info, "offset(%d)", offset);
+	sprintf(size_info, "size(%d)", size);
 
 	if (dist_type & DPAA2_FLOW_QOS_TYPE) {
+		sprintf(rule_size_info, "qos rule size(%d)",
+			flow->qos_rule_size);
 		memcpy((flow->qos_key_addr + offset), key, size);
 		memcpy((flow->qos_mask_addr + offset), mask, size);
-		if (key_profile->ip_addr_type == IP_NONE_ADDR_EXTRACT)
-			flow->qos_rule_size = offset + size;
+		if (key_profile->ip_addr_type == IP_NONE_ADDR_EXTRACT) {
+			if (offset >= flow->qos_rule_size) {
+				flow->qos_rule_size = offset + size;
+			} else if ((offset + size) > flow->qos_rule_size) {
+				DPAA2_PMD_ERR("%s: %s < %s, but %s + %s > %s",
+					__func__, offset_info, rule_size_info,
+					offset_info, size_info, rule_size_info);
+				return -EINVAL;
+			}
+		}
 	}
 
 	if (dist_type & DPAA2_FLOW_FS_TYPE) {
+		sprintf(rule_size_info, "fs rule size(%d)",
+			flow->fs_rule_size);
 		memcpy((flow->fs_key_addr + offset), key, size);
 		memcpy((flow->fs_mask_addr + offset), mask, size);
-		if (key_profile->ip_addr_type == IP_NONE_ADDR_EXTRACT)
-			flow->fs_rule_size = offset + size;
+		if (key_profile->ip_addr_type == IP_NONE_ADDR_EXTRACT) {
+			if (offset >= flow->fs_rule_size) {
+				flow->fs_rule_size = offset + size;
+			} else if ((offset + size) > flow->fs_rule_size) {
+				DPAA2_PMD_ERR("%s: %s < %s, but %s + %s > %s",
+					__func__, offset_info, rule_size_info,
+					offset_info, size_info, rule_size_info);
+				return -EINVAL;
+			}
+		}
 	}
 
 	return 0;
@@ -1602,6 +1652,7 @@ dpaa2_flow_raw_rule_data_set(struct dpaa2_dev_flow *flow,
 	int extract_size = size > DPAA2_FLOW_MAX_KEY_SIZE ?
 		DPAA2_FLOW_MAX_KEY_SIZE : size;
 	int offset, field;
+	char offset_info[64], size_info[64], rule_size_info[64];
 
 	field = extract_offset << DPAA2_FLOW_RAW_OFFSET_FIELD_SHIFT;
 	field |= extract_size;
@@ -1612,17 +1663,37 @@ dpaa2_flow_raw_rule_data_set(struct dpaa2_dev_flow *flow,
 			extract_offset, size);
 		return -EINVAL;
 	}
+	sprintf(offset_info, "offset(%d)", offset);
+	sprintf(size_info, "size(%d)", size);
 
 	if (dist_type & DPAA2_FLOW_QOS_TYPE) {
+		sprintf(rule_size_info, "qos rule size(%d)",
+			flow->qos_rule_size);
 		memcpy((flow->qos_key_addr + offset), key, size);
 		memcpy((flow->qos_mask_addr + offset), mask, size);
-		flow->qos_rule_size = offset + size;
+		if (offset >= flow->qos_rule_size) {
+			flow->qos_rule_size = offset + size;
+		} else if ((offset + size) > flow->qos_rule_size) {
+			DPAA2_PMD_ERR("%s: %s < %s, but %s + %s > %s",
+				__func__, offset_info, rule_size_info,
+				offset_info, size_info, rule_size_info);
+			return -EINVAL;
+		}
 	}
 
 	if (dist_type & DPAA2_FLOW_FS_TYPE) {
+		sprintf(rule_size_info, "fs rule size(%d)",
+			flow->fs_rule_size);
 		memcpy((flow->fs_key_addr + offset), key, size);
 		memcpy((flow->fs_mask_addr + offset), mask, size);
-		flow->fs_rule_size = offset + size;
+		if (offset >= flow->fs_rule_size) {
+			flow->fs_rule_size = offset + size;
+		} else if ((offset + size) > flow->fs_rule_size) {
+			DPAA2_PMD_ERR("%s: %s < %s, but %s + %s > %s",
+				__func__, offset_info, rule_size_info,
+				offset_info, size_info, rule_size_info);
+			return -EINVAL;
+		}
 	}
 
 	return 0;
-- 
2.43.0

