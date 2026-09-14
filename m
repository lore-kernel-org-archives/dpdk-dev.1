Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C9172C88E64
	for <dpdk-dev@archiver.kernel.org>; Mon, 14 Sep 2026 11:49:47 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id EA73E40DC9;
	Mon, 14 Sep 2026 13:49:32 +0200 (CEST)
Received: from mail.amicon.ru (mail.amicon.ru [77.108.111.100])
 by mails.dpdk.org (Postfix) with ESMTP id 0418340144;
 Mon, 14 Sep 2026 12:09:19 +0200 (CEST)
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
DKIM-Signature: v=1; a=rsa-sha256; d=amicon.ru; s=mail; c=simple/simple;
 t=1789380558; h=from:subject:to:date:message-id;
 bh=Y+B2OByauhsypaazCe83ifo09fO5lkspqk+Qz6bhMZ8=;
 b=WE/94lPUva+vfaL5pr1Senj69FyFBy4Mwub79t5cneayclD+EIF54t4Zg+0qJHHct7rULcal6Ug
 YGAwRteHqSBK3NQ/9UnWMHWugA01Z7NEdej4j72P0I/T9K2GX4PtYhFio3ZJ0Udw2/NvVoW8hmrQa
 jCRwlWVQIPNyt85np0MhX+pz817pxmmov2457ZpsngAe8LA3fJ9So01dUdGwyu4hX/WBhqmSlSW7k
 wSPLJl0Npn7jY86OfUdxUzpfGr9g2cYvPk4+1Hlgvj/CF0I8fwCCJdo9+bQnHq6n6X2r8OFCkScPB
 wGQY3W6RXTdG4UqjOb+B6wwL6VG/yPDfqvAw==
Received: from amicon.ru (172.16.36.76) by mail.amicon.lan (192.168.0.59) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.27; Mon, 14 Sep
 2026 13:09:17 +0300
From: Artem Novikov <naa@amicon.ru>
To: <dev@dpdk.org>
CC: <naa@amicon.ru>, <rrv@amicon.ru>, <lvc-project@linuxtesting.org>,
 <bruce.richardson@intel.com>, <guinanx.sun@intel.com>, <stable@dpdk.org>
Subject: [PATCH] net/e1000/base: check i210 PHY access errors
Date: Mon, 14 Sep 2026 13:08:57 +0300
Message-ID: <20260914100858.55336-1-naa@amicon.ru>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
X-Originating-IP: [172.16.36.76]
X-Mailman-Approved-At: Mon, 14 Sep 2026 13:49:28 +0200
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

The i210 PLL workaround switches the internal PHY page before
reading the PLL frequency register and then switches the page back
to zero. These direct MDIC operations can fail, but the results
were ignored.

Propagate failures from the semaphore acquisition and the
page-select/read/restore sequence. Preserve the original MDIC read
error when page restoration succeeds, while still reporting a
restore failure when it is the first error seen.

Fixes: 3f0188c8f298 ("net/e1000/base: update for i210 slow system clock")
Cc: stable@dpdk.org

Signed-off-by: Artem Novikov <naa@amicon.ru>
---
 drivers/net/intel/e1000/base/e1000_i210.c | 25 ++++++++++++++++++-----
 1 file changed, 20 insertions(+), 5 deletions(-)

diff --git a/drivers/net/intel/e1000/base/e1000_i210.c b/drivers/net/intel/e1000/base/e1000_i210.c
index 479d2dc2c2..27b33cae37 100644
--- a/drivers/net/intel/e1000/base/e1000_i210.c
+++ b/drivers/net/intel/e1000/base/e1000_i210.c
@@ -824,13 +824,16 @@ STATIC s32 e1000_valid_led_default_i210(struct e1000_hw *hw, u16 *data)
  **/
 STATIC s32 e1000_pll_workaround_i210(struct e1000_hw *hw)
 {
-	s32 ret_val;
+	s32 ret_val, page_ret_val;
 	u32 wuc, mdicnfg, ctrl, ctrl_ext, reg_val;
 	u16 nvm_word, phy_word, pci_word, tmp_nvm;
 	int i;
 
 	/* Get PHY semaphore */
-	hw->phy.ops.acquire(hw);
+	ret_val = hw->phy.ops.acquire(hw);
+	if (ret_val)
+		return ret_val;
+
 	/* Get and set needed register values */
 	wuc = E1000_READ_REG(hw, E1000_WUC);
 	mdicnfg = E1000_READ_REG(hw, E1000_MDICNFG);
@@ -846,11 +849,22 @@ STATIC s32 e1000_pll_workaround_i210(struct e1000_hw *hw)
 	phy_word = E1000_PHY_PLL_UNCONF;
 	for (i = 0; i < E1000_MAX_PLL_TRIES; i++) {
 		/* check current state directly from internal PHY */
-		e1000_write_phy_reg_mdic(hw, GS40G_PAGE_SELECT, 0xFC);
+		ret_val = e1000_write_phy_reg_mdic(hw, GS40G_PAGE_SELECT, 0xFC);
+		if (ret_val)
+			goto restore_page;
+
 		usec_delay(20);
-		e1000_read_phy_reg_mdic(hw, E1000_PHY_PLL_FREQ_REG, &phy_word);
+		ret_val = e1000_read_phy_reg_mdic(hw, E1000_PHY_PLL_FREQ_REG,
+						  &phy_word);
 		usec_delay(20);
-		e1000_write_phy_reg_mdic(hw, GS40G_PAGE_SELECT, 0);
+
+restore_page:
+		page_ret_val = e1000_write_phy_reg_mdic(hw, GS40G_PAGE_SELECT, 0);
+		if (page_ret_val && ret_val == E1000_SUCCESS)
+			ret_val = page_ret_val;
+		if (ret_val)
+			goto out;
+
 		if ((phy_word & E1000_PHY_PLL_UNCONF)
 		    != E1000_PHY_PLL_UNCONF) {
 			ret_val = E1000_SUCCESS;
@@ -882,6 +896,7 @@ STATIC s32 e1000_pll_workaround_i210(struct e1000_hw *hw)
 		/* restore WUC register */
 		E1000_WRITE_REG(hw, E1000_WUC, wuc);
 	}
+out:
 	/* restore MDICNFG setting */
 	E1000_WRITE_REG(hw, E1000_MDICNFG, mdicnfg);
 	/* Release PHY semaphore */
-- 
2.43.0

