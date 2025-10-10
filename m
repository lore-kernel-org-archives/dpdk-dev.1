Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 94FC0CAC5BB
	for <dpdk-dev@archiver.kernel.org>; Fri, 10 Oct 2025 07:01:41 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 059F1402C3;
	Fri, 10 Oct 2025 09:01:39 +0200 (CEST)
Received: from smtpbgeu1.qq.com (smtpbgeu1.qq.com [52.59.177.22])
 by mails.dpdk.org (Postfix) with ESMTP id 79BAE402C3;
 Fri, 10 Oct 2025 09:01:36 +0200 (CEST)
X-QQ-mid: zesmtpgz5t1760079689tfefdb249
X-QQ-Originating-IP: 2AMGXDblbpu2s6UuuOKEoGAm6BY2Ey4iJoLgWugPPOw=
Received: from sunshaojie-Precision-5820-Tower ( [203.174.112.180])
 by bizesmtp.qq.com (ESMTP) with 
 id ; Fri, 10 Oct 2025 15:01:27 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 9894306512829593228
EX-QQ-RecipientCnt: 6
From: Wenbo Cao <caowenbo@mucse.com>
To: stephen@networkplumber.org, Wenbo Cao <caowenbo@mucse.com>,
 Ferruh Yigit <ferruh.yigit@amd.com>
Cc: dev@dpdk.org,
	yaojun@mucse.com,
	stable@dpdk.org
Subject: [PATCH v3 1/4] net/rnp: add check firmware respond info
Date: Fri, 10 Oct 2025 15:01:19 +0800
Message-Id: <20251010070122.161401-2-caowenbo@mucse.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20251010070122.161401-1-caowenbo@mucse.com>
References: <20251010070122.161401-1-caowenbo@mucse.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: zesmtpgz:mucse.com:qybglogicsvrgz:qybglogicsvrgz5a-0
X-QQ-XMAILINFO: N+zv///MAAEkBtQRmcwCurrIOJUJEhy1Z2gKffvFqLfnIYglm2F+Fg7t
 XDT5fzGlJNpv+qRzbW/sG/NWcC/X1A+XbfIkSB9lczGtxZVw+Nuvieer/gg3ubACy3SMiD6
 3vYYlEm7fiYqNEspDYf42ww/CZYuhi0NDBRtfp17vglCoyxSBNiANb1+tLVHd7jg3VtYKsb
 EYzHjeqSKgjjYa/ogA5yAU9oD07Ln0WZpd4pnDUFRjz3lqAYYSlIrbxcXrpvTi/NkTz/tyX
 dZ3T/70qLBNmOlSrGjNHjzQ59GPvQHmE2E7lN2EbN1C7VhtXSnXibRXiXaAz9zkAMwFTT9Z
 q57lClhbi8buD4woMBXfK1kR6NbgJ+EILKuN0y1vqpNdtfA13zNTDY8/PhjsYfuF+0aPyP5
 8ibxzPjssIOhvjKOdqahPEZEcwidsnY73wFAhaoPq3CQMn+dEo2GfHsxNq82RaAqeLXesW/
 BAg60kEgL09ixwpr5M+jaWJd/tD48OSSctyF8XP6AbXWzkmwDQDqLfTogz8axGPZ9g91bXW
 /eDDBnciNXeSBleksYybUNEa4YoPic5+BBMY+xMJS2Rs64USKisKroBOkQsvc27++K++Nka
 fwKHuQ10sLJm8o3O/gpPoOabgBmdgH75ML3wJHEx1y9HXN8BRmxMZtewFBzdwxCvnmdGHN2
 mXo5e6okGfoKP4LMP7zfUVLlUKi8u3+7ags1G8MqahSOZA0AJmjYdbF5JIL3Yw1TtarBRkF
 vWSHyRQFqJQAt2LG3jUI+1X7YRIjB0iPuDioi3MO+o1TcRAakexJ6mxqD18gHo4a54X0gvA
 v+l8LzCusff40s3J7IpExiaOUvqFUVaLw9OiwcBVGH+Ejp5zjy4g3nBZ7OK852IXPZ+bbtZ
 jaIASXqfYwhKqwWifXsAIX0zmpyH9ZXnnQJKDObeSRz9fsv8h3LWlq4+TSw0WOyAdYN+hEM
 f31+i3xsDwHnTK+8OVGanhui9QY9xxLTF/uJW3zaZBIQf6G09OdaZj/M0N2Te+6XWHaa3Ke
 8fwn0mRNonU7K4hpzOvJHoLSS59o+o4SyI78C4jkJkeugpAHX4SSQQ2QQp3fXt6qJGHmyTv
 w==
X-QQ-XMRINFO: NyFYKkN4Ny6FSmKK/uo/jdU=
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
 drivers/net/rnp/base/rnp_mbx_fw.c | 17 +++++++++++++++--
 drivers/net/rnp/rnp_ethdev.c      | 16 ++++++++--------
 2 files changed, 23 insertions(+), 10 deletions(-)

diff --git a/drivers/net/rnp/base/rnp_mbx_fw.c b/drivers/net/rnp/base/rnp_mbx_fw.c
index 3e7cf7f9ad..7ae8763a4a 100644
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
-			lane_bit = ffs(temp_mask) - 1;
+			if (temp_mask == 0) {
+				RNP_PMD_LOG(ERR, "temp_mask is zero at idx=%d", idx);
+				return -EINVAL;
+			}
+			lane_bit = rte_ffs32(temp_mask) - 1;
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

