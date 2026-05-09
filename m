Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 15555CD343F
	for <dpdk-dev@archiver.kernel.org>; Sat,  9 May 2026 11:29:31 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 9241640678;
	Sat,  9 May 2026 13:29:10 +0200 (CEST)
Received: from smtpbguseast1.qq.com (smtpbguseast1.qq.com [54.204.34.129])
 by mails.dpdk.org (Postfix) with ESMTP id 7411840673;
 Sat,  9 May 2026 13:29:06 +0200 (CEST)
X-QQ-mid: zesmtpgz1t1778326140t728b4b06
X-QQ-Originating-IP: dmds/nkra1b17obdd4Zggc8qJ3/7tuI33UrvlNsIKo0=
Received: from DSK-zaiyuwang.trustnetic.com ( [115.204.251.157])
 by bizesmtp.qq.com (ESMTP) with 
 id ; Sat, 09 May 2026 19:28:59 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 4341777369527933098
EX-QQ-RecipientCnt: 4
From: Zaiyu Wang <zaiyuwang@trustnetic.com>
To: dev@dpdk.org
Cc: Zaiyu Wang <zaiyuwang@trustnetic.com>, stable@dpdk.org,
 Jiawen Wu <jiawenwu@trustnetic.com>
Subject: [PATCH v3 05/20] net/txgbe: fix inaccuracy in TX rate limiting
Date: Sat,  9 May 2026 19:28:07 +0800
Message-Id: <20260509112823.7728-6-zaiyuwang@trustnetic.com>
X-Mailer: git-send-email 2.21.0.windows.1
In-Reply-To: <20260509112823.7728-1-zaiyuwang@trustnetic.com>
References: <20260423034024.14404-1-zaiyuwang@trustnetic.com>
 <20260509112823.7728-1-zaiyuwang@trustnetic.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: zesmtpgz:trustnetic.com:qybglogicsvrsz:qybglogicsvrsz3b-0
X-QQ-XMAILINFO: NOIkHYnr7Vzdp/2HeafEPAW/u7wdNdLplKIGTX6v8BA5hElZl3Sfv+24
 PmqlswUKwjpXM4uZ2SV8Ssf69m7/NkSNZQ5a+BJ8tPYYynnCAGBAKP/1FU+4X0SWiGJS2+7
 VNXV5OhD5Y+m6c+aFB0UH0zjCK15QRIv6eEm4sULPZrwUaZlkIluKah/u2J18clLtuT65i0
 rtZi7DzzWNoXD3oRYEaqvxqVZhX+DO/9YOLac9YzGOU6MjmJ+FpZU3cwvrkq5f8LZnDP65A
 GZWQZNhZI+kugOT7QLPaJ4GpL1nM0MqqHmo+Wy6vOwZqBH4caGGW8XKmNks5iioI8oI3Qd3
 zvWRjshpVR7hW/rQu1wGHysGvn9N7eCR2NdquMo/ziGN9y2VXI5x/qyFKi3WUG39Klp4+NA
 G3MyfjWs/IYAmn/E8v9bkmaFKEQLzxWDnGsUxcvkUpiZpEM5p9KfJj/whrWd3QO1uX1+fsX
 aWUu+jKF4i6H5DMj2uuux6Yz4wNyCsfF8ciO31SHYSyWLWEFQ8TlmFAyJacz2fjUYhRcm/R
 8V+WU3dTgY23GJjkhsyIBhAlBmUfW8wnRYD+sHIwoLDKFa9gNQnjN/SgZSfr/mhfF9OF48u
 l7yUh1QJ7nq0geh0micsT8ij+9ZN7//ztLQ2FL8ctqWaVRnUyc4dGQ7gAYBrNsfzH2Dl86G
 2Om8rWTTtreeZmKW+cfCoJq0Z85UhMFhYF+Q5uC542R3aOnDMzA/NZCRHNuxoiQoDs/2zbd
 MSq2CEX/SiJMLfGSVKgzso9rLoSxHoitTehFxNSCBQCfY2eaa51ljKi3caPcc27eT0g+nie
 QlJNph2OwfLDdig0U/uOOL3z0ZbbpSVbe2Ah2shZH9Ow4RuD52++MbNWXc4Vq5xiHZ9QKwr
 /kX1750rrAbQzCMR66U/kimmCJjSxUk7q7GuMZ4l5Pt5s8m6ic/941OW1xLk14vrLpCC1g0
 g4Qvj/894y+e77j9V2YOnRgWggeEgJP7nQ41DAIgwXNY0jMIVba/+Wlnl+bbYF7tJPtSw9r
 gaYMtiLCb3bi+CzG5745sY/xQEsGKh7ERPNonAqOuwP6Vgfu5DgesODz15sTc=
X-QQ-XMRINFO: MPJ6Tf5t3I/ylTmHUqvI8+Wpn+Gzalws3A==
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
packets. To fix this issue, there are some changes:

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
 drivers/net/txgbe/base/txgbe_regs.h | 1 +
 drivers/net/txgbe/txgbe_ethdev.c    | 2 +-
 2 files changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/net/txgbe/base/txgbe_regs.h b/drivers/net/txgbe/base/txgbe_regs.h
index 95c585a025..060757323a 100644
--- a/drivers/net/txgbe/base/txgbe_regs.h
+++ b/drivers/net/txgbe/base/txgbe_regs.h
@@ -1670,6 +1670,7 @@ enum txgbe_5tuple_protocol {
 #define   TXGBE_TDM_FACTOR_INT_SHIFT    16
 #define   TXGBE_TDM_FACTOR_FRA_SHIFT    2
 
+#define TXGBE_TDM_RL_ADJ                0x1820C
 #define TXGBE_TDM_RL_VM_IDX             0x018218
 #define TXGBE_TDM_RL_VM_CFG             0x01821C
 #define TXGBE_TDM_RL_CFG                0x018400
diff --git a/drivers/net/txgbe/txgbe_ethdev.c b/drivers/net/txgbe/txgbe_ethdev.c
index 779874aac9..414107d7a7 100644
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
 
+			wr32(hw, TXGBE_TDM_RL_ADJ, 21);
 			wr32(hw, TXGBE_TDM_RL_QUEUE_IDX, queue_idx);
 			wr32m(hw, TXGBE_TDM_RL_QUEUE_CFG,
 			      TXGBE_TDM_FACTOR_INT_MASK, factor_int << TXGBE_TDM_FACTOR_INT_SHIFT);
-- 
2.21.0.windows.1

