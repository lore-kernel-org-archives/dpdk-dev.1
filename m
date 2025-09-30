Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C2579CCA470
	for <dpdk-dev@archiver.kernel.org>; Tue, 30 Sep 2025 10:02:19 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 25CA540E4F;
	Tue, 30 Sep 2025 12:01:07 +0200 (CEST)
Received: from smtpbg150.qq.com (smtpbg150.qq.com [18.132.163.193])
 by mails.dpdk.org (Postfix) with ESMTP id 39C3540E49
 for <dev@dpdk.org>; Tue, 30 Sep 2025 12:01:04 +0200 (CEST)
X-QQ-mid: esmtpgz13t1759226459tf17ea2af
X-QQ-Originating-IP: /ofTs+cv0DGSbM5zUpoNQ4ryM6WaQwD8S6gDd8IIV3c=
Received: from DSK-zaiyuwang.trustnetic.com ( [115.220.225.164])
 by bizesmtp.qq.com (ESMTP) with 
 id ; Tue, 30 Sep 2025 18:00:58 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 14217161575231773427
EX-QQ-RecipientCnt: 4
From: Zaiyu Wang <zaiyuwang@trustnetic.com>
To: dev@dpdk.org
Cc: Zaiyu Wang <zaiyuwang@trustnetic.com>, Jiawen Wu <jiawenwu@trustnetic.com>,
 Jian Wang <jianwang@trustnetic.com>
Subject: [PATCH v4 17/20] net/txgbe: add support for getting PHY ID
Date: Tue, 30 Sep 2025 17:59:49 +0800
Message-Id: <20250930095953.18508-18-zaiyuwang@trustnetic.com>
X-Mailer: git-send-email 2.21.0.windows.1
In-Reply-To: <20250930095953.18508-1-zaiyuwang@trustnetic.com>
References: <20250418094131.24136-1-zaiyuwang@trustnetic.com>
 <20250930095953.18508-1-zaiyuwang@trustnetic.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: esmtpgz:trustnetic.com:qybglogicsvrgz:qybglogicsvrgz5a-1
X-QQ-XMAILINFO: NgzJQeCZ3xJjFw/B/6LhnQPfRPgaZla4vKjMUq12KE9WqFRkqj1ZvQdu
 r+arbMjXuwsDfEhgQUb0VdkZA+4Bk9wu92kSzM3PFsoSvt8jBcXUQX7C3jZS4XgVHM36bg7
 oesVgWlFJcY4Kp7EBxC+iicrnp1vfv7GlchjwtwSp07ut2QyNInXrpQYEbuyMpqPfzE8twP
 oFaq8z6W3ZivH2ZhM3aXNureRHy0RilVbwv9j29il9IDCybuPl+lMzM2A6HGZSuwkqyRoom
 1Z3WZHyxNHIOSUex8MI8b34TI8sWzYfVrjUCE700t7akQ6Ej4XOoqFgPzjN336M83966oxH
 zEEYYbLYokuBqVjfHH1nMf7bXxJD61+8GFVyNh7lCKG5CGWa5aVVuKU1oqST0AVkjRV2epI
 36FPep4o6ZwFEVzFHZKfyhVxrQPGw2Ju7tyTEo2pD7uuPy72BbRFKx5W1RSxspVf+njiDgS
 6JKJRu9VvLJ8eHJ35qAeatA8exyZEbWKAWyDccEiTN1WyJsmh3utMP9WqP1m9WuXm8RSbgn
 afQuQfi1WDaZKhUu2D0KTpCOIpvNdXaNi8wEi7SFlk19i9Mx1rM/cH8X7oky47mjCNqEDw4
 bIMDZuTsuhDSurgPCdeynftTKkbER3z/4BWMH8qo3eNYQjGd1poiBIluKctJvvmitePtjFK
 F7NTZ+IybfgncZ+nlPMfHwfiW5Qgc89ip86K9qXYPZwdxVw9rIC+p2By/ZHfJlu1vn7pI2/
 aN8BEgIbfWjT12LjwXdwcnOJZTwxiGnKSCruYR8rCtMAz8LThyrqnayMvyfko9Ihk6hnBsu
 EqXInZ23VRbLJ9nqQgTHw8K1Y6ybCxZ3W21+QiOM4ZgUBdNsh2hN6DBSXNoOJkAStsv785m
 RNMQy5hTBYaJgIK9qddrRTvsCdzJZkGS4vb/A6R+Z7mWwKl8sDoyGZbNB7z1TLB2XV9l8Kb
 xwMLa2CGdL0yednGGHL3ZN3uUQsaqtwHUuI/CwTsN4wBLNxUqhs8WSG31Lxjz1FKxG2kHGQ
 v7Sy640MFHKvGkwiJG9Gz5N3rmXYbrhaOnKr6+Jcr9/D4Xf9u2crkdO2tXKs/DT36TWbhsH
 37ncNdN+rrE
X-QQ-XMRINFO: OD9hHCdaPRBwq3WW+NvGbIU=
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

Add PHY ID reading functionality for Amber-Lite NICs.
Due to hardware design differences, the process for obtaining the
PHY ID on Amber-Lite NICs differs from Sapphire NICs and requires
additional delay handling.

Signed-off-by: Zaiyu Wang <zaiyuwang@trustnetic.com>
---
 drivers/net/txgbe/base/txgbe_phy.c | 35 ++++++++++++++++++++++++++++++
 1 file changed, 35 insertions(+)

diff --git a/drivers/net/txgbe/base/txgbe_phy.c b/drivers/net/txgbe/base/txgbe_phy.c
index 81e9aee295..bf7260a295 100644
--- a/drivers/net/txgbe/base/txgbe_phy.c
+++ b/drivers/net/txgbe/base/txgbe_phy.c
@@ -173,6 +173,41 @@ s32 txgbe_get_phy_id(struct txgbe_hw *hw)
 	u32 err;
 	u16 phy_id_high = 0;
 	u16 phy_id_low = 0;
+	u32 i = 0;
+	u32 status;
+
+	if (hw->mac.type == txgbe_mac_aml) {
+		hw->phy.addr = 0;
+
+		for (i = 0; i < 32; i++) {
+			hw->phy.addr = i;
+			status = txgbe_read_phy_reg_mdi(hw, TXGBE_MD_PHY_ID_HIGH, 0, &phy_id_high);
+			if (status) {
+				DEBUGOUT("txgbe_read_phy_reg_mdi failed 1");
+				return status;
+			}
+			DEBUGOUT("%d: phy_id_high 0x%x", i, phy_id_high);
+			if ((phy_id_high & 0xFFFF) == 0x0141)
+				break;
+		}
+
+		if (i == 32) {
+			DEBUGOUT("txgbe_read_phy_reg_mdi failed");
+			return TXGBE_ERR_PHY;
+		}
+
+		status = txgbe_read_phy_reg_mdi(hw, TXGBE_MD_PHY_ID_LOW, 0, &phy_id_low);
+		if (status) {
+			DEBUGOUT("txgbe_read_phy_reg_mdi failed 2");
+			return status;
+		}
+		hw->phy.id = (u32)(phy_id_high & 0xFFFF) << 6;
+		hw->phy.id |= (u32)((phy_id_low & 0xFC00) >> 10);
+
+		DEBUGOUT("phy_id 0x%x", hw->phy.id);
+
+		return status;
+	}
 
 	err = hw->phy.read_reg(hw, TXGBE_MD_PHY_ID_HIGH,
 				      TXGBE_MD_DEV_PMA_PMD,
-- 
2.21.0.windows.1

