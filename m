Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1FDD8C8302F
	for <dpdk-dev@archiver.kernel.org>; Tue,  1 Jul 2025 06:45:56 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id C57B74067E;
	Tue,  1 Jul 2025 08:45:23 +0200 (CEST)
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
 by mails.dpdk.org (Postfix) with ESMTP id 172F6402EB
 for <dev@dpdk.org>; Tue,  1 Jul 2025 08:45:19 +0200 (CEST)
Received: from mail.maildlp.com (unknown [172.19.88.105])
 by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4bWYLq4fDlz14LsW;
 Tue,  1 Jul 2025 14:40:35 +0800 (CST)
Received: from kwepemo500011.china.huawei.com (unknown [7.202.195.194])
 by mail.maildlp.com (Postfix) with ESMTPS id 9967A1402CF;
 Tue,  1 Jul 2025 14:45:15 +0800 (CST)
Received: from localhost.localdomain (10.50.165.33) by
 kwepemo500011.china.huawei.com (7.202.195.194) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Tue, 1 Jul 2025 14:45:15 +0800
From: Dengdui Huang <huangdengdui@huawei.com>
To: <dev@dpdk.org>
CC: <stephen@networkplumber.org>, <fengchengwen@huawei.com>,
 <lihuisong@huawei.com>, <liuyonglong@huawei.com>
Subject: [PATCH v2 5/6] net/hns3: VF support discover multi-TCs capability
Date: Tue, 1 Jul 2025 14:45:11 +0800
Message-ID: <20250701064512.3868175-6-huangdengdui@huawei.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20250701064512.3868175-1-huangdengdui@huawei.com>
References: <20250611081900.3658421-1-huangdengdui@huawei.com>
 <20250701064512.3868175-1-huangdengdui@huawei.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.50.165.33]
X-ClientProxiedBy: kwepems100002.china.huawei.com (7.221.188.206) To
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

From: Chengwen Feng <fengchengwen@huawei.com>

The VF multi-TCs feature depends on firmware and PF driver, the
capability was set when:
1) Firmware report VF multi-TCs flag.
2) PF driver report VF multi-TCs flag.
3) PF driver support query multi-TCs info mailbox message.

Signed-off-by: Chengwen Feng <fengchengwen@huawei.com>
---
 drivers/net/hns3/hns3_cmd.c       |  5 ++++-
 drivers/net/hns3/hns3_cmd.h       |  2 ++
 drivers/net/hns3/hns3_dump.c      |  3 ++-
 drivers/net/hns3/hns3_ethdev.h    |  1 +
 drivers/net/hns3/hns3_ethdev_vf.c | 33 +++++++++++++++++++++++++++++++
 drivers/net/hns3/hns3_mbx.h       |  7 +++++++
 6 files changed, 49 insertions(+), 2 deletions(-)

