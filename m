Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B06E2FF8875
	for <dpdk-dev@archiver.kernel.org>; Wed, 29 Apr 2026 10:26:55 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 3EF2A4068E;
	Wed, 29 Apr 2026 12:26:31 +0200 (CEST)
Received: from smtpbgjp3.qq.com (smtpbgjp3.qq.com [54.92.39.34])
 by mails.dpdk.org (Postfix) with ESMTP id ED3BF4069F;
 Wed, 29 Apr 2026 12:26:28 +0200 (CEST)
X-QQ-mid: esmtpgz10t1777458386t9333bca7
X-QQ-Originating-IP: d0v+qLTIsrtsXV0xo7pqGhi2mx2BKoLGwZF9V5omyzo=
Received: from DSK-zaiyuwang.trustnetic.com ( [36.24.191.108])
 by bizesmtp.qq.com (ESMTP) with 
 id ; Wed, 29 Apr 2026 18:26:24 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 10163159953806440651
EX-QQ-RecipientCnt: 4
From: Zaiyu Wang <zaiyuwang@trustnetic.com>
To: dev@dpdk.org
Cc: Zaiyu Wang <zaiyuwang@trustnetic.com>, stable@dpdk.org,
 Jiawen Wu <jiawenwu@trustnetic.com>
Subject: [PATCH v2 08/20] net/txgbe: fix link flow control registers for
 Amber-Lite
Date: Wed, 29 Apr 2026 18:25:02 +0800
Message-Id: <20260429102515.58880-9-zaiyuwang@trustnetic.com>
X-Mailer: git-send-email 2.21.0.windows.1
In-Reply-To: <20260429102515.58880-1-zaiyuwang@trustnetic.com>
References: <20260423034024.14404-1-zaiyuwang@trustnetic.com>
 <20260429102515.58880-1-zaiyuwang@trustnetic.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: esmtpgz:trustnetic.com:qybglogicsvrsz:qybglogicsvrsz3b-0
X-QQ-XMAILINFO: NRYSeI3Ux+UPLvwMBTWbxcdB/oagWnE7v+PIA20wlC6nU7gLX0Qk689K
 lr8IaiEtUw/FKg7a64LhEGPhi1IqC8LMvSF/myGvq7bcHPumZ222OQqNmI9TjwrFoh4C1FD
 aIWltcvGR/rxu8Z3jWu2Vt0JHDJdwOP7Ba3Uvpq1bbEE/RmQE4Cx5S+r+GXaoty8GR9yWa0
 a7SvJK4Falowia6qp5pIrGAbMRbGpBw2mBMPkdpHj5bCyo37KX2X4ZuQwtoYk4mmqvd45LL
 P17UpU9vcWoyfgyiiSCr6N5kykKublUwDiwRkjkNjOl97hGMRGR8dt17URWN13mcYTsuLYw
 8bvvmcFh0uSv39zb4QmE2QNawaRlW2NIWhvXvqPSSMjLr6r+OZtlArsiyNdQV2lE1vRIj1v
 Ca/r8x9gZgCk7oYjJWhcgn59N2WJFgAoTG4o5Dnc3Khv3cOlPk8iLX5LL/DPi6/LgGGYJ/B
 h4J3oXJuIrW/3B4RzMdi5LrohVnCcMsUUxGR2mCYyJN01iLcN0aguS2a9osXAeXd91RlBhR
 LoneVNXJE2LNqouMhVQRdv9MOQE1TdI78Bdk5fDSMb2fG2z4I4XXCWO2t8nzd2tDdEtBiA9
 hyVW3ufP4Em1HoMQpc8YYinTyA40amCMqPh3A3inLXGtJ15TBb0SfkY67NTnn7iN6jtkfwF
 HwA+tXn18W5RCZh/hP6dyjiKhGL7SBjQNKZy7l/pyqyR9TW+6bYbhy+6oeRFPG03NQHzUtI
 RRqV5KCZk/TVq1duUsbhWn8KkftDGp/77EjQHa/u1IUobWVYpN2FBISrt8ZolsxJxOuvZky
 VIV2SlIwAIqsiBOWEG4A/gEzj0A/Vp7Qj3p2gcR8NPsvk7zbnO3rgL+M/FGp8eB+8/488fE
 Oq8lfoXH7GawH1vv/d4FuBcWhTQJOet0vkko077bpotCrQNfdDEW/ywSSeQ3zTo/QXTJ5VF
 2xmwb/Jktrdl8MF/JSB9/Nry4ewtPIliH7td9a6UAkJX2eK/Q2U6FFYgT+oO6pntYysEAhI
 3/Ca5SiRmxSzQVo6fpqn7V1maHFYAdZXGcao+h/DfRb9q2gl8ccn9+EPmKbLQurowjKzW79
 xRZtThW8vxm
