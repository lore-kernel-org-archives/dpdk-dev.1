Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 10FD8C5B572
	for <dpdk-dev@archiver.kernel.org>; Thu, 13 Aug 2026 17:23:23 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 8AA9C42E53;
	Thu, 13 Aug 2026 19:23:03 +0200 (CEST)
Received: from mail-pf1-f200.google.com (mail-pf1-f200.google.com
 [209.85.210.200])
 by mails.dpdk.org (Postfix) with ESMTP id 450A942E4C
 for <dev@dpdk.org>; Thu, 13 Aug 2026 19:23:02 +0200 (CEST)
Received: by mail-pf1-f200.google.com with SMTP id
 d2e1a72fcca58-8484f26852dso2503961b3a.1
 for <dev@dpdk.org>; Thu, 13 Aug 2026 10:23:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=google.com; s=20251104; t=1786641781; x=1787246581; darn=dpdk.org;
 h=content-type:cc:to:from:subject:message-id:references:mime-version
 :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=ORS2u0TmuUpdj4rkT8u3RgOvKUPbW3hJI40zVmQvXeU=;
 b=mxB64bxoEC5kqlElcgSDsRnvdvZaaWt8zhiTpbkzPVVYAiC+q8XTnSXtcwhhAuJtpC
 PJcB2LqSwF+TaoDf+HtxQ2ovnoqb3AKJO1gMrsWgg6eer02+6tucffUG2JJHor/NylMB
 1ECIEbYB9rcIV9OthrMptxO/qJuH4w2cDGjSQdjyy1qGYucVXvAgoab+b5bojDu29iZO
 CRoAgbKXuli+uCVCRIDwLfh7HZZSoiQBzUxQyxzForSSaExRRtfh0BwrQHF8q/V10hBS
 gLnXL1k1bvlULxVASeGsK04PJf9Srg3XM/iI9ku6Hmwncs8lpPO+G40oNlqBRBphRxTU
 doCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786641781; x=1787246581;
 h=content-type:cc:to:from:subject:message-id:references:mime-version
 :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=ORS2u0TmuUpdj4rkT8u3RgOvKUPbW3hJI40zVmQvXeU=;
 b=rUcrmbsN3i+u4lg4jlybMFhw4mHvLjKxsphulivhRjN3lx6g68JVfj47hUNV0T/k4p
 EZtGgRWERsjd5G4RAX2iS7DUxBkZlyOt8YMrI6xVSTcJ9xZNqyNCaTIlAsSti+epCOlc
 DhG672GH7V65b3WoWtMo3Pdf/8cGyb4an2mqYRJdd+5AiWBrVAGReNfTOZJTTP5GHu1a
 moZqggqFSL0DULu+4J5LtWy5W7wzeu+dyIRJ8Q6sYY7B15L3SzY2Jwf4pWh/3UbIz1nS
 ItQp1FjLmNpmkiNJC+MhuPDBe5QDLimSPnztq7UA6dMNMhj2HtXkNmrpe2fvasGGY6Uq
 ZmtQ==
X-Gm-Message-State: AOJu0YwkVqR9bf/Iy+Nqt8DeDShXHq8VGxWB7FUxTJtj/mTtAV995i9P
 EcAy75mvk1xJ5kNew8/EB02K3xTd3zmqh7L9hoxik6ig/XIsvWv3A7ofD4hr9WYb1tJ5AEFrkyf
 62m5AWS1SOE1d1g==
X-Received: from pfbkq3.prod.google.com ([2002:a05:6a00:4b03:b0:848:5453:d5d1])
 (user=joshwash job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6a00:4385:b0:845:3fe5:cddd with SMTP id
 d2e1a72fcca58-84fc747f37emr8396713b3a.36.1786641781248; 
 Thu, 13 Aug 2026 10:23:01 -0700 (PDT)
Date: Thu, 13 Aug 2026 10:22:32 -0700
In-Reply-To: <20260813172241.964736-1-joshwash@google.com>
Mime-Version: 1.0
References: <20260812223017.2980190-1-joshwash@google.com>
 <20260813172241.964736-1-joshwash@google.com>
X-Mailer: git-send-email 2.55.0.691.gc56d675ccc-goog
Message-ID: <20260813172241.964736-8-joshwash@google.com>
Subject: [PATCH v2 07/14] net/hns3: use common division round up macro
From: Joshua Washington <joshwash@google.com>
To: Xingui Yang <yangxingui@huawei.com>,
 Chengwen Feng <fengchengwen@huawei.com>
Cc: dev@dpdk.org, Joshua Washington <joshwash@google.com>
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
2.55.0.691.gc56d675ccc-goog

