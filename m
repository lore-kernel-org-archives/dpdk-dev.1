Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5A1BAC87FCF
	for <dpdk-dev@archiver.kernel.org>; Wed, 13 Aug 2025 07:33:39 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id AEC8E40B8C;
	Wed, 13 Aug 2025 09:33:25 +0200 (CEST)
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
 by mails.dpdk.org (Postfix) with ESMTP id E191440658
 for <dev@dpdk.org>; Wed, 13 Aug 2025 09:33:20 +0200 (CEST)
Received: from mail.maildlp.com (unknown [172.19.163.174])
 by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4c20Pt6B59z13N7d;
 Wed, 13 Aug 2025 15:29:54 +0800 (CST)
Received: from kwepemo500011.china.huawei.com (unknown [7.202.195.194])
 by mail.maildlp.com (Postfix) with ESMTPS id ECF7A1401F1;
 Wed, 13 Aug 2025 15:33:18 +0800 (CST)
Received: from localhost.localdomain (10.50.165.33) by
 kwepemo500011.china.huawei.com (7.202.195.194) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Wed, 13 Aug 2025 15:33:18 +0800
From: Dengdui Huang <huangdengdui@huawei.com>
To: <dev@dpdk.org>
CC: <stephen@networkplumber.org>, <lihuisong@huawei.com>,
 <fengchengwen@huawei.com>, <liuyonglong@huawei.com>
Subject: [PATCH 2/3] net/hns3: fix unrelease VLAN resource when init fail
Date: Wed, 13 Aug 2025 15:33:16 +0800
Message-ID: <20250813073317.1352274-3-huangdengdui@huawei.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20250813073317.1352274-1-huangdengdui@huawei.com>
References: <20250813073317.1352274-1-huangdengdui@huawei.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.50.165.33]
X-ClientProxiedBy: kwepems200002.china.huawei.com (7.221.188.68) To
 kwepemo500011.china.huawei.com (7.202.195.194)
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

In the initialization process, it is necessary to release VLAN resources
on the failure branch.

Additionally, encapsulate a function hns3_uninit_hardware() to release
the resources allocated by the hns3_init_hardware() function.

Fixes: 411d23b9eafb ("net/hns3: support VLAN")
Cc: stable@dpdk.org

Signed-off-by: Dengdui Huang <huangdengdui@huawei.com>
---
 drivers/net/hns3/hns3_ethdev.c | 31 ++++++++++++++++++++-----------
 1 file changed, 20 insertions(+), 11 deletions(-)

diff --git a/drivers/net/hns3/hns3_ethdev.c b/drivers/net/hns3/hns3_ethdev.c
index a809a47423..b2eab7e1c5 100644
--- a/drivers/net/hns3/hns3_ethdev.c
+++ b/drivers/net/hns3/hns3_ethdev.c
@@ -4366,25 +4366,25 @@ hns3_init_hardware(struct hns3_adapter *hns)
 	ret = hns3_dcb_init(hw);
 	if (ret) {
 		PMD_INIT_LOG(ERR, "Failed to init dcb: %d", ret);
-		goto err_mac_init;
+		goto rm_vlan_table;
 	}
 
 	ret = hns3_init_fd_config(hns);
 	if (ret) {
 		PMD_INIT_LOG(ERR, "Failed to init flow director: %d", ret);
-		goto err_mac_init;
+		goto rm_vlan_table;
 	}
 
 	ret = hns3_config_tso(hw, HNS3_TSO_MSS_MIN, HNS3_TSO_MSS_MAX);
 	if (ret) {
 		PMD_INIT_LOG(ERR, "Failed to config tso: %d", ret);
-		goto err_mac_init;
+		goto rm_vlan_table;
 	}
 
 	ret = hns3_config_gro(hw, false);
 	if (ret) {
 		PMD_INIT_LOG(ERR, "Failed to config gro: %d", ret);
-		goto err_mac_init;
+		goto rm_vlan_table;
 	}
 
 	/*
@@ -4396,22 +4396,33 @@ hns3_init_hardware(struct hns3_adapter *hns)
 	ret = hns3_init_ring_with_vector(hw);
 	if (ret) {
 		PMD_INIT_LOG(ERR, "Failed to init ring intr vector: %d", ret);
-		goto err_mac_init;
+		goto rm_vlan_table;
 	}
 
 	ret = hns3_ptp_init(hw);
 	if (ret) {
 		PMD_INIT_LOG(ERR, "Failed to init PTP, ret = %d", ret);
-		goto err_mac_init;
+		goto rm_vlan_table;
 	}
 
 	return 0;
-
+rm_vlan_table:
+	hns3_rm_all_vlan_table(hns, true);
 err_mac_init:
 	hns3_uninit_umv_space(hw);
 	return ret;
 }
 
+static void
+hns3_uninit_hardware(struct hns3_hw *hw)
+{
+	struct hns3_adapter *hns = HNS3_DEV_HW_TO_ADAPTER(hw);
+
+	(void)hns3_uninit_umv_space(hw);
+	hns3_ptp_uninit(hw);
+	hns3_rm_all_vlan_table(hns, true);
+}
+
 static int
 hns3_clear_hw(struct hns3_hw *hw)
 {
@@ -4623,8 +4634,7 @@ hns3_init_pf(struct rte_eth_dev *eth_dev)
 err_enable_intr:
 	hns3_fdir_filter_uninit(hns);
 err_fdir:
-	hns3_uninit_umv_space(hw);
-	hns3_ptp_uninit(hw);
+	hns3_uninit_hardware(hw);
 err_init_hw:
 	hns3_stats_uninit(hw);
 err_get_config:
@@ -4659,8 +4669,7 @@ hns3_uninit_pf(struct rte_eth_dev *eth_dev)
 	hns3_promisc_uninit(hw);
 	hns3_flow_uninit(eth_dev);
 	hns3_fdir_filter_uninit(hns);
-	hns3_uninit_umv_space(hw);
-	hns3_ptp_uninit(hw);
+	hns3_uninit_hardware(hw);
 	hns3_stats_uninit(hw);
 	hns3_config_mac_tnl_int(hw, false);
 	hns3_pf_disable_irq0(hw);
-- 
2.33.0

