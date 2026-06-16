Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C4514CD98E1
	for <dpdk-dev@archiver.kernel.org>; Tue, 16 Jun 2026 12:21:38 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 2160340E42;
	Tue, 16 Jun 2026 14:21:17 +0200 (CEST)
Received: from smtpbgbr2.qq.com (smtpbgbr2.qq.com [54.207.22.56])
 by mails.dpdk.org (Postfix) with ESMTP id 64F4A40E13;
 Tue, 16 Jun 2026 14:21:11 +0200 (CEST)
X-QQ-mid: esmtpsz20t1781612466t1195fe80
X-QQ-Originating-IP: AbA6D0RxBUOlgoyBZL4XTv4jcM/zbaEr/jV9VgBp7Og=
Received: from DSK-zaiyuwang.trustnetic.com ( [183.157.22.210])
 by bizesmtp.qq.com (ESMTP) with 
 id ; Tue, 16 Jun 2026 20:21:04 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 7881421196719803942
EX-QQ-RecipientCnt: 4
From: Zaiyu Wang <zaiyuwang@trustnetic.com>
To: dev@dpdk.org
Cc: Zaiyu Wang <zaiyuwang@trustnetic.com>, stable@dpdk.org,
 Jiawen Wu <jiawenwu@trustnetic.com>
Subject: [PATCH v6 05/21] net/txgbe: fix inaccuracy in Tx rate limiting
Date: Tue, 16 Jun 2026 20:20:13 +0800
Message-Id: <20260616122030.9688-6-zaiyuwang@trustnetic.com>
X-Mailer: git-send-email 2.21.0.windows.1
In-Reply-To: <20260616122030.9688-1-zaiyuwang@trustnetic.com>
References: <20260423034024.14404-1-zaiyuwang@trustnetic.com>
 <20260616122030.9688-1-zaiyuwang@trustnetic.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: esmtpsz:trustnetic.com:qybglogicsvrsz:qybglogicsvrsz3b-0
X-QQ-XMAILINFO: OVMqbsUyNYbuKe09/eg7d0wreR1jPxENCAEXrZLnVpCpmUH2tylmVc3j
 4DoYYhO5umSRBaJCpL/61VfaPw6dQra3RSYdX1hPoF56rMF0mGnsGw7sfgvWm/G66zFhdSW
 D120yYk2isS6hNZArtJQqrS2D6RKAm3fioCSncsx3bTqgbiTtYEdCJM1VNrJIJas/eVwquN
 4Ab9bPsEqFhE7ntUsnoiqt/n8uqxv849OmURLeqcvSrKPzssCHXuIohrvySny70wC9H6Q33
 8aZxyThJKIIMH1xMoE6DIlKkEYU25YaNTVf6hZ7oCIiqnuOAtbXhrJmrJIUpDHXvy7bvSTJ
 tgVsjR35Uen9i6a8DyiqZXDrPo8TUqnJ2QYqkAOfMKm7mYO4AD8sMGgN+IhrAGm5ZbG/bLx
 McuZaddKUXqQMKeirgcuUxMPdz6RG1DWbKzPQx0b5I6gMCmYIRN6u2Fpw6aRc4r04l8RuCy
 VYxWZC80AhKnhiiV37EWZi0kADAKZJaJ/pmMIHEeumG2D2se45PLoo49nX1Oo9orh4A906K
 wfqzBWzBuRdUGdl6qqow1BUUZ++2WVB29F5M/CU6HMMnAsFc+BIIgO2Hy5v+S8CR7+QaftA
 jEalec3pcR/GP43ji9wtUbb6HR0LqJhKhoZhb0FC3iQ6Z8MB6vQYgY2iEMsNcAdvEs2ad+W
 HpUVvDaUmK//5wrnBjNdmgCDsPKdxG27CPQyGBKWe1c92CWKDXsoswc+Hyt8PjNsY83gisO
 xuFzIQ4rDMaLL9oSPnPW2hIGVbUJf2hXBrWdQbFXOI5Czse1o7zDJ2KPHGlVYNulifW1AlC
 i7SjAaygF4MO/zYPB2mZH+c6380Phv3WQgteFC/inXmeZxWtG2LLlXXcJbTfpN6djnzfo7k
 Ol/1tYlcZ2+Aw1T+OkPBLvJmmaz3gogH/cntkY4GSzQ7QbVS05BovQ/m81l8ZAwkQsp5bWz
 gPxLgIDZ7GDaqW19ajFxbDPoSWjT0dvp/n6U3NA8soCHb5HkcZmFaLVPTK0bjS+knzhBr1Z
 JZ+JizRE60pnrnwxNh90f/6UQppwdv23+zXMKZ7W6lnHzUnBh2qcH8NN3sZsMOCWS8SiiS4
 HCKBmw+7avP
