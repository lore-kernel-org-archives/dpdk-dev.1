Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 769DCCA5FF0
	for <dpdk-dev@archiver.kernel.org>; Tue,  6 Oct 2026 02:31:40 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id F1C6B40E4C;
	Tue,  6 Oct 2026 04:31:11 +0200 (CEST)
Received: from mail-pl1-f198.google.com (mail-pl1-f198.google.com
 [209.85.214.198])
 by mails.dpdk.org (Postfix) with ESMTP id 10F0D40E5A
 for <dev@dpdk.org>; Tue,  6 Oct 2026 04:31:10 +0200 (CEST)
Received: by mail-pl1-f198.google.com with SMTP id
 d9443c01a7336-2dfb24dfedfso21953095ad.2
 for <dev@dpdk.org>; Mon, 05 Oct 2026 19:31:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=google.com; s=20251104; t=1791253869; x=1791858669; darn=dpdk.org;
 h=content-type:cc:to:from:subject:message-id:references:mime-version
 :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=w69Eoq1bbJjZoIRvzFau4x/gu3Zpl4q9sdp+8dz3k0w=;
 b=HlbMF+/5E4skGDJmfdq5KdchJGcDzze0GNiI54Ik3HSAeomRdX9gwiYp5tMQsHWfwW
 NR6qF/XPrlUFm7o5Fmx6LQyz3YkblzxnNKifVhV9BhVbaeqSX5VG5aoFGc/sOEnQ27Sl
 18oLASIuP4egaHpZwzaOUZ/DRZBUueoNoOz36SkIzjXnTR6LJCwuqb2gU7sb2+8pJoci
 Zf61zhs/xITMahUy6QesK/tq6sZBgZkPjPM38QoZ/w02cLVrbss7EBQP4JRIaHpB7W3m
 fQCETz4Lye/gkrs73JVvOaE6upjCuzCZ+0dFnxeBb8yz2LaevfKuHKWCzi8i5xLPaVAY
 hu2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791253869; x=1791858669;
 h=content-type:cc:to:from:subject:message-id:references:mime-version
 :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=w69Eoq1bbJjZoIRvzFau4x/gu3Zpl4q9sdp+8dz3k0w=;
 b=FGqD41Lk5cPVuaEzaZciU/jWcD1S7Ebh33luKMb/zWBnsXtH45W6wFsMRcp9vntD+f
 zR30/kWNDtwZv21BFWH2ii/E2gAo005wIoS+zwnDNI+xIYXdffEf7OC5t6uMoTtqLDp0
 IsJ80a/gY6tab5JsJmsGQkCdTPLEt0BOdnucylp2HzGnBw6K8JQ1hMJWRWld9rcNGjv9
 kt6pJeXcMbAqH371btN7yMUCrnFGiU3e1En/HoTmdEkJ9np2f2ETEq9jEuP4GQZlirwJ
 j0OUeRb06FDp7wwUuvS8XxD3hiOkFkhsF1CgitVGD8pe/4sp4O16GfIyiNSg7Dd+dHc1
 jd9A==
X-Gm-Message-State: AFq9FYKd7bKyBe8XIjHURs4B2rK1pVaU5/SmpsZWnQrcfh950otL0VVh
 OBXQKsbdKAv1uUhl6D+YD8GO5k6/76qM1WfR6E4WYtCRbAjI5CzpAzQbbC4zi8q2fI0he68M9Vp
 3OUXkiXZeVlRh5g==
X-Received: from plbd7.prod.google.com ([2002:a17:902:f147:b0:2e3:cf6:2b17])
 (user=joshwash job=prod-delivery.src-stubby-dispatcher) by
 2002:a17:902:db0c:b0:2df:9244:fcb6 with SMTP id
 d9443c01a7336-2e5dccf81d8mr773915ad.4.1791253868869; 
 Mon, 05 Oct 2026 19:31:08 -0700 (PDT)
Date: Mon,  5 Oct 2026 19:30:43 -0700
In-Reply-To: <20261006023053.2572501-1-joshwash@google.com>
Mime-Version: 1.0
References: <20260923010742.2468145-1-joshwash@google.com>
 <20261006023053.2572501-1-joshwash@google.com>
X-Mailer: git-send-email 2.56.0.rc1.315.gc6ed9934b7-goog
Message-ID: <20261006023053.2572501-8-joshwash@google.com>
Subject: [PATCH v4 07/15] net/hns3: use common division round up macro
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
Acked-by: Chengwen Feng <fengchengwen@huawei.com>
Reviewed-by: Stephen Hemminger <stephen@networkplumber.org>
---
Changes in v4:
  - Add rte_common.h includes.
---
 drivers/net/hns3/hns3_ethdev.h | 2 --
 drivers/net/hns3/hns3_fdir.c   | 3 ++-
 drivers/net/hns3/hns3_regs.c   | 9 +++++----
 drivers/net/hns3/hns3_rss.c    | 9 +++++----
 4 files changed, 12 insertions(+), 11 deletions(-)

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
index 50572ae430..0096aa21e9 100644
--- a/drivers/net/hns3/hns3_fdir.c
+++ b/drivers/net/hns3/hns3_fdir.c
@@ -7,6 +7,7 @@
 #include <rte_hash_crc.h>
 #include <rte_io.h>
 #include <rte_malloc.h>
+#include <rte_common.h>
 
 #include "hns3_ethdev.h"
 #include "hns3_logs.h"
