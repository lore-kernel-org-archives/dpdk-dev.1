Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D6B3606A32C
	for <dpdk-dev@archiver.kernel.org>; Wed,  4 Nov 2026 12:40:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=h-partners.com header.i=@h-partners.com header.a=rsa-sha256 header.s=dkim header.b=W1jl3GUr
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 96CAA40281;
	Wed,  4 Nov 2026 13:40:48 +0100 (CET)
Received: from canpmsgout02.his.huawei.com (canpmsgout02.his.huawei.com
 [113.46.200.217])
 by mails.dpdk.org (Postfix) with ESMTPS id 770624025A;
 Wed,  4 Nov 2026 13:40:46 +0100 (CET)
dkim-signature: v=1; a=rsa-sha256; d=h-partners.com; s=dkim;
 c=relaxed/relaxed; q=dns/txt; h=From;
 bh=YynSg1AUrzOprr/iE1Ss9kcythZ30/nQw2L1mLVNQdY=;
 b=W1jl3GUrm/NGMutDhn31jo08rLeAeWtb7+Q7qiFBPT4/kELtBLiRol/Z43fkJXBGa9roLg0qv
 NWc6eajJQNa+vKbF8XV8SH3aGq+Rk9BqX/qCr5Dtqy1+ylztbWtiPMR2a+K+8dXSB9/KorY/LST
 w2HbBJdCLs/VjkgwO4hB5hY=
Received: from mail.maildlp.com (unknown [172.19.162.144])
 by canpmsgout02.his.huawei.com (SkyGuard) with ESMTPS id 4jKQ5C2Ks2zcb0K;
 Wed,  4 Nov 2026 20:40:15 +0800 (CST)
Received: from dggpemr100003.china.huawei.com (unknown [7.185.36.150])
 by mail.maildlp.com (Postfix) with ESMTPS id 5443440538;
 Wed,  4 Nov 2026 20:40:42 +0800 (CST)
Received: from localhost.localdomain (10.50.163.32) by
 dggpemr100003.china.huawei.com (7.185.36.150) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46; Wed, 4 Nov 2026 20:40:41 +0800
From: Shuaisong Yang <yangshuaisong@h-partners.com>
To: Xingui Yang <yangxingui@huawei.com>, Chengwen Feng
 <fengchengwen@huawei.com>, Hao Chen <chenh@yusur.tech>, "Min Hu (Connor)"
 <humin29@huawei.com>, "Wei Hu (Xavier)" <xavier.huwei@huawei.com>, Chunsong
 Feng <fengchunsong@huawei.com>, Ferruh Yigit <ferruh.yigit@amd.com>
CC: <dev@dpdk.org>, <stable@dpdk.org>, <yangshuaisong@h-partners.com>,
 <liuyonglong@huawei.com>
Subject: [PATCH] net/hns3: fix hard-coded default value of UMV space
Date: Wed, 4 Nov 2026 20:40:33 +0800
Message-ID: <20261104124033.3373452-1-yangshuaisong@h-partners.com>
X-Mailer: git-send-email 2.33.0
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: kwepems500002.china.huawei.com (7.221.188.17) To
 dggpemr100003.china.huawei.com (7.185.36.150)
X-BeenThere: dev@dpdk.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: DPDK patches and discussions <dev.dpdk.org>
List-Archive: <http://mails.dpdk.org/archives/dev/>
List-Post: <mailto:dev@dpdk.org>
List-Help: <mailto:dev-request@dpdk.org?subject=help>
List-Subscribe: <https://mails.dpdk.org/listinfo/dev>,
 <mailto:dev-request@dpdk.org?subject=subscribe>
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Currently, the driver obtains the PF's UMV (unicast MAC VLAN) table
space from the board configuration, and falls back to the hard-coded
default value HNS3_DEFAULT_UMV_SPACE_PER_PF (384 = 3072 / 8) when
the firmware reports an empty umv_space field.

The hard-coded value is only accurate for chips with a 3072-entry UMV
table. On chips whose total UMV table size is smaller than 3072, every
PF still requests 384 entries: the first initialized PF occupies the
whole table while the others get nothing, which makes adding unicast
MAC or VLAN entries fail on those ports.

Fix this by obtaining the UMV size from the device specifications
command, whose umv_size field is the default value allocated by the
firmware policy. The requested size is determined at allocation time
in hns3_init_umv_space(), in the following priority:
  1. pf->cfg_umv_size, the user specified value from the board
     configuration
  2. pf->def_umv_size, the default value reported by the firmware
  3. the hard-coded default, as the last fallback for old firmware

Fixes: d51867db65 ("net/hns3: add initialization")
Cc: stable@dpdk.org

Signed-off-by: Shuaisong Yang <yangshuaisong@h-partners.com>
---
 drivers/net/hns3/hns3_cmd.h    |  6 ++++--
 drivers/net/hns3/hns3_common.c |  1 +
 drivers/net/hns3/hns3_ethdev.c | 19 ++++++++++++-------
 drivers/net/hns3/hns3_ethdev.h |  3 ++-
 4 files changed, 19 insertions(+), 10 deletions(-)

