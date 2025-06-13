Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7D374C71135
	for <dpdk-dev@archiver.kernel.org>; Fri, 13 Jun 2025 08:43:42 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id D8B3342F37;
	Fri, 13 Jun 2025 10:42:43 +0200 (CEST)
Received: from smtpbg151.qq.com (smtpbg151.qq.com [18.169.211.239])
 by mails.dpdk.org (Postfix) with ESMTP id 4E27942EFA;
 Fri, 13 Jun 2025 10:42:38 +0200 (CEST)
X-QQ-mid: esmtpsz18t1749804155t88e3f10d
X-QQ-Originating-IP: 61FMBiNzineaTm7HmK4qN+4pC+1RRZYIHtmSZTIV9+I=
Received: from lap-jiawenwu.trustnetic.com ( [36.20.60.58])
 by bizesmtp.qq.com (ESMTP) with 
 id ; Fri, 13 Jun 2025 16:42:35 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 3016224053250777575
EX-QQ-RecipientCnt: 4
From: Jiawen Wu <jiawenwu@trustnetic.com>
To: dev@dpdk.org
Cc: zaiyuwang@trustnetic.com, Jiawen Wu <jiawenwu@trustnetic.com>,
 stable@dpdk.org
Subject: [PATCH v3 11/17] net/txgbe: fix MAC control frame forwarding
Date: Fri, 13 Jun 2025 16:41:53 +0800
Message-Id: <20250613084159.22184-12-jiawenwu@trustnetic.com>
X-Mailer: git-send-email 2.21.0.windows.1
In-Reply-To: <20250613084159.22184-1-jiawenwu@trustnetic.com>
References: <00DEAE896AFE0D2D+20250606080117.183198-1-jiawenwu@trustnetic.com>
 <20250613084159.22184-1-jiawenwu@trustnetic.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: esmtpsz:trustnetic.com:qybglogicsvrgz:qybglogicsvrgz8a-1
X-QQ-XMAILINFO: OSjQccS6YHkHRjmP6eiNyz375pzeboZA2sh5IhFzX83mWwLt3916DRV0
 +6r5e2lbVMFn4p5TUIlEZoP3dBB16lV3l0XZ9X+21zg9RW4OjXxlVxhggmJmbQizX+V+d33
 2ETbpvZ+wI74K1Q3Sd0F8zjBckcIuLi7hW/j7Tp5aWf40YFc0OAR2NcALjvgTrMyHPg8JjC
 lQnX7EU36cGr7LWLbe9PV6fyK8SJs37t4pFBN7N0uAPd/C4BC/tn6eEjtXxxRBJht2T4b9k
 drVXpV+0YJAf92ftFR8oDLRqBU3BnUQ0cORnoN+sVsJlvmG+NbGhvdbefIefLRcozuH1AGg
 PQXzwNcvh5hEtSsecNTclxdi7jx7/vbEAMjVxPB6nmm9tERwg15wwQX3KTqNXiPyBJRkRxR
 OoajK0Upc6qVGPCnUDLi7t3q/i/6j7BmCoeVMBQi5O4MY5kFNdbdcAmYo0rG2MteRpAOwXC
 HE0696I6SOFyAa5pQ7mhL36Dat2E6Qy6nFrUWfVNpvgCMLSK9WxVl9ArnRhpbsJ87zV7dKh
 /cqHjdsUlk1rDl2DcadRzj1/FnudS3OwzWOzhgES25bm3foT5fctVhfi4fKF/H2to17KWdi
 9QKruUiPxm+F3twkEWpBth0kVQMQwX/pf9+G01UCgvjhzPR1r3+yzT21sFK7SJnZtH4UVZy
 koI1IvuR3EHHQWEYGw8nYmj6rLULSTtf6lkurHZvHHfLDlPIr1wnfzlBsjzxMvKCWp9oy94
 TgNjZ0izlIzuoMj53FgApLAWMA03Q3CKXqP/S/QPHOn5kvPwd9QrOJaubhxM/9vsrg4JtZo
 cnUK9yWjjd8NoXcM+Qo9J6vtEKS5j/Td20E6l3WE1a7cBHBxWgr5We6mCYjh3AgXTEbYD1M
 YLQbaqg7Nz/FCCT2xA7Idqel31eagKVMFcZUwlVQ7t610enTFOxjWnXqTocvmSukDyZr5Oy
 Wjg7DhcmmiN9jnBjbFfTFWyfz9BimuIXBXUqi4EH0bwnTEnCJU0zE4IifQURL1jTz6CAp6h
 df65CKUP+c5EC5erA8gqrGgZ2b5FNnEYIPqkF6s9EhuMtWpB3Y
