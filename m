Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0FDE2C83000
	for <dpdk-dev@archiver.kernel.org>; Mon, 30 Jun 2025 05:58:29 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id DC1554065B;
	Mon, 30 Jun 2025 07:58:16 +0200 (CEST)
Received: from smtpbgbr2.qq.com (smtpbgbr2.qq.com [54.207.22.56])
 by mails.dpdk.org (Postfix) with ESMTP id A1DEC40647;
 Mon, 30 Jun 2025 07:58:13 +0200 (CEST)
X-QQ-mid: esmtpsz17t1751263081td1727c0d
X-QQ-Originating-IP: wml7EQGoWcWhyPXUtjuml9oDz7JNPwqZT7LUSgypsUI=
Received: from sunshaojie-Precision-5820-Tower ( [203.174.112.180])
 by bizesmtp.qq.com (ESMTP) with 
 id ; Mon, 30 Jun 2025 13:57:58 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 15478959123980315158
EX-QQ-RecipientCnt: 6
From: Wenbo Cao <caowenbo@mucse.com>
To: stephen@networkplumber.org, Wenbo Cao <caowenbo@mucse.com>,
 Ferruh Yigit <ferruh.yigit@amd.com>
Cc: dev@dpdk.org,
	yaojun@mucse.com,
	stable@dpdk.org
Subject: [PATCH v2 1/3] net/rnp: add check firmware respond info
Date: Mon, 30 Jun 2025 13:57:51 +0800
Message-Id: <20250630055753.35445-2-caowenbo@mucse.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250630055753.35445-1-caowenbo@mucse.com>
References: <20250630055753.35445-1-caowenbo@mucse.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: esmtpsz:mucse.com:qybglogicsvrgz:qybglogicsvrgz5a-0
X-QQ-XMAILINFO: MtNNO3F5RRafecaLV2V0ciI+2DXwkMDHBYcLe6vsO269la4m5dSC3x1K
 V+HUMldFAApiKcGNc4SKoOoqmDPS9LFEKF3XcUo8fQVEsxK8O0Epdx+gPZJ/yYoLSG8T3j8
 4kt0heo8tuozL5Lgz7O42Iw6ZgE2mHTDmkbLk5207VkRN2JI1JPJlmPpfF1RFSD7EsG6AMk
 4x/AErHD7l+Ev40j3/FuuY/qksg0j/f94mChNk498+cwA3UEHQJqWbpTUcj5ZGJ4SZEMe+t
 R3xfa6YUvTdb/u+G7hSMa8m+Mac74J4lJ97Eu4AkAtfiMOE2yvSwwCf5mMX+COM5DwARK8g
 ip6iI2I5f8KRK0LMtTh98FDNWbk9diuneprurN56FZDAoJ3AL1WXsDjeleskKGOfQUaExR2
 MJDYFORIBPa4CiA10cItEcpFrlombfzLYXO+cWL1Cjur1hvTW/Pj9NLTLskj36MfseaRITn
 K47h+yojFogdnGHFr2fbVdocrL0hmsAa7S5wUGmUy0w+jwELpiMw8Mj3StJFwMLGLKpHdaT
 3a8L2aOylIIPHfTiPBCWoc3+RZYPl0Q8+My9uIUv+ANL8EqZ/Vckug6ngfXQSnDED92UL7d
 f/qAlcwIu6+drJ3K7Nx33Ldacu3BAIORMbHEkOZcislv4Z+wME1Wp9i/wxK9VW98NihIkkC
 fXrULqxSn8qJym4WJAjP2qij5o+z0lpGGYcWqe9ny0K8z6/Xjevnc7KFO+6Q57CqeFzB+9l
 rE6UJMdSo1rOVLJBZ1qEzhb/j8nPq1IIZgCi9pp7Ybp/ClkxHGm48YlSU6xRp7oMLRfyE2X
 1oXgxMPpmZF3CxtAwPeg+5vOSwQaD0Tj3+Su1D6TuJJ1Hc1P2EUIgcxPZUrUJziQrq7xBP+
 Lba9WiL8L/zCXXj7J0msn02GCqqYtQ0IDjn/lrO4KE7t/808VQZZAjaP6v5/+qh2JGVDhvr
 Hb/BfkTZs5xoBsykx9ZnW5u4a4dGVATZsirGGZGKXiUklGFO+1T8CWM0ZNBmocUnHqrb6lN
 qcM/klEco3o0ZJk5hs
X-QQ-XMRINFO: OWPUhxQsoeAVDbp3OJHYyFg=
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

Add logic checks at critical points to detect potentially illegal
firmware information, preventing subsequent logic exceptions.

Fixes: 52aae4ed4ffb ("net/rnp: add device capabilities")
Fixes: 52dfb84e14be ("net/rnp: add device init and uninit")
Cc: stable@dpdk.org