diff --git a/drivers/net/hns3/hns3_cmd.h b/drivers/net/hns3/hns3_cmd.h
index 2a2ec155ea..473c4f1ec4 100644
--- a/drivers/net/hns3/hns3_cmd.h
+++ b/drivers/net/hns3/hns3_cmd.h
@@ -1008,9 +1008,11 @@ struct hns3_dev_specs_0_cmd {
 };
 
 struct hns3_dev_specs_1_cmd {
-	uint8_t rsv0[12];
+	uint8_t rsv0[8];
+	uint16_t umv_size;
+	uint8_t rsv1[2];
 	uint8_t min_tx_pkt_len;
-	uint8_t rsv1[11];
+	uint8_t rsv2[11];
 };
 
 struct hns3_query_rpu_cmd {
diff --git a/drivers/net/hns3/hns3_common.c b/drivers/net/hns3/hns3_common.c
index 5e6fbd1f97..a2384ca6c9 100644
--- a/drivers/net/hns3/hns3_common.c
+++ b/drivers/net/hns3/hns3_common.c
@@ -997,6 +997,7 @@ hns3_parse_dev_specifications(struct hns3_hw *hw, struct hns3_cmd_desc *desc)
 		return;
 
 	hw->max_tm_rate = rte_le_to_cpu_32(req0->max_tm_rate);
+	hns->pf.def_umv_size = rte_le_to_cpu_16(req1->umv_size);
 }
 
 static int
diff --git a/drivers/net/hns3/hns3_ethdev.c b/drivers/net/hns3/hns3_ethdev.c
index 8a898422b1..e45e0d2b16 100644
--- a/drivers/net/hns3/hns3_ethdev.c
+++ b/drivers/net/hns3/hns3_ethdev.c
@@ -1330,19 +1330,26 @@ hns3_init_umv_space(struct hns3_hw *hw)
 	struct hns3_adapter *hns = HNS3_DEV_HW_TO_ADAPTER(hw);
 	struct hns3_pf *pf = &hns->pf;
 	uint16_t allocated_size = 0;
+	uint16_t wanted_umv_size;
 	int ret;
 
-	ret = hns3_set_umv_space(hw, pf->wanted_umv_size, &allocated_size,
+	wanted_umv_size = pf->cfg_umv_size;
+	if (wanted_umv_size == 0)
+		wanted_umv_size = pf->def_umv_size;
+	if (wanted_umv_size == 0)
+		wanted_umv_size = HNS3_DEFAULT_UMV_SPACE_PER_PF;
+
+	ret = hns3_set_umv_space(hw, wanted_umv_size, &allocated_size,
 				 true);
 	if (ret)
 		return ret;
 
-	if (allocated_size < pf->wanted_umv_size)
+	if (allocated_size < wanted_umv_size)
 		PMD_INIT_LOG(WARNING, "Alloc umv space failed, want %u, get %u",
-			     pf->wanted_umv_size, allocated_size);
+			     wanted_umv_size, allocated_size);
 
 	pf->max_umv_size = (!!allocated_size) ? allocated_size :
-						pf->wanted_umv_size;
+						wanted_umv_size;
 	pf->used_umv_size = 0;
 	return 0;
 }
@@ -2560,8 +2567,6 @@ hns3_parse_cfg(struct hns3_cfg *cfg, struct hns3_cmd_desc *desc)
 	cfg->umv_space = hns3_get_field(rte_le_to_cpu_32(req->param[1]),
 					HNS3_CFG_UMV_TBL_SPACE_M,
 					HNS3_CFG_UMV_TBL_SPACE_S);
-	if (!cfg->umv_space)
-		cfg->umv_space = HNS3_DEFAULT_UMV_SPACE_PER_PF;
 
 	ext_rss_size_max = hns3_get_field(rte_le_to_cpu_32(req->param[2]),
 					       HNS3_CFG_EXT_RSS_SIZE_M,
@@ -2792,7 +2797,7 @@ hns3_get_board_configuration(struct hns3_hw *hw)
 	hns3_set_bit(hw->dcb_info.hw_tc_map, 0, 1);
 	pf->tx_sch_mode = HNS3_FLAG_TC_BASE_SCH_MODE;
 
-	pf->wanted_umv_size = cfg.umv_space;
+	pf->cfg_umv_size = cfg.umv_space;
 
 	return ret;
 }
diff --git a/drivers/net/hns3/hns3_ethdev.h b/drivers/net/hns3/hns3_ethdev.h
index fb1a3795cf..4df83e88eb 100644
--- a/drivers/net/hns3/hns3_ethdev.h
+++ b/drivers/net/hns3/hns3_ethdev.h
@@ -841,7 +841,8 @@ struct hns3_pf {
 	bool support_fc_autoneg;       /* support FC autonegotiate */
 	bool support_multi_tc_pause;
 
-	uint16_t wanted_umv_size;
+	uint16_t cfg_umv_size;
+	uint16_t def_umv_size;
 	uint16_t max_umv_size;
 	uint16_t used_umv_size;
 
-- 
2.33.0

