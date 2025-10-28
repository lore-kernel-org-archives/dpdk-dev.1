Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 27C56CCF9E0
	for <dpdk-dev@archiver.kernel.org>; Tue, 28 Oct 2025 08:47:56 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 9FDBF40659;
	Tue, 28 Oct 2025 09:47:46 +0100 (CET)
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
 by mails.dpdk.org (Postfix) with ESMTP id A0A93406BC
 for <dev@dpdk.org>; Tue, 28 Oct 2025 09:47:44 +0100 (CET)
X-SpamFilter-By: ArmorX SpamTrap 5.80 with qID 59S8lgKE32161783,
 This message is accepted by code: ctloc85258
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=realsil.com.cn;
 s=dkim; t=1761641263;
 bh=XoJukuaL+59ZsrTvGs3ac8I+tpS1krG0y2iXldzt0OI=;
 h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
 MIME-Version:Content-Transfer-Encoding:Content-Type;
 b=B7CZGxpX8kwXStQWRVL72at690g+irjMy5ACrrlNTRS6IhUmulSnuquzGyhmiTzYW
 oH46nFTsQwnqN+0f2vrsWfGaa6jkpdkJuO/4X82AWnS6YwLqiQnQLSAq7W/MLDqo6C
 q9NfDuDyKeJiFkn1c/5BfC4bQWImUW6mC9TbWLoPZMlx+YUKmVdRMNfMbWnnFOMAWc
 xmK70E3vQmQ1iwO4f4e4uZMdoqfdFvWJnlrDa4J29WrD+GdA9Xi7QCwytwLJEc2qof
 JwQTjK26rfQ66AuIbxci3b0glvcZIN9awUA1Draq1+nQKkEObeSRIaWx3YOObrM/cF
 KcyPxmoJKYlZQ==
Received: from RS-EX-MBS1.realsil.com.cn ([172.29.17.101])
 by rtits2.realtek.com.tw (8.15.2/3.13/5.93) with ESMTPS id 59S8lgKE32161783
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL)
 for <dev@dpdk.org>; Tue, 28 Oct 2025 16:47:42 +0800
Received: from RS-EX-MBS2.realsil.com.cn (172.29.17.102) by
 RS-EX-MBS1.realsil.com.cn (172.29.17.101) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.33; Tue, 28 Oct 2025 16:47:42 +0800
Received: from 172.29.32.27 (172.29.32.27) by RS-EX-MBS2.realsil.com.cn
 (172.29.17.102) with Microsoft SMTP Server id 15.2.1544.33 via Frontend
 Transport; Tue, 28 Oct 2025 16:47:42 +0800
From: Howard Wang <howard_wang@realsil.com.cn>
To: <dev@dpdk.org>
CC: <pro_nic_dpdk@realtek.com>, Howard Wang <howard_wang@realsil.com.cn>
Subject: [PATCH v1 3/3] net/r8169: fix issues reported by Coverity
Date: Tue, 28 Oct 2025 16:47:16 +0800
Message-ID: <20251028084716.369128-4-howard_wang@realsil.com.cn>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20251028084716.369128-1-howard_wang@realsil.com.cn>
References: <20251028084716.369128-1-howard_wang@realsil.com.cn>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
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

Signed-off-by: Howard Wang <howard_wang@realsil.com.cn>
---
 drivers/net/r8169/r8169_hw.c   | 10 ++++-----
 drivers/net/r8169/r8169_phy.c  |  2 +-
 drivers/net/r8169/r8169_rxtx.c | 37 +++++++++++++++++++---------------
 3 files changed, 27 insertions(+), 22 deletions(-)

diff --git a/drivers/net/r8169/r8169_hw.c b/drivers/net/r8169/r8169_hw.c
index f69f87c202..e1521f5f9d 100644
--- a/drivers/net/r8169/r8169_hw.c
+++ b/drivers/net/r8169/r8169_hw.c
@@ -346,16 +346,16 @@ rtl_oob_mutex_lock(struct rtl_hw *hw)
 	}
 
 	rtl_ocp_write(hw, ocp_reg_mutex_ib, 1, BIT_0);
-	reg_16 = rtl_ocp_read(hw, ocp_reg_mutex_oob, 1);
+	reg_16 = (u8)rtl_ocp_read(hw, ocp_reg_mutex_oob, 1);
 	wait_cnt_0 = 0;
 	while (reg_16) {
-		reg_a0 = rtl_ocp_read(hw, ocp_reg_mutex_prio, 1);
+		reg_a0 = (u8)rtl_ocp_read(hw, ocp_reg_mutex_prio, 1);
 		if (reg_a0) {
 			rtl_ocp_write(hw, ocp_reg_mutex_ib, 1, 0x00);
-			reg_a0 = rtl_ocp_read(hw, ocp_reg_mutex_prio, 1);
+			reg_a0 = (u8)rtl_ocp_read(hw, ocp_reg_mutex_prio, 1);
 			wait_cnt_1 = 0;
 			while (reg_a0) {
-				reg_a0 = rtl_ocp_read(hw, ocp_reg_mutex_prio, 1);
+				reg_a0 = (u8)rtl_ocp_read(hw, ocp_reg_mutex_prio, 1);
 
 				wait_cnt_1++;
 
@@ -364,7 +364,7 @@ rtl_oob_mutex_lock(struct rtl_hw *hw)
 			};
 			rtl_ocp_write(hw, ocp_reg_mutex_ib, 1, BIT_0);
 		}
-		reg_16 = rtl_ocp_read(hw, ocp_reg_mutex_oob, 1);
+		reg_16 = (u8)rtl_ocp_read(hw, ocp_reg_mutex_oob, 1);
 
 		wait_cnt_0++;
 
diff --git a/drivers/net/r8169/r8169_phy.c b/drivers/net/r8169/r8169_phy.c
index 9bb5774672..50c24d1504 100644
--- a/drivers/net/r8169/r8169_phy.c
+++ b/drivers/net/r8169/r8169_phy.c
@@ -807,7 +807,7 @@ rtl8168_phy_ram_code_check(struct rtl_hw *hw)
 				retval = FALSE;
 		}
 
