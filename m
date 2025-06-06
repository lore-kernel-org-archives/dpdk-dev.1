Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A7484C5AD49
	for <dpdk-dev@archiver.kernel.org>; Fri,  6 Jun 2025 08:02:38 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id A067E4067C;
	Fri,  6 Jun 2025 10:02:02 +0200 (CEST)
Received: from smtpbgau1.qq.com (smtpbgau1.qq.com [54.206.16.166])
 by mails.dpdk.org (Postfix) with ESMTP id 3AFA84066F;
 Fri,  6 Jun 2025 10:01:59 +0200 (CEST)
X-QQ-mid: zesmtpsz2t1749196916t0ef8bf2b
X-QQ-Originating-IP: 2HXYhBHpObDLgehiaxJJuRqcd+kCk0YIWbkop4tGbjU=
Received: from w-MS-7E16.trustnetic.com ( [220.184.249.46])
 by bizesmtp.qq.com (ESMTP) with 
 id ; Fri, 06 Jun 2025 16:01:55 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 973462684417254708
EX-QQ-RecipientCnt: 4
From: Jiawen Wu <jiawenwu@trustnetic.com>
To: dev@dpdk.org
Cc: zaiyuwang@trustnetic.com, Jiawen Wu <jiawenwu@trustnetic.com>,
 stable@dpdk.org
Subject: [PATCH 06/12] net/txgbe: fix MAC control frame forwarding
Date: Fri,  6 Jun 2025 16:01:11 +0800
Message-ID: <B2D0E5072FC8B760+20250606080117.183198-7-jiawenwu@trustnetic.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250606080117.183198-1-jiawenwu@trustnetic.com>
References: <20250606080117.183198-1-jiawenwu@trustnetic.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: zesmtpsz:trustnetic.com:qybglogicsvrgz:qybglogicsvrgz8a-1
X-QQ-XMAILINFO: Nf6zhP74XG+b/enQn54aQ4RqjcYIFTQdUA1iygs/KR4xRIyoqaBvDHYC
 Mg1kIYckTWSN1gFGs+l84NqDPUmOnP6r0247JUhapf18ier3AARPbiCnRMD8/Uhr65Umwjn
 AaJC/YXmVJZa+Fy2ZRmyZBS47p9CzWPCbouU2hNac01nS2JmvlC7NaNjMvhuGq58OndmD72
 bs1TQmebWuoRzgAv6qzgsUV8aKYffBf50NqaDMNGLZ9+4rm3korPgln4qTsMM/r6JarkfVi
 Q963oOCzw8XhbcU61MwcXK0AFIvxCgoX1zqFUNGkDD08jZ27Ind3WVtK9Ay3t0Wr7CnADg3
 84ZX20l3JWLsWNRhVeyi+Cquzt013QB0bidNPN/RrWMx4tB0Cfjw4KMi6a3WiQT7H/j8CNq
 MrBgQVl09qK6Upx/+lfSB/avxGftp5rfAnyy1Dxep64JJ0OejDEncdYw6FaxgszJICeNsks
 +D76B3O5ooj+OVFRTqGR0Sd7QuU+SDsp5L3YVe3NKgkx+VCLIjv2JT2KylHp1FxOLtq0NVk
 yYEdRThzGTjdWKrxZUIhhFuedvA5Fn+q7cXXZeOa0qGupQ+9+qgz0OZWXNYOgutoNwKpfmq
 2HQb6xKMSWMqUgf05pEWDXQazf7vph3w+8I4BUfaIR09Wb+o1F1uGAwVfg1ggvxqPDo4TKN
 fUbSMLm81ZhkExrsJz+6V0yOvbhRiorE9EoM/nrW2NwoHEb/KQ0WeflArr1MTH3hEALJ/gk
 FUHW5CNS3oUyQUMTYzSIksfVGNt1ugD5yZoHk8zUDIDUW8S6SfvGrmlJgmEgMOPRxp+CqG8
 SAxdHuW8DVg5KKGcTwrJXYrNozS41LP+iwaNm/w+OS2qeGIkUKJDeL5MD0jVrBX8tdbwFhx
 9Sq+jWyH4tOROvyxxvUuBE50TCwqBAy2T8RGJH9FGTQgxTJO2FSPrxpZk6ZrUFC00DqC6Ec
 jaJTYYGwXrWGdXHq4PemIi8gnK2DqQAtXCs0Rp9WMTRXny9HHVKUWEvuKU0PkoK4saCKMAE
 Ip2Nv9ViwDjPEl6luri0NrhKMR6LOMkvh0mztpfQbxg0fatLmw
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

