Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1BF3BC61DB2
	for <dpdk-dev@archiver.kernel.org>; Mon,  9 Jun 2025 07:06:08 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 43C3840B97;
	Mon,  9 Jun 2025 09:05:27 +0200 (CEST)
Received: from smtpbgjp3.qq.com (smtpbgjp3.qq.com [54.92.39.34])
 by mails.dpdk.org (Postfix) with ESMTP id 1ABDF40B97;
 Mon,  9 Jun 2025 09:05:23 +0200 (CEST)
X-QQ-mid: zesmtpsz9t1749452721t6674f443
X-QQ-Originating-IP: NLSLzlGBDPqXZRl3K8d1i+B2ec2VnEvdPWRB9ixrLbo=
Received: from w-MS-7E16.trustnetic.com ( [220.184.249.46])
 by bizesmtp.qq.com (ESMTP) with 
 id ; Mon, 09 Jun 2025 15:05:20 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 3508509440119966417
EX-QQ-RecipientCnt: 4
From: Jiawen Wu <jiawenwu@trustnetic.com>
To: dev@dpdk.org
Cc: zaiyuwang@trustnetic.com, Jiawen Wu <jiawenwu@trustnetic.com>,
 stable@dpdk.org
Subject: [PATCH v2 06/12] net/txgbe: fix MAC control frame forwarding
Date: Mon,  9 Jun 2025 15:04:48 +0800
Message-ID: <099358DAE8B5A930+20250609070454.223387-7-jiawenwu@trustnetic.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250609070454.223387-1-jiawenwu@trustnetic.com>
References: <00DEAE896AFE0D2D+20250606080117.183198-1-jiawenwu@trustnetic.com>
 <20250609070454.223387-1-jiawenwu@trustnetic.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: zesmtpsz:trustnetic.com:qybglogicsvrgz:qybglogicsvrgz8a-1
X-QQ-XMAILINFO: NeJ0kb0We42H01yi/DZBML3JrXIwPQmesf0hcXShYsmszY0ECEhkh/Eu
 OoL8vrXJa3SKpsmsJsj3KEeKMQS3lBS2rP5vHDAwIkxKLG29tIGF3Q2a399Lrh6E5wJI1sQ
 ham2Iq6kWWztV42nk/TK04PwWKbni9B+9Lykple1joxXSjetbDQU9GQcEGA+8MmkC/8pS5c
 dccwmEp9CY8XmdjIaqiSGOlww5XRMMAOMvV5RLhieDFxMPr71I1MFn5j1EhQSlrVOKcRX3S
 ThRSs+ca1LlOM8fgtDSqvwQqhMJi+836zu9lghHKXXt9TAgb+CLvj3V53I/uhgRFrarWKZC
 UIqPcfTBA+OsUKf8Ja7zrqnmXoGbNCpVD7B9Kkr+49xaWWkJ44CR9R+EEP/lAJ2MGbbZtqO
 Zfbuw0N8lgEOrdDXOiGoAzx/qy7nhRL5GxQ0cSJQbk6LNn/BZ2rFEGiQulIRyZZo335jBQc
 cBcNkLMF8wkxmlmml5ImQ4XpzrV62Fsis/OVzLNQQP/SHdl4+qU0vll6cHCyd6V3srhTyXS
 vpkwXnYi3QKUJImDazTo3VOR1VrxrE5HqL+BcNz9utr7KwDURTtLKjpsDY8G+h8qpX+IDhx
 Mwbq6T1qoNd/oZvE6tPaAI0asmEa+t2T867UzdZJf4MfUTZNxQVpfSX3TUoDzVysPt0dFow
 zlDnSpjDl4ScqRmUXMrmuCCwmHOrJJkrOR1cyhCivj2Bqe4Rgqh36cOlKbH0wgHI7gS19zB
 h3kjbXgdKNKAIbASbF5ZD5SJ78LT9wjMdS4SUwdMrUrQVinU/5RrYmYEUhv7q5esgCD6rD4
 ya6J6ZE9iQksjVuPZNt6y+qJoriNwjntTuamCS89apQwwAdOTebofFUfZToUhh6RcDBreQF
 fy3hz5cwPQB1x9vMGp6wjoxX7IYwvDrzIEbTsxEXiHdxlMwaKGHvW48wGsnlatqsxVNKHRa
 3l6v1c//BcbL0WcuW8aLU79OAH9J7BECMtvO3duHOqVsk6TbS0hE5Kz7HNZzZYqS4ajgTH0
 ImXzdZVTRHae5A4Pmuji7OXunb6oEIxSANSkiZaV8VrNUOIPETigjBoM65RQwnNMW6aXig6
 w==
X-QQ-XMRINFO: MSVp+SPm3vtS1Vd6Y4Mggwc=
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

