Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BF9F0FAD3F8
	for <dpdk-dev@archiver.kernel.org>; Thu, 23 Apr 2026 03:42:10 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id A466340A6C;
	Thu, 23 Apr 2026 05:41:23 +0200 (CEST)
Received: from smtpbgbr2.qq.com (smtpbgbr2.qq.com [54.207.22.56])
 by mails.dpdk.org (Postfix) with ESMTP id C4E70406FF;
 Thu, 23 Apr 2026 05:41:20 +0200 (CEST)
X-QQ-mid: zesmtpgz4t1776915677te1563952
X-QQ-Originating-IP: pgPvUEfQXZCkzRsNHjEYqV3G0Wm6AuSLE5T2+hkKtEM=
Received: from DSK-zaiyuwang.trustnetic.com ( [115.220.225.180])
 by bizesmtp.qq.com (ESMTP) with 
 id ; Thu, 23 Apr 2026 11:41:15 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 16099726469634549823
EX-QQ-RecipientCnt: 4
From: Zaiyu Wang <zaiyuwang@trustnetic.com>
To: dev@dpdk.org
Cc: Zaiyu Wang <zaiyuwang@trustnetic.com>, stable@dpdk.org,
 Jiawen Wu <jiawenwu@trustnetic.com>
Subject: [PATCH 11/18] net/txgbe: fix traffic class priority configuration
Date: Thu, 23 Apr 2026 11:40:16 +0800
Message-Id: <20260423034024.14404-12-zaiyuwang@trustnetic.com>
X-Mailer: git-send-email 2.21.0.windows.1
In-Reply-To: <20260423034024.14404-1-zaiyuwang@trustnetic.com>
References: <20260423034024.14404-1-zaiyuwang@trustnetic.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: zesmtpgz:trustnetic.com:qybglogicsvrsz:qybglogicsvrsz3b-0
X-QQ-XMAILINFO: NNbmL8osjKKNMyE8MymjjCidsK1I0NkFJDf85akve78qlsIzpdfpZVlT
 GMMz8uRK34r/+NJ3sHBLflvlohDlqkDwGQ8JjNgFnKshi4786SHKJgB62dp9UlPoei2kVrK
 PZSDwkrrDyuK6tLdRj/xXQyFYnUqTUn3+GsGoo0p3lnkgUAmnfHeFdLquLWQvjEhECWc7GU
 tTl9qQXAVgsf6OaXchCxxoNmogPZw9DL4dpS6RZkgBziWgrmzMBb4jp+39IlXVpxtnvJ5Zc
 B/tFXw6g66NsxBqwtVYGXf28CVK7onCKefiBQTnOvtIbkZE0Ev76dReyYObtJRa4AU7x1lH
 Vrq9PL7oRL8ZgpzECRxAmv32HHDlEqiyHyXxEyQon6PduPlCoQA/68mnPgRl39+CmznwXWL
 M9b6zcQwF2f5Ti6XVIq3knYm9QMaKuoGriOPlqfoDSHOi2Ui7/Cw+O8Hu3VXD/G3iEs+EuR
 yjMAzzcquPNd5bYh8AU26BbK75zhXr/+XHNx7NBay32DrPNPQahVAzzmG8XeVlT5ULVoJgE
 D8jcgj6VuhyC23E+31yzjDkzGkt3b7UEW18Mq/oP0WcGhnCV7jk1zHCF6+0rugksCsfPxzm
 v9unIxJea+zm0pL2UxSCuQujVVk7OIgCjajqWzNGle/trKfAie41LKivXfODdXMhJOrzRmh
 FeW91Al8lV3hiuYCESGpcUt5LLxrA7MfR/cJFaJZC4mT6e+emQWsDhERa/k8YF9HWoxmSRj
 BqqUBuR/bR9V+I9BGml5cluiuDS0OksXP7Z0KjmCGGpWB9lqzYtQet/gidzB7it0qJJhVdl
 7Ppu14xar4IsfWc8BQq33VE+ZNbRYXat+PlussyRtUpSsGm8E1moPcoS698eAEVwGy/wEzI
 xEvJ+1LpoDvYcQmniVekSAdjvKVRgz48jaFrl9BVHbglLAa/TWv8dOaaYEj641Jgu+FYcEp
 4EjJs9AvRjqSKOENSI4ovjRKChB2aSxhnMdR36Cx81/xTnBzaml5jdsT9Kk35tLmtwQO3d2
 36dsaSaTXh2t9rpix/V9Ref3+AwiaJHnYJT+gLL1uaRx8Mjyu/TUJ8ixPtZymaTNMrhIbzn
 A==
X-QQ-XMRINFO: OWPUhxQsoeAVwkVaQIEGSKwwgKCxK/fD5g==
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
   priority-to-TC mapping, but the driver incorrectly configured it as 3 bits.
2. The DCB TX configuration mistakenly wrote to the RX register.

Fix both issues, ensuring that tc-prio mapping works as expected.

Cc: stable@dpdk.org

Signed-off-by: Zaiyu Wang <zaiyuwang@trustnetic.com>
---
 drivers/net/txgbe/base/txgbe_dcb_hw.c | 2 +-
 drivers/net/txgbe/base/txgbe_regs.h   | 5 ++---
 2 files changed, 3 insertions(+), 4 deletions(-)

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
index de382601c9..bc73f28ca2 100644
--- a/drivers/net/txgbe/base/txgbe_regs.h
+++ b/drivers/net/txgbe/base/txgbe_regs.h
@@ -503,9 +503,8 @@
 #define TXGBE_PBRXCTL                   0x019000
 #define   TXGBE_PBRXCTL_ST              MS(0, 0x1)
 #define   TXGBE_PBRXCTL_ENA             MS(31, 0x1)
-#define TXGBE_PBRXUP2TC                 0x019008
 #define TXGBE_PBTXUP2TC                 0x01C800
-#define   TXGBE_DCBUP2TC_MAP(tc, v)     LS(v, 3 * (tc), 0x7)
+#define   TXGBE_DCBUP2TC_MAP(tc, v)     LS(v, 4 * (tc), 0x7)
 #define   TXGBE_DCBUP2TC_DEC(tc, r)     RS(r, 3 * (tc), 0x7)
 #define TXGBE_PBRXSIZE(tc)              (0x019020 + (tc) * 4)
 #define   TXGBE_PBRXSIZE_KB(v)          LS(v, 10, 0x3FF)
@@ -1703,7 +1702,7 @@ enum txgbe_5tuple_protocol {
 #define TXGBE_RDM_PF_HIDE(_i)   (0x12090 + ((_i) * 4))
 
 #define TXGBE_RPUP2TC                   0x019008
-#define   TXGBE_RPUP2TC_UP_SHIFT        3
+#define   TXGBE_RPUP2TC_UP_SHIFT        4
 #define   TXGBE_RPUP2TC_UP_MASK         0x7
 
 #define TXGBE_RDM_DCACHE_CTL             0x0120A8
-- 
2.21.0.windows.1