@@ -129,7 +130,7 @@ static const struct key_info tuple_key_info[] = {
 #define MAX_KEY_LENGTH		400
 #define MAX_200B_KEY_LENGTH	200
 #define MAX_META_DATA_LENGTH	16
-#define MAX_KEY_DWORDS	DIV_ROUND_UP(MAX_KEY_LENGTH / HNS3_BITS_PER_BYTE, 4)
+#define MAX_KEY_DWORDS	RTE_DIV_ROUND_UP(MAX_KEY_LENGTH / HNS3_BITS_PER_BYTE, 4)
 #define MAX_KEY_BYTES	(MAX_KEY_DWORDS * 4)
 
 enum HNS3_FD_PACKET_TYPE {
diff --git a/drivers/net/hns3/hns3_regs.c b/drivers/net/hns3/hns3_regs.c
index 5c74f9ae2e..2bf0baa5c1 100644
--- a/drivers/net/hns3/hns3_regs.c
+++ b/drivers/net/hns3/hns3_regs.c
@@ -4,6 +4,7 @@
 
 #include <ethdev_pci.h>
 #include <rte_io.h>
+#include <rte_common.h>
 
 #include "hns3_ethdev.h"
 #include "hns3_logs.h"
@@ -1034,8 +1035,8 @@ hns3_get_32_bit_regs(struct hns3_hw *hw, uint32_t regs_num, struct rte_dev_reg_i
 	if (regs_num == 0)
 		return 0;
 
-	cmd_num = DIV_ROUND_UP(regs_num + HNS3_32_BIT_DESC_NODATA_LEN,
-			       HNS3_32_BIT_REG_RTN_DATANUM);
+	cmd_num = RTE_DIV_ROUND_UP(regs_num + HNS3_32_BIT_DESC_NODATA_LEN,
+				   HNS3_32_BIT_REG_RTN_DATANUM);
 	desc = rte_zmalloc("hns3-32bit-regs",
 			   sizeof(struct hns3_cmd_desc) * cmd_num, 0);
 	if (desc == NULL) {
@@ -1093,8 +1094,8 @@ hns3_get_64_bit_regs(struct hns3_hw *hw, uint32_t regs_num, struct rte_dev_reg_i
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
index 508b3e26d0..080800d60a 100644
--- a/drivers/net/hns3/hns3_rss.c
+++ b/drivers/net/hns3/hns3_rss.c
@@ -5,6 +5,7 @@
 #include <rte_ethdev.h>
 #include <rte_io.h>
 #include <rte_malloc.h>
+#include <rte_common.h>
 
 #include "hns3_ethdev.h"
 #include "hns3_logs.h"
@@ -295,7 +296,7 @@ hns3_rss_set_algo_key(struct hns3_hw *hw, uint8_t hash_algo,
 
 	req = (struct hns3_rss_generic_config_cmd *)desc.data;
 
-	max_bd_num = DIV_ROUND_UP(key_len, HNS3_RSS_HASH_KEY_NUM);
+	max_bd_num = RTE_DIV_ROUND_UP(key_len, HNS3_RSS_HASH_KEY_NUM);
 	for (idx = 0; idx < max_bd_num; idx++) {
 		hns3_cmd_setup_basic_desc(&desc, HNS3_OPC_RSS_GENERIC_CONFIG,
 					  false);
@@ -335,7 +336,7 @@ hns3_rss_get_algo_key(struct hns3_hw *hw,  uint8_t *hash_algo,
 	int ret;
 
 	req = (struct hns3_rss_generic_config_cmd *)desc.data;
-	max_bd_num = DIV_ROUND_UP(key_len, HNS3_RSS_HASH_KEY_NUM);
+	max_bd_num = RTE_DIV_ROUND_UP(key_len, HNS3_RSS_HASH_KEY_NUM);
 	for (idx = 0; idx < max_bd_num; idx++) {
 		hns3_cmd_setup_basic_desc(&desc, HNS3_OPC_RSS_GENERIC_CONFIG,
 					  true);
@@ -381,7 +382,7 @@ hns3_set_rss_indir_table(struct hns3_hw *hw, uint16_t *indir, uint16_t size)
 	int ret;
 
 	req = (struct hns3_rss_indirection_table_cmd *)desc.data;
-	max_bd_num = DIV_ROUND_UP(size, HNS3_RSS_CFG_TBL_SIZE);
+	max_bd_num = RTE_DIV_ROUND_UP(size, HNS3_RSS_CFG_TBL_SIZE);
 	for (i = 0; i < max_bd_num; i++) {
 		hns3_cmd_setup_basic_desc(&desc, HNS3_OPC_RSS_INDIR_TABLE,
 					  false);
@@ -431,7 +432,7 @@ hns3_get_rss_indir_table(struct hns3_hw *hw, uint16_t *indir, uint16_t size)
 	int ret;
 
 	req = (struct hns3_rss_indirection_table_cmd *)desc.data;
-	max_bd_num = DIV_ROUND_UP(size, HNS3_RSS_CFG_TBL_SIZE);
+	max_bd_num = RTE_DIV_ROUND_UP(size, HNS3_RSS_CFG_TBL_SIZE);
 	for (i = 0; i < max_bd_num; i++) {
 		hns3_cmd_setup_basic_desc(&desc, HNS3_OPC_RSS_INDIR_TABLE,
 					  true);
-- 
2.56.0.rc1.315.gc6ed9934b7-goog

