Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 01316C7115A
	for <dpdk-dev@archiver.kernel.org>; Wed, 18 Jun 2025 11:05:45 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id E97CC42D9F;
	Wed, 18 Jun 2025 13:05:39 +0200 (CEST)
Received: from smtpbguseast1.qq.com (smtpbguseast1.qq.com [54.204.34.129])
 by mails.dpdk.org (Postfix) with ESMTP id 3623542D80;
 Wed, 18 Jun 2025 13:05:36 +0200 (CEST)
X-QQ-mid: esmtpgz10t1750244728t0d81f284
X-QQ-Originating-IP: WiCC6ajt35NEmchGRGY7G3Ob95JtdcrBk2Xbv0tK24A=
Received: from localhost.localdomain ( [203.174.112.180])
 by bizesmtp.qq.com (ESMTP) with 
 id ; Wed, 18 Jun 2025 19:05:22 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 4490012609733460719
EX-QQ-RecipientCnt: 6
From: Wenbo Cao <caowenbo@mucse.com>
To: stephen@networkplumber.org, Wenbo Cao <caowenbo@mucse.com>,
 Ferruh Yigit <ferruh.yigit@amd.com>
Cc: dev@dpdk.org,
	yaojun@mucse.com,
	stable@dpdk.org
Subject: [PATCH v0 1/3] net/rnp: add check firmware respond info
Date: Wed, 18 Jun 2025 19:05:14 +0800
Message-Id: <20250618110516.90113-2-caowenbo@mucse.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20250618110516.90113-1-caowenbo@mucse.com>
References: <20250618110516.90113-1-caowenbo@mucse.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: esmtpgz:mucse.com:qybglogicsvrgz:qybglogicsvrgz5a-0
X-QQ-XMAILINFO: NQ/JKI5VIEMilu5fCp4A61FSb7v3lPHfijfJbI8WOG7ASEvHAXP7G1OR
 iIxp8RTWrWufzk/uP8FT630CnTrkvHKY5S0+u4WQfRDjYzB4+t5GOU8xykR6IaMM11cd+/j
 kEQeYzDBCHjIv3gcjVGdOXyb0rOTVSB+E3irJGLVJQvB4G0MULhhcz0yjXx8HkUNipTs0Aq
 R0DiuzDYUoZjEPNuJdSGH5/2BIzPl/3JnP+2mcWCLuWulxIOwnUitBRAbgrF25e5lf9YLgS
 rC39+1EWMUDRpqqMddhU32L9mrVexYbfp1B1BImXIA1U4xCn+VtNQfAfzF51pi+KJ78knm7
 zDGe3rbNb4GxBr7Arc9DVFEFxPJUGCL4qnRlOOOgi0ZwWtFeTanqJW2zOg0EbhiyHsc5Ouj
 BAm7vJcm9ye1xkfSCtUpigdCgEPfOQex7Gu0lHpTj1yDkAksbc4SdIJuM25GWfNLX7pzMpc
 6Z7ZVlK9CykdnuMOwDa+eKtT3fmWNd4exBfqmdgZyhQAg+ugF41kEN2XrLBiGuXzNdkodMS
 UydnAVg3DDmL5mJg7jMmzPifR1fcJxcryd8LFDGljnyF5mn3k0mxVFNGbS/HiBTyTuffpNg
 jS1UzB+SszVxXrkKcrqbNzrGUOyAmv7vhhHoa6oWidCu6Q1Ot3jF9fnOrqPYi0pQrGB+xAR
 o3SwjETE/X23qiHESOhxdM1RFqPOD/z5ZyBTMBnc2Zm0fR4J8PA1NbUkICL1luQviM2zTy4
 h2nlvbViXLcUAsXyJwQ9tN1hgJTs00NOYBisOYD3zvCjt77ufU+T1AsV9Y61DDRSfgJ1GID
 3x58yZ4Mww+UuZyu2YpklEOW1fhG0t3xCCnwoPDoSTlGMJKb8QpN0vATykGgPJ9xIZ5ZPsq
 0x3/uEKk02WrFwg9Ayuv1PKgjMHzmRq7eJRjzc9ekprPcAHmWHby4J3AuSPrnFIcplT9kT4
 wJF/VUATkU7ieQeSSgNDf/MOZgKbvXgGVCxRHvHlaaEi4o1Ie8HKNRfmM5j/UKn3GT7f1Hj
 jutn+pfcVlHXvn7U+W
X-QQ-XMRINFO: MPJ6Tf5t3I/ycC2BItcBVIA=
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
---
 drivers/net/rnp/base/rnp_fw_cmd.h |  1 +
 drivers/net/rnp/base/rnp_mbx_fw.c | 15 ++++++++++++++-
 drivers/net/rnp/rnp_ethdev.c      | 16 ++++++++--------
 3 files changed, 23 insertions(+), 9 deletions(-)

diff --git a/drivers/net/rnp/base/rnp_fw_cmd.h b/drivers/net/rnp/base/rnp_fw_cmd.h
index 26db07ad36..f6c0d77f1d 100644
--- a/drivers/net/rnp/base/rnp_fw_cmd.h
+++ b/drivers/net/rnp/base/rnp_fw_cmd.h
@@ -159,6 +159,7 @@ struct rnp_mac_addr_rep {
 #define RNP_SPEED_CAP_100M_HALF  RTE_BIT32(11)
 #define RNP_SPEED_CAP_1GB_HALF   RTE_BIT32(12)
 
+#define RNP_SPEED_VALID_MASK	RTE_GENMASK32(12, 2)
 enum rnp_pma_phy_type {
 	RNP_PHY_TYPE_NONE = 0,
 	RNP_PHY_TYPE_1G_BASE_KX,
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
index de1c077f61..7b996913c8 100644
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
+		bit_pos = ffs(support_link) - 1;
+		speed = RTE_BIT32(bit_pos) & RNP_SPEED_VALID_MASK;
+		switch (speed) {
 		case RNP_SPEED_CAP_10M_FULL:
 			speed_cap |= RTE_ETH_LINK_SPEED_10M;
 			break;
@@ -789,7 +789,7 @@ rnp_get_speed_caps(struct rte_eth_dev *dev)
 		default:
 			speed_cap |= 0;
 		}
-		support_link &= ~RTE_BIT32(speed);
+		support_link &= ~(1ULL << bit_pos);
 	}
 	if (!port->attr.phy_meta.link_autoneg)
 		speed_cap |= RTE_ETH_LINK_SPEED_FIXED;
-- 
2.25.1

