Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BF3CCC5B549
	for <dpdk-dev@archiver.kernel.org>; Fri,  6 Jun 2025 08:02:44 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 936B840684;
	Fri,  6 Jun 2025 10:02:04 +0200 (CEST)
Received: from smtpbguseast1.qq.com (smtpbguseast1.qq.com [54.204.34.129])
 by mails.dpdk.org (Postfix) with ESMTP id EDC184066F;
 Fri,  6 Jun 2025 10:02:01 +0200 (CEST)
X-QQ-mid: zesmtpsz2t1749196918t613b34b1
X-QQ-Originating-IP: KUrRAxCvEM2iEuPq1AUjEy50NoqTwEf0J7T4D0m6cvI=
Received: from w-MS-7E16.trustnetic.com ( [220.184.249.46])
 by bizesmtp.qq.com (ESMTP) with 
 id ; Fri, 06 Jun 2025 16:01:57 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 6897335794406002394
EX-QQ-RecipientCnt: 4
From: Jiawen Wu <jiawenwu@trustnetic.com>
To: dev@dpdk.org
Cc: zaiyuwang@trustnetic.com, Jiawen Wu <jiawenwu@trustnetic.com>,
 stable@dpdk.org
Subject: [PATCH 07/12] net/ngbe: fix MAC control frame forwarding
Date: Fri,  6 Jun 2025 16:01:12 +0800
Message-ID: <6B775662DA1AA425+20250606080117.183198-8-jiawenwu@trustnetic.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250606080117.183198-1-jiawenwu@trustnetic.com>
References: <20250606080117.183198-1-jiawenwu@trustnetic.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: zesmtpsz:trustnetic.com:qybglogicsvrgz:qybglogicsvrgz8a-1
X-QQ-XMAILINFO: NL81vSJxOQlIZIzGFRBjY0dIYRzl3+JEJlO9E0Smqb83BOHUaeLy5ITD
 7hQDlzTXxWa/qaN+N9dAgH9zX8vTuzDAHFkHbHRiCP55QMz4Z+Hj6LW8NIVxYcuz8okHBit
 JOSWdBFUG9Nz1JE1qi2xFZBKCuJ/SqfaTpLO+B2T67p1rIQG/GZFaQ1dRDNflqQu69be0r/
 cqxQrFaFzqH2CoOUfScDgqmu4tk048d/eoP1MzOvlySmytXVkUpedsuVmhav2liPWUvUUqr
 OEg0fq00wYcluSNcr9yQP6vGeDsmahdk2cbgzxUZgK2lAtMGemPvG9227AITKTYfEcnJtAG
 zgr/fvyELXZ5l25b76nn/otlyyqMbJ76lOnfgdrhot8tnrosKq6ODWxGmLz8+OCo+lyHMue
 acYWOAAPCLGmH55+2RnE5dR/dPqHlyNJJnHSZbXQDr5yoUv1Un4z6ZKVD7hbgKYuskN2vkV
 /my1OyeDfemDqcPwmD33fNANkGCJlpwvsDdjzBFByUYBiSUHol2A/DR3vKnbtMLBmCNhkzR
 M2jQgiSKqYRJeSUHLvCVc8rSikjL2yVdXfxPFzvO/pVR/PwgGzxbJrqJXZTY7rctvFdVb0p
 r1XUBoLJsV26egw/zpGo29pqvRTzxioUvZTQ9j1j+6Z9k0fBII0TEWY2VfbNrGn46cvTO79
 AnoNdFEjGOBmbyMyU8W6EtzkDL8ZcuIxtA0C3M5a2zJN/Dhb/DFnL7amZtAjCHqLFUAV9Ww
 FbwBRRXQTg8QsdpAlMorP77IDkVX7uiz/aI35Q7LiLdMU2KrfWDnJTmwtKc45372fiuTqMJ
 6Ao+QWeQ4n+dokjkJi3o9qhfKu7P4mepWESsYgkXPtET8emcvOtXVphhnn40PAZ43YFfxbs
 B9cRg0LmileFU14e1ABF3kF6tG2pab6qw86pJzA1WQb79iTEOVJl062WD8x3lg4X+oBa6It
 bzWurA8mxmgXstMaDpKM8JEv1ttYdM6PVSJmRGRPVlzgoXZK5+QIeS5X5mdssAxfOlKgEln
 poCmYW1vnY1boR4bcDDE6SadRVJRk=
X-QQ-XMRINFO: NS+P29fieYNw95Bth2bWPxk=
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