X-QQ-XMRINFO: NyFYKkN4Ny6FuXrnB5Ye7Aabb3ujjtK+gg==
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

Amber-lite NIC's TX rate limiting has large deviations for small
packets. To address this, the following changes are made:

1. Set TDM_RL_ADJ (0x1820c) to 21B (includes 7B Ethernet preamble,
   1B SFD, 1B EFD, and 12B IPG).
2) Remove the rate offset in the driver (e.g., 105 / 100, a rough
   compensation value from Linux kernel driver tests).

After these changes, accuracy deviation for 64B packets is within
~5%, while large packets show lower deviation.

Fixes: a309ab43acf3 ("net/txgbe: support Tx queue rate limiting for Amber-Lite")
Cc: stable@dpdk.org

Signed-off-by: Zaiyu Wang <zaiyuwang@trustnetic.com>
---
 drivers/net/txgbe/base/txgbe_regs.h | 3 +++
 drivers/net/txgbe/txgbe_ethdev.c    | 2 +-
 2 files changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/net/txgbe/base/txgbe_regs.h b/drivers/net/txgbe/base/txgbe_regs.h
index 95c585a025..3d1bc88430 100644
--- a/drivers/net/txgbe/base/txgbe_regs.h
+++ b/drivers/net/txgbe/base/txgbe_regs.h
@@ -1670,6 +1670,9 @@ enum txgbe_5tuple_protocol {
 #define   TXGBE_TDM_FACTOR_INT_SHIFT    16
 #define   TXGBE_TDM_FACTOR_FRA_SHIFT    2
 
+#define TXGBE_TDM_RL_ADJ                0x1820C
+ /* Ethernet framing overhead: 7B Ethernet preamble + 1B SFD + 1B EFD + 12B IPG */
+#define   TXGBE_FRAME_OVERHEAD          21
 #define TXGBE_TDM_RL_VM_IDX             0x018218
 #define TXGBE_TDM_RL_VM_CFG             0x01821C
 #define TXGBE_TDM_RL_CFG                0x018400
diff --git a/drivers/net/txgbe/txgbe_ethdev.c b/drivers/net/txgbe/txgbe_ethdev.c
index 779874aac9..099341b5ab 100644
--- a/drivers/net/txgbe/txgbe_ethdev.c
+++ b/drivers/net/txgbe/txgbe_ethdev.c
@@ -4314,7 +4314,6 @@ txgbe_set_queue_rate_limit(struct rte_eth_dev *dev,
 			u16 frac;
 
 			link_speed = dev->data->dev_link.link_speed;
-			tx_rate  = tx_rate * 105 / 100;
 			/* Calculate the rate factor values to set */
 			factor_int = link_speed / tx_rate;
 			frac = (link_speed % tx_rate) * 10000 / tx_rate;
@@ -4324,6 +4323,7 @@ txgbe_set_queue_rate_limit(struct rte_eth_dev *dev,
 				factor_fra = 0;
 			}
 
+			wr32(hw, TXGBE_TDM_RL_ADJ, TXGBE_FRAME_OVERHEAD);
 			wr32(hw, TXGBE_TDM_RL_QUEUE_IDX, queue_idx);
 			wr32m(hw, TXGBE_TDM_RL_QUEUE_CFG,
 			      TXGBE_TDM_FACTOR_INT_MASK, factor_int << TXGBE_TDM_FACTOR_INT_SHIFT);
-- 
2.21.0.windows.1

