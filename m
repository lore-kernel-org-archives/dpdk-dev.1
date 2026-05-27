Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 91A89CD5BD5
	for <dpdk-dev@archiver.kernel.org>; Wed, 27 May 2026 13:05:10 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id BC1FD40BA6;
	Wed, 27 May 2026 15:04:01 +0200 (CEST)
Received: from smtpbgsg1.qq.com (smtpbgsg1.qq.com [54.254.200.92])
 by mails.dpdk.org (Postfix) with ESMTP id CB44C40689;
 Wed, 27 May 2026 15:03:58 +0200 (CEST)
X-QQ-mid: esmtpsz19t1779887035tc05232a2
X-QQ-Originating-IP: JhhL37bOGSumF339zuWOpxQAlyZLJAvWZ9+FFWzmZ70=
Received: from DSK-zaiyuwang.trustnetic.com ( [122.231.28.113])
 by bizesmtp.qq.com (ESMTP) with 
 id ; Wed, 27 May 2026 21:03:53 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 16909530328550077712
EX-QQ-RecipientCnt: 4
From: Zaiyu Wang <zaiyuwang@trustnetic.com>
To: dev@dpdk.org
Cc: Zaiyu Wang <zaiyuwang@trustnetic.com>, stable@dpdk.org,
 Jiawen Wu <jiawenwu@trustnetic.com>
Subject: [PATCH v5 15/21] net/txgbe: fix FEC mode configuration on 25G NIC
Date: Wed, 27 May 2026 21:02:15 +0800
Message-Id: <20260527130222.24348-16-zaiyuwang@trustnetic.com>
X-Mailer: git-send-email 2.21.0.windows.1
In-Reply-To: <20260527130222.24348-1-zaiyuwang@trustnetic.com>
References: <20260423034024.14404-1-zaiyuwang@trustnetic.com>
 <20260527130222.24348-1-zaiyuwang@trustnetic.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: esmtpsz:trustnetic.com:qybglogicsvrsz:qybglogicsvrsz3b-0
X-QQ-XMAILINFO: OA34ehyuJLv36MRyT0E9mpC+algWwJxno5ljiJeeyYcOGoBImhiSefeH
 WvdDAFwCUV5sCjYKPMTWBsiDOwhRuQZ41TZXH3IwBXM5vq2yF/ZaxBGL2KBS1iw+sXO4JAj
 wB6hTGAdxBMl68cNACyQI8sUR7YyLxQa8r3hMDK2bTn2i2l99FO+9gkV5pHp/KRMA/fbxQc
 eQdZn51MTf4bWOS1XRDoUFTsOf0L/zLw6xhlYMyXkmfqBhkkf05db6qhSZGnl3Kcxclm+JJ
 e+oPzSC81FLcE6WWD1gYnQOsFNxmhdlMi9qQ1kVMW1HLxasM6u7npMjYQXzZ+22tnYQHA9J
 iJ2rMC+3YnihPx/OoNGKGN8foc3IQA3ZznklaDeEulNNPfQX19q2K3aS7GBiiEDbuy7/Mre
 uGni8ZSMYhxJbZxeZI9nGVOGa9JfaSpVbsraBSpBcaOj0raZQBohs/GizbJhdxRNItiwhIS
 LCLOhih5kdP6ffpGQBD57FbmeT8CYO+/IA7jaJXVzGRNt8ZNsM6aWSd6ZuI5J3SigXgCz8s
 zxSL5HEyaY47bLHzR7KKvtjkD7GCDaEwgFz8FiTdtyOOfiubGBQdjR4Bg0GWAMHhxF8md+G
 m4Dhl9SrMsX+hlBxek2Pyxo/thfwQuP0q/XeDJiBbgdW9d67JuFjEpeuMqCc8XcMSoNvOq3
 OXAI5HPXh9FodwGmtcd2m3OlnLSpRMHakXRAeVAUwdr8Y9pc0MgXHGKYTf/puNlSWcPK/A2
 QNEtooqTlbmKSr1tstT0Vn7yJoa3USpsDzEFIVoZUKP5QRKhS97YCQShO+yPUjY0kt+OSva
 sHBkJ5C3GL+B6W2qKdsUK7+/XZ7I6onGy9Zi4AClF+UaTX68tOdeEsPs49gNhHeUObbEMw4
 TVlyGGMU63Z7XIzkhu1AOhZ0KYLKUtu9iOz4FkrVibsjG2bVPF3XLoWzNS9uStdaq5DQyDt
 j5OaBTN28aZbn3g7kDP7vkkeukMxxterssh9cj9bPjw4umxOEi1hytOj7f46S5axUjK9bKL
 6yz4w2QVbcQGVvAsXRflEI1ujYUwnPIaIGw28xjO3UP9k7mT/tQgp/Ui5OiB+V1/x9vwL3m
 Ey01ZHglAbtk6odaHIFR+k=
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

The 25G NIC offers off, RS, Base-R, and auto FEC modes. When
reconfiguring the PHY, the FEC mode must match on both sides;
otherwise, the link cannot come up. The current driver fails to
maintain this requirement, causing link instability.

Add proper FEC mode handling during PHY reconfiguration to
guarantee link establishment.

Fixes: fb6eb170dfa2 ("net/txgbe: add basic link configuration for Amber-Lite")
Cc: stable@dpdk.org

Signed-off-by: Zaiyu Wang <zaiyuwang@trustnetic.com>
---
 drivers/net/txgbe/base/txgbe_aml.c | 13 ++++++++++++-
 1 file changed, 12 insertions(+), 1 deletion(-)

diff --git a/drivers/net/txgbe/base/txgbe_aml.c b/drivers/net/txgbe/base/txgbe_aml.c
index 5d449a0bd9..ac80d85f08 100644
--- a/drivers/net/txgbe/base/txgbe_aml.c
+++ b/drivers/net/txgbe/base/txgbe_aml.c
@@ -282,6 +282,14 @@ s32 txgbe_setup_phy_link_aml(struct txgbe_hw *hw,
 	    !(hw->fec_mode & hw->cur_fec_link)))
 		goto out;
 
+	if (speed == TXGBE_LINK_SPEED_25GB_FULL &&
+	    link_speed == TXGBE_LINK_SPEED_25GB_FULL) {
+		txgbe_e56_fec_polling(hw, &link_up);
+
+		if (link_up)
+			goto out;
+	}
+
 	rte_spinlock_lock(&hw->phy_lock);
 	ret_status = txgbe_set_link_to_amlite(hw, speed);
 	rte_spinlock_unlock(&hw->phy_lock);
@@ -360,7 +368,10 @@ static s32 txgbe_setup_mac_link_multispeed_fiber_aml(struct txgbe_hw *hw,
 		/* If we already have link at this speed, just jump out */
 		txgbe_e56_check_phy_link(hw, &link_speed, &link_up);
 
-		if (link_speed == TXGBE_LINK_SPEED_25GB_FULL && link_up)
+		hw->cur_fec_link = txgbe_phy_fec_get(hw);
+
+		if (link_speed == TXGBE_LINK_SPEED_25GB_FULL && link_up &&
+		    hw->fec_mode & hw->cur_fec_link)
 			goto out;
 
 		/* Allow module to change analog characteristics (10G -> 25G) */
-- 
2.21.0.windows.1

