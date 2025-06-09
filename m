Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 57D0DC61DB2
	for <dpdk-dev@archiver.kernel.org>; Mon,  9 Jun 2025 07:06:17 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id B31ED40DC9;
	Mon,  9 Jun 2025 09:05:29 +0200 (CEST)
Received: from smtpbgau1.qq.com (smtpbgau1.qq.com [54.206.16.166])
 by mails.dpdk.org (Postfix) with ESMTP id 14C1740A80;
 Mon,  9 Jun 2025 09:05:26 +0200 (CEST)
X-QQ-mid: zesmtpsz9t1749452723tb1d9b2fb
X-QQ-Originating-IP: a7bUlGyrsVPE3jdBo7jUzbMjoVfxcAi8LXm7oTJunhE=
Received: from w-MS-7E16.trustnetic.com ( [220.184.249.46])
 by bizesmtp.qq.com (ESMTP) with 
 id ; Mon, 09 Jun 2025 15:05:22 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 15688012892001810133
EX-QQ-RecipientCnt: 4
From: Jiawen Wu <jiawenwu@trustnetic.com>
To: dev@dpdk.org
Cc: zaiyuwang@trustnetic.com, Jiawen Wu <jiawenwu@trustnetic.com>,
 stable@dpdk.org
Subject: [PATCH v2 07/12] net/ngbe: fix MAC control frame forwarding
Date: Mon,  9 Jun 2025 15:04:49 +0800
Message-ID: <6D83A31D8EF41AE5+20250609070454.223387-8-jiawenwu@trustnetic.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250609070454.223387-1-jiawenwu@trustnetic.com>
References: <00DEAE896AFE0D2D+20250606080117.183198-1-jiawenwu@trustnetic.com>
 <20250609070454.223387-1-jiawenwu@trustnetic.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: zesmtpsz:trustnetic.com:qybglogicsvrgz:qybglogicsvrgz8a-1
X-QQ-XMAILINFO: Mw3/skGyA4U5+o8st0jMs31UkQCQtAx6/fqxpy5A2l4RmyRhP3J8faIQ
 dqfyU1xsSgfslznjsFqljhQkDJjd9JYgLaFH8D8/5QbZB8OqWF6gKqxY0qU96nAxmLETUMg
 PV0F5MY+rFCQVN1srVBc1xeXhlMnBNDqjmOBUYZpgpowTMrO9Nv1dPzLK3fMUM2uYSEBDvB
 NB4K2cqtnJxhcOpS6uzX7+mrgEZXvIkTu4WGpKnkioTOihWOUQN+4QpRtS0A+CyT8wdrChN
 s79Z17dg+O5I7IldeIw7I23KN4zS7RCJw5CM0gvhuzP3tLNvb9ANJXbjDL8KN3KrM+97bKs
 fh/Lv1r75eFihrFCzPAdQ9HzlrCGIhVrfII1jSv8VOYppco36Tbro1j8TbUO4wPNJ5AMS8B
 7dJ3cT5ur4vwnuB5p4Lp7rtquLdouC5/yX7EzaISNF8DlInKXRBage4d7QHEw5cXDih/Vkm
 IFGNz/3kVFHVHBJ+SieZ9hGM62sdNxK82TEuy2jtko/Wf7gW8Rcm7b59+XhySjPnoDRVATX
 pn9G+m9LbRyT+vSNbEwMFjcH/fCV+qoS+iiJBU2PcKrXwrA9VnOkZk+SQJAWZBLWfbVN65U
 aDrzZ1hzVAIkzNQxPA74Fa5c2iWcOxd48Dh0mscefQaQR+1kW85Q020y2kVmI4UxzPAtVAH
 g3ALufBAyPrA1QIV5+obXk2h/10dL60lMYsO69wbNHkLa5ylZC6FHSSdceJmXihK5dFBvVt
 nAp8RrGkeGnzkDzonKmwHnoKrsC7/U3xtVu8D8dKJLKDstBw1npL5kakZk4S53lzlg5PsdS
 KLiwQXmsfoZ0cTHMj/LeOA2kyMbkMcFyv5V2xsKilQrzfsfx0jlg2PfWtTMJPk1i+KSg4+v
 fvNkGhK/M6scdU5+hkimZM6rSCmIDyiisaGqjhgk+hRHvCqTPLj0few2NvIQ+uzOeQBktzC
 tN5o5Gitq1jTotUQcmJlhQVAPPRIXEQfC+DFW+p9HOnjfaXI+68BiacbmfcjftbfSGdchFd
 3hTc2Q0U+kZmjohJegep5TDbBT9oOEPL8Rr/nBrneiUP3e6g/qB2RugrQAIxM=
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