diff --git a/drivers/net/hns3/hns3_cmd.c b/drivers/net/hns3/hns3_cmd.c
index 398b75384e..ad4ef9e189 100644
--- a/drivers/net/hns3/hns3_cmd.c
+++ b/drivers/net/hns3/hns3_cmd.c
@@ -482,7 +482,8 @@ static void
 hns3_parse_capability(struct hns3_hw *hw,
 		      struct hns3_query_version_cmd *cmd)
 {
-	uint32_t caps = rte_le_to_cpu_32(cmd->caps[0]);
+	uint64_t caps = ((uint64_t)rte_le_to_cpu_32(cmd->caps[1]) << 32) |
+			rte_le_to_cpu_32(cmd->caps[0]);
 
 	if (hns3_get_bit(caps, HNS3_CAPS_FD_QUEUE_REGION_B))
 		hns3_set_bit(hw->capability, HNS3_DEV_SUPPORT_FD_QUEUE_REGION_B,
@@ -524,6 +525,8 @@ hns3_parse_capability(struct hns3_hw *hw,
 		hns3_set_bit(hw->capability, HNS3_DEV_SUPPORT_FC_AUTO_B, 1);
 	if (hns3_get_bit(caps, HNS3_CAPS_GRO_B))
 		hns3_set_bit(hw->capability, HNS3_DEV_SUPPORT_GRO_B, 1);
+	if (hns3_get_bit(caps, HNS3_CAPS_VF_MULTI_TCS_B))
+		hns3_set_bit(hw->capability, HNS3_DEV_SUPPORT_VF_MULTI_TCS_B, 1);
 }
 
 static uint32_t
diff --git a/drivers/net/hns3/hns3_cmd.h b/drivers/net/hns3/hns3_cmd.h
index e21a2b652f..2a2ec155ea 100644
--- a/drivers/net/hns3/hns3_cmd.h
+++ b/drivers/net/hns3/hns3_cmd.h
@@ -326,6 +326,7 @@ enum HNS3_CAPS_BITS {
 	HNS3_CAPS_TM_B = 19,
 	HNS3_CAPS_GRO_B = 20,
 	HNS3_CAPS_FC_AUTO_B = 30,
+	HNS3_CAPS_VF_MULTI_TCS_B = 34,
 };
 
 /* Capabilities of VF dependent on the PF */
@@ -335,6 +336,7 @@ enum HNS3VF_CAPS_BITS {
 	 * in kernel side PF.
 	 */
 	HNS3VF_CAPS_VLAN_FLT_MOD_B = 0,
+	HNS3VF_CAPS_MULTI_TCS_B = 1,
 };
 
 enum HNS3_API_CAP_BITS {
diff --git a/drivers/net/hns3/hns3_dump.c b/drivers/net/hns3/hns3_dump.c
index 63c6b4ef2c..678279e2ac 100644
--- a/drivers/net/hns3/hns3_dump.c
+++ b/drivers/net/hns3/hns3_dump.c
@@ -105,7 +105,8 @@ hns3_get_dev_feature_capability(FILE *file, struct hns3_hw *hw)
 		{HNS3_DEV_SUPPORT_TM_B, "TM"},
 		{HNS3_DEV_SUPPORT_VF_VLAN_FLT_MOD_B, "VF VLAN FILTER MOD"},
 		{HNS3_DEV_SUPPORT_FC_AUTO_B, "FC AUTO"},
-		{HNS3_DEV_SUPPORT_GRO_B, "GRO"}
+		{HNS3_DEV_SUPPORT_GRO_B, "GRO"},
+		{HNS3_DEV_SUPPORT_VF_MULTI_TCS_B, "VF MULTI TCS"},
 	};
 	uint32_t i;
 
diff --git a/drivers/net/hns3/hns3_ethdev.h b/drivers/net/hns3/hns3_ethdev.h
index d7a55c134f..d602bfa02f 100644
--- a/drivers/net/hns3/hns3_ethdev.h
+++ b/drivers/net/hns3/hns3_ethdev.h
@@ -916,6 +916,7 @@ enum hns3_dev_cap {
 	HNS3_DEV_SUPPORT_VF_VLAN_FLT_MOD_B,
 	HNS3_DEV_SUPPORT_FC_AUTO_B,
 	HNS3_DEV_SUPPORT_GRO_B,
+	HNS3_DEV_SUPPORT_VF_MULTI_TCS_B,
 };
 
 #define hns3_dev_get_support(hw, _name) \
diff --git a/drivers/net/hns3/hns3_ethdev_vf.c b/drivers/net/hns3/hns3_ethdev_vf.c
index 632409c5d0..41d8252540 100644
--- a/drivers/net/hns3/hns3_ethdev_vf.c
+++ b/drivers/net/hns3/hns3_ethdev_vf.c
@@ -815,12 +815,45 @@ hns3vf_get_queue_info(struct hns3_hw *hw)
 	return hns3vf_check_tqp_info(hw);
 }
 
+static void
+hns3vf_update_multi_tcs_cap(struct hns3_hw *hw, uint32_t pf_multi_tcs_bit)
+{
+	uint8_t resp_msg[HNS3_MBX_MAX_RESP_DATA_SIZE];
+	struct hns3_vf_to_pf_msg req;
+	int ret;
+
+	if (!hns3_dev_get_support(hw, VF_MULTI_TCS))
+		return;
+
+	if (pf_multi_tcs_bit == 0) {
+		/*
+		 * Early PF driver versions may don't report
+		 * HNS3VF_CAPS_MULTI_TCS_B when VF query basic info, so clear
+		 * the corresponding capability bit.
+		 */
+		hns3_set_bit(hw->capability, HNS3_DEV_SUPPORT_VF_MULTI_TCS_B, 0);
+		return;
+	}
+
+	/*
+	 * Early PF driver versions may also report HNS3VF_CAPS_MULTI_TCS_B
+	 * when VF query basic info, but they don't support query TC info
+	 * mailbox message, so clear the corresponding capability bit.
+	 */
+	hns3vf_mbx_setup(&req, HNS3_MBX_GET_TC, HNS3_MBX_GET_PRIO_MAP);
+	ret = hns3vf_mbx_send(hw, &req, true, resp_msg, sizeof(resp_msg));
+	if (ret)
+		hns3_set_bit(hw->capability, HNS3_DEV_SUPPORT_VF_MULTI_TCS_B, 0);
+}
+
 static void
 hns3vf_update_caps(struct hns3_hw *hw, uint32_t caps)
 {
 	if (hns3_get_bit(caps, HNS3VF_CAPS_VLAN_FLT_MOD_B))
 		hns3_set_bit(hw->capability,
 				HNS3_DEV_SUPPORT_VF_VLAN_FLT_MOD_B, 1);
+
+	hns3vf_update_multi_tcs_cap(hw, hns3_get_bit(caps, HNS3VF_CAPS_MULTI_TCS_B));
 }
 
 static int
diff --git a/drivers/net/hns3/hns3_mbx.h b/drivers/net/hns3/hns3_mbx.h
index 651c6b9023..eec3dd2c7e 100644
--- a/drivers/net/hns3/hns3_mbx.h
+++ b/drivers/net/hns3/hns3_mbx.h
@@ -48,6 +48,9 @@ enum HNS3_MBX_OPCODE {
 
 	HNS3_MBX_HANDLE_VF_TBL = 38,    /* (VF -> PF) store/clear hw cfg tbl */
 	HNS3_MBX_GET_RING_VECTOR_MAP,   /* (VF -> PF) get ring-to-vector map */
+
+	HNS3_MBX_GET_TC = 47,           /* (VF -> PF) get tc info of PF configured */
+
 	HNS3_MBX_PUSH_LINK_STATUS = 201, /* (IMP -> PF) get port link status */
 };
 
@@ -59,6 +62,10 @@ struct hns3_basic_info {
 	uint32_t caps;
 };
 
+enum hns3_mbx_get_tc_subcode {
+	HNS3_MBX_GET_PRIO_MAP = 0, /* query priority to tc map */
+};
+
 /* below are per-VF mac-vlan subcodes */
 enum hns3_mbx_mac_vlan_subcode {
 	HNS3_MBX_MAC_VLAN_UC_MODIFY = 0,        /* modify UC mac addr */
-- 
2.33.0

