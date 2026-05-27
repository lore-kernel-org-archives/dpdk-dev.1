Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 31713CD5BD0
	for <dpdk-dev@archiver.kernel.org>; Wed, 27 May 2026 13:06:11 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id AF0DD40DD3;
	Wed, 27 May 2026 15:04:39 +0200 (CEST)
Received: from smtpbgbr2.qq.com (smtpbgbr2.qq.com [54.207.22.56])
 by mails.dpdk.org (Postfix) with ESMTP id BCC8840653;
 Wed, 27 May 2026 15:04:36 +0200 (CEST)
X-QQ-mid: esmtpsz19t1779887023t0f89af60
X-QQ-Originating-IP: Rem5LDMQy6lWcXNdpMI4f9QVpNP3rSo+Sar+YdgdU20=
Received: from DSK-zaiyuwang.trustnetic.com ( [122.231.28.113])
 by bizesmtp.qq.com (ESMTP) with 
 id ; Wed, 27 May 2026 21:03:41 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 11240907872603166142
EX-QQ-RecipientCnt: 5
From: Zaiyu Wang <zaiyuwang@trustnetic.com>
To: dev@dpdk.org
Cc: Zaiyu Wang <zaiyuwang@trustnetic.com>, stable@dpdk.org,
 Jiawen Wu <jiawenwu@trustnetic.com>, Ferruh Yigit <ferruh.yigit@amd.com>
Subject: [PATCH v5 11/21] net/txgbe: fix traffic class priority configuration
Date: Wed, 27 May 2026 21:02:11 +0800
Message-Id: <20260527130222.24348-12-zaiyuwang@trustnetic.com>
X-Mailer: git-send-email 2.21.0.windows.1
In-Reply-To: <20260527130222.24348-1-zaiyuwang@trustnetic.com>
References: <20260423034024.14404-1-zaiyuwang@trustnetic.com>
 <20260527130222.24348-1-zaiyuwang@trustnetic.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: esmtpsz:trustnetic.com:qybglogicsvrsz:qybglogicsvrsz3b-0
X-QQ-XMAILINFO: NhvpCzAv3WKAwKVe2pTNZllmGg/ZKPlExviYp0H4LqWPxFreK9Kufglp
 asC+8n1mIaW+YxnQRspiv0FBm4QRwI6QTfpqbgzuGleNS7iAH15sITsc8L4DPK6X9eR1XxC
 /DicEVsmrvm0h7DmA0h7k8exexoehbgVOGB3MZvZnJBRxYmbAj0a5UoNQs0GeSP3w0XmSGQ
 NSY0st0mG4N9HL28WwUWWvsfbG84tljS6x68uKK9S6k9wTXmj2stTReNIqFWGhQzDmxUn8Y
 CBdZ/c7xejQuTMpTA64tiR02mjo9EdAFNRZKcCw5UyKrbwa7HetIZu5JOeCp56B9m0mg91E
 hhXhBrm9MA1dDVziJXferQ2uUADfTmSyI458tDzS2YnbeUAByqKExeL7CIUZH9Hb1FUJAvg
 8dUT6eqbAi9BujX0VT5e+DtQCpqs3uHBU3Z7e4V8SRtK6SVcv66odZMxFZLsnyBNMXzVQ5L
 HJfmiyDHxeeqAfEP1stKPU4OcegXUEx6RfAJVmIyRhe2D3gSEStOFjygzW9VbmR+lZ1v3xL
 kEmD8bGlxZ924gEaDOmpTqK3nVqEu7GuhOTapJJ6mUs1fzjhgLnsEIB+Af2dE/JwpGLtN0Z
 GIaZVRrEnn2pvQS+IkPcLqDd/1K/epsdbrmmNIJbiP+J0lkK3w2vhLdlNPzhTHUi59e4Z4y
 VASkl50ni5k/eoog4X3r8C1vgB7zAq4kUnsx3ieP6QT2HesGI0F4RWK3/bDKa1Hb2uMo4vK
 fYy9dwdet4KdDjMvxkVFFsgFjr8Mb0pioOkDB4vwJlyYXmOyr4V9vYq1spZQtk2OJMKfDha
 quWBGV4JD4AuQthIUSRwQdnS89F/r7/a2Kqy3FogjiSLQH7MGTAdUgE0/m3adk0eSsOtoxF
 MPGMGTVib5MSnrFrziXg7Kl8PX8hHHJc8BuNjAPw9S5hdDcaIXvbXlPWgehI+Yy4iqIlXVp
 xx9ZeUFZFZbbqoa7Y1EwyDnaSgKSiJ+sn/1FWivir1SLQcWYtd2jUdfRzAXpzd8M+8hJI/H
 B2jxxYaLHonJVJQ2cDBuIBP9xUMomyPxpuww8lr5pIcwKwXijX/RI3qYt1Rw8D9hWCIl+T8
 wmMd7gy3URDz/3juucLHxsK1XAaNAoUxw==
X-QQ-XMRINFO: MSVp+SPm3vtSI1QTLgDHQqIV1w2oNKDqfg==
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