Test failure on the case "test_pause_fwd_port_stop_start", which expect
MAC control frame forwarding setting still working after port stop/start.
Fix the bug to pass the test case.

Fixes: f40e9f0e2278 ("net/ngbe: support flow control")
Cc: stable@dpdk.org

Signed-off-by: Jiawen Wu <jiawenwu@trustnetic.com>
---
 drivers/net/ngbe/base/ngbe_hw.c   | 9 +++++++++
 drivers/net/ngbe/base/ngbe_type.h | 1 +
 drivers/net/ngbe/ngbe_ethdev.c    | 1 +
 3 files changed, 11 insertions(+)

diff --git a/drivers/net/ngbe/base/ngbe_hw.c b/drivers/net/ngbe/base/ngbe_hw.c
index 6688ae6a31..bf09f8a817 100644
--- a/drivers/net/ngbe/base/ngbe_hw.c
+++ b/drivers/net/ngbe/base/ngbe_hw.c
@@ -865,6 +865,15 @@ s32 ngbe_setup_fc_em(struct ngbe_hw *hw)
 		goto out;
 	}
 
+	/*
+	 * Reconfig mac ctrl frame fwd rule to make sure it still
+	 * working after port stop/start.
+	 */
+	wr32m(hw, NGBE_MACRXFLT, NGBE_MACRXFLT_CTL_MASK,
+	      (hw->fc.mac_ctrl_frame_fwd ?
+	       NGBE_MACRXFLT_CTL_NOPS : NGBE_MACRXFLT_CTL_DROP));
+	ngbe_flush(hw);
+
 	err = hw->phy.set_pause_adv(hw, reg_cu);
 
 out:
diff --git a/drivers/net/ngbe/base/ngbe_type.h b/drivers/net/ngbe/base/ngbe_type.h
index 7a3b52ffd4..fc571c7457 100644
--- a/drivers/net/ngbe/base/ngbe_type.h
+++ b/drivers/net/ngbe/base/ngbe_type.h
@@ -112,6 +112,7 @@ struct ngbe_fc_info {
 	u32 high_water; /* Flow Ctrl High-water */
 	u32 low_water; /* Flow Ctrl Low-water */
 	u16 pause_time; /* Flow Control Pause timer */
+	u8 mac_ctrl_frame_fwd; /* Forward MAC control frames */
 	bool send_xon; /* Flow control send XON */
 	bool strict_ieee; /* Strict IEEE mode */
 	bool disable_fc_autoneg; /* Do not autonegotiate FC */
diff --git a/drivers/net/ngbe/ngbe_ethdev.c b/drivers/net/ngbe/ngbe_ethdev.c
index 08e87471f6..a8f847de8d 100644
--- a/drivers/net/ngbe/ngbe_ethdev.c
+++ b/drivers/net/ngbe/ngbe_ethdev.c
@@ -2420,6 +2420,7 @@ ngbe_flow_ctrl_set(struct rte_eth_dev *dev, struct rte_eth_fc_conf *fc_conf)
 	hw->fc.low_water      = fc_conf->low_water;
 	hw->fc.send_xon       = fc_conf->send_xon;
 	hw->fc.disable_fc_autoneg = !fc_conf->autoneg;
+	hw->fc.mac_ctrl_frame_fwd = fc_conf->mac_ctrl_frame_fwd;
 
 	err = hw->mac.fc_enable(hw);
 
-- 
2.48.1