X-QQ-XMRINFO: NI4Ajvh11aEjEMj13RCX7UuhPEoou2bs1g==
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

The flow control counter registers on AML NICs differ from those on SP
NICs. Update the register offsets accordingly to ensure the counters
work correctly.

Fixes: fb6eb170dfa2 ("net/txgbe: add basic link configuration for Amber-Lite")
Cc: stable@dpdk.org

Signed-off-by: Zaiyu Wang <zaiyuwang@trustnetic.com>
---
 drivers/net/txgbe/base/txgbe_hw.c   |  5 +++++
 drivers/net/txgbe/base/txgbe_regs.h |  2 ++
 drivers/net/txgbe/txgbe_ethdev.c    | 10 ++++++++--
 3 files changed, 15 insertions(+), 2 deletions(-)

diff --git a/drivers/net/txgbe/base/txgbe_hw.c b/drivers/net/txgbe/base/txgbe_hw.c
index 0f3db3a1ad..52fead6171 100644
--- a/drivers/net/txgbe/base/txgbe_hw.c
+++ b/drivers/net/txgbe/base/txgbe_hw.c
@@ -394,6 +394,11 @@ s32 txgbe_clear_hw_cntrs(struct txgbe_hw *hw)
 	rd32(hw, TXGBE_PBTXLNKXON);
 	rd32(hw, TXGBE_PBTXLNKXOFF);
 
+	if (hw->mac.type == txgbe_mac_aml || hw->mac.type == txgbe_mac_aml40) {
+		wr32(hw, TXGBE_PBRXLNKXON_AML, 0);
+		wr32(hw, TXGBE_PBRXLNKXOFF_AML, 0);
+	}
+
 	/* DMA Stats */
 	rd32(hw, TXGBE_DMARXPKT);
 	rd32(hw, TXGBE_DMATXPKT);
diff --git a/drivers/net/txgbe/base/txgbe_regs.h b/drivers/net/txgbe/base/txgbe_regs.h
index 060757323a..de382601c9 100644
--- a/drivers/net/txgbe/base/txgbe_regs.h
+++ b/drivers/net/txgbe/base/txgbe_regs.h
@@ -1085,6 +1085,8 @@ enum txgbe_5tuple_protocol {
 #define TXGBE_PBRXDROP                    0x019068
 #define TXGBE_PBRXLNKXOFF                 0x011988
 #define TXGBE_PBRXLNKXON                  0x011E0C
+#define TXGBE_PBRXLNKXOFF_AML             0x011F80
+#define TXGBE_PBRXLNKXON_AML              0x011F84
 #define TXGBE_PBRXUPXON(up)               (0x011E30 + (up) * 4)
 #define TXGBE_PBRXUPXOFF(up)              (0x011E10 + (up) * 4)
 
diff --git a/drivers/net/txgbe/txgbe_ethdev.c b/drivers/net/txgbe/txgbe_ethdev.c
index 414107d7a7..e3492c9cd7 100644
--- a/drivers/net/txgbe/txgbe_ethdev.c
+++ b/drivers/net/txgbe/txgbe_ethdev.c
@@ -2331,8 +2331,14 @@ txgbe_read_stats_registers(struct txgbe_hw *hw,
 		hw_stats->up[i].rx_up_dropped +=
 				rd32(hw, TXGBE_PBRXMISS(i));
 	}
-	hw_stats->rx_xon_packets += rd32(hw, TXGBE_PBRXLNKXON);
-	hw_stats->rx_xoff_packets += rd32(hw, TXGBE_PBRXLNKXOFF);
+
+	if (hw->mac.type == txgbe_mac_aml || hw->mac.type == txgbe_mac_aml40) {
+		hw_stats->rx_xon_packets = rd32(hw, TXGBE_PBRXLNKXON_AML);
+		hw_stats->rx_xoff_packets = rd32(hw, TXGBE_PBRXLNKXOFF_AML);
+	} else {
+		hw_stats->rx_xon_packets += rd32(hw, TXGBE_PBRXLNKXON);
+		hw_stats->rx_xoff_packets += rd32(hw, TXGBE_PBRXLNKXOFF);
+	}
 	hw_stats->tx_xon_packets += rd32(hw, TXGBE_PBTXLNKXON);
 	hw_stats->tx_xoff_packets += rd32(hw, TXGBE_PBTXLNKXOFF);
 
-- 
2.21.0.windows.1

