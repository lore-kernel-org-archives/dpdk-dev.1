Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5E0FEC98302
	for <dpdk-dev@archiver.kernel.org>; Wed, 23 Sep 2026 01:08:32 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 0059842ED0;
	Wed, 23 Sep 2026 03:08:00 +0200 (CEST)
Received: from mail-pl1-f197.google.com (mail-pl1-f197.google.com
 [209.85.214.197])
 by mails.dpdk.org (Postfix) with ESMTP id 7FEAB42EB6
 for <dev@dpdk.org>; Wed, 23 Sep 2026 03:07:57 +0200 (CEST)
Received: by mail-pl1-f197.google.com with SMTP id
 d9443c01a7336-2db87f759c5so4189515ad.1
 for <dev@dpdk.org>; Tue, 22 Sep 2026 18:07:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=google.com; s=20251104; t=1790125677; x=1790730477; darn=dpdk.org;
 h=content-type:cc:to:from:subject:message-id:references:mime-version
 :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=8vj1uu0yjM7gxNI4rCoS797GBsJ2f4dbdKwVruHchUA=;
 b=vgpVPBttBtfk8mNG+FKNq8bpASmrho3eAROZabqpfpguqfGd2i23NzwinRZTDiYVuV
 eKEB+MwDEi34ns5RJFvQPCP59W2+tExSBu4UshkwDxviI/NAg7RX9bZaofBc6EHDiDEE
 5YbU9rYbfpOZ5rHvn7KtHJJO+7qDhf+WVPkOI3+qL0tXjJYPdwnNDD4GNa/Gc/YUaMwv
 lEM3bV84jvgJGurzdsWsD+ICq0IewnQ8DfmEFta0erE2ew4YY0IutPTVwXRZEJsGBTl1
 zgqwcZ9eZqaFxMlSd1iNU3xSsUjP67Xq66GhiFXqXig6xD3bwgl6PYWYFUNZ+eknjSp5
 lTIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790125677; x=1790730477;
 h=content-type:cc:to:from:subject:message-id:references:mime-version
 :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=8vj1uu0yjM7gxNI4rCoS797GBsJ2f4dbdKwVruHchUA=;
 b=GikKJYOchcnyAW/tOX7/rePoOXBizvzFiPEymscNtE7f3UQSLbpecBOkc1t19RTkNC
 IO9dFHnbjlDkLy2gxn1idGAE6mAVJxk5kbizU6l8K0IpRWanFt7WiP3rI9pL4eRNk3Fx
 3ZpujlYp4dB/1Wi7XZqSb8kF0NBTviZRwE4bPacXdCxh/LfsDLDuf7zm59p7fEe/HdLa
 NNkt/GJfPpEStZhA+kvYi7a3V42enlikcTlGfP52YTFU6dWuLf4zJLpEThTSLRVwZZkn
 tXQCxsdeAOCowQLGAwXHPHybl2lN/7Wg3H0dX+P9zRXRQ66TKUI0EV0Nhw5jk9TG+TzW
 qo4Q==
X-Gm-Message-State: AFuF++mROpz2Y4RW/K+VJAcVHG2uOhHWcqj0ZaekbV775JcW/K8zvuIs
 PJnbyQZ/8RMsvCuYdBMnN+BXSOSsQ0AvJB8GwjcV2o+abus9NsV8fVJEbhreWkQg4s7Y2aMyQdW
 id34qJXOB7Myf3A==
X-Received: from ploc2.prod.google.com ([2002:a17:902:8482:b0:2dd:53b8:ff02])
 (user=joshwash job=prod-delivery.src-stubby-dispatcher) by
 2002:a17:902:c943:b0:2dd:c100:b2c5 with SMTP id
 d9443c01a7336-2df69e023eemr10307775ad.48.1790125676218; 
 Tue, 22 Sep 2026 18:07:56 -0700 (PDT)
Date: Tue, 22 Sep 2026 18:07:30 -0700
In-Reply-To: <20260923010742.2468145-1-joshwash@google.com>
Mime-Version: 1.0
References: <20260812223017.2980190-1-joshwash@google.com>
 <20260923010742.2468145-1-joshwash@google.com>