Signed-off-by: Wenbo Cao <caowenbo@mucse.com>
Reviewed-by: Stephen Hemminger <stephen@networkplumber.org>
---
 drivers/net/rnp/base/rnp_mbx_fw.c | 15 ++++++++++++++-
 drivers/net/rnp/rnp_ethdev.c      | 16 ++++++++--------
 2 files changed, 22 insertions(+), 9 deletions(-)

diff --git a/drivers/net/rnp/base/rnp_mbx_fw.c b/drivers/net/rnp/base/rnp_mbx_fw.c
index 3e7cf7f9ad..9e0b1730c2 100644
--- a/drivers/net/rnp/base/rnp_mbx_fw.c
+++ b/drivers/net/rnp/base/rnp_mbx_fw.c
@@ -230,6 +230,7 @@ rnp_fw_get_phy_capability(struct rnp_eth_port *port,
 	return 0;
 }
 
+#define RNP_MAX_LANE_MASK	(0xf)
 int rnp_mbx_fw_get_capability(struct rnp_eth_port *port)
 {
 	struct rnp_phy_abilities_rep ability;
@@ -252,17 +253,29 @@ int rnp_mbx_fw_get_capability(struct rnp_eth_port *port)
 		hw->nic_mode = ability.nic_mode;
 		/* get phy<->lane mapping info */
 		lane_cnt = rte_popcount32(hw->lane_mask);
+		if (lane_cnt > RNP_MAX_PORT_OF_PF) {
+			RNP_PMD_LOG(ERR, "firmware invalid lane_mask");
+			return -EINVAL;
+		}
 		temp_mask = hw->lane_mask;
+		if (temp_mask == 0 || temp_mask > RNP_MAX_LANE_MASK) {
+			RNP_PMD_LOG(ERR, "lane_mask is invalid 0x%.2x", temp_mask);
+			return -EINVAL;
+		}
 		if (ability.e.ports_is_sgmii_valid)
 			is_sgmii_bits = ability.e.lane_is_sgmii;
 		for (idx = 0; idx < lane_cnt; idx++) {
 			hw->phy_port_ids[idx] = port_ids[idx];
+			if (temp_mask == 0) {
+				RNP_PMD_LOG(ERR, "temp_mask is zero at idx=%d", idx);
+				return -EINVAL;
+			}
 			lane_bit = ffs(temp_mask) - 1;
 			lane_idx = port_ids[idx] % lane_cnt;
 			hw->lane_of_port[lane_idx] = lane_bit;
 			is_sgmii = lane_bit & is_sgmii_bits ? 1 : 0;
 			hw->lane_is_sgmii[lane_idx] = is_sgmii;
-			temp_mask &= ~RTE_BIT32(lane_bit);
+			temp_mask &= ~(1ULL << lane_bit);
 		}
 		hw->max_port_num = lane_cnt;
 	}
diff --git a/drivers/net/rnp/rnp_ethdev.c b/drivers/net/rnp/rnp_ethdev.c
index de1c077f61..24eb0b16dd 100644
--- a/drivers/net/rnp/rnp_ethdev.c
+++ b/drivers/net/rnp/rnp_ethdev.c
@@ -751,17 +751,17 @@ rnp_get_speed_caps(struct rte_eth_dev *dev)
 {
 	struct rnp_eth_port *port = RNP_DEV_TO_PORT(dev);
 	uint32_t speed_cap = 0;
-	uint32_t i = 0, speed;
 	uint32_t support_link;
-	uint32_t link_types;
+	uint32_t speed = 0;
+	int bit_pos = 0;
 
 	support_link = port->attr.phy_meta.supported_link;
-	link_types = rte_popcount64(support_link);
-	if (!link_types)
+	if (support_link == 0)
 		return 0;
-	for (i = 0; i < link_types; i++) {
-		speed = ffs(support_link) - 1;
-		switch (RTE_BIT32(speed)) {
+	while (support_link) {
+		bit_pos = rte_ffs32(support_link) - 1;
+		speed = RTE_BIT32(bit_pos);
+		switch (speed) {
 		case RNP_SPEED_CAP_10M_FULL:
 			speed_cap |= RTE_ETH_LINK_SPEED_10M;
 			break;
@@ -789,7 +789,7 @@ rnp_get_speed_caps(struct rte_eth_dev *dev)
 		default:
 			speed_cap |= 0;
 		}
-		support_link &= ~RTE_BIT32(speed);
+		support_link &= ~speed;
 	}
 	if (!port->attr.phy_meta.link_autoneg)
 		speed_cap |= RTE_ETH_LINK_SPEED_FIXED;
-- 
2.34.1