X-QQ-XMRINFO: Nq+8W0+stu50PRdwbJxPCL0=
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

Test Failure on the case "test_pause_fwd_port_stop_start", which expect
MAC control frame forwarding setting still working after port stop/start.
Fix the bug to pass the test case.

Fixes: 69ce8c8a4ce3 ("net/txgbe: support flow control")
Cc: stable@dpdk.org

Signed-off-by: Jiawen Wu <jiawenwu@trustnetic.com>
---
 drivers/net/txgbe/base/txgbe_hw.c   | 9 +++++++++
 drivers/net/txgbe/base/txgbe_type.h | 1 +
 drivers/net/txgbe/txgbe_ethdev.c    | 1 +
 3 files changed, 11 insertions(+)

diff --git a/drivers/net/txgbe/base/txgbe_hw.c b/drivers/net/txgbe/base/txgbe_hw.c
index 76b9ee3c0a..42cd0e0e2c 100644
--- a/drivers/net/txgbe/base/txgbe_hw.c
+++ b/drivers/net/txgbe/base/txgbe_hw.c
@@ -226,6 +226,15 @@ s32 txgbe_setup_fc(struct txgbe_hw *hw)
 				      TXGBE_MD_DEV_AUTO_NEG, reg_cu);
 	}
 
+	/*
+	 * Reconfig mac ctrl frame fwd rule to make sure it still
+	 * working after port stop/start.
+	 */
+	wr32m(hw, TXGBE_MACRXFLT, TXGBE_MACRXFLT_CTL_MASK,
+	      (hw->fc.mac_ctrl_frame_fwd ?
+	       TXGBE_MACRXFLT_CTL_NOPS : TXGBE_MACRXFLT_CTL_DROP));
+	txgbe_flush(hw);
+
 	DEBUGOUT("Set up FC; reg = 0x%08X", reg);
 out:
 	return err;
diff --git a/drivers/net/txgbe/base/txgbe_type.h b/drivers/net/txgbe/base/txgbe_type.h
index 383438ea3c..65527a22e7 100644
--- a/drivers/net/txgbe/base/txgbe_type.h
+++ b/drivers/net/txgbe/base/txgbe_type.h
@@ -299,6 +299,7 @@ struct txgbe_fc_info {
 	u32 high_water[TXGBE_DCB_TC_MAX]; /* Flow Ctrl High-water */
 	u32 low_water[TXGBE_DCB_TC_MAX]; /* Flow Ctrl Low-water */
 	u16 pause_time; /* Flow Control Pause timer */
+	u8 mac_ctrl_frame_fwd; /* Forward MAC control frames */
 	bool send_xon; /* Flow control send XON */
 	bool strict_ieee; /* Strict IEEE mode */
 	bool disable_fc_autoneg; /* Do not autonegotiate FC */
diff --git a/drivers/net/txgbe/txgbe_ethdev.c b/drivers/net/txgbe/txgbe_ethdev.c
index e5736bf387..b68a0557be 100644
--- a/drivers/net/txgbe/txgbe_ethdev.c
+++ b/drivers/net/txgbe/txgbe_ethdev.c
@@ -3586,6 +3586,7 @@ txgbe_flow_ctrl_set(struct rte_eth_dev *dev, struct rte_eth_fc_conf *fc_conf)
 	hw->fc.low_water[0]   = fc_conf->low_water;
 	hw->fc.send_xon       = fc_conf->send_xon;
 	hw->fc.disable_fc_autoneg = !fc_conf->autoneg;
+	hw->fc.mac_ctrl_frame_fwd = fc_conf->mac_ctrl_frame_fwd;
 
 	err = txgbe_fc_enable(hw);
 
-- 
2.48.1