After applying the following testpmd command, 802.1Q packets with specific
priorities were not properly directed to the corresponding traffic classes:
    port config 0 dcb vt off 4 pfc off

The old driver had two issues:
1. The hardware uses a 4-bit mapping register per traffic class for
   priority-to-TC mapping, but the driver incorrectly configured it
   as 3 bits.
2. The DCB TX configuration mistakenly wrote to the RX register.

Fix both issues, ensuring that tc-prio mapping works as expected.
Additionally, remove the stale and inconsistent TXGBE_DCBUP2TC_DEC macro as
it has no callers.

Fixes: 8bdc7882f376 ("net/txgbe: support DCB")
Cc: stable@dpdk.org

Signed-off-by: Zaiyu Wang <zaiyuwang@trustnetic.com>
---
 drivers/net/txgbe/base/txgbe_dcb_hw.c | 2 +-
 drivers/net/txgbe/base/txgbe_regs.h   | 6 ++----
 drivers/net/txgbe/txgbe_rxtx.c        | 7 ++-----
 3 files changed, 5 insertions(+), 10 deletions(-)

diff --git a/drivers/net/txgbe/base/txgbe_dcb_hw.c b/drivers/net/txgbe/base/txgbe_dcb_hw.c
index 75c91a6b6a..79e1da447b 100644
--- a/drivers/net/txgbe/base/txgbe_dcb_hw.c
+++ b/drivers/net/txgbe/base/txgbe_dcb_hw.c
@@ -154,7 +154,7 @@ s32 txgbe_dcb_config_tx_data_arbiter_raptor(struct txgbe_hw *hw, u16 *refill,
 	for (i = 0; i < TXGBE_DCB_UP_MAX; i++)
 		reg |= TXGBE_DCBUP2TC_MAP(i, map[i]);
 
-	wr32(hw, TXGBE_PBRXUP2TC, reg);
+	wr32(hw, TXGBE_PBTXUP2TC, reg);
 
 	/* Configure traffic class credits and priority */
 	for (i = 0; i < TXGBE_DCB_TC_MAX; i++) {
diff --git a/drivers/net/txgbe/base/txgbe_regs.h b/drivers/net/txgbe/base/txgbe_regs.h
index 22c46e3d56..4aa62919b4 100644
--- a/drivers/net/txgbe/base/txgbe_regs.h
+++ b/drivers/net/txgbe/base/txgbe_regs.h
@@ -503,10 +503,8 @@
 #define TXGBE_PBRXCTL                   0x019000
 #define   TXGBE_PBRXCTL_ST              MS(0, 0x1)
 #define   TXGBE_PBRXCTL_ENA             MS(31, 0x1)
-#define TXGBE_PBRXUP2TC                 0x019008
 #define TXGBE_PBTXUP2TC                 0x01C800
-#define   TXGBE_DCBUP2TC_MAP(tc, v)     LS(v, 3 * (tc), 0x7)
-#define   TXGBE_DCBUP2TC_DEC(tc, r)     RS(r, 3 * (tc), 0x7)
+#define   TXGBE_DCBUP2TC_MAP(tc, v)     LS(v, 4 * (tc), 0x7)
 #define TXGBE_PBRXSIZE(tc)              (0x019020 + (tc) * 4)
 #define   TXGBE_PBRXSIZE_KB(v)          LS(v, 10, 0x3FF)
 
@@ -1705,7 +1703,7 @@ enum txgbe_5tuple_protocol {
 #define TXGBE_RDM_PF_HIDE(_i)   (0x12090 + ((_i) * 4))
 
 #define TXGBE_RPUP2TC                   0x019008
-#define   TXGBE_RPUP2TC_UP_SHIFT        3
+#define   TXGBE_RPUP2TC_UP_SHIFT        4
 #define   TXGBE_RPUP2TC_UP_MASK         0x7
 
 #define TXGBE_RDM_DCACHE_CTL             0x0120A8
diff --git a/drivers/net/txgbe/txgbe_rxtx.c b/drivers/net/txgbe/txgbe_rxtx.c
index 28b06f3b93..ea4947201e 100644
--- a/drivers/net/txgbe/txgbe_rxtx.c
+++ b/drivers/net/txgbe/txgbe_rxtx.c
@@ -3376,11 +3376,8 @@ txgbe_vmdq_dcb_configure(struct rte_eth_dev *dev)
 
 	queue_mapping = 0;
 	for (i = 0; i < RTE_ETH_DCB_NUM_USER_PRIORITIES; i++)
-		/*
-		 * mapping is done with 3 bits per priority,
-		 * so shift by i*3 each time
-		 */
-		queue_mapping |= ((cfg->dcb_tc[i] & 0x07) << (i * 3));
+		queue_mapping |= ((cfg->dcb_tc[i] & TXGBE_RPUP2TC_UP_MASK) <<
+				  (i * TXGBE_RPUP2TC_UP_SHIFT));
 
 	wr32(hw, TXGBE_RPUP2TC, queue_mapping);
 
-- 
2.21.0.windows.1