X-Mailer: git-send-email 2.55.0.1082.g2b9226bbc0-goog
Message-ID: <20260923010742.2468145-8-joshwash@google.com>
Subject: [PATCH v3 07/16] net/hns3: use common division round up macro
From: Joshua Washington <joshwash@google.com>
To: Xingui Yang <yangxingui@huawei.com>,
 Chengwen Feng <fengchengwen@huawei.com>
Cc: dev@dpdk.org, Joshua Washington <joshwash@google.com>, 
 Stephen Hemminger <stephen@networkplumber.org>
Content-Type: text/plain; charset="UTF-8"
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

The RTE_DIV_ROUND_UP in rte_common.h makes DIV_ROUND_UP redundant.

Signed-off-by: Joshua Washington <joshwash@google.com>
Reviewed-by: Stephen Hemminger <stephen@networkplumber.org>
---
 drivers/net/hns3/hns3_ethdev.h | 2 --
 drivers/net/hns3/hns3_fdir.c   | 2 +-
 drivers/net/hns3/hns3_regs.c   | 8 ++++----
 drivers/net/hns3/hns3_rss.c    | 8 ++++----
 4 files changed, 9 insertions(+), 11 deletions(-)

diff --git a/drivers/net/hns3/hns3_ethdev.h b/drivers/net/hns3/hns3_ethdev.h
index 209b042816..b4feff4b94 100644
--- a/drivers/net/hns3/hns3_ethdev.h
+++ b/drivers/net/hns3/hns3_ethdev.h
@@ -978,8 +978,6 @@ static inline struct hns3_vf *HNS3_DEV_HW_TO_VF(struct hns3_hw *hw)
 #define roundup(x, y) ((((x) + ((y) - 1)) / (y)) * (y))
 #define rounddown(x, y) ((x) - ((x) % (y)))
 
