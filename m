Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2D3DDC71135
	for <dpdk-dev@archiver.kernel.org>; Fri, 13 Jun 2025 08:44:12 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id D5F5D42F13;
	Fri, 13 Jun 2025 10:42:58 +0200 (CEST)
Received: from smtpbgsg1.qq.com (smtpbgsg1.qq.com [54.254.200.92])
 by mails.dpdk.org (Postfix) with ESMTP id E361942F4B;
 Fri, 13 Jun 2025 10:42:55 +0200 (CEST)
X-QQ-mid: esmtpsz18t1749804157taecb0ad0
X-QQ-Originating-IP: mEpCgrSHgI6zw2+vhmqIayGudDpf6vO64KRlZ+E8sbo=
Received: from lap-jiawenwu.trustnetic.com ( [36.20.60.58])
 by bizesmtp.qq.com (ESMTP) with 
 id ; Fri, 13 Jun 2025 16:42:37 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 8095402523383158914
EX-QQ-RecipientCnt: 4
From: Jiawen Wu <jiawenwu@trustnetic.com>
To: dev@dpdk.org
Cc: zaiyuwang@trustnetic.com, Jiawen Wu <jiawenwu@trustnetic.com>,
 stable@dpdk.org
Subject: [PATCH v3 12/17] net/ngbe: fix MAC control frame forwarding
Date: Fri, 13 Jun 2025 16:41:54 +0800
Message-Id: <20250613084159.22184-13-jiawenwu@trustnetic.com>
X-Mailer: git-send-email 2.21.0.windows.1
In-Reply-To: <20250613084159.22184-1-jiawenwu@trustnetic.com>
References: <00DEAE896AFE0D2D+20250606080117.183198-1-jiawenwu@trustnetic.com>
 <20250613084159.22184-1-jiawenwu@trustnetic.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: esmtpsz:trustnetic.com:qybglogicsvrgz:qybglogicsvrgz8a-1
X-QQ-XMAILINFO: M4DH96YQFINpW0FLQQaTNYZ3KVt1faTnzehEjMHAD1yExLj8+fk4dSl/
 yN8W1aWD7BShp+drOlwmLqgQZJjpiY2/LODrfB7cjAvrZA3U2KuiiQKPppM+P71leLtBiKr
 7Pra/n6PE/efktM1yb98I2esHEf8Yz+vP7jMmZiZ9/7Y9ObgSsSj1jaPhbux95IiGKAiOsD
 zgSvnQb/mkt/p3uiiR+2i55v+dTS33UAPydPa8wyJh/jkuUzyAmObUf1dDs0y9Rw8TruVsN
 52IpWKDFbxA0feDulAwvLNmXKDiFrAloKzqwWyf3mGoEpgFVVggNgO5/FN3OA6S0kTj0lEH
 t67ArXtY+2fdaN8pLRrXWcXkoIIDnPye2E9APk94LBl1J29Q21xUQWFGV6JBzoQQZCNko0b
 vFVonHqneE9Mxiuxau49WHANfIMsEGHpstYciRHp9iYEWYgy/s+sujfGR3Cq7CHq6bt7JvN
 GCIZoO49GI3pIRp/f1yVtv1ti6Dld/Wrkk33m19s6Y8HSsiYYcoZCLUgtpY3Z10eOoHmlFy
 78NzWC9yA22OzbfugGzD+7m58Gi2RwSilolxgiXNvoV0O/NUFBXqJRt/L2XZ33kTSCvT04i
 S4J2X1N07ZiM3vQidAZFlTAJTbGgTrFlStj0Q8wSKaXGlfGyvm1Myby64Q2ZluVdrA6CGS8
 ogSMiRJbGb/vxVSbC+YhLJolkLxzzoCPWoa75BiwbkeKesZ1NfLraMbtwlmapgIOLVlWi4s
 Msz+spyp5LHV5gMcGJPXm/BqhGj8qhVavqFy6RvVxHleaagU26JfWhN8csZm3UAFXXENJR2
 CDLT8yqPyymiWfkcnoDyMmRwm4jpAZDN7jUoH7KBiOWAtz6ExvF+2llhTc70AgApMwnFqmW
 TtyGupbXHpf3sIpR1Ka9Im2gx/Y3lxd10imMCZV4E+6Z0XZ1hKqPsNUA0+hMHz1RUpE/Bgz
 IWcZ1Ka2C2j9s09dembx25GW+td1/oEufbXIkDNJN9ILDASF4Mraes1tF+auyADV41QxzL5
 Q/J5d33wPJmMIIvFfIMSRFfOPTdS5yTt+G8RgLBUfzR2R/6OZCU/GnwJgy3ZdU54VzCGD52
 w==
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

