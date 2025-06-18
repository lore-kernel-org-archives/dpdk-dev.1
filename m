Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F114FC71157
	for <dpdk-dev@archiver.kernel.org>; Wed, 18 Jun 2025 12:11:48 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 0B8AB42DC9;
	Wed, 18 Jun 2025 14:11:34 +0200 (CEST)
Received: from smtpbg150.qq.com (smtpbg150.qq.com [18.132.163.193])
 by mails.dpdk.org (Postfix) with ESMTP id 2CDAA42DB0;
 Wed, 18 Jun 2025 14:11:30 +0200 (CEST)
X-QQ-mid: esmtpgz13t1750248680t0db3771e
X-QQ-Originating-IP: SjXUQe1V72DjWKh7hpM2jZRDvUQxPJ3KhkDNZdCxh+A=
Received: from localhost.localdomain ( [203.174.112.180])
 by bizesmtp.qq.com (ESMTP) with 
 id ; Wed, 18 Jun 2025 20:11:17 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 11083644411994837775
EX-QQ-RecipientCnt: 6
From: Wenbo Cao <caowenbo@mucse.com>
To: stephen@networkplumber.org, Wenbo Cao <caowenbo@mucse.com>,
 Ferruh Yigit <ferruh.yigit@amd.com>
Cc: dev@dpdk.org,
	yaojun@mucse.com,
	stable@dpdk.org
Subject: [PATCH v1 1/3] net/rnp: add check firmware respond info
Date: Wed, 18 Jun 2025 20:11:11 +0800
Message-Id: <20250618121113.17302-2-caowenbo@mucse.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20250618121113.17302-1-caowenbo@mucse.com>
References: <20250618121113.17302-1-caowenbo@mucse.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: esmtpgz:mucse.com:qybglogicsvrgz:qybglogicsvrgz5a-0
X-QQ-XMAILINFO: Ob/XveE7/E1wWynDcERuxK/2MDyCsr+FLsvsCvyhxeQzPE9YsILyT84i
 YZD+KcezjIQxD06W1sm8uc1gX3z3RdqOZNIlpH7X5Ro8ANjfqmoQwTjGGCE1Kxmqd9AJhWB
 +jUVhVv6Qvhtw+N4+n/TJAlfsIfMo+9+b6r+nj3f4oV7As5AiU0KeIG1qMoyIQv3UtqtHyr
 jnZSvAVv9KW9VE8PO/KTtqjTd7xNpShke1oYluN5pqbbFKCMzZS+wjEN5IZkNGPWzZTC224
 WC0PW7l7CZQoGf+A41stJtYPQaB2MWFBV6jDxnjl8n9uESzCuh4VwWfYLxB+NJDA+ha+lck
 RROr/ZnvsKT7cNlSpmOuP+ik8xFwzissbBsscI7VYJDHFuynh2vLixgW6gv9FebwWo1Fyoz
 E/kHfhIg/ZUsqu7Cuz0XJcd8igQMHf+QqlIZ/gvY41lNY1ll+uN9KDcDCY1576CBSb8EYt9
 7nTzrrg5U6ZzzUfjwv1Mav3AGgSKBvYq3vuJ2VbH9rHdZMst9TvvIwrcKRgJOqHYtHBe4Cy
 xbQnFLa6YHpgTYNC/+OyGD1rR7BTcVccYoEdnwEzfG4uDb+4Opszg6VlJL22/WsaUQkgVtv
 zguUBpXSV9bZxsm5GdD1nh1VJKNji5zfPaGgVUfo3M+8AAX2rdvAXI103NfOu+iURNysovJ
 uiCpwq0mG04QPs9vSivSw8ne5qv6kBHCrSgGsvGGit2l6wD69PskrY8GA9//9p/hThUf4OO
 oXVYmYldLbxsknawBDIYJy0tXdar/qB14ImKXNroDR0Z0n5D/oSRnq6f8xpwBU8BDznPYWp
 tryzrib7BKB434y0RgYPz0QPHSl+kvkpXyOojJnVGoLInCt8C6szUEdJnZpzwcarDR0qR8D
 WBo+mO0EfhO7Lpxg+6AzV0Nnfulo44p6QGPmpjYkXMl49s6yuzJWSKVLlnWdG0dMqiU0yzn
 Hdyq01/iXPqcdY9fS0+xMrhGKZACnl011SnLwT0rooxQgD5/4UhpC6baySJaXGOfBaXXhGg
 pa6TKZlRI8L91HPn5vYVHsvHeO/E6u/Njh1XX3tkgsAPkK2hjQ+lK1+kchP8MaANEkZQwit
 eq4P/j64OG2A221Z53xuftHZgjApivnuA==
X-QQ-XMRINFO: NI4Ajvh11aEj8Xl/2s1/T8w=
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