-#define DIV_ROUND_UP(n, d) (((n) + (d) - 1) / (d))
-
 /*
  * Because hardware always access register in little-endian mode based on hns3
  * network engine, so driver should also call rte_cpu_to_le_32 to convert data
diff --git a/drivers/net/hns3/hns3_fdir.c b/drivers/net/hns3/hns3_fdir.c
index 50572ae430..dfcc5c0d99 100644
--- a/drivers/net/hns3/hns3_fdir.c
+++ b/drivers/net/hns3/hns3_fdir.c
@@ -129,7 +129,7 @@ static const struct key_info tuple_key_info[] = {
 #define MAX_KEY_LENGTH		400
 #define MAX_200B_KEY_LENGTH	200
 #define MAX_META_DATA_LENGTH	16
-#define MAX_KEY_DWORDS	DIV_ROUND_UP(MAX_KEY_LENGTH / HNS3_BITS_PER_BYTE, 4)
+#define MAX_KEY_DWORDS	RTE_DIV_ROUND_UP(MAX_KEY_LENGTH / HNS3_BITS_PER_BYTE, 4)
 #define MAX_KEY_BYTES	(MAX_KEY_DWORDS * 4)
 
 enum HNS3_FD_PACKET_TYPE {
diff --git a/drivers/net/hns3/hns3_regs.c b/drivers/net/hns3/hns3_regs.c
index 5c74f9ae2e..066b836556 100644
--- a/drivers/net/hns3/hns3_regs.c
+++ b/drivers/net/hns3/hns3_regs.c
@@ -1034,8 +1034,8 @@ hns3_get_32_bit_regs(struct hns3_hw *hw, uint32_t regs_num, struct rte_dev_reg_i
 	if (regs_num == 0)
 		return 0;
 
-	cmd_num = DIV_ROUND_UP(regs_num + HNS3_32_BIT_DESC_NODATA_LEN,
-			       HNS3_32_BIT_REG_RTN_DATANUM);
+	cmd_num = RTE_DIV_ROUND_UP(regs_num + HNS3_32_BIT_DESC_NODATA_LEN,
+				   HNS3_32_BIT_REG_RTN_DATANUM);
 	desc = rte_zmalloc("hns3-32bit-regs",
 			   sizeof(struct hns3_cmd_desc) * cmd_num, 0);
 	if (desc == NULL) {
@@ -1093,8 +1093,8 @@ hns3_get_64_bit_regs(struct hns3_hw *hw, uint32_t regs_num, struct rte_dev_reg_i
 	if (regs_num == 0)
 		return 0;
 
-	cmd_num = DIV_ROUND_UP(regs_num + HNS3_64_BIT_DESC_NODATA_LEN,
-			       HNS3_64_BIT_REG_RTN_DATANUM);
+	cmd_num = RTE_DIV_ROUND_UP(regs_num + HNS3_64_BIT_DESC_NODATA_LEN,
+				   HNS3_64_BIT_REG_RTN_DATANUM);
 	desc = rte_zmalloc("hns3-64bit-regs",
 			   sizeof(struct hns3_cmd_desc) * cmd_num, 0);
 	if (desc == NULL) {
diff --git a/drivers/net/hns3/hns3_rss.c b/drivers/net/hns3/hns3_rss.c
index 508b3e26d0..6cb8d9482d 100644
--- a/drivers/net/hns3/hns3_rss.c
+++ b/drivers/net/hns3/hns3_rss.c
@@ -295,7 +295,7 @@ hns3_rss_set_algo_key(struct hns3_hw *hw, uint8_t hash_algo,
 
 	req = (struct hns3_rss_generic_config_cmd *)desc.data;
 
-	max_bd_num = DIV_ROUND_UP(key_len, HNS3_RSS_HASH_KEY_NUM);
+	max_bd_num = RTE_DIV_ROUND_UP(key_len, HNS3_RSS_HASH_KEY_NUM);
 	for (idx = 0; idx < max_bd_num; idx++) {
 		hns3_cmd_setup_basic_desc(&desc, HNS3_OPC_RSS_GENERIC_CONFIG,
 					  false);
@@ -335,7 +335,7 @@ hns3_rss_get_algo_key(struct hns3_hw *hw,  uint8_t *hash_algo,
 	int ret;
 
 	req = (struct hns3_rss_generic_config_cmd *)desc.data;
-	max_bd_num = DIV_ROUND_UP(key_len, HNS3_RSS_HASH_KEY_NUM);
+	max_bd_num = RTE_DIV_ROUND_UP(key_len, HNS3_RSS_HASH_KEY_NUM);
 	for (idx = 0; idx < max_bd_num; idx++) {
 		hns3_cmd_setup_basic_desc(&desc, HNS3_OPC_RSS_GENERIC_CONFIG,
 					  true);
@@ -381,7 +381,7 @@ hns3_set_rss_indir_table(struct hns3_hw *hw, uint16_t *indir, uint16_t size)
 	int ret;
 
 	req = (struct hns3_rss_indirection_table_cmd *)desc.data;
-	max_bd_num = DIV_ROUND_UP(size, HNS3_RSS_CFG_TBL_SIZE);
+	max_bd_num = RTE_DIV_ROUND_UP(size, HNS3_RSS_CFG_TBL_SIZE);
 	for (i = 0; i < max_bd_num; i++) {
 		hns3_cmd_setup_basic_desc(&desc, HNS3_OPC_RSS_INDIR_TABLE,
 					  false);
@@ -431,7 +431,7 @@ hns3_get_rss_indir_table(struct hns3_hw *hw, uint16_t *indir, uint16_t size)
 	int ret;
 
 	req = (struct hns3_rss_indirection_table_cmd *)desc.data;
-	max_bd_num = DIV_ROUND_UP(size, HNS3_RSS_CFG_TBL_SIZE);
+	max_bd_num = RTE_DIV_ROUND_UP(size, HNS3_RSS_CFG_TBL_SIZE);
 	for (i = 0; i < max_bd_num; i++) {
 		hns3_cmd_setup_basic_desc(&desc, HNS3_OPC_RSS_INDIR_TABLE,
 					  true);
-- 
2.55.0.1082.g2b9226bbc0-goog

