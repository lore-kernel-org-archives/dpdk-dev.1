Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C1FE2FF8867
	for <dpdk-dev@archiver.kernel.org>; Wed, 29 Apr 2026 10:27:58 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 3842140B99;
	Wed, 29 Apr 2026 12:27:03 +0200 (CEST)
Received: from smtpbgbr1.qq.com (smtpbgbr1.qq.com [54.207.19.206])
 by mails.dpdk.org (Postfix) with ESMTP id C6A5640661;
 Wed, 29 Apr 2026 12:26:49 +0200 (CEST)
X-QQ-mid: esmtpgz10t1777458406tca99dbba
X-QQ-Originating-IP: a0f2XCdakGbTfPfse1oYs8R3Xq3thGmGIYI3FGpIZPo=
Received: from DSK-zaiyuwang.trustnetic.com ( [36.24.191.108])
 by bizesmtp.qq.com (ESMTP) with 
 id ; Wed, 29 Apr 2026 18:26:44 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 1789250619230630237
EX-QQ-RecipientCnt: 4
From: Zaiyu Wang <zaiyuwang@trustnetic.com>
To: dev@dpdk.org
Cc: Zaiyu Wang <zaiyuwang@trustnetic.com>, stable@dpdk.org,
 Jiawen Wu <jiawenwu@trustnetic.com>
Subject: [PATCH v2 15/20] net/txgbe: fix FEC mode configuration on 25G NIC
Date: Wed, 29 Apr 2026 18:25:09 +0800
Message-Id: <20260429102515.58880-16-zaiyuwang@trustnetic.com>
X-Mailer: git-send-email 2.21.0.windows.1
In-Reply-To: <20260429102515.58880-1-zaiyuwang@trustnetic.com>
References: <20260423034024.14404-1-zaiyuwang@trustnetic.com>
 <20260429102515.58880-1-zaiyuwang@trustnetic.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: esmtpgz:trustnetic.com:qybglogicsvrsz:qybglogicsvrsz3b-0
X-QQ-XMAILINFO: MrY0q4FYDxnuyy+gqfMnplH7jjQs1sAU1JlfyTYXZe+RJo3BlI5pZB2Q
 r9qUN2IzW8ol6C9qw15VplKqhIXLroZ0mDMcCkM5C6YQA5xg5O5JsgpMPgnJB4+DCHl/wVf
 55ru+KOcb6z3v/kMss2Z+e02JtIK7NemaAnLs+Qy2OEfpnD/NiC7MYReCDBTvstUqsHRDHm
 KhlDnbgr9GiYByAxwbcs8kdcyWuH2qfgiZ/q49ehPlJYZ+ATKZdvBEzSfpnD84bl6f9BXlx
 Lwk0VutWmyQ9ju1b6ibMZ5m2IdMK4+Owzf68vCb5vHn08Iy2C2VBi7NvSlQATt1v2T/DtLH
 xRbfr/a7c3ehkoQFychFYDQS5zmSIPaDXJtsYruEOAYP62SU652Woa5WZPpkhVK33n54jPl
 vNuqC9LUi2YzmeM0J4NTZCp/9kTLBKop8TdG8lA5tCYNx2PMNhx2TMGH13IZYv4eVCjLLYv
 tbtnGZDUnSAhzbQ5K/DJmf1AoB+9rZgJfImiGfV165Lwi8weG5QonU/0uWlwcLIMMU9O2Sy
 8qWWV48uyj7Y7IrHKhmU2fuMxcZEGrIqvwNR1ObrXH0nt3bc82AjLeNjqJ8d6z6/ASAB756
 xgzmMJsM3pfWIlfQjeMAPT0N8hx+mi2Zb/NMVZIDurSVV+FFSdxHcym4WVw/3hn0+XaiJ+F
 xipDFqqaa2cqI3un6rzILxFyfJol8hkafkKHpsB6VBuDmqVYEVXfZUq4ZP3ff9lsV2R3q4d
 LjBU0MkfvmZG5xFG2NEhjB/27nIsqv4dhny5CTLJ5gPNORP/SF+X79GL2NUlqku7PHlJH0l
 yfEhXf1McObmbaxt1B8EcXCkfJzSKSEMPTiXyoAtDjlO6maw3I2BeeAfESnQHXlZ7kf8Rrg
 MGWDL0fWMQRiYsBezI2AdPzaD0c6BU47I2u9ZSs73L9X/GVUf6cHJU3NzaPIbJMc2y3MMec
 +uhQLnotGvaqM2gkQXQeOWiBhGJIzVfsZI+2OFX2UeKsxopJ8wr13YUPvpRU+3xXftmnm2m
 PRmpID8SYbShSJmJ0sS8IyXucGG0bXE6HnBlGpLglvFnYWaqFuqZa/nKOdG+y+vI1HfFEUz
 g5RIe+6hlzdLdZckbi6I5U=
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
index 5cc8741f10..72a894c4ae 100644
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