-		retval = rtl_clear_phy_mcu_patch_request(hw);
+		rtl_clear_phy_mcu_patch_request(hw);
 
 		rte_delay_ms(2);
 	}
diff --git a/drivers/net/r8169/r8169_rxtx.c b/drivers/net/r8169/r8169_rxtx.c
index 50a47c3670..37f4c4da80 100644
--- a/drivers/net/r8169/r8169_rxtx.c
+++ b/drivers/net/r8169/r8169_rxtx.c
@@ -1707,9 +1707,6 @@ rtl8125_tx_clean(struct rtl_hw *hw, struct rtl_tx_queue *txq)
 	uint32_t tx_left;
 	uint32_t tx_desc_closed;
 
-	if (!txq)
-		return;
-
 	if (enable_tx_no_close) {
 		txq->NextHwDesCloPtr = rtl_get_hw_clo_ptr(txq);
 		tx_desc_closed = rtl_fast_mod_mask(txq->NextHwDesCloPtr -
@@ -1755,9 +1752,6 @@ rtl8168_tx_clean(struct rtl_hw *hw __rte_unused, struct rtl_tx_queue *txq)
 	int head = txq->tx_head;
 	uint16_t desc_freed = 0;
 
-	if (!txq)
-		return;
-
 	while (1) {
 		txd = &txq->hw_ring[head];
 
@@ -1794,13 +1788,13 @@ static int
 rtl8125_tx_done_cleanup(void *tx_queue, uint32_t free_cnt)
 {
 	struct rtl_tx_queue *txq = tx_queue;
-	struct rtl_hw *hw = txq->hw;
-	struct rtl_tx_entry *sw_ring = txq->sw_ring;
+	struct rtl_hw *hw;
+	struct rtl_tx_entry *sw_ring;
 	struct rtl_tx_entry *txe;
 	struct rtl_tx_desc *txd;
-	const uint8_t enable_tx_no_close = hw->EnableTxNoClose;
-	const uint16_t nb_tx_desc = txq->nb_tx_desc;
-	uint16_t head = txq->tx_head;
+	uint8_t enable_tx_no_close;
+	uint16_t nb_tx_desc;
+	uint16_t head;
 	uint16_t desc_freed = 0;
 	uint32_t tx_left;
 	uint32_t count = 0;
@@ -1810,6 +1804,12 @@ rtl8125_tx_done_cleanup(void *tx_queue, uint32_t free_cnt)
 	if (!txq)
 		return -ENODEV;
 
+	hw = txq->hw;
+	enable_tx_no_close = hw->EnableTxNoClose;
+	sw_ring = txq->sw_ring;
+	nb_tx_desc = txq->nb_tx_desc;
+	head = txq->tx_head;
+
 	if (enable_tx_no_close) {
 		txq->NextHwDesCloPtr = rtl_get_hw_clo_ptr(txq);
 		tx_desc_closed = rtl_fast_mod_mask(txq->NextHwDesCloPtr -
@@ -1860,19 +1860,24 @@ static int
 rtl8168_tx_done_cleanup(void *tx_queue, uint32_t free_cnt)
 {
 	struct rtl_tx_queue *txq = tx_queue;
-	struct rtl_tx_entry *sw_ring = txq->sw_ring;
+	struct rtl_tx_entry *sw_ring;
 	struct rtl_tx_entry *txe;
 	struct rtl_tx_desc *txd;
-	const uint16_t nb_tx_desc = txq->nb_tx_desc;
-	const int tx_tail = txq->tx_tail % nb_tx_desc;
-	int head = txq->tx_head;
+	uint16_t nb_tx_desc;
 	uint16_t desc_freed = 0;
-	int count = 0;
 	uint32_t status;
+	int tx_tail;
+	int head;
+	int count = 0;
 
 	if (!txq)
 		return -ENODEV;
 
+	sw_ring = txq->sw_ring;
+	nb_tx_desc = txq->nb_tx_desc;
+	tx_tail = txq->tx_tail % nb_tx_desc;
+	head = txq->tx_head;
+
 	while (1) {
 		txd = &txq->hw_ring[head];
 
-- 
2.34.1

