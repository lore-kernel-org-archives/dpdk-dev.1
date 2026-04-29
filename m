Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4CA35FF8867
	for <dpdk-dev@archiver.kernel.org>; Wed, 29 Apr 2026 10:27:27 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 4803640667;
	Wed, 29 Apr 2026 12:26:52 +0200 (CEST)
Received: from smtpbgbr2.qq.com (smtpbgbr2.qq.com [54.207.22.56])
 by mails.dpdk.org (Postfix) with ESMTP id B874B4066A;
 Wed, 29 Apr 2026 12:26:41 +0200 (CEST)
X-QQ-mid: esmtpgz10t1777458394t1a784f4c
X-QQ-Originating-IP: zJf6awVR8gn+jC9Xx5gMmQrVRMRsZ1xQhDwBD5zZ4CI=
Received: from DSK-zaiyuwang.trustnetic.com ( [36.24.191.108])
 by bizesmtp.qq.com (ESMTP) with 
 id ; Wed, 29 Apr 2026 18:26:32 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 4140990884731147463
EX-QQ-RecipientCnt: 5
From: Zaiyu Wang <zaiyuwang@trustnetic.com>
To: dev@dpdk.org
Cc: Zaiyu Wang <zaiyuwang@trustnetic.com>, stable@dpdk.org,
 Jiawen Wu <jiawenwu@trustnetic.com>, Ferruh Yigit <ferruh.yigit@amd.com>
Subject: [PATCH v2 11/20] net/txgbe: fix traffic class priority configuration
Date: Wed, 29 Apr 2026 18:25:05 +0800
Message-Id: <20260429102515.58880-12-zaiyuwang@trustnetic.com>
X-Mailer: git-send-email 2.21.0.windows.1
In-Reply-To: <20260429102515.58880-1-zaiyuwang@trustnetic.com>
References: <20260423034024.14404-1-zaiyuwang@trustnetic.com>
 <20260429102515.58880-1-zaiyuwang@trustnetic.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: esmtpgz:trustnetic.com:qybglogicsvrsz:qybglogicsvrsz3b-0
X-QQ-XMAILINFO: MZQHZNohqAr19SMYQNnxvJSsJJY82T4jYCe2pIrVGOZoAawu51yCja66
 32vBYHaZGU5AFG0yvz2bVIo6XxTjRu3GJ5G11eqiRntGnws4GfLY6gbMb/Bv5P8pjuYwBug
 eMsVr242EAadc3/Di71jSXonRds/Aggq/IzM8yq5pmwWnNau3FFXdwWLASnFZoaFfqapD5N
 di5GEMDW64ccFIG1xawQMeNpnkLLRrWDkul8/mnAkXqfnQZxsiDg8dwV7zLskWU0t/jUJek
 M9xUNmlDLh6EorfzBwY58eztoY71sbQ3HVu71nGV8Vb/VfJSKpRk2j58KMSzpGVfvVW0wyw
 w0DmiGDcrIlW7pIoVw97cADG2f7fah5BcLrieM4hKBEtVNT47iXBLkIN8QJm4n5IOP11U6l
 G8rdxHTY2Zk8i3llR8hA6y4SpNM9kq9W/8bkPbP/ZeY2tTD/3aIZkmYCwnBW7lWnvJ15Tzf
 bcw4pndskJDeqi/8aXVU7eL4RmPxyx44OpsP9kf8Rj3EbynZJRe820aN/MUwMOBF6wN5FFq
 k7As57AjhYm2L7vGdfV8ziBDR/u3zedBzQbr04CLPeZMNXCrSADf5nlbdHdJdq+am4SFuEt
 hP/9aKz3e1/m1XqaSeOocFmTkEraqnpCEvZypJlIrCCIh5SwveeBJxFbIWlSNNirDOmBuyA
 g5qTo3ik+EHFFDu5iOOYnyz6msuaArxInWkMIvxihaiSweknkE5+PJbbQHROJpMCJ1boCnP
 2h69CrXYvK4eXeRVJLAWvkkCPzrPeYhps7MemyeWvhJmWRW39p8UJCVyNOrkvzxZpanIHWK
 7Pxu7vo8nwcuadJf1HOaz2FjglGKSWclYHkJCvGGE+XQdxJmWy++BqMyWzHMjDWXfOipil/
 PiplrvgiLsZp6cVtCv/2u+UfwjD+DVuwFuI6Flm4GpgehVwpHbmdZNhSiE7Aqs2NPz3md33
 w8Val//FNeTokC3Eu8S/AXqnyZDP9ivnHKbVX3D5pkoX5Jz432M1UMe01dzrpr8qr6eAwCR
 sWX3lWlbej8aBgfTgYkYZoZxy4wgsjjNksTl75gm8szsWdXhWXsX02VneQ8k9OX5GYm4I7y
 A==
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

After applying the following testpmd command, 802.1Q packets with specific
priorities were not properly directed to the corresponding traffic classes:
    port config 0 dcb vt off 4 pfc off

The old driver had two issues:
1. The hardware uses a 4-bit mapping register per traffic class for
   priority-to-TC mapping, but the driver incorrectly configured it
   as 3 bits.
2. The DCB TX configuration mistakenly wrote to the RX register.

Fix both issues, ensuring that tc-prio mapping works as expected.

Fixes: 8bdc7882f376 ("net/txgbe: support DCB")
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

